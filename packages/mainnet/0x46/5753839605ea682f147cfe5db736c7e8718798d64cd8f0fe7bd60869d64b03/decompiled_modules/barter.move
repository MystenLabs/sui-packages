module 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::barter {
    struct Deal has key {
        id: 0x2::object::UID,
        bid_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        ask_sui: u64,
        fee_bps: u16,
        give: vector<0x2::object::ID>,
        want: vector<0x2::object::ID>,
        taker: 0x1::option::Option<address>,
        expiry_epoch: u64,
        made_epoch: u64,
        maker_kiosk: 0x2::object::ID,
        maker: address,
        live: bool,
        version: u64,
    }

    struct CapSlot has copy, drop, store {
        item: 0x2::object::ID,
    }

    struct Swap {
        deal: 0x2::object::ID,
        taker: address,
        given: vector<0x2::object::ID>,
        to_receive: vector<0x2::object::ID>,
        ask_left: 0x2::balance::Balance<0x2::sui::SUI>,
        give_each: u64,
        give_left: u64,
        want_each: u64,
        bid_total: u64,
    }

    struct Unwind {
        deal: 0x2::object::ID,
        left: u64,
    }

    public fun ask_sui(arg0: &Deal) : u64 {
        arg0.ask_sui
    }

    public fun begin(arg0: &mut Deal, arg1: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : Swap {
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_open(arg1);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_object(arg0.version);
        assert!(arg0.live, 404);
        assert!(arg0.expiry_epoch == 0 || 0x2::tx_context::epoch(arg3) <= arg0.expiry_epoch, 406);
        if (0x1::option::is_some<address>(&arg0.taker)) {
            assert!(*0x1::option::borrow<address>(&arg0.taker) == 0x2::tx_context::sender(arg3), 407);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg0.ask_sui, 408);
        let v0 = 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), arg0.ask_sui);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::send(0x2::balance::split<0x2::sui::SUI>(&mut v0, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::portion(arg0.ask_sui, arg0.fee_bps)), 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::treasury(arg1), arg3);
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg0.give);
        let v2 = 0x1::vector::length<0x2::object::ID>(&arg0.want);
        if (v1 == 0) {
            0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::send(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v0), arg0.maker, arg3);
        };
        arg0.live = false;
        let v3 = if (v1 == 0) {
            0
        } else {
            0x2::balance::value<0x2::sui::SUI>(&v0) / v1
        };
        let v4 = if (v2 == 0) {
            0
        } else {
            0x2::balance::value<0x2::sui::SUI>(&arg0.bid_sui) / v2
        };
        Swap{
            deal       : 0x2::object::id<Deal>(arg0),
            taker      : 0x2::tx_context::sender(arg3),
            given      : arg0.give,
            to_receive : arg0.want,
            ask_left   : v0,
            give_each  : v3,
            give_left  : v1,
            want_each  : v4,
            bid_total  : 0x2::balance::value<0x2::sui::SUI>(&arg0.bid_sui),
        }
    }

    public fun bid_sui(arg0: &Deal) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.bid_sui)
    }

    public fun draft(arg0: &0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::Config, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: vector<0x2::object::ID>, arg4: u64, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) : Deal {
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::assert_open(arg0);
        assert!(0x2::kiosk::has_access(arg1, arg2), 401);
        assert!(0x2::kiosk::owner(arg1) == 0x2::tx_context::sender(arg9), 402);
        assert!(0x1::vector::length<0x2::object::ID>(&arg3) <= 32, 414);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            let v1 = v0 + 1;
            while (v1 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
                assert!(*0x1::vector::borrow<0x2::object::ID>(&arg3, v0) != *0x1::vector::borrow<0x2::object::ID>(&arg3, v1), 415);
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::courier::enable(arg1, arg2, arg9);
        let v2 = 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::portion(arg5, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::swap_bps(arg0)) + 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::swap_flat(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg8) >= arg5 + v2, 408);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::send(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg8), v2), 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::treasury(arg0), arg9);
        let v3 = 0x2::tx_context::epoch(arg9);
        let v4 = if (arg7 == 0) {
            0
        } else {
            v3 + arg7
        };
        Deal{
            id           : 0x2::object::new(arg9),
            bid_sui      : 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg8), arg5),
            ask_sui      : arg4,
            fee_bps      : 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::swap_bps(arg0),
            give         : 0x1::vector::empty<0x2::object::ID>(),
            want         : arg3,
            taker        : arg6,
            expiry_epoch : v4,
            made_epoch   : v3,
            maker_kiosk  : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            maker        : 0x2::tx_context::sender(arg9),
            live         : false,
            version      : 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::current(),
        }
    }

    public fun expiry_epoch(arg0: &Deal) : u64 {
        arg0.expiry_epoch
    }

    public fun finish(arg0: Swap, arg1: Deal, arg2: &mut 0x2::tx_context::TxContext) {
        let Swap {
            deal       : v0,
            taker      : v1,
            given      : v2,
            to_receive : v3,
            ask_left   : v4,
            give_each  : _,
            give_left  : v6,
            want_each  : _,
            bid_total  : v8,
        } = arg0;
        let v9 = v3;
        assert!(v0 == 0x2::object::id<Deal>(&arg1), 409);
        assert!(0x1::vector::is_empty<0x2::object::ID>(&v9) && v6 == 0, 411);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v4);
        let Deal {
            id           : v10,
            bid_sui      : v11,
            ask_sui      : v12,
            fee_bps      : v13,
            give         : v14,
            want         : v15,
            taker        : _,
            expiry_epoch : _,
            made_epoch   : _,
            maker_kiosk  : _,
            maker        : v20,
            live         : _,
            version      : _,
        } = arg1;
        let v23 = v14;
        assert!(0x1::vector::is_empty<0x2::object::ID>(&v23), 411);
        0x2::object::delete(v10);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::send(v11, v1, arg2);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::deal_settled(v0, v20, v1, v2, v15, v12, 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::portion(v12, v13), v8);
    }

    public fun give(arg0: &Deal) : vector<0x2::object::ID> {
        arg0.give
    }

    public fun hand<T0: store + key>(arg0: &mut Swap, arg1: &mut Deal, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: 0x2::object::ID, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(arg0.deal == 0x2::object::id<Deal>(arg1), 409);
        let v0 = CapSlot{item: arg6};
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg1.give, &arg6);
        assert!(v1, 409);
        0x1::vector::remove<0x2::object::ID>(&mut arg1.give, v2);
        let v3 = if (arg0.give_left == 1) {
            0x2::balance::value<0x2::sui::SUI>(&arg0.ask_left)
        } else {
            arg0.give_each
        };
        arg0.give_left = arg0.give_left - 1;
        let (v4, v5) = 0x2::kiosk::purchase_with_cap<T0>(arg2, 0x2::dynamic_object_field::remove<CapSlot, 0x2::kiosk::PurchaseCap<T0>>(&mut arg1.id, v0), 0x2::coin::take<0x2::sui::SUI>(&mut arg0.ask_left, v3, arg8));
        let v6 = v5;
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::clearing::settle_into<T0>(arg5, &mut v6, v4, arg3, arg4, arg7, arg8);
        v6
    }

    public fun is_live(arg0: &Deal) : bool {
        arg0.live
    }

    public fun maker(arg0: &Deal) : address {
        arg0.maker
    }

    public fun pledge<T0: store + key>(arg0: &mut Deal, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.live, 403);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.maker_kiosk, 413);
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.give) < 32, 414);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg0.give, &arg3), 415);
        assert!(!0x2::kiosk::is_listed(arg1, arg3), 416);
        let v0 = CapSlot{item: arg3};
        0x2::dynamic_object_field::add<CapSlot, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.id, v0, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg4));
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.give, arg3);
    }

    public fun publish(arg0: Deal) {
        assert!(!arg0.live, 403);
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.give) > 0 || 0x2::balance::value<0x2::sui::SUI>(&arg0.bid_sui) > 0, 405);
        arg0.live = true;
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::deal_proposed(0x2::object::id<Deal>(&arg0), arg0.maker, arg0.maker_kiosk, arg0.taker, arg0.give, arg0.want, arg0.ask_sui, 0x2::balance::value<0x2::sui::SUI>(&arg0.bid_sui), arg0.expiry_epoch);
        0x2::transfer::share_object<Deal>(arg0);
    }

    public fun receive<T0: store + key>(arg0: &mut Swap, arg1: &mut Deal, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: 0x2::object::ID, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(arg0.deal == 0x2::object::id<Deal>(arg1), 409);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg4) == arg1.maker_kiosk, 413);
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.to_receive, &arg6);
        assert!(v0, 410);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.to_receive, v1);
        let v2 = if (0x1::vector::is_empty<0x2::object::ID>(&arg0.to_receive)) {
            0x2::balance::value<0x2::sui::SUI>(&arg1.bid_sui)
        } else {
            arg0.want_each
        };
        let (v3, v4) = 0x2::kiosk::purchase_with_cap<T0>(arg2, 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, arg6, v2, arg8), 0x2::coin::take<0x2::sui::SUI>(&mut arg1.bid_sui, v2, arg8));
        let v5 = v4;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::kiosk::withdraw(arg2, arg3, 0x1::option::some<u64>(v2), arg8), arg0.taker);
        };
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::courier::deliver<T0>(arg4, arg1.maker, v3, arg5);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::clearing::clear<T0>(arg5, &mut v5, arg4, 0x2::coin::balance_mut<0x2::sui::SUI>(arg7), arg8);
        v5
    }

    public fun restore<T0: store + key>(arg0: &mut Unwind, arg1: &mut Deal, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID) {
        assert!(arg0.deal == 0x2::object::id<Deal>(arg1), 409);
        let v0 = CapSlot{item: arg3};
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg1.give, &arg3);
        assert!(v1, 409);
        0x1::vector::remove<0x2::object::ID>(&mut arg1.give, v2);
        0x2::kiosk::return_purchase_cap<T0>(arg2, 0x2::dynamic_object_field::remove<CapSlot, 0x2::kiosk::PurchaseCap<T0>>(&mut arg1.id, v0));
        arg0.left = arg0.left - 1;
    }

    public fun unwind(arg0: &mut Deal, arg1: &mut 0x2::tx_context::TxContext) : Unwind {
        let v0 = arg0.expiry_epoch != 0 && 0x2::tx_context::epoch(arg1) > arg0.expiry_epoch;
        assert!(0x2::tx_context::sender(arg1) == arg0.maker || v0, 412);
        arg0.live = false;
        Unwind{
            deal : 0x2::object::id<Deal>(arg0),
            left : 0x1::vector::length<0x2::object::ID>(&arg0.give),
        }
    }

    public fun unwound(arg0: Unwind, arg1: Deal, arg2: &mut 0x2::tx_context::TxContext) {
        let Unwind {
            deal : v0,
            left : v1,
        } = arg0;
        assert!(v0 == 0x2::object::id<Deal>(&arg1), 409);
        assert!(v1 == 0, 411);
        let v2 = arg1.expiry_epoch != 0 && 0x2::tx_context::epoch(arg2) > arg1.expiry_epoch;
        let Deal {
            id           : v3,
            bid_sui      : v4,
            ask_sui      : _,
            fee_bps      : _,
            give         : v7,
            want         : _,
            taker        : _,
            expiry_epoch : _,
            made_epoch   : _,
            maker_kiosk  : _,
            maker        : v13,
            live         : _,
            version      : _,
        } = arg1;
        let v16 = v7;
        let v17 = v4;
        assert!(0x1::vector::is_empty<0x2::object::ID>(&v16), 411);
        0x2::object::delete(v3);
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events::deal_unwound(v0, v13, 0x2::tx_context::sender(arg2), v2, 0x2::balance::value<0x2::sui::SUI>(&v17));
        0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::config::send(v17, v13, arg2);
    }

    public fun want(arg0: &Deal) : vector<0x2::object::ID> {
        arg0.want
    }

    // decompiled from Move bytecode v7
}

