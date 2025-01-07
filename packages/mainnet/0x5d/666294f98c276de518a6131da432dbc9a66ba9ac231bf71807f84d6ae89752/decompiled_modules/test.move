module 0x5d666294f98c276de518a6131da432dbc9a66ba9ac231bf71807f84d6ae89752::test {
    struct Msg has copy, drop {
        msg: u8,
    }

    struct Auth has key {
        id: 0x2::object::UID,
    }

    struct Cap has key {
        id: 0x2::object::UID,
        auth_id: 0x2::object::ID,
    }

    public fun emit(arg0: &Auth, arg1: &Cap) {
        is_cap_correct(arg0, arg1);
        let v0 = Msg{msg: 0};
        0x2::event::emit<Msg>(v0);
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Auth{id: 0x2::object::new(arg0)};
        let v1 = Cap{
            id      : 0x2::object::new(arg0),
            auth_id : 0x2::object::id<Auth>(&v0),
        };
        0x2::transfer::share_object<Auth>(v0);
        0x2::transfer::transfer<Cap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_cap_correct(arg0: &Auth, arg1: &Cap) {
        assert!(0x2::object::id<Auth>(arg0) == arg1.auth_id, 0);
    }

    // decompiled from Move bytecode v6
}

