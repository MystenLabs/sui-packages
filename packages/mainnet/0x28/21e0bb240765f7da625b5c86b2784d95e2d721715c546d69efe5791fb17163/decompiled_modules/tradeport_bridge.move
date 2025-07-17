module 0x2821e0bb240765f7da625b5c86b2784d95e2d721715c546d69efe5791fb17163::tradeport_bridge {
    struct TRADEPORT_BRIDGE has drop {
        dummy_field: bool,
    }

    struct Manager has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        public_key: vector<u8>,
        fee_in: u64,
        fee_out: u64,
        kiosk: 0x2::kiosk::Kiosk,
        kiosk_owner_cap: 0x2::kiosk::KioskOwnerCap,
        bridges: 0x2::table::Table<0x1::ascii::String, Bridge>,
        fees: 0x2::bag::Bag,
    }

    struct Bridge has store, key {
        id: 0x2::object::UID,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
        state: u64,
        supply: u64,
        treasury: 0x2::bag::Bag,
        registry: 0x2::table::Table<0x2::object::ID, u64>,
    }

    struct RegisterBridgeEvent has copy, drop {
        bridge_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
    }

    struct LoadBridgeEvent has copy, drop {
        bridge_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
        index: u64,
        state: u64,
    }

    struct BridgeNftToCoinEvent has copy, drop {
        bridge_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
        direction: u64,
        nft_id: 0x2::object::ID,
        amount: u64,
    }

    public fun bridge_coin_to_nft<T0: store + key, T1>(arg0: &mut Manager, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        verify_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = *0x1::type_name::borrow_string(&v0);
        let v2 = 0x1::type_name::get<T1>();
        let v3 = *0x1::type_name::borrow_string(&v2);
        assert!(0x2::table::contains<0x1::ascii::String, Bridge>(&arg0.bridges, v1), 5);
        let v4 = 0x2::table::borrow_mut<0x1::ascii::String, Bridge>(&mut arg0.bridges, v1);
        assert!(v4.nft_type == v1, 3);
        assert!(v4.ft_type == v3, 3);
        assert!(v4.state == 1, 6);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&v4.registry, arg2), 8);
        assert!(0x2::kiosk::has_item_with_type<T0>(&arg0.kiosk, arg2), 9);
        assert!(0x2::coin::value<T1>(&arg1) == *0x2::table::borrow<0x2::object::ID, u64>(&v4.registry, arg2), 11);
        let v5 = 0x2::coin::into_balance<T1>(arg1);
        if (arg0.fee_out > 0) {
            let v6 = if (0x2::bag::contains<0x1::ascii::String>(&arg0.fees, v3)) {
                0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.fees, v3)
            } else {
                0x2::balance::zero<T1>()
            };
            let v7 = v6;
            0x2::balance::join<T1>(&mut v7, 0x2::balance::split<T1>(&mut v5, (((0x2::balance::value<T1>(&v5) as u128) * (arg0.fee_out as u128) / 10000) as u64)));
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.fees, v3, v7);
        };
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut v4.treasury, v3), v5);
        assert!(!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg3), 10);
        assert!(!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg3), 10);
        let (v8, v9) = 0x2::kiosk::purchase_with_cap<T0>(&mut arg0.kiosk, 0x2::kiosk::list_with_purchase_cap<T0>(&mut arg0.kiosk, &arg0.kiosk_owner_cap, arg2, 0, arg7), 0x2::coin::zero<0x2::sui::SUI>(arg7));
        let v10 = v9;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg3)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg3, &mut v10, arg4);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg4);
        };
        0x2::kiosk::lock<T0>(arg5, arg6, arg3, v8);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg3)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v10, arg5);
        };
        let v11 = BridgeNftToCoinEvent{
            bridge_id : 0x2::object::id<Bridge>(v4),
            nft_type  : v1,
            ft_type   : v3,
            direction : 1,
            nft_id    : arg2,
            amount    : *0x2::table::borrow<0x2::object::ID, u64>(&v4.registry, arg2),
        };
        0x2::event::emit<BridgeNftToCoinEvent>(v11);
        v10
    }

    public fun bridge_nft_to_coin<T0: store + key, T1>(arg0: &mut Manager, arg1: 0x2::object::ID, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferRequest<T0>, 0x2::coin::Coin<T1>) {
        verify_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = *0x1::type_name::borrow_string(&v0);
        let v2 = 0x1::type_name::get<T1>();
        let v3 = *0x1::type_name::borrow_string(&v2);
        assert!(0x2::table::contains<0x1::ascii::String, Bridge>(&arg0.bridges, v1), 5);
        let v4 = 0x2::table::borrow_mut<0x1::ascii::String, Bridge>(&mut arg0.bridges, v1);
        assert!(v4.nft_type == v1, 3);
        assert!(v4.ft_type == v3, 3);
        assert!(v4.state == 1, 6);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&v4.registry, arg1), 8);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg4, arg1), 9);
        let v5 = 0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut v4.treasury, v3), *0x2::table::borrow<0x2::object::ID, u64>(&v4.registry, arg1));
        if (arg0.fee_in > 0) {
            let v6 = if (0x2::bag::contains<0x1::ascii::String>(&arg0.fees, v3)) {
                0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.fees, v3)
            } else {
                0x2::balance::zero<T1>()
            };
            let v7 = v6;
            0x2::balance::join<T1>(&mut v7, 0x2::balance::split<T1>(&mut v5, (((0x2::balance::value<T1>(&v5) as u128) * (arg0.fee_in as u128) / 10000) as u64)));
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.fees, v3, v7);
        };
        assert!(!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg2), 10);
        assert!(!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg2), 10);
        let (v8, v9) = 0x2::kiosk::purchase_with_cap<T0>(arg4, 0x2::kiosk::list_with_purchase_cap<T0>(arg4, arg5, arg1, 0, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v10 = v9;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg2)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg2, &mut v10, arg3);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        0x2::kiosk::lock<T0>(&mut arg0.kiosk, &arg0.kiosk_owner_cap, arg2, v8);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg2)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v10, &arg0.kiosk);
        };
        let v11 = BridgeNftToCoinEvent{
            bridge_id : 0x2::object::id<Bridge>(v4),
            nft_type  : v1,
            ft_type   : v3,
            direction : 0,
            nft_id    : arg1,
            amount    : *0x2::table::borrow<0x2::object::ID, u64>(&v4.registry, arg1),
        };
        0x2::event::emit<BridgeNftToCoinEvent>(v11);
        (v10, 0x2::coin::from_balance<T1>(v5, arg6))
    }

    fun init(arg0: TRADEPORT_BRIDGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<TRADEPORT_BRIDGE>(arg0, arg1);
        let (v0, v1) = 0x2::kiosk::new(arg1);
        let v2 = Manager{
            id              : 0x2::object::new(arg1),
            version         : 1,
            admin           : 0x2::tx_context::sender(arg1),
            public_key      : 0x1::vector::empty<u8>(),
            fee_in          : 0,
            fee_out         : 0,
            kiosk           : v0,
            kiosk_owner_cap : v1,
            bridges         : 0x2::table::new<0x1::ascii::String, Bridge>(arg1),
            fees            : 0x2::bag::new(arg1),
        };
        0x2::transfer::share_object<Manager>(v2);
    }

    public fun load_bridge<T0>(arg0: &mut Manager, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: u64, arg4: vector<0x2::object::ID>, arg5: vector<u64>, arg6: vector<u8>, arg7: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg7);
        let v0 = 0x1::type_name::get<T0>();
        assert!(arg2 == *0x1::type_name::borrow_string(&v0), 3);
        assert!(0x2::table::contains<0x1::ascii::String, Bridge>(&arg0.bridges, arg1), 5);
        let v1 = 0x2::table::borrow_mut<0x1::ascii::String, Bridge>(&mut arg0.bridges, arg1);
        assert!(v1.nft_type == arg1, 3);
        assert!(v1.ft_type == arg2, 3);
        assert!(v1.state == 0, 6);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg4)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg5);
            0x2::table::add<0x2::object::ID, u64>(&mut v1.registry, 0x1::vector::pop_back<0x2::object::ID>(&mut arg4), v2);
            v1.supply = v1.supply + v2;
        };
        let v3 = 0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T0>>(&v1.treasury, arg2);
        assert!(v1.supply <= 0x2::balance::value<T0>(v3), 7);
        if (v1.supply == 0x2::balance::value<T0>(v3)) {
            v1.state = 1;
        };
        let v4 = LoadBridgeEvent{
            bridge_id : 0x2::object::id<Bridge>(v1),
            nft_type  : arg1,
            ft_type   : arg2,
            index     : arg3,
            state     : v1.state,
        };
        0x2::event::emit<LoadBridgeEvent>(v4);
    }

    public fun register_bridge<T0>(arg0: &mut Manager, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x2::coin::Coin<T0>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg5);
        let v0 = 0x1::type_name::get<T0>();
        assert!(arg2 == *0x1::type_name::borrow_string(&v0), 3);
        assert!(!0x2::table::contains<0x1::ascii::String, Bridge>(&arg0.bridges, arg1), 4);
        let v1 = Bridge{
            id       : 0x2::object::new(arg5),
            nft_type : arg1,
            ft_type  : arg2,
            state    : 0,
            supply   : 0,
            treasury : 0x2::bag::new(arg5),
            registry : 0x2::table::new<0x2::object::ID, u64>(arg5),
        };
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v1.treasury, arg2, 0x2::coin::into_balance<T0>(arg3));
        0x2::table::add<0x1::ascii::String, Bridge>(&mut arg0.bridges, arg1, v1);
        let v2 = RegisterBridgeEvent{
            bridge_id : 0x2::object::id<Bridge>(&v1),
            nft_type  : arg1,
            ft_type   : arg2,
        };
        0x2::event::emit<RegisterBridgeEvent>(v2);
    }

    entry fun set_admin(arg0: &mut Manager, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    entry fun set_fee(arg0: &mut Manager, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg3);
        arg0.fee_in = arg1;
        arg0.fee_out = arg2;
    }

    entry fun set_public_key(arg0: &mut Manager, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.public_key = arg1;
    }

    entry fun set_version(arg0: &mut Manager, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    fun verify_admin(arg0: &Manager, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_version(arg0: &Manager) {
        assert!(arg0.version == 1, 1);
    }

    // decompiled from Move bytecode v6
}

