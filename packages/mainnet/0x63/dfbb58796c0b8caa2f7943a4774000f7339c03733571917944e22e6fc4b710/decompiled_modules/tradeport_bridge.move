module 0x63dfbb58796c0b8caa2f7943a4774000f7339c03733571917944e22e6fc4b710::tradeport_bridge {
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
        reservation_mode: u64,
        reservation_fees: 0x2::table::Table<u64, u64>,
        kiosk: 0x2::kiosk::Kiosk,
        kiosk_owner_cap: 0x2::kiosk::KioskOwnerCap,
        bridges: 0x2::table::Table<0x1::ascii::String, Bridge>,
        fees: 0x2::bag::Bag,
    }

    struct Request has drop {
        sender: vector<u8>,
        order_id: 0x1::ascii::String,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
        ft_supply: u64,
    }

    struct Bridge has store, key {
        id: 0x2::object::UID,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
        state: u64,
        supply: u64,
        treasury: 0x2::bag::Bag,
        registry: 0x2::table::Table<0x2::object::ID, u64>,
        reservations: 0x2::table::Table<0x2::object::ID, Reservation>,
    }

    struct Reservation has copy, drop, store {
        holder: address,
        expires_at: u64,
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

    struct ReserveNftEvent has copy, drop {
        bridge_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        holder: address,
        expires_at: u64,
    }

    public fun add_exclusive_transfer_policy<T0: store + key>(arg0: &mut Manager, arg1: 0x2::transfer_policy::TransferPolicy<T0>) {
        verify_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = *0x1::type_name::borrow_string(&v0);
        assert!(0x2::table::contains<0x1::ascii::String, Bridge>(&arg0.bridges, v1), 5);
        assert!(0x2::vec_set::size<0x1::type_name::TypeName>(0x2::transfer_policy::rules<T0>(&arg1)) == 0, 10);
        0x2::dynamic_object_field::add<0x1::ascii::String, 0x2::transfer_policy::TransferPolicy<T0>>(&mut 0x2::table::borrow_mut<0x1::ascii::String, Bridge>(&mut arg0.bridges, v1).id, v1, arg1);
    }

    public fun bridge_coin_to_nft<T0: store + key, T1>(arg0: &0x2::clock::Clock, arg1: &mut Manager, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::object::ID, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::kiosk::Kiosk, arg7: &0x2::kiosk::KioskOwnerCap, arg8: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        verify_version(arg1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = *0x1::type_name::borrow_string(&v0);
        let v2 = 0x1::type_name::get<T1>();
        let v3 = *0x1::type_name::borrow_string(&v2);
        assert!(0x2::table::contains<0x1::ascii::String, Bridge>(&arg1.bridges, v1), 5);
        let v4 = 0x2::table::borrow_mut<0x1::ascii::String, Bridge>(&mut arg1.bridges, v1);
        assert!(v4.nft_type == v1, 3);
        assert!(v4.ft_type == v3, 3);
        assert!(v4.state == 1, 6);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&v4.registry, arg3), 8);
        assert!(0x2::kiosk::has_item_with_type<T0>(&arg1.kiosk, arg3), 9);
        if (0x2::table::contains<0x2::object::ID, Reservation>(&v4.reservations, arg3)) {
            let v5 = 0x2::table::remove<0x2::object::ID, Reservation>(&mut v4.reservations, arg3);
            assert!(v5.holder == 0x2::tx_context::sender(arg8) || v5.expires_at < 0x2::clock::timestamp_ms(arg0), 16);
        };
        let v6 = 0x2::coin::into_balance<T1>(arg2);
        if (arg1.fee_out > 0) {
            let v7 = if (0x2::bag::contains<0x1::ascii::String>(&arg1.fees, v3)) {
                0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg1.fees, v3)
            } else {
                0x2::balance::zero<T1>()
            };
            let v8 = v7;
            0x2::balance::join<T1>(&mut v8, 0x2::balance::split<T1>(&mut v6, (((*0x2::table::borrow<0x2::object::ID, u64>(&v4.registry, arg3) as u128) * (arg1.fee_out as u128) / 10000) as u64)));
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg1.fees, v3, v8);
        };
        assert!(0x2::balance::value<T1>(&v6) == *0x2::table::borrow<0x2::object::ID, u64>(&v4.registry, arg3), 11);
        0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut v4.treasury, v3), v6);
        let v9 = if (0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, 0x2::transfer_policy::TransferPolicy<T0>>(&v4.id, v1)) {
            0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0x2::transfer_policy::TransferPolicy<T0>>(&mut v4.id, v1)
        } else {
            assert!(!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg4), 10);
            assert!(!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg4), 10);
            arg4
        };
        let (v10, v11) = 0x2::kiosk::purchase_with_cap<T0>(&mut arg1.kiosk, 0x2::kiosk::list_with_purchase_cap<T0>(&mut arg1.kiosk, &arg1.kiosk_owner_cap, arg3, 0, arg8), 0x2::coin::zero<0x2::sui::SUI>(arg8));
        let v12 = v11;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(v9)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(v9, &mut v12, arg5);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
        };
        0x2::kiosk::lock<T0>(arg6, arg7, v9, v10);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(v9)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v12, arg6);
        };
        let v13 = BridgeNftToCoinEvent{
            bridge_id : 0x2::object::id<Bridge>(v4),
            nft_type  : v1,
            ft_type   : v3,
            direction : 1,
            nft_id    : arg3,
            amount    : *0x2::table::borrow<0x2::object::ID, u64>(&v4.registry, arg3),
        };
        0x2::event::emit<BridgeNftToCoinEvent>(v13);
        v12
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
        if (arg0.reservation_mode > 0) {
            let v5 = Reservation{
                holder     : 0x2::tx_context::sender(arg6),
                expires_at : 0,
            };
            0x2::table::add<0x2::object::ID, Reservation>(&mut v4.reservations, arg1, v5);
        };
        let v6 = 0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut v4.treasury, v3), *0x2::table::borrow<0x2::object::ID, u64>(&v4.registry, arg1));
        if (arg0.fee_in > 0) {
            let v7 = if (0x2::bag::contains<0x1::ascii::String>(&arg0.fees, v3)) {
                0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.fees, v3)
            } else {
                0x2::balance::zero<T1>()
            };
            let v8 = v7;
            0x2::balance::join<T1>(&mut v8, 0x2::balance::split<T1>(&mut v6, (((0x2::balance::value<T1>(&v6) as u128) * (arg0.fee_in as u128) / 10000) as u64)));
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg0.fees, v3, v8);
        };
        let v9 = if (0x2::dynamic_object_field::exists_with_type<0x1::ascii::String, 0x2::transfer_policy::TransferPolicy<T0>>(&v4.id, v1)) {
            0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, 0x2::transfer_policy::TransferPolicy<T0>>(&mut v4.id, v1)
        } else {
            assert!(!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg2), 10);
            assert!(!0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg2), 10);
            arg2
        };
        let (v10, v11) = 0x2::kiosk::purchase_with_cap<T0>(arg4, 0x2::kiosk::list_with_purchase_cap<T0>(arg4, arg5, arg1, 0, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v12 = v11;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(v9)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(v9, &mut v12, arg3);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        0x2::kiosk::lock<T0>(&mut arg0.kiosk, &arg0.kiosk_owner_cap, v9, v10);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(v9)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v12, &arg0.kiosk);
        };
        let v13 = BridgeNftToCoinEvent{
            bridge_id : 0x2::object::id<Bridge>(v4),
            nft_type  : v1,
            ft_type   : v3,
            direction : 0,
            nft_id    : arg1,
            amount    : *0x2::table::borrow<0x2::object::ID, u64>(&v4.registry, arg1),
        };
        0x2::event::emit<BridgeNftToCoinEvent>(v13);
        (v12, 0x2::coin::from_balance<T1>(v6, arg6))
    }

    fun create_bridge<T0: store + key, T1>(arg0: &mut Manager, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = *0x1::type_name::borrow_string(&v0);
        let v2 = 0x1::type_name::get<T1>();
        let v3 = *0x1::type_name::borrow_string(&v2);
        assert!(!0x2::table::contains<0x1::ascii::String, Bridge>(&arg0.bridges, v1), 4);
        let v4 = Bridge{
            id           : 0x2::object::new(arg2),
            nft_type     : v1,
            ft_type      : v3,
            state        : 0,
            supply       : 0,
            treasury     : 0x2::bag::new(arg2),
            registry     : 0x2::table::new<0x2::object::ID, u64>(arg2),
            reservations : 0x2::table::new<0x2::object::ID, Reservation>(arg2),
        };
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut v4.treasury, v3, 0x2::coin::into_balance<T1>(arg1));
        0x2::table::add<0x1::ascii::String, Bridge>(&mut arg0.bridges, v1, v4);
        let v5 = RegisterBridgeEvent{
            bridge_id : 0x2::object::id<Bridge>(&v4),
            nft_type  : v1,
            ft_type   : v3,
        };
        0x2::event::emit<RegisterBridgeEvent>(v5);
    }

    fun init(arg0: TRADEPORT_BRIDGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<TRADEPORT_BRIDGE>(arg0, arg1);
        let (v0, v1) = 0x2::kiosk::new(arg1);
        let v2 = Manager{
            id               : 0x2::object::new(arg1),
            version          : 1,
            admin            : 0x2::tx_context::sender(arg1),
            public_key       : 0x1::vector::empty<u8>(),
            fee_in           : 0,
            fee_out          : 0,
            reservation_mode : 0,
            reservation_fees : 0x2::table::new<u64, u64>(arg1),
            kiosk            : v0,
            kiosk_owner_cap  : v1,
            bridges          : 0x2::table::new<0x1::ascii::String, Bridge>(arg1),
            fees             : 0x2::bag::new(arg1),
        };
        0x2::transfer::share_object<Manager>(v2);
    }

    public fun load_bridge<T0: store + key, T1>(arg0: &mut Manager, arg1: u64, arg2: vector<0x2::object::ID>, arg3: vector<u64>, arg4: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg4);
        assert!(0x1::vector::length<0x2::object::ID>(&arg2) == 0x1::vector::length<u64>(&arg3), 17);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = *0x1::type_name::borrow_string(&v0);
        let v2 = 0x1::type_name::get<T1>();
        let v3 = *0x1::type_name::borrow_string(&v2);
        assert!(0x2::table::contains<0x1::ascii::String, Bridge>(&arg0.bridges, v1), 5);
        let v4 = 0x2::table::borrow_mut<0x1::ascii::String, Bridge>(&mut arg0.bridges, v1);
        assert!(v4.nft_type == v1, 3);
        assert!(v4.ft_type == v3, 3);
        assert!(v4.state == 0, 6);
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg2)) {
            let v5 = 0x1::vector::pop_back<u64>(&mut arg3);
            0x2::table::add<0x2::object::ID, u64>(&mut v4.registry, 0x1::vector::pop_back<0x2::object::ID>(&mut arg2), v5);
            v4.supply = v4.supply + v5;
        };
        let v6 = 0x2::bag::borrow<0x1::ascii::String, 0x2::balance::Balance<T1>>(&v4.treasury, v3);
        assert!(v4.supply <= 0x2::balance::value<T1>(v6), 7);
        if (v4.supply == 0x2::balance::value<T1>(v6)) {
            v4.state = 1;
        };
        let v7 = LoadBridgeEvent{
            bridge_id : 0x2::object::id<Bridge>(v4),
            nft_type  : v1,
            ft_type   : v3,
            index     : arg1,
            state     : v4.state,
        };
        0x2::event::emit<LoadBridgeEvent>(v7);
    }

    public fun register_bridge<T0: store + key, T1>(arg0: &mut Manager, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        create_bridge<T0, T1>(arg0, arg1, arg2);
    }

    public fun register_bridge_with_signature<T0: store + key, T1>(arg0: &mut Manager, arg1: 0x1::ascii::String, arg2: 0x2::coin::Coin<T1>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x1::type_name::get<T1>();
        let v3 = Request{
            sender    : 0x2::bcs::to_bytes<address>(&v0),
            order_id  : arg1,
            nft_type  : *0x1::type_name::borrow_string(&v1),
            ft_type   : *0x1::type_name::borrow_string(&v2),
            ft_supply : 0x2::coin::value<T1>(&arg2),
        };
        verify_signature<Request>(arg3, arg0.public_key, &v3);
        create_bridge<T0, T1>(arg0, arg2, arg4);
    }

    public fun reserve_nft<T0: store + key, T1>(arg0: &0x2::clock::Clock, arg1: &mut Manager, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = *0x1::type_name::borrow_string(&v0);
        let v2 = 0x1::type_name::get<T1>();
        let v3 = *0x1::type_name::borrow_string(&v2);
        assert!(0x2::table::contains<0x1::ascii::String, Bridge>(&arg1.bridges, v1), 5);
        let v4 = 0x2::table::borrow_mut<0x1::ascii::String, Bridge>(&mut arg1.bridges, v1);
        assert!(v4.nft_type == v1, 3);
        assert!(v4.ft_type == v3, 3);
        assert!(v4.state == 1, 6);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&v4.registry, arg2), 8);
        assert!(0x2::kiosk::has_item_with_type<T0>(&arg1.kiosk, arg2), 9);
        assert!(arg1.reservation_mode > 0, 13);
        assert!(0x2::table::contains<u64, u64>(&arg1.reservation_fees, arg3), 14);
        if (0x2::table::contains<0x2::object::ID, Reservation>(&v4.reservations, arg2)) {
            let v5 = 0x2::table::remove<0x2::object::ID, Reservation>(&mut v4.reservations, arg2);
            if (arg1.reservation_mode == 1) {
                assert!(v5.holder == 0x2::tx_context::sender(arg5), 15);
            } else {
                assert!(arg1.reservation_mode == 2, 13);
                assert!(v5.holder == 0x2::tx_context::sender(arg5) || v5.expires_at < 0x2::clock::timestamp_ms(arg0), 16);
            };
        };
        assert!(0x2::coin::value<T1>(&arg4) == (((*0x2::table::borrow<0x2::object::ID, u64>(&v4.registry, arg2) as u128) * (*0x2::table::borrow<u64, u64>(&arg1.reservation_fees, arg3) as u128) / 10000) as u64), 11);
        let v6 = if (0x2::bag::contains<0x1::ascii::String>(&arg1.fees, v3)) {
            0x2::bag::remove<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg1.fees, v3)
        } else {
            0x2::balance::zero<T1>()
        };
        let v7 = v6;
        0x2::balance::join<T1>(&mut v7, 0x2::coin::into_balance<T1>(arg4));
        0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg1.fees, v3, v7);
        let v8 = Reservation{
            holder     : 0x2::tx_context::sender(arg5),
            expires_at : 0x2::clock::timestamp_ms(arg0) + arg3 * 24 * 3600 * 1000,
        };
        let v9 = ReserveNftEvent{
            bridge_id  : 0x2::object::id<Bridge>(v4),
            nft_type   : v1,
            ft_type    : v3,
            nft_id     : arg2,
            holder     : v8.holder,
            expires_at : v8.expires_at,
        };
        0x2::event::emit<ReserveNftEvent>(v9);
        0x2::table::add<0x2::object::ID, Reservation>(&mut v4.reservations, arg2, v8);
    }

    entry fun set_admin(arg0: &mut Manager, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    entry fun set_fee(arg0: &mut Manager, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg3);
        assert!(arg1 < 10000 && arg2 < 10000, 17);
        arg0.fee_in = arg1;
        arg0.fee_out = arg2;
    }

    entry fun set_public_key(arg0: &mut Manager, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.public_key = arg1;
    }

    entry fun set_reservation_fees(arg0: &mut Manager, arg1: vector<u64>, arg2: vector<u64>, arg3: vector<u64>, arg4: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg4);
        while (!0x1::vector::is_empty<u64>(&arg1)) {
            0x2::table::remove<u64, u64>(&mut arg0.reservation_fees, 0x1::vector::pop_back<u64>(&mut arg1));
        };
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 17);
        while (!0x1::vector::is_empty<u64>(&arg2)) {
            let v0 = 0x1::vector::pop_back<u64>(&mut arg3);
            assert!(v0 < 10000, 17);
            0x2::table::add<u64, u64>(&mut arg0.reservation_fees, 0x1::vector::pop_back<u64>(&mut arg2), v0);
        };
    }

    entry fun set_reservation_mode(arg0: &mut Manager, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        assert!(arg1 <= 2, 13);
        arg0.reservation_mode = arg1;
    }

    entry fun set_version(arg0: &mut Manager, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    fun verify_admin(arg0: &Manager, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_signature<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &T0) {
        let v0 = 0x2::bcs::to_bytes<T0>(arg2);
        assert!(0x2::ed25519::ed25519_verify(&arg0, &arg1, &v0), 12);
    }

    fun verify_version(arg0: &Manager) {
        assert!(arg0.version == 1, 1);
    }

    entry fun withdraw_fee<T0>(arg0: &mut Manager, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg3);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = *0x1::type_name::borrow_string(&v0);
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg0.fees, v1), 17);
        let v2 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.fees, v1);
        assert!(0x2::balance::value<T0>(v2) >= arg1, 17);
        if (0x2::tx_context::sender(arg3) == arg2) {
            0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, arg1), arg3), arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, arg1), arg3), arg2);
        };
    }

    // decompiled from Move bytecode v6
}

