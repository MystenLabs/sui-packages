module 0x918ed97cac57e821079d2d6a200714d3d441f059e29daa0bfeeaf2fa93bb8708::counter {
    struct Counter has key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
        value: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun increment(arg0: &mut Counter) {
        assert!(arg0.version == 1, 1);
        arg0.value = arg0.value + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Counter{
            id      : 0x2::object::new(arg0),
            version : 1,
            admin   : 0x2::object::id<AdminCap>(&v0),
            value   : 0,
        };
        0x2::transfer::share_object<Counter>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

