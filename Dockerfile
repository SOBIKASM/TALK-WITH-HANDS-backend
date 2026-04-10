FROM python:3.10

# Create user to run the app on Hugging Face (security standard)
RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

WORKDIR $HOME/app

# Copy requirements and install
COPY --chown=user ./requirements.txt $HOME/app/
RUN pip install --no-cache-dir --upgrade -r requirements.txt

# Copy all the rest of the application code
COPY --chown=user . $HOME/app/

# Hugging face spaces default port is 7860
CMD ["uvicorn", "backend:app", "--host", "0.0.0.0", "--port", "7860"]
