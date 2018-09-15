# README
## Media Coding Challenge

### Webiste
https://media-coding-challenge.herokuapp.com

### Data
All the data comes from The Movie Database

### Testing 
You can run tests by typing **rake test**.
The tests check each endpoint to see if they return the right value.  

### Deployment
The app is automatically deployed to heroku from master.

### Endpoints
#### /show/:id
    - Parameter: 
        - Id
     - Response:
        - Title
        - Release
        - Synopsis
     - ex.  /show/1 => {"title":"Pride","release":"2004-01-12","synopsis":"Pride is a Japanese drama."}

#### /movie/:id
    - Parameter: 
        - Id
     - Response:
        - Title
        - Release
        - Synopsis
     - ex.  /movie/2 => {"title":"Ariel","release":"1988-10-21","synopsis":"Taisto Kasurinen is a Finnish coal miner whose father has just committed suicide and who is framed for a crime he did not commit. In jail, he starts to dream about leaving the country and starting a new life. He escapes from prison but things don't go as planned..."}
#### /search?query=some_title&page=page_number
    - Parameter: 
        - query
        - page(optional)
     - Response:
        - Media : array[object]
            - Title
            - Release
            - Synopsis
            - Type
     - ex.  /search?query=mad&&page=10 => {"media":[{"title":"It's a Mad, Mad, Mad World II","release":"1988-02-13","synopsis":"After losing their lottery winnings during the bank's closure, the Biu family's luck changes again as Bill's job promotion and daughters' education and work careers sent them and the entire family to lead their new lives in Canada, where new misadventures await.","type":"movie"}, ... ]}
