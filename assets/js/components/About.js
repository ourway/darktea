import React from "react";

class About extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    document.title = "About DarkTea | A blog engine for developers";
  }

  render() {
    return (
      <div className="jumbotron">
        <h2 className="about">DarkTea is all about simplicity</h2>
        <p className="about">
          There are millions of ways for you to log your development progress;
          but I bet non of them are painless. What you probability need is
          simple ways to log and search your researches, code snippets,
          bookmarks, ...; Also what is important is to categorize all those
          topics and make them useful for later usage. DarkTea tries to solve
          these problems for you ;-)
        </p>
        <p>
          I am Farsheed Ashouri and if you are using DarkTea and somehow you
          find it useful, I am happy I made something useful.
        </p>
      </div>
    );
  }
}

export default About;
