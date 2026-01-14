module 0x898c82845cc338d0c6f3e79e6b97bf12bdd8369dd5a757e5b3bf31bf56cf36eb::registry {
    struct EModeRegistry has store, key {
        id: 0x2::object::UID,
        user_emode_to_account_cap: 0x2::table::Table<address, 0x2::vec_map::VecMap<u64, address>>,
    }

    public fun admin_register_emode_for_account_cap(arg0: &mut EModeRegistry, arg1: address, arg2: u64, arg3: u64, arg4: address) {
        let v0 = arg2 * 100000 + arg3;
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<u64, address>>(&arg0.user_emode_to_account_cap, arg4)) {
            0x2::table::add<address, 0x2::vec_map::VecMap<u64, address>>(&mut arg0.user_emode_to_account_cap, arg4, 0x2::vec_map::empty<u64, address>());
        };
        let v1 = 0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<u64, address>>(&mut arg0.user_emode_to_account_cap, arg4);
        assert!(!0x2::vec_map::contains<u64, address>(v1, &v0), 10001);
        0x2::vec_map::insert<u64, address>(v1, v0, arg1);
    }

    public fun admin_unregister_emode_for_account_cap(arg0: &mut EModeRegistry, arg1: u64, arg2: u64, arg3: address) {
        let v0 = arg1 * 100000 + arg2;
        let v1 = 0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<u64, address>>(&mut arg0.user_emode_to_account_cap, arg3);
        assert!(0x2::vec_map::contains<u64, address>(v1, &v0), 10002);
        let (_, _) = 0x2::vec_map::remove<u64, address>(v1, &v0);
    }

    public fun find_user_emode_account_caps(arg0: &EModeRegistry, arg1: address) : (vector<u64>, vector<u64>, vector<address>) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<address>();
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<u64, address>>(&arg0.user_emode_to_account_cap, arg1)) {
            return (v0, v1, v2)
        };
        let v3 = 0x2::table::borrow<address, 0x2::vec_map::VecMap<u64, address>>(&arg0.user_emode_to_account_cap, arg1);
        let v4 = 0x2::vec_map::keys<u64, address>(v3);
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&v4)) {
            let v6 = *0x1::vector::borrow<u64>(&v4, v5);
            0x1::vector::push_back<u64>(&mut v0, v6 / 100000);
            0x1::vector::push_back<u64>(&mut v1, v6 % 100000);
            0x1::vector::push_back<address>(&mut v2, *0x2::vec_map::get<u64, address>(v3, &v6));
            v5 = v5 + 1;
        };
        (v0, v1, v2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EModeRegistry{
            id                        : 0x2::object::new(arg0),
            user_emode_to_account_cap : 0x2::table::new<address, 0x2::vec_map::VecMap<u64, address>>(arg0),
        };
        let v1 = &mut v0;
        test(v1, arg0);
        0x2::transfer::share_object<EModeRegistry>(v0);
    }

    public fun register_emode_for_account_cap(arg0: &mut EModeRegistry, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = arg2 * 100000 + arg3;
        if (!0x2::table::contains<address, 0x2::vec_map::VecMap<u64, address>>(&arg0.user_emode_to_account_cap, v0)) {
            0x2::table::add<address, 0x2::vec_map::VecMap<u64, address>>(&mut arg0.user_emode_to_account_cap, v0, 0x2::vec_map::empty<u64, address>());
        };
        let v2 = 0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<u64, address>>(&mut arg0.user_emode_to_account_cap, v0);
        assert!(!0x2::vec_map::contains<u64, address>(v2, &v1), 10001);
        0x2::vec_map::insert<u64, address>(v2, v1, arg1);
    }

    fun test(arg0: &mut EModeRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        register_emode_for_account_cap(arg0, @0xaa, 2, 1, arg1);
        let (v1, v2, v3) = find_user_emode_account_caps(arg0, v0);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        assert!(0x1::vector::length<u64>(&v6) == 1, 10003);
        assert!(0x1::vector::length<u64>(&v5) == 1, 10004);
        assert!(0x1::vector::length<address>(&v4) == 1, 10005);
        assert!(*0x1::vector::borrow<u64>(&v6, 0) == 2, 10006);
        assert!(*0x1::vector::borrow<u64>(&v5, 0) == 1, 10007);
        assert!(*0x1::vector::borrow<address>(&v4, 0) == @0xaa, 10008);
        unregister_emode_for_account_cap(arg0, 2, 1, arg1);
        let (v7, v8, v9) = find_user_emode_account_caps(arg0, v0);
        let v10 = v9;
        let v11 = v8;
        let v12 = v7;
        assert!(0x1::vector::length<u64>(&v12) == 0, 10009);
        assert!(0x1::vector::length<u64>(&v11) == 0, 10010);
        assert!(0x1::vector::length<address>(&v10) == 0, 10011);
    }

    public fun unregister_emode_for_account_cap(arg0: &mut EModeRegistry, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 * 100000 + arg2;
        let v1 = 0x2::table::borrow_mut<address, 0x2::vec_map::VecMap<u64, address>>(&mut arg0.user_emode_to_account_cap, 0x2::tx_context::sender(arg3));
        assert!(0x2::vec_map::contains<u64, address>(v1, &v0), 10002);
        let (_, _) = 0x2::vec_map::remove<u64, address>(v1, &v0);
    }

    // decompiled from Move bytecode v6
}

