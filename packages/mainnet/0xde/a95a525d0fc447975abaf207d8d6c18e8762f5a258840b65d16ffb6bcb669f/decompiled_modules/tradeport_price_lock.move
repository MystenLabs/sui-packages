module 0xdea95a525d0fc447975abaf207d8d6c18e8762f5a258840b65d16ffb6bcb669f::tradeport_price_lock {
    struct TRADEPORT_PRICE_LOCK has drop {
        dummy_field: bool,
    }

    struct Store has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        version: u64,
    }

    struct Lock<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        lock_type: u64,
        state: u64,
        maker_price: u64,
        marketplace_fee: u64,
        royalty: u64,
        premium: u64,
        premium_fee: u64,
        expire_in: u64,
        maker: address,
        taker: 0x1::option::Option<address>,
        expire_at: 0x1::option::Option<u64>,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        taker_price: 0x1::option::Option<u64>,
    }

    struct ConfirmLockRequest<phantom T0: store + key> {
        lock_id: 0x2::object::ID,
    }

    struct LockCreatedEvent<phantom T0: store + key> has copy, drop {
        lock_id: 0x2::object::ID,
        lock_type: u64,
        maker_price: u64,
        marketplace_fee: u64,
        royalty: u64,
        premium: u64,
        premium_fee: u64,
        expire_in: u64,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        maker: address,
        maker_kiosk_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct LockCanceledEvent<phantom T0: store + key> has copy, drop {
        lock_id: 0x2::object::ID,
        lock_type: u64,
        maker_price: u64,
        maker: address,
        nft_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct LockLockedEvent<phantom T0: store + key> has copy, drop {
        lock_id: 0x2::object::ID,
        lock_type: u64,
        maker_price: u64,
        maker: address,
        taker: address,
        expire_at: u64,
        nft_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct LockConfirmedEvent<phantom T0: store + key> has copy, drop {
        lock_id: 0x2::object::ID,
        lock_type: u64,
        maker_price: u64,
        maker: address,
        taker: address,
        nft_id: 0x2::object::ID,
        taker_price: u64,
    }

    public fun buy_lock<T0: store + key>(arg0: &mut Store, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Lock<T0>>(&arg0.id, arg2), 4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Lock<T0>>(&mut arg0.id, arg2);
        assert!(v0.state == 0, 2);
        assert!(v0.premium == 0x2::coin::value<0x2::sui::SUI>(&arg3), 7);
        let v1 = 0x2::clock::timestamp_ms(arg1) + v0.expire_in;
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v0.premium_fee, arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0.maker);
        v0.state = 1;
        v0.taker = 0x1::option::some<address>(0x2::tx_context::sender(arg4));
        v0.expire_at = 0x1::option::some<u64>(v1);
        let v2 = LockLockedEvent<T0>{
            lock_id     : arg2,
            lock_type   : v0.lock_type,
            maker_price : v0.maker_price,
            maker       : v0.maker,
            taker       : 0x2::tx_context::sender(arg4),
            expire_at   : v1,
            nft_id      : v0.nft_id,
        };
        0x2::event::emit<LockLockedEvent<T0>>(v2);
    }

    public fun cancel_lock<T0: store + key>(arg0: &mut Store, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Lock<T0>>(&arg0.id, arg2), 2);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Lock<T0>>(&mut arg0.id, arg2);
        assert!(v0.state == 0 || v0.state == 1 && 0x1::option::is_some<u64>(&v0.expire_at) && *0x1::option::borrow<u64>(&v0.expire_at) <= 0x2::clock::timestamp_ms(arg1), 2);
        assert!(v0.maker == 0x2::tx_context::sender(arg4), 1);
        if (0x2::dynamic_object_field::exists_with_type<u64, 0x2::kiosk::PurchaseCap<T0>>(&v0.id, 0)) {
            0x2::kiosk::return_purchase_cap<T0>(arg3, 0x2::dynamic_object_field::remove<u64, 0x2::kiosk::PurchaseCap<T0>>(&mut v0.id, 0));
        };
        if (0x2::dynamic_field::exists_with_type<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&v0.id, 1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::dynamic_field::remove<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v0.id, 1), arg4), v0.maker);
        };
        let v1 = LockCanceledEvent<T0>{
            lock_id     : arg2,
            lock_type   : v0.lock_type,
            maker_price : v0.maker_price,
            maker       : v0.maker,
            nft_id      : v0.nft_id,
        };
        0x2::event::emit<LockCanceledEvent<T0>>(v1);
        delete_lock<T0>(v0);
    }

    public fun create_long_lock<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::kiosk::has_item_with_type<T0>(arg2, arg1), 5);
        assert!(get_premium(arg4) == arg7, 7);
        assert!(arg8 == 604800000, 10);
        let v0 = 0x2::object::new(arg9);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = get_premium_fee(arg7);
        let v3 = Lock<T0>{
            id              : v0,
            lock_type       : 1,
            state           : 0,
            maker_price     : arg4,
            marketplace_fee : arg5,
            royalty         : arg6,
            premium         : arg7,
            premium_fee     : v2,
            expire_in       : arg8,
            maker           : 0x2::tx_context::sender(arg9),
            taker           : 0x1::option::none<address>(),
            expire_at       : 0x1::option::none<u64>(),
            nft_id          : 0x1::option::some<0x2::object::ID>(arg1),
            taker_price     : 0x1::option::none<u64>(),
        };
        0x2::dynamic_object_field::add<u64, 0x2::kiosk::PurchaseCap<T0>>(&mut v3.id, 0, 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, arg1, 0, arg9));
        0x2::dynamic_object_field::add<0x2::object::ID, Lock<T0>>(&mut arg0.id, v1, v3);
        let v4 = LockCreatedEvent<T0>{
            lock_id         : v1,
            lock_type       : 1,
            maker_price     : arg4,
            marketplace_fee : arg5,
            royalty         : arg6,
            premium         : arg7,
            premium_fee     : v2,
            expire_in       : arg8,
            nft_id          : 0x1::option::some<0x2::object::ID>(arg1),
            maker           : 0x2::tx_context::sender(arg9),
            maker_kiosk_id  : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(arg2)),
        };
        0x2::event::emit<LockCreatedEvent<T0>>(v4);
        v1
    }

    public fun create_short_lock<T0: store + key>(arg0: &mut Store, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= arg1 + arg3 + arg2, 6);
        assert!(get_premium(arg1) == arg4, 7);
        assert!(arg5 == 604800000, 10);
        let v0 = get_premium_fee(arg4);
        let v1 = Lock<T0>{
            id              : 0x2::object::new(arg7),
            lock_type       : 0,
            state           : 0,
            maker_price     : arg1,
            marketplace_fee : arg2,
            royalty         : arg3,
            premium         : arg4,
            premium_fee     : v0,
            expire_in       : arg5,
            maker           : 0x2::tx_context::sender(arg7),
            taker           : 0x1::option::none<address>(),
            expire_at       : 0x1::option::none<u64>(),
            nft_id          : 0x1::option::none<0x2::object::ID>(),
            taker_price     : 0x1::option::none<u64>(),
        };
        let v2 = 0x2::object::id<Lock<T0>>(&v1);
        0x2::dynamic_field::add<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v1.id, 1, 0x2::coin::into_balance<0x2::sui::SUI>(arg6));
        0x2::dynamic_object_field::add<0x2::object::ID, Lock<T0>>(&mut arg0.id, v2, v1);
        let v3 = LockCreatedEvent<T0>{
            lock_id         : v2,
            lock_type       : 0,
            maker_price     : arg1,
            marketplace_fee : arg2,
            royalty         : arg3,
            premium         : arg4,
            premium_fee     : v0,
            expire_in       : arg5,
            nft_id          : 0x1::option::none<0x2::object::ID>(),
            maker           : 0x2::tx_context::sender(arg7),
            maker_kiosk_id  : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::event::emit<LockCreatedEvent<T0>>(v3);
        v2
    }

    fun delete_lock<T0: store + key>(arg0: Lock<T0>) {
        let Lock {
            id              : v0,
            lock_type       : _,
            state           : _,
            maker_price     : _,
            marketplace_fee : _,
            royalty         : _,
            premium         : _,
            premium_fee     : _,
            expire_in       : _,
            maker           : _,
            taker           : _,
            expire_at       : _,
            nft_id          : _,
            taker_price     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun end_confirm_long_lock<T0: store + key>(arg0: &mut Store, arg1: ConfirmLockRequest<T0>, arg2: &0x2::kiosk::Kiosk, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let ConfirmLockRequest { lock_id: v0 } = arg1;
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Lock<T0>>(&arg0.id, v0), 4);
        let v1 = 0x2::dynamic_object_field::remove<0x2::object::ID, Lock<T0>>(&mut arg0.id, v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v1.maker_price + v1.marketplace_fee, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1.maker_price, arg4), v1.maker);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg3);
        let v2 = LockConfirmedEvent<T0>{
            lock_id     : v0,
            lock_type   : v1.lock_type,
            maker_price : v1.maker_price,
            maker       : v1.maker,
            taker       : *0x1::option::borrow<address>(&v1.taker),
            nft_id      : *0x1::option::borrow<0x2::object::ID>(&v1.nft_id),
            taker_price : v1.maker_price,
        };
        0x2::event::emit<LockConfirmedEvent<T0>>(v2);
        delete_lock<T0>(v1);
        0x2::transfer_policy::new_request<T0>(*0x1::option::borrow<0x2::object::ID>(&v1.nft_id), v1.maker_price, 0x2::object::id<0x2::kiosk::Kiosk>(arg2))
    }

    public fun end_confirm_long_lock_with_bid<T0: store + key>(arg0: &mut Store, arg1: ConfirmLockRequest<T0>, arg2: &0x2::transfer_policy::TransferRequest<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let ConfirmLockRequest { lock_id: v0 } = arg1;
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Lock<T0>>(&arg0.id, v0), 4);
        let v1 = 0x2::dynamic_object_field::remove<0x2::object::ID, Lock<T0>>(&mut arg0.id, v0);
        let v2 = 0x2::transfer_policy::paid<T0>(arg2);
        assert!(0x2::transfer_policy::item<T0>(arg2) == *0x1::option::borrow<0x2::object::ID>(&v1.nft_id), 11);
        assert!(v1.maker_price <= v2, 8);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v1.maker_price + v1.marketplace_fee, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1.maker_price, arg4), v1.maker);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg3);
        let v3 = LockConfirmedEvent<T0>{
            lock_id     : v0,
            lock_type   : v1.lock_type,
            maker_price : v1.maker_price,
            maker       : v1.maker,
            taker       : *0x1::option::borrow<address>(&v1.taker),
            nft_id      : *0x1::option::borrow<0x2::object::ID>(&v1.nft_id),
            taker_price : v2,
        };
        0x2::event::emit<LockConfirmedEvent<T0>>(v3);
        delete_lock<T0>(v1);
    }

    public fun end_confirm_short_lock<T0: store + key>(arg0: &mut Store, arg1: &mut 0x47c8d4e4f92f877521a1b9dd553554dfec0f449277a9611aed4349c1c40a96ba::kiosk_transfers::Store, arg2: ConfirmLockRequest<T0>, arg3: 0x2::object::ID, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::tx_context::TxContext) {
        let ConfirmLockRequest { lock_id: v0 } = arg2;
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Lock<T0>>(&arg0.id, v0), 4);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg4, arg3), 5);
        let v1 = 0x2::dynamic_object_field::remove<0x2::object::ID, Lock<T0>>(&mut arg0.id, v0);
        assert!(v1.lock_type == 0, 9);
        assert!(v1.state == 1, 2);
        assert!(0x1::option::is_some<address>(&v1.taker) && *0x1::option::borrow<address>(&v1.taker) == 0x2::tx_context::sender(arg6), 1);
        let v2 = LockConfirmedEvent<T0>{
            lock_id     : v0,
            lock_type   : v1.lock_type,
            maker_price : v1.maker_price,
            maker       : v1.maker,
            taker       : *0x1::option::borrow<address>(&v1.taker),
            nft_id      : *0x1::option::borrow<0x2::object::ID>(&v1.nft_id),
            taker_price : *0x1::option::borrow<u64>(&v1.taker_price),
        };
        0x2::event::emit<LockConfirmedEvent<T0>>(v2);
        delete_lock<T0>(v1);
        0x47c8d4e4f92f877521a1b9dd553554dfec0f449277a9611aed4349c1c40a96ba::kiosk_transfers::transfer_with_purchase_capability<T0>(arg1, arg4, arg5, arg3, v1.maker, arg6);
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

    public fun start_confirm_long_lock<T0: store + key>(arg0: &mut Store, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferRequest<T0>, ConfirmLockRequest<T0>) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Lock<T0>>(&arg0.id, arg2), 4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Lock<T0>>(&mut arg0.id, arg2);
        assert!(v0.lock_type == 1, 9);
        assert!(v0.state == 1, 2);
        assert!(0x1::option::is_some<u64>(&v0.expire_at) && *0x1::option::borrow<u64>(&v0.expire_at) > 0x2::clock::timestamp_ms(arg1), 3);
        assert!(0x1::option::is_some<address>(&v0.taker) && *0x1::option::borrow<address>(&v0.taker) == 0x2::tx_context::sender(arg7) && 0x1::option::is_some<0x2::object::ID>(&v0.nft_id) && 0x2::dynamic_object_field::exists_with_type<u64, 0x2::kiosk::PurchaseCap<T0>>(&v0.id, 0), 1);
        let (v1, v2) = 0x2::kiosk::purchase_with_cap<T0>(arg3, 0x2::dynamic_object_field::remove<u64, 0x2::kiosk::PurchaseCap<T0>>(&mut v0.id, 0), 0x2::coin::zero<0x2::sui::SUI>(arg7));
        let v3 = v1;
        assert!(0x1::option::is_some<0x2::object::ID>(&v0.nft_id) && 0x2::object::id<T0>(&v3) == *0x1::option::borrow<0x2::object::ID>(&v0.nft_id), 1);
        0x2::kiosk::lock<T0>(arg4, arg5, arg6, v3);
        let v4 = ConfirmLockRequest<T0>{lock_id: arg2};
        (v2, v4)
    }

    public fun start_confirm_short_lock<T0: store + key>(arg0: &mut Store, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferRequest<T0>, ConfirmLockRequest<T0>) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Lock<T0>>(&arg0.id, arg2), 4);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg4, arg3), 5);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Lock<T0>>(&mut arg0.id, arg2);
        let v1 = v0.maker_price + v0.royalty;
        assert!(v0.lock_type == 0, 9);
        assert!(v0.state == 1, 2);
        assert!(0x1::option::is_some<u64>(&v0.expire_at) && *0x1::option::borrow<u64>(&v0.expire_at) > 0x2::clock::timestamp_ms(arg1), 3);
        assert!(0x2::dynamic_field::exists_with_type<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&v0.id, 1) && 0x2::balance::value<0x2::sui::SUI>(0x2::dynamic_field::borrow<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&v0.id, 1)) >= v1, 6);
        assert!(0x1::option::is_some<address>(&v0.taker) && *0x1::option::borrow<address>(&v0.taker) == 0x2::tx_context::sender(arg5), 1);
        let v2 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::dynamic_field::remove<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v0.id, 1), arg5);
        0x2::pay::keep<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v1, arg5), arg5);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, v2);
        v0.taker_price = 0x1::option::some<u64>(v0.maker_price);
        let v3 = ConfirmLockRequest<T0>{lock_id: arg2};
        (0x2::transfer_policy::new_request<T0>(arg3, v0.maker_price, 0x2::object::id<0x2::kiosk::Kiosk>(arg4)), v3)
    }

    public fun start_confirm_short_lock_with_buy_listing<T0: store + key>(arg0: &mut Store, arg1: &0x2::clock::Clock, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &0x2::transfer_policy::TransferRequest<T0>, arg6: &mut 0x2::tx_context::TxContext) : ConfirmLockRequest<T0> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Lock<T0>>(&arg0.id, arg2), 4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Lock<T0>>(&mut arg0.id, arg2);
        assert!(arg3 <= v0.maker_price, 12);
        assert!(arg4 <= v0.royalty, 13);
        assert!(arg3 == 0x2::transfer_policy::paid<T0>(arg5), 12);
        let v1 = v0.maker_price + arg4;
        assert!(v0.lock_type == 0, 9);
        assert!(v0.state == 1, 2);
        assert!(0x1::option::is_some<u64>(&v0.expire_at) && *0x1::option::borrow<u64>(&v0.expire_at) > 0x2::clock::timestamp_ms(arg1), 3);
        assert!(0x2::dynamic_field::exists_with_type<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&v0.id, 1) && 0x2::balance::value<0x2::sui::SUI>(0x2::dynamic_field::borrow<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&v0.id, 1)) >= v1, 6);
        assert!(0x1::option::is_some<address>(&v0.taker) && *0x1::option::borrow<address>(&v0.taker) == 0x2::tx_context::sender(arg6), 1);
        let v2 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::dynamic_field::remove<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v0.id, 1), arg6);
        0x2::pay::keep<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v1, arg6), arg6);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, v2);
        v0.taker_price = 0x1::option::some<u64>(arg3);
        ConfirmLockRequest<T0>{lock_id: arg2}
    }

    public fun withdraw_balance(arg0: &0x2::package::Publisher, arg1: &mut Store, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Store>(arg0), 1);
        0x2::pay::keep<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.balance), arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

