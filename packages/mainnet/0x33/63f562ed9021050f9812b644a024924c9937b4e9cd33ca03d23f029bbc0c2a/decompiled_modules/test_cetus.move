module 0x3363f562ed9021050f9812b644a024924c9937b4e9cd33ca03d23f029bbc0c2a::test_cetus {
    struct Counter has key {
        id: 0x2::object::UID,
        value: u64,
        bag: 0x2::bag::Bag,
    }

    public fun add_to_bag<T0: store>(arg0: &mut Counter, arg1: 0x1::string::String, arg2: T0) {
        0x2::bag::add<0x1::string::String, T0>(&mut arg0.bag, arg1, arg2);
    }

    public fun assert_eq<T0: drop>(arg0: T0, arg1: T0) {
        assert!(arg0 == arg1, 0);
    }

    public fun get_from_bag<T0: store>(arg0: &Counter, arg1: 0x1::string::String) : &T0 {
        0x2::bag::borrow<0x1::string::String, T0>(&arg0.bag, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Counter{
            id    : 0x2::object::new(arg0),
            value : 0,
            bag   : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Counter>(v0);
    }

    // decompiled from Move bytecode v6
}

