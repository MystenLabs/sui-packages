module 0xc9535f816daad33c30e6b7e4e31a97df6cfe480d201bd68e5d5bcbe551da4e67::greeter {
    struct Greeting has store, key {
        id: 0x2::object::UID,
        message: 0x1::string::String,
    }

    struct GreetedEvent has copy, drop {
        greeting_id: 0x2::object::ID,
        recipient: address,
        message: 0x1::string::String,
    }

    public fun greet(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Greeting {
        assert!(0x1::string::length(&arg0) <= 140, 20);
        let v0 = Greeting{
            id      : 0x2::object::new(arg1),
            message : arg0,
        };
        let v1 = GreetedEvent{
            greeting_id : 0x2::object::uid_to_inner(&v0.id),
            recipient   : 0x2::tx_context::sender(arg1),
            message     : arg0,
        };
        0x2::event::emit<GreetedEvent>(v1);
        v0
    }

    public fun message(arg0: &Greeting) : &0x1::string::String {
        &arg0.message
    }

    // decompiled from Move bytecode v7
}

