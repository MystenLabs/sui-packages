module 0xe1a56d99c1bc74510caf97717e13da674244fad4811e6b17d6960963f00789d7::test_multi_sign {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TestMultiSign has key {
        id: 0x2::object::UID,
        count: u64,
    }

    public fun do_something(arg0: &AdminCap, arg1: &mut TestMultiSign) {
        arg1.count = arg1.count + 1;
    }

    public fun get_count(arg0: &TestMultiSign) : u64 {
        arg0.count
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = TestMultiSign{
            id    : 0x2::object::new(arg0),
            count : 0,
        };
        0x2::transfer::share_object<TestMultiSign>(v1);
    }

    // decompiled from Move bytecode v6
}

