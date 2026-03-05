module 0x304ab697f8ab3e7f874dd6c3877237e1be1fc40938929f42084908d3319f6a28::greeting {
    struct Greeting has store, key {
        id: 0x2::object::UID,
        message: 0x1::string::String,
        owner: address,
    }

    public fun create_greeting(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Greeting {
        Greeting{
            id      : 0x2::object::new(arg1),
            message : arg0,
            owner   : 0x2::tx_context::sender(arg1),
        }
    }

    public fun message(arg0: &Greeting) : &0x1::string::String {
        &arg0.message
    }

    public fun owner(arg0: &Greeting) : address {
        arg0.owner
    }

    public fun update_message(arg0: &mut Greeting, arg1: 0x1::string::String) {
        arg0.message = arg1;
    }

    // decompiled from Move bytecode v6
}

