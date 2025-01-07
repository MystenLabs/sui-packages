module 0x20eb3797930e205055f0ec72c9d8ca98b4a62b2b47d3d097ab1abecc2be6a97a::tradeport_price_lock {
    struct TRADEPORT_PRICE_LOCK has drop {
        dummy_field: bool,
    }

    struct Store has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        version: u64,
    }

    struct Strike<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        strike_type: u64,
        state: u64,
        maker_price: u64,
        marketplace_fee: u64,
        premium: u64,
        premium_fee: u64,
        expire_in: u64,
        maker: address,
        taker: 0x1::option::Option<address>,
        expire_at: 0x1::option::Option<u64>,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        taker_price: 0x1::option::Option<u64>,
    }

    struct CoinRequest<phantom T0: store + key> {
        strike_id: 0x2::object::ID,
    }

    struct StrikeCreatedEvent<phantom T0: store + key> has copy, drop {
        strike_id: 0x2::object::ID,
        strike_type: u64,
        maker_price: u64,
        marketplace_fee: u64,
        premium: u64,
        premium_fee: u64,
        expire_in: u64,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        maker: address,
        maker_kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct StrikeCanceledEvent<phantom T0: store + key> has copy, drop {
        strike_id: 0x2::object::ID,
        strike_type: u64,
        maker_price: u64,
    }

    struct StrikeLockedEvent<phantom T0: store + key> has copy, drop {
        strike_id: 0x2::object::ID,
        strike_type: u64,
        maker_price: u64,
        taker: address,
        expire_at: u64,
    }

    struct StrikeConfirmedEvent<phantom T0: store + key> has copy, drop {
        strike_id: 0x2::object::ID,
        strike_type: u64,
        maker_price: u64,
        taker: address,
        nft_id: 0x2::object::ID,
        taker_price: u64,
    }

    public fun cancel_strike<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Strike<T0>>(&arg0.id, arg1), 2);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Strike<T0>>(&mut arg0.id, arg1);
        assert!(v0.state == 0 || v0.state == 1, 2);
        assert!(v0.maker == 0x2::tx_context::sender(arg3), 1);
        if (0x2::dynamic_object_field::exists_with_type<u64, 0x2::kiosk::PurchaseCap<T0>>(&v0.id, 0)) {
            0x2::kiosk::return_purchase_cap<T0>(arg2, 0x2::dynamic_object_field::remove<u64, 0x2::kiosk::PurchaseCap<T0>>(&mut v0.id, 0));
        };
        if (0x2::dynamic_field::exists_with_type<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&v0.id, 1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::dynamic_field::remove<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v0.id, 1), arg3), v0.maker);
        };
        v0.state = 4;
        let v1 = StrikeCanceledEvent<T0>{
            strike_id   : arg1,
            strike_type : v0.strike_type,
            maker_price : v0.maker_price,
        };
        0x2::event::emit<StrikeCanceledEvent<T0>>(v1);
    }

    public fun confirm_long_strike<T0: store + key>(arg0: &mut Store, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::transfer_policy::TransferPolicy<T0>, arg7: u64, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Strike<T0>>(&arg0.id, arg2), 4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Strike<T0>>(&mut arg0.id, arg2);
        assert!(v0.strike_type == 1, 9);
        assert!(v0.state == 1, 2);
        assert!(0x1::option::is_some<u64>(&v0.expire_at) && *0x1::option::borrow<u64>(&v0.expire_at) > 0x2::clock::timestamp_ms(arg1), 3);
        assert!(0x1::option::is_some<address>(&v0.taker) && *0x1::option::borrow<address>(&v0.taker) == 0x2::tx_context::sender(arg9) && 0x1::option::is_some<0x2::object::ID>(&v0.nft_id) && 0x2::dynamic_object_field::exists_with_type<u64, 0x2::kiosk::PurchaseCap<T0>>(&v0.id, 0), 1);
        let (v1, v2) = 0x2::kiosk::purchase_with_cap<T0>(arg3, 0x2::dynamic_object_field::remove<u64, 0x2::kiosk::PurchaseCap<T0>>(&mut v0.id, 0), 0x2::coin::zero<0x2::sui::SUI>(arg9));
        let v3 = v1;
        assert!(0x1::option::is_some<0x2::object::ID>(&v0.nft_id) && 0x2::object::id<T0>(&v3) == *0x1::option::borrow<0x2::object::ID>(&v0.nft_id), 1);
        0x2::kiosk::lock<T0>(arg4, arg5, arg6, v3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg8) == v0.maker_price + v0.marketplace_fee, 8);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::split<0x2::sui::SUI>(&mut arg8, v0.marketplace_fee, arg9));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg8, v0.maker);
        v0.state = 3;
        v0.taker_price = 0x1::option::some<u64>(arg7);
        let v4 = StrikeConfirmedEvent<T0>{
            strike_id   : arg2,
            strike_type : v0.strike_type,
            maker_price : v0.maker_price,
            taker       : *0x1::option::borrow<address>(&v0.taker),
            nft_id      : *0x1::option::borrow<0x2::object::ID>(&v0.nft_id),
            taker_price : arg7,
        };
        0x2::event::emit<StrikeConfirmedEvent<T0>>(v4);
        v2
    }

    public fun create_long_strike<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::kiosk::has_item_with_type<T0>(arg2, arg1), 5);
        assert!(get_premium(arg4) == arg6, 7);
        assert!(arg7 == 604800000, 10);
        let v0 = 0x2::object::new(arg8);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = get_premium_fee(arg6);
        let v3 = Strike<T0>{
            id              : v0,
            strike_type     : 1,
            state           : 0,
            maker_price     : arg4,
            marketplace_fee : arg5,
            premium         : arg6,
            premium_fee     : v2,
            expire_in       : arg7,
            maker           : 0x2::tx_context::sender(arg8),
            taker           : 0x1::option::none<address>(),
            expire_at       : 0x1::option::none<u64>(),
            nft_id          : 0x1::option::some<0x2::object::ID>(arg1),
            taker_price     : 0x1::option::none<u64>(),
        };
        0x2::dynamic_object_field::add<u64, 0x2::kiosk::PurchaseCap<T0>>(&mut v3.id, 0, 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, arg1, 0, arg8));
        0x2::dynamic_object_field::add<0x2::object::ID, Strike<T0>>(&mut arg0.id, v1, v3);
        let v4 = StrikeCreatedEvent<T0>{
            strike_id       : v1,
            strike_type     : 1,
            maker_price     : arg4,
            marketplace_fee : arg5,
            premium         : arg6,
            premium_fee     : v2,
            expire_in       : arg7,
            nft_id          : 0x1::option::some<0x2::object::ID>(arg1),
            maker           : 0x2::tx_context::sender(arg8),
            maker_kiosk_id  : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(arg2)),
        };
        0x2::event::emit<StrikeCreatedEvent<T0>>(v4);
        v1
    }

    public fun create_short_strike<T0: store + key>(arg0: &mut Store, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= arg1 + arg2, 6);
        assert!(get_premium(arg1) == arg3, 7);
        assert!(arg4 == 604800000, 10);
        let v0 = get_premium_fee(arg3);
        let v1 = Strike<T0>{
            id              : 0x2::object::new(arg6),
            strike_type     : 0,
            state           : 0,
            maker_price     : arg1,
            marketplace_fee : arg2,
            premium         : arg3,
            premium_fee     : v0,
            expire_in       : arg4,
            maker           : 0x2::tx_context::sender(arg6),
            taker           : 0x1::option::none<address>(),
            expire_at       : 0x1::option::none<u64>(),
            nft_id          : 0x1::option::none<0x2::object::ID>(),
            taker_price     : 0x1::option::none<u64>(),
        };
        let v2 = 0x2::object::id<Strike<T0>>(&v1);
        0x2::dynamic_field::add<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v1.id, 1, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        0x2::dynamic_object_field::add<0x2::object::ID, Strike<T0>>(&mut arg0.id, v2, v1);
        let v3 = StrikeCreatedEvent<T0>{
            strike_id       : v2,
            strike_type     : 0,
            maker_price     : arg1,
            marketplace_fee : arg2,
            premium         : arg3,
            premium_fee     : v0,
            expire_in       : arg4,
            nft_id          : 0x1::option::none<0x2::object::ID>(),
            maker           : 0x2::tx_context::sender(arg6),
            maker_kiosk_id  : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::event::emit<StrikeCreatedEvent<T0>>(v3);
        v2
    }

    public fun end_confirm_short_strike<T0: store + key>(arg0: &mut Store, arg1: &mut 0x47c8d4e4f92f877521a1b9dd553554dfec0f449277a9611aed4349c1c40a96ba::kiosk_transfers::Store, arg2: CoinRequest<T0>, arg3: 0x2::object::ID, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &0x2::transfer_policy::TransferPolicy<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let CoinRequest { strike_id: v0 } = arg2;
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Strike<T0>>(&arg0.id, v0), 4);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg5, arg3), 5);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Strike<T0>>(&mut arg0.id, v0);
        assert!(v1.strike_type == 0, 9);
        assert!(v1.state == 1, 2);
        assert!(0x1::option::is_some<address>(&v1.taker) && *0x1::option::borrow<address>(&v1.taker) == 0x2::tx_context::sender(arg9), 1);
        v1.nft_id = 0x1::option::some<0x2::object::ID>(arg3);
        v1.state = 3;
        v1.taker_price = 0x1::option::some<u64>(arg8);
        let v2 = StrikeConfirmedEvent<T0>{
            strike_id   : v0,
            strike_type : v1.strike_type,
            maker_price : v1.maker_price,
            taker       : *0x1::option::borrow<address>(&v1.taker),
            nft_id      : *0x1::option::borrow<0x2::object::ID>(&v1.nft_id),
            taker_price : arg8,
        };
        0x2::event::emit<StrikeConfirmedEvent<T0>>(v2);
        0x47c8d4e4f92f877521a1b9dd553554dfec0f449277a9611aed4349c1c40a96ba::kiosk_transfers::transfer<T0>(arg1, arg4, arg5, arg6, arg3, v1.maker, arg7, arg9)
    }

    fun get_premium(arg0: u64) : u64 {
        arg0 * 3 / 100
    }

    fun get_premium_fee(arg0: u64) : u64 {
        arg0 * 25 / 100
    }

    fun init(arg0: TRADEPORT_PRICE_LOCK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<TRADEPORT_PRICE_LOCK>(arg0, arg1);
        let v0 = Store{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            version : 0,
        };
        0x2::transfer::share_object<Store>(v0);
    }

    public fun lock_strike<T0: store + key>(arg0: &mut Store, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Strike<T0>>(&arg0.id, arg2), 4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Strike<T0>>(&mut arg0.id, arg2);
        assert!(v0.state == 0, 2);
        assert!(v0.premium + v0.premium_fee == 0x2::coin::value<0x2::sui::SUI>(&arg3), 7);
        let v1 = 0x2::clock::timestamp_ms(arg1) + v0.expire_in;
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v0.premium_fee, arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0.maker);
        v0.state = 1;
        v0.taker = 0x1::option::some<address>(0x2::tx_context::sender(arg4));
        v0.expire_at = 0x1::option::some<u64>(v1);
        let v2 = StrikeLockedEvent<T0>{
            strike_id   : arg2,
            strike_type : v0.strike_type,
            maker_price : v0.maker_price,
            taker       : 0x2::tx_context::sender(arg4),
            expire_at   : v1,
        };
        0x2::event::emit<StrikeLockedEvent<T0>>(v2);
    }

    public fun start_confirm_short_strike<T0: store + key>(arg0: &mut Store, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : CoinRequest<T0> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Strike<T0>>(&arg0.id, arg2), 4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Strike<T0>>(&mut arg0.id, arg2);
        assert!(v0.strike_type == 0, 9);
        assert!(v0.state == 1, 2);
        assert!(0x1::option::is_some<u64>(&v0.expire_at) && *0x1::option::borrow<u64>(&v0.expire_at) > 0x2::clock::timestamp_ms(arg1), 3);
        assert!(0x2::dynamic_field::exists_with_type<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&v0.id, 1) && 0x2::balance::value<0x2::sui::SUI>(0x2::dynamic_field::borrow<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&v0.id, 1)) >= arg3, 6);
        assert!(0x1::option::is_some<address>(&v0.taker) && *0x1::option::borrow<address>(&v0.taker) == 0x2::tx_context::sender(arg4), 1);
        let v1 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::dynamic_field::remove<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v0.id, 1), arg4);
        0x2::pay::keep<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v1, arg3, arg4), arg4);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, v1);
        CoinRequest<T0>{strike_id: arg2}
    }

    public fun withdraw_balance(arg0: &0x2::package::Publisher, arg1: &mut Store, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Store>(arg0), 1);
        0x2::pay::keep<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.balance), arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

