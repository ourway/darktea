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
        <h2>Darktea is a way to log your development</h2>
        <p className="lead">
          A productive web framework that
          <br />
          does not compromise speed and maintainability.
        </p>
      </div>
    );
  }
}

export default About;
