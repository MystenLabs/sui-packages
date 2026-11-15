module 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::otc {
    struct Offer<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        maker: address,
        funds: 0x2::balance::Balance<T0>,
        amount_a: u64,
        ask: u64,
        taker: 0x1::option::Option<address>,
        fee_bps: u64,
        fee_on_a: bool,
        created_ms: u64,
        expiry_ms: u64,
    }

    struct OfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
        amount_a: u64,
        ask: u64,
        taker: 0x1::option::Option<address>,
        fee_bps: u64,
        fee_on_a: bool,
        expiry_ms: u64,
    }

    struct OfferTaken has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        taker: address,
        amount_a: u64,
        ask: u64,
        fee: u64,
        fee_on_a: bool,
    }

    struct OfferClosed has copy, drop {
        offer_id: 0x2::object::ID,
        maker: address,
        refunded: u64,
        expired: bool,
    }

    public fun amount_a<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        arg0.amount_a
    }

    public fun ask<T0, T1>(arg0: &Offer<T0, T1>) : u64 {
        arg0.ask
    }

    public fun cancel<T0, T1>(arg0: Offer<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.maker, 206);
        close<T0, T1>(arg0, false, arg1);
    }

    fun close<T0, T1>(arg0: Offer<T0, T1>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let Offer {
            id         : v0,
            maker      : v1,
            funds      : v2,
            amount_a   : _,
            ask        : _,
            taker      : _,
            fee_bps    : _,
            fee_on_a   : _,
            created_ms : _,
            expiry_ms  : _,
        } = arg0;
        let v10 = v2;
        let v11 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v10, arg2), v1);
        let v12 = OfferClosed{
            offer_id : 0x2::object::uid_to_inner(&v11),
            maker    : v1,
            refunded : 0x2::balance::value<T0>(&v10),
            expired  : arg1,
        };
        0x2::event::emit<OfferClosed>(v12);
        0x2::object::delete(v11);
    }

    public fun create<T0, T1>(arg0: &0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::Config, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: 0x1::option::Option<address>, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::paused(arg0), 201);
        let v0 = 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::fee_bps(arg0);
        assert!(v0 <= 100, 209);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0 && arg2 > 0, 202);
        let v2 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg5 > v2 && arg5 - v2 <= 7776000000, 203);
        if (0x1::option::is_some<address>(&arg3)) {
            assert!(*0x1::option::borrow<address>(&arg3) != 0x2::tx_context::sender(arg7), 210);
        };
        let v3 = Offer<T0, T1>{
            id         : 0x2::object::new(arg7),
            maker      : 0x2::tx_context::sender(arg7),
            funds      : 0x2::coin::into_balance<T0>(arg1),
            amount_a   : v1,
            ask        : arg2,
            taker      : arg3,
            fee_bps    : v0,
            fee_on_a   : arg4,
            created_ms : v2,
            expiry_ms  : arg5,
        };
        let v4 = 0x2::object::id<Offer<T0, T1>>(&v3);
        let v5 = OfferCreated{
            offer_id  : v4,
            maker     : v3.maker,
            coin_a    : 0x1::type_name::with_defining_ids<T0>(),
            coin_b    : 0x1::type_name::with_defining_ids<T1>(),
            amount_a  : v1,
            ask       : arg2,
            taker     : arg3,
            fee_bps   : v0,
            fee_on_a  : arg4,
            expiry_ms : arg5,
        };
        0x2::event::emit<OfferCreated>(v5);
        0x2::transfer::share_object<Offer<T0, T1>>(v3);
        v4
    }

    public fun expire_refund<T0, T1>(arg0: Offer<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expiry_ms, 205);
        close<T0, T1>(arg0, true, arg2);
    }

    public fun maker<T0, T1>(arg0: &Offer<T0, T1>) : address {
        arg0.maker
    }

    public fun take<T0, T1>(arg0: Offer<T0, T1>, arg1: &0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::Config, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::paused(arg1), 201);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.expiry_ms, 204);
        let v0 = 0x2::tx_context::sender(arg4);
        if (0x1::option::is_some<address>(&arg0.taker)) {
            assert!(*0x1::option::borrow<address>(&arg0.taker) == v0, 207);
        };
        assert!(0x2::coin::value<T1>(&arg2) == arg0.ask, 208);
        let Offer {
            id         : v1,
            maker      : v2,
            funds      : v3,
            amount_a   : v4,
            ask        : v5,
            taker      : _,
            fee_bps    : v7,
            fee_on_a   : v8,
            created_ms : _,
            expiry_ms  : _,
        } = arg0;
        let v11 = v1;
        let v12 = 0x2::coin::from_balance<T0>(v3, arg4);
        let v13 = if (v8) {
            v4
        } else {
            v5
        };
        let v14 = 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::fee_for(v13, v7);
        if (v14 > 0) {
            if (v8) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v12, v14, arg4), 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::fee_recipient(arg1));
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg2, v14, arg4), 0xa10b7229fe2dde62280a48386be883fefe073e31a7b3c69291e6a72e74fd363e::limits::fee_recipient(arg1));
            };
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v2);
        let v15 = OfferTaken{
            offer_id : 0x2::object::uid_to_inner(&v11),
            maker    : v2,
            taker    : v0,
            amount_a : v4,
            ask      : v5,
            fee      : v14,
            fee_on_a : v8,
        };
        0x2::event::emit<OfferTaken>(v15);
        0x2::object::delete(v11);
        v12
    }

    public fun taker<T0, T1>(arg0: &Offer<T0, T1>) : 0x1::option::Option<address> {
        arg0.taker
    }

    // decompiled from Move bytecode v7
}

