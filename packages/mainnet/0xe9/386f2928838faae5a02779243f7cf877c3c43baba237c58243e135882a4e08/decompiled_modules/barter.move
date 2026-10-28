module 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::barter {
    struct Deal has key {
        id: 0x2::object::UID,
        rev: u64,
        maker: address,
        maker_kiosk: 0x2::object::ID,
        taker: 0x1::option::Option<address>,
        give: vector<0x2::object::ID>,
        want: vector<0x2::object::ID>,
        ask: u64,
        bid: u64,
        bps: u16,
        escrow: 0x2::balance::Balance<0x2::sui::SUI>,
        ends_ms: 0x1::option::Option<u64>,
        open: bool,
    }

    struct Swap {
        deal: 0x2::object::ID,
        taker: address,
        given: vector<0x2::object::ID>,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        give_total: u64,
        handed: u64,
        want_left: vector<0x2::object::ID>,
        received: u64,
        fee: u64,
    }

    struct Unwind {
        deal: 0x2::object::ID,
    }

    public fun ask_sui(arg0: &Deal) : u64 {
        arg0.ask
    }

    public fun begin(arg0: &mut Deal, arg1: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Swap {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate(arg1);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate_rev(arg0.rev);
        assert!(arg0.open, 27);
        assert!(!ended(arg0, arg3), 23);
        let v0 = &arg0.taker;
        if (0x1::option::is_some<address>(v0)) {
            assert!(*0x1::option::borrow<address>(v0) == 0x2::tx_context::sender(arg4), 13);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg0.ask, 30);
        arg0.open = false;
        let v1 = 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), arg0.ask);
        let v2 = 0x2::balance::split<0x2::sui::SUI>(&mut v1, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::fee_of(arg0.ask, arg0.bps));
        0x2::balance::join<0x2::sui::SUI>(&mut v2, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.escrow, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::fee_of(arg0.bid, arg0.bps)));
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::pay_out(v2, 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::treasury(arg1), arg4);
        if (0x1::vector::is_empty<0x2::object::ID>(&arg0.give)) {
            0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::pay_out(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v1), arg0.maker, arg4);
        };
        Swap{
            deal       : 0x2::object::id<Deal>(arg0),
            taker      : 0x2::tx_context::sender(arg4),
            given      : arg0.give,
            pot        : v1,
            give_total : 0x2::balance::value<0x2::sui::SUI>(&v1),
            handed     : 0,
            want_left  : arg0.want,
            received   : 0,
            fee        : 0x2::balance::value<0x2::sui::SUI>(&v2),
        }
    }

    public fun bid_sui(arg0: &Deal) : u64 {
        arg0.bid
    }

    public fun draft(arg0: &0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::Config, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: vector<0x2::object::ID>, arg4: u64, arg5: u64, arg6: 0x1::option::Option<address>, arg7: 0x1::option::Option<u64>, arg8: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : Deal {
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::gate(arg0);
        assert!(0x2::kiosk::has_access(arg1, arg2), 12);
        assert!(0x2::kiosk::owner(arg1) == 0x2::tx_context::sender(arg10), 15);
        assert!(0x1::vector::length<0x2::object::ID>(&arg3) <= 32, 46);
        assert!(no_repeats(&arg3), 47);
        let v0 = &arg7;
        if (0x1::option::is_some<u64>(v0)) {
            assert!(*0x1::option::borrow<u64>(v0) > 0x2::clock::timestamp_ms(arg9), 64);
        };
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::courier::enable(arg1, arg2, arg10);
        let v1 = 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::swap_bps(arg0);
        let v2 = arg5 + 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::fee_of(arg5, v1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg8) >= v2, 30);
        Deal{
            id          : 0x2::object::new(arg10),
            rev         : 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::rev(),
            maker       : 0x2::tx_context::sender(arg10),
            maker_kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            taker       : arg6,
            give        : 0x1::vector::empty<0x2::object::ID>(),
            want        : arg3,
            ask         : arg4,
            bid         : arg5,
            bps         : v1,
            escrow      : 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg8), v2),
            ends_ms     : arg7,
            open        : false,
        }
    }

    fun ended(arg0: &Deal, arg1: &0x2::clock::Clock) : bool {
        let v0 = &arg0.ends_ms;
        0x1::option::is_some<u64>(v0) && 0x2::clock::timestamp_ms(arg1) >= *0x1::option::borrow<u64>(v0)
    }

    public fun ends_ms(arg0: &Deal) : 0x1::option::Option<u64> {
        arg0.ends_ms
    }

    public fun finish(arg0: Swap, arg1: Deal, arg2: &mut 0x2::tx_context::TxContext) {
        let Swap {
            deal       : v0,
            taker      : v1,
            given      : v2,
            pot        : v3,
            give_total : _,
            handed     : _,
            want_left  : v6,
            received   : _,
            fee        : v8,
        } = arg0;
        let v9 = v6;
        assert!(v0 == 0x2::object::id<Deal>(&arg1), 60);
        assert!(0x1::vector::is_empty<0x2::object::ID>(&v9), 28);
        let Deal {
            id          : v10,
            rev         : _,
            maker       : v12,
            maker_kiosk : _,
            taker       : _,
            give        : v15,
            want        : v16,
            ask         : v17,
            bid         : v18,
            bps         : _,
            escrow      : v20,
            ends_ms     : _,
            open        : _,
        } = arg1;
        let v23 = v15;
        assert!(0x1::vector::is_empty<0x2::object::ID>(&v23), 28);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
        0x2::object::delete(v10);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::pay_out(v20, v1, arg2);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::swap_done(v0, v12, v1, v2, v16, v17, v18, v8);
    }

    public fun give(arg0: &Deal) : vector<0x2::object::ID> {
        arg0.give
    }

    public fun hand<T0: store + key>(arg0: &mut Swap, arg1: &mut Deal, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: 0x2::object::ID, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(arg0.deal == 0x2::object::id<Deal>(arg1), 60);
        assert!(arg1.maker_kiosk == 0x2::object::id<0x2::kiosk::Kiosk>(arg2), 11);
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg1.give, &arg6);
        assert!(v0, 60);
        0x1::vector::remove<0x2::object::ID>(&mut arg1.give, v1);
        arg0.handed = arg0.handed + 1;
        let (v2, v3) = 0x2::kiosk::purchase_with_cap<T0>(arg2, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut arg1.id, arg6), 0x2::coin::take<0x2::sui::SUI>(&mut arg0.pot, share_of(arg0.give_total, 0x1::vector::length<0x2::object::ID>(&arg1.give) + arg0.handed, arg0.handed), arg8));
        let v4 = v3;
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::clearing::settle_into<T0>(arg5, &mut v4, v2, arg3, arg4, arg7, arg8);
        v4
    }

    public fun is_live(arg0: &Deal) : bool {
        arg0.open
    }

    public fun maker(arg0: &Deal) : address {
        arg0.maker
    }

    fun no_repeats(arg0: &vector<0x2::object::ID>) : bool {
        let v0 = 1;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            let v1 = 0;
            while (v1 < v0) {
                if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == *0x1::vector::borrow<0x2::object::ID>(arg0, v1)) {
                    return false
                };
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun pledge<T0: store + key>(arg0: &mut Deal, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.open, 26);
        assert!(arg0.maker_kiosk == 0x2::object::id<0x2::kiosk::Kiosk>(arg1), 11);
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.give) < 32, 46);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg0.give, &arg3), 47);
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut arg0.id, arg3, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg4));
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.give, arg3);
    }

    public fun publish(arg0: Deal) {
        assert!(!arg0.open, 26);
        assert!(!0x1::vector::is_empty<0x2::object::ID>(&arg0.give) || arg0.bid != 0, 62);
        arg0.open = true;
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::swap_offered(0x2::object::id<Deal>(&arg0), arg0.maker, arg0.taker, arg0.maker_kiosk, arg0.give, arg0.want, arg0.ask, arg0.bid, arg0.ends_ms);
        0x2::transfer::share_object<Deal>(arg0);
    }

    public fun receive<T0: store + key>(arg0: &mut Swap, arg1: &mut Deal, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg6: 0x2::object::ID, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(arg0.deal == 0x2::object::id<Deal>(arg1), 60);
        assert!(arg1.maker_kiosk == 0x2::object::id<0x2::kiosk::Kiosk>(arg4), 11);
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.want_left, &arg6);
        assert!(v0, 61);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.want_left, v1);
        let v2 = share_of(arg1.bid, 0x1::vector::length<0x2::object::ID>(&arg1.want), arg0.received);
        arg0.received = arg0.received + 1;
        let (v3, v4) = 0x2::kiosk::purchase_with_cap<T0>(arg2, 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, arg6, v2, arg8), 0x2::coin::take<0x2::sui::SUI>(&mut arg1.escrow, v2, arg8));
        let v5 = v4;
        if (v2 != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::kiosk::withdraw(arg2, arg3, 0x1::option::some<u64>(v2), arg8), arg0.taker);
        };
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::courier::deliver<T0>(arg4, arg1.maker, v3, arg5);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::clearing::clear<T0>(arg5, &mut v5, arg4, 0x2::coin::balance_mut<0x2::sui::SUI>(arg7), arg8);
        v5
    }

    public fun restore<T0: store + key>(arg0: &mut Unwind, arg1: &mut Deal, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID) {
        assert!(arg0.deal == 0x2::object::id<Deal>(arg1), 60);
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg1.give, &arg3);
        assert!(v0, 60);
        0x1::vector::remove<0x2::object::ID>(&mut arg1.give, v1);
        0x2::kiosk::return_purchase_cap<T0>(arg2, 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::kiosk::PurchaseCap<T0>>(&mut arg1.id, arg3));
    }

    fun share_of(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        if (arg2 == 0) {
            arg0 / arg1 + arg0 % arg1
        } else {
            arg0 / arg1
        }
    }

    public fun unwind(arg0: &mut Deal, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : Unwind {
        assert!(arg0.maker == 0x2::tx_context::sender(arg2) || ended(arg0, arg1), 10);
        arg0.open = false;
        Unwind{deal: 0x2::object::id<Deal>(arg0)}
    }

    public fun unwound(arg0: Unwind, arg1: Deal, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let Unwind { deal: v0 } = arg0;
        assert!(v0 == 0x2::object::id<Deal>(&arg1), 60);
        let Deal {
            id          : v1,
            rev         : _,
            maker       : v3,
            maker_kiosk : _,
            taker       : _,
            give        : v6,
            want        : _,
            ask         : _,
            bid         : _,
            bps         : _,
            escrow      : v11,
            ends_ms     : _,
            open        : _,
        } = arg1;
        let v14 = v11;
        let v15 = v6;
        assert!(0x1::vector::is_empty<0x2::object::ID>(&v15), 28);
        0x2::object::delete(v1);
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events::swap_cancelled(v0, v3, 0x2::tx_context::sender(arg3), 0x2::balance::value<0x2::sui::SUI>(&v14), ended(&arg1, arg2));
        0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::config::pay_out(v14, v3, arg3);
    }

    public fun want(arg0: &Deal) : vector<0x2::object::ID> {
        arg0.want
    }

    // decompiled from Move bytecode v7
}

