module 0xbc7da750932ad0f730a2a2392bde7d4afb4e64a5e6c7a94ba024e2201853715f::test_multi_sign {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TestMultiSign has key {
        id: 0x2::object::UID,
        count: u64,
    }

    struct TestMultiSign2 has key {
        id: 0x2::object::UID,
        count: u64,
    }

    public fun do_something(arg0: &AdminCap, arg1: &mut TestMultiSign) {
        arg1.count = arg1.count + 1;
    }

    public fun do_something2(arg0: &AdminCap, arg1: &mut TestMultiSign2) {
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
        let v2 = TestMultiSign2{
            id    : 0x2::object::new(arg0),
            count : 0,
        };
        0x2::transfer::share_object<TestMultiSign2>(v2);
    }

    // decompiled from Move bytecode v6
}

