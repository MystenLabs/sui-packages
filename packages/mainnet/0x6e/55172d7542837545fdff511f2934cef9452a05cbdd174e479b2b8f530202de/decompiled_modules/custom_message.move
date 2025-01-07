module 0x6e55172d7542837545fdff511f2934cef9452a05cbdd174e479b2b8f530202de::custom_message {
    struct Greeting has key {
        id: 0x2::object::UID,
    }

    struct Greeted has copy, drop {
        sender: address,
        message: vector<u8>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Greeting{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Greeting>(v0);
    }

    public entry fun say_hello(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Greeted{
            sender  : 0x2::tx_context::sender(arg0),
            message : b"Hello, Sui!",
        };
        0x2::event::emit<Greeted>(v0);
    }

    // decompiled from Move bytecode v6
}

