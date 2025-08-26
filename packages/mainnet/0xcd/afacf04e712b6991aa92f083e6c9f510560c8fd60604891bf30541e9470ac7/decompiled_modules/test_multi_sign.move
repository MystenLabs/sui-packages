module 0xcdafacf04e712b6991aa92f083e6c9f510560c8fd60604891bf30541e9470ac7::test_multi_sign {
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
        0x2::transfer::transfer<TestMultiSign>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

