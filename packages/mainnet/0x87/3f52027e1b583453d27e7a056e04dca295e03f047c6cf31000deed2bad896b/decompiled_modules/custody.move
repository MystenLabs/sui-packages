module 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::custody {
    struct Custody has store {
        stores: 0x2::bag::Bag,
        balances: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        discovered: vector<0x1::type_name::TypeName>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Custody {
        Custody{
            stores     : 0x2::bag::new(arg0),
            balances   : 0x2::table::new<0x1::type_name::TypeName, u64>(arg0),
            discovered : 0x1::vector::empty<0x1::type_name::TypeName>(),
        }
    }

    public(friend) fun join<T0>(arg0: &mut Custody, arg1: 0x2::balance::Balance<T0>) {
        ensure_registered<T0>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.stores, v0), arg1);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.balances, v0);
        *v1 = *v1 + 0x2::balance::value<T0>(&arg1);
    }

    public(friend) fun split<T0>(arg0: &mut Custody, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.stores, v0), 400);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.stores, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 401);
        let v2 = 0x2::balance::split<T0>(v1, arg1);
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.balances, v0);
        *v3 = *v3 - arg1;
        v2
    }

    public(friend) fun assert_empty(arg0: &Custody) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.discovered)) {
            assert!(tracked(arg0, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.discovered, v0)) == 0, 403);
            v0 = v0 + 1;
        };
    }

    public(friend) fun assert_registered_consistent<T0>(arg0: &Custody) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.stores, v0), 400);
        assert!(0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.stores, v0)) == tracked(arg0, v0), 402);
    }

    public(friend) fun balance_of<T0>(arg0: &Custody) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.stores, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.stores, v0))
    }

    public(friend) fun discovered(arg0: &Custody) : vector<0x1::type_name::TypeName> {
        arg0.discovered
    }

    public(friend) fun discovered_count(arg0: &Custody) : u64 {
        0x1::vector::length<0x1::type_name::TypeName>(&arg0.discovered)
    }

    public(friend) fun ensure_registered<T0>(arg0: &mut Custody) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.stores, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.stores, v0, 0x2::balance::zero<T0>());
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.balances, v0, 0);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.discovered, v0);
        };
    }

    public(friend) fun held(arg0: &Custody) : vector<0x1::type_name::TypeName> {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.discovered)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.discovered, v1);
            if (tracked(arg0, v2) > 0) {
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun split_all<T0>(arg0: &mut Custody) : 0x2::balance::Balance<T0> {
        let v0 = balance_of<T0>(arg0);
        split<T0>(arg0, v0)
    }

    public(friend) fun tracked(arg0: &Custody, arg1: 0x1::type_name::TypeName) : u64 {
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.balances, arg1)) {
            return 0
        };
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.balances, arg1)
    }

    // decompiled from Move bytecode v7
}

