import React from "react";
import { Header, Segment } from "semantic-ui-react";
import { Link } from "react-router-dom";

const HeaderSection = () => {
  return (
    <div style={{ width: "100%", clear: "both", padding: 10 }}>
      <Header as="div" floated="right" color="grey" dividing={false}>
        <Link to="/login">Login</Link>
      </Header>
      <br />
    </div>
  );
};

export default HeaderSection;
