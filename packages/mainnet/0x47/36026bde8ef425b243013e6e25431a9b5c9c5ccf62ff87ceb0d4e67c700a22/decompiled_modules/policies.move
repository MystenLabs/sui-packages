module 0x4736026bde8ef425b243013e6e25431a9b5c9c5ccf62ff87ceb0d4e67c700a22::policies {
    struct Policies has store {
        bag: 0x2::bag::Bag,
    }

    struct PolicyKey<phantom T0: store> has copy, drop, store {
        dummy_field: bool,
    }

    public fun length(arg0: &Policies) : u64 {
        0x2::bag::length(&arg0.bag)
    }

    public fun borrow<T0: store>(arg0: &Policies) : &T0 {
        assert!(contains<T0>(arg0), 13835058231375822849);
        let v0 = PolicyKey<T0>{dummy_field: false};
        0x2::bag::borrow<PolicyKey<T0>, T0>(&arg0.bag, v0)
    }

    public fun borrow_mut<T0: store>(arg0: &mut Policies) : &mut T0 {
        assert!(contains<T0>(arg0), 13835058252850659329);
        let v0 = PolicyKey<T0>{dummy_field: false};
        0x2::bag::borrow_mut<PolicyKey<T0>, T0>(&mut arg0.bag, v0)
    }

    public(friend) fun destroy_empty(arg0: Policies) {
        let Policies { bag: v0 } = arg0;
        0x2::bag::destroy_empty(v0);
    }

    public fun add<T0: store>(arg0: &mut Policies, arg1: T0) {
        assert!(!contains<T0>(arg0), 13835339663402991619);
        let v0 = PolicyKey<T0>{dummy_field: false};
        0x2::bag::add<PolicyKey<T0>, T0>(&mut arg0.bag, v0, arg1);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Policies {
        Policies{bag: 0x2::bag::new(arg0)}
    }

    public fun remove<T0: store>(arg0: &mut Policies) : T0 {
        assert!(contains<T0>(arg0), 13835058209900986369);
        let v0 = PolicyKey<T0>{dummy_field: false};
        0x2::bag::remove<PolicyKey<T0>, T0>(&mut arg0.bag, v0)
    }

    public fun contains<T0: store>(arg0: &Policies) : bool {
        let v0 = PolicyKey<T0>{dummy_field: false};
        0x2::bag::contains_with_type<PolicyKey<T0>, T0>(&arg0.bag, v0)
    }

    // decompiled from Move bytecode v7
}

