# -*- coding: utf-8 -*-
from dotenv import load_dotenv
import os

load_dotenv()

VALID_USER = {
    "username": os.getenv("STANDARD_USERNAME"),
    "password": os.getenv("STANDARD_PASSWORD"),
    "name": "John Doe" 
}