var NameInput = React.createClass({displayName: "NameInput",
    handleTextChange: function(){
        var x = this.refs.nameField.getDOMNode().value;
        
        if(x != ''){
            this.refs.nameField.getDOMNode().className = 'active';
        } else {
            this.refs.nameField.getDOMNode().className = '';
        }

        this.props.onUserInput(x);
    },
    render: function(){
        return (
            React.createElement("div", {className: "control"}, 
                React.createElement("input", {type: "text", id: "name", ref: "nameField", placeholder: "What should I call you?", autoFocus: true, required: true, onChange: this.handleTextChange}), 
                React.createElement("label", {for: "name"}, "Name")
            )
        )
    }
});

var EmailInput = React.createClass({displayName: "EmailInput",
    handleTextChange: function(){
        var x = this.refs.emailField.getDOMNode().value;
        
        if(x != ''){
            this.refs.emailField.getDOMNode().className = 'active';
        } else {
            this.refs.emailField.getDOMNode().className = '';
        }

        this.props.onUserInput('', x);
    },
    render: function(){
        return (
            React.createElement("div", {className: "control"}, 
                React.createElement("input", {type: "email", id: "email", ref: "emailField", placeholder: "Where can I reach you?", required: true, onChange: this.handleTextChange}), 
                React.createElement("label", {for: "email"}, "e-mail")
            )
        )
    }
});

var TicketForm = React.createClass({displayName: "TicketForm",
    getInitialState: function() {
        return {
            nameText: '',
            emailText: '',
            messageText: ''
        };
    },
    handleUserInput: function(nameText, emailText, messageText) {
        this.setState({
            nameText: nameText,
            emailText: emailText,
            messageText: messageText
        });
    },
  render: function(){
    return (
         React.createElement("form", {action: "/"}, 
        
            React.createElement("fieldset", null, 
                React.createElement("legend", null, "Buy a ticket."),
                React.createElement("legend", {className: 'price'}, "Price 10 finney"),
                
                React.createElement(NameInput, {onUserInput: this.handleUserInput}),
                React.createElement(EmailInput, {onUserInput: this.handleUserInput}),
                
                React.createElement("input", {type: "submit", value: "Buy a ticket"})
            )

        )
        );
  }
});

React.render(React.createElement(TicketForm, null), document.getElementById('stage'));