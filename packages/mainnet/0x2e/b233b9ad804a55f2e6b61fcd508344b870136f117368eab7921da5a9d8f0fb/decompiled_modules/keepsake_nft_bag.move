module 0x2eb233b9ad804a55f2e6b61fcd508344b870136f117368eab7921da5a9d8f0fb::keepsake_nft_bag {
    struct BagRules<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        kiosk_id: 0x2::object::ID,
        kiosk_cap: 0x2::kiosk::KioskOwnerCap,
        owner: address,
    }

    struct BAG_CREATED<phantom T0> has copy, drop {
        id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
    }

    public fun place<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut BagRules<T0>, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 0);
        let v0 = 0x2::table::length<u64, 0x2::object::ID>(0x2::dynamic_object_field::borrow<u64, 0x2::table::Table<u64, 0x2::object::ID>>(&arg1.id, 0));
        0x2::table::add<0x2::object::ID, u64>(0x2::dynamic_object_field::borrow_mut<u64, 0x2::table::Table<0x2::object::ID, u64>>(&mut arg1.id, 1), 0x2::object::id<T0>(&arg2), v0);
        0x2::table::add<u64, 0x2::object::ID>(0x2::dynamic_object_field::borrow_mut<u64, 0x2::table::Table<u64, 0x2::object::ID>>(&mut arg1.id, 0), v0, 0x2::object::id<T0>(&arg2));
        0x2::kiosk::place<T0>(arg0, &mut arg1.kiosk_cap, arg2);
    }

    public fun take<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut BagRules<T0>, arg2: 0x1::option::Option<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = get_id<T0>(arg0, arg1, arg2, arg3);
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(&mut arg1.id, 0x1::string::utf8(b"fee")), 3);
        let v1 = &mut arg1.id;
        check_limits(v1, arg3);
        0x2::kiosk::take<T0>(arg0, &mut arg1.kiosk_cap, v0)
    }

    public fun admin_take<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut BagRules<T0>, arg2: 0x1::option::Option<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 0);
        let v0 = get_id<T0>(arg0, arg1, arg2, arg3);
        0x2::kiosk::take<T0>(arg0, &mut arg1.kiosk_cap, v0)
    }

    public fun admin_take_balance<T0: store + key>(arg0: &mut BagRules<T0>, arg1: 0x1::option::Option<u64>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        let v0 = 0x2::dynamic_field::borrow_mut<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, 3);
        let v1 = if (!0x1::option::is_none<u64>(&arg1)) {
            0x1::option::extract<u64>(&mut arg1)
        } else {
            0x2::balance::value<0x2::sui::SUI>(v0)
        };
        0x2::balance::split<0x2::sui::SUI>(v0, v1)
    }

    fun check_fee(arg0: &mut 0x2::object::UID, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::dynamic_object_field::exists_<u64>(arg0, 3)) {
            0x2::dynamic_field::add<u64, 0x2::balance::Balance<0x2::sui::SUI>>(arg0, 3, 0x2::balance::zero<0x2::sui::SUI>());
        };
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1) == *0x2::dynamic_field::borrow<0x1::string::String, u64>(arg0, 0x1::string::utf8(b"fee")), 3);
        0x2::balance::join<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<u64, 0x2::balance::Balance<0x2::sui::SUI>>(arg0, 3), arg1);
    }

    fun check_limits(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::dynamic_field::exists_with_type<0x1::string::String, u64>(arg0, 0x1::string::utf8(b"limit"))) {
            let v0 = *0x2::dynamic_field::borrow<0x1::string::String, u64>(arg0, 0x1::string::utf8(b"limit"));
            let v1 = 0x2::dynamic_object_field::borrow_mut<u64, 0x2::table::Table<address, u64>>(arg0, 2);
            if (0x2::table::contains<address, u64>(v1, 0x2::tx_context::sender(arg1))) {
                let v2 = 0x2::table::borrow_mut<address, u64>(v1, 0x2::tx_context::sender(arg1));
                *v2 = *v2 + 1;
                assert!(v0 == 0 || v0 > *v2, 2);
            } else {
                0x2::table::add<address, u64>(v1, 0x2::tx_context::sender(arg1), 1);
            };
        };
    }

    public fun create<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, BagRules<T0>) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v0;
        let v3 = BagRules<T0>{
            id        : 0x2::object::new(arg0),
            kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
            kiosk_cap : v1,
            owner     : 0x2::tx_context::sender(arg0),
        };
        0x2::dynamic_object_field::add<u64, 0x2::table::Table<u64, 0x2::object::ID>>(&mut v3.id, 0, 0x2::table::new<u64, 0x2::object::ID>(arg0));
        0x2::dynamic_object_field::add<u64, 0x2::table::Table<0x2::object::ID, u64>>(&mut v3.id, 1, 0x2::table::new<0x2::object::ID, u64>(arg0));
        0x2::dynamic_object_field::add<u64, 0x2::table::Table<address, u64>>(&mut v3.id, 2, 0x2::table::new<address, u64>(arg0));
        let v4 = BAG_CREATED<T0>{
            id       : 0x2::object::id<BagRules<T0>>(&v3),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
        };
        0x2::event::emit<BAG_CREATED<T0>>(v4);
        (v2, v3)
    }

    fun get_id<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut BagRules<T0>, arg2: 0x1::option::Option<0x2::object::ID>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x2::object::id_from_address(0x2::tx_context::sender(arg3));
        let v0 = 0x2::table::length<u64, 0x2::object::ID>(0x2::dynamic_object_field::borrow<u64, 0x2::table::Table<u64, 0x2::object::ID>>(&arg1.id, 0));
        let (v1, v2) = if (0x2::dynamic_field::exists_<0x1::string::String>(&mut arg1.id, 0x1::string::utf8(b"random")) || 0x1::option::is_none<0x2::object::ID>(&arg2)) {
            assert!(0x1::option::is_none<0x2::object::ID>(&arg2), 1);
            let v3 = 0x2::tx_context::epoch_timestamp_ms(arg3);
            let v4 = 0x2::bcs::to_bytes<u64>(&v3);
            let v5 = 0x2::hash::keccak256(&v4);
            let v6 = (u32_from_bytes(&v5) as u64) % v0;
            (*0x2::table::borrow<u64, 0x2::object::ID>(0x2::dynamic_object_field::borrow<u64, 0x2::table::Table<u64, 0x2::object::ID>>(&mut arg1.id, 0), v6), v6)
        } else {
            let v7 = 0x1::option::extract<0x2::object::ID>(&mut arg2);
            (v7, *0x2::table::borrow<0x2::object::ID, u64>(0x2::dynamic_object_field::borrow<u64, 0x2::table::Table<0x2::object::ID, u64>>(&arg1.id, 1), v7))
        };
        let v8 = 0x2::dynamic_object_field::borrow_mut<u64, 0x2::table::Table<u64, 0x2::object::ID>>(&mut arg1.id, 0);
        let v9 = v1;
        0x2::table::remove<u64, 0x2::object::ID>(v8, v2);
        if (v2 < v0 - 1) {
            let v10 = 0x2::table::remove<u64, 0x2::object::ID>(v8, v0 - 1);
            v9 = v10;
            0x2::table::add<u64, 0x2::object::ID>(v8, v2, v10);
        };
        let v11 = 0x2::dynamic_object_field::borrow_mut<u64, 0x2::table::Table<0x2::object::ID, u64>>(&mut arg1.id, 1);
        0x2::table::remove<0x2::object::ID, u64>(v11, v1);
        if (v2 < v0 - 1) {
            *0x2::table::borrow_mut<0x2::object::ID, u64>(v11, v9) = v2;
        };
        v1
    }

    public fun get_limits(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::dynamic_object_field::borrow<u64, 0x2::table::Table<address, u64>>(arg0, 2);
        let v1 = if (0x2::table::contains<address, u64>(v0, 0x2::tx_context::sender(arg1))) {
            *0x2::table::borrow<address, u64>(v0, 0x2::tx_context::sender(arg1))
        } else {
            0
        };
        (*0x2::dynamic_field::borrow<0x1::string::String, u64>(arg0, 0x1::string::utf8(b"limit")), v1)
    }

    public fun remove_rule<T0: store + key>(arg0: &mut BagRules<T0>, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        0x2::dynamic_field::remove_if_exists<0x1::string::String, u64>(&mut arg0.id, arg1);
    }

    public fun set_rule<T0: store + key>(arg0: &mut BagRules<T0>, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        let v0 = &mut arg0.id;
        if (0x2::dynamic_field::exists_<0x1::string::String>(v0, arg1)) {
            0x2::dynamic_field::remove_if_exists<0x1::string::String, u64>(v0, arg1);
        };
        0x2::dynamic_field::add<0x1::string::String, u64>(v0, arg1, arg2);
    }

    public fun take_with_fee<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut BagRules<T0>, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = get_id<T0>(arg0, arg1, arg2, arg4);
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&mut arg1.id, 0x1::string::utf8(b"fee")), 3);
        let v1 = &mut arg1.id;
        check_limits(v1, arg4);
        let v2 = &mut arg1.id;
        check_fee(v2, 0x2::coin::into_balance<0x2::sui::SUI>(arg3), arg4);
        0x2::kiosk::take<T0>(arg0, &mut arg1.kiosk_cap, v0)
    }

    public fun u32_from_bytes(arg0: &vector<u8>) : u32 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = v0 << 8;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg0, v1) as u32);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

