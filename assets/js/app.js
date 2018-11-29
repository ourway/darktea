// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.

import "semantic-ui-css/semantic.min.css";
import css from "../css/app.css";
import { BrowserRouter as Router, Route, Link } from "react-router-dom";
import React from "react";
import ReactDOM from "react-dom";
import Header from "./components/Header";
import Login from "./components/Login";
import About from "./components/About";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"
//
ReactDOM.render(
  <div>
    <Router>
      <section className="darktea-route-section">
        <Header />
        <Route path="/about" exact component={About} />
        <Route path="/login" exact component={Login} />
      </section>
    </Router>
  </div>,
  document.getElementById("react-app")
);
