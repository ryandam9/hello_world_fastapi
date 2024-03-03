from fastapi import FastAPI, Request, responses
from fastapi.staticfiles import StaticFiles

app = FastAPI()

# Serve static files
app.mount("/static", StaticFiles(directory="app/static"), name="static")

# Redirect root URL to /static/index.html
@app.get("/")
async def read_index():
    return responses.RedirectResponse(url='/static/index.html')


@app.get("/hello")
async def say_hello():
    return "Hello, world"