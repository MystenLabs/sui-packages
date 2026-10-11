module 0x9d4f14311cbc6c23a372fae5cfdd56fa4ee5bbc5f93270b5bf21bd56ca65de18::limit_order {
    struct Order<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        curve_id: 0x2::object::ID,
        kind: u8,
        trigger: u128,
        slip_bps: u64,
        sui_in: 0x2::balance::Balance<0x2::sui::SUI>,
        tokens_in: 0x2::balance::Balance<T0>,
        tip: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_bps: u64,
        fee_to: address,
        expires_ms: u64,
        created_ms: u64,
        confirm_ms: u64,
        armed_ms: u64,
    }

    struct OrderPlaced has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        curve_id: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
        kind: u8,
        trigger: u128,
        slip_bps: u64,
        amount: u64,
        tip: u64,
        fee_bps: u64,
        expires_ms: u64,
        confirm_ms: u64,
    }

    struct OrderFilled has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        keeper: address,
        curve_id: 0x2::object::ID,
        kind: u8,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        tip: u64,
    }

    struct OrderClosed has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        by: address,
        expired: bool,
    }

    struct OrderArmed has copy, drop {
        order_id: 0x2::object::ID,
        armed: bool,
        at_ms: u64,
    }

    public fun armed_ms<T0>(arg0: &Order<T0>) : u64 {
        arg0.armed_ms
    }

    public fun cancel<T0>(arg0: Order<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        let v0 = 0x2::tx_context::sender(arg1);
        close<T0>(arg0, v0, false, v0, arg1);
    }

    fun check_common(arg0: bool, arg1: u8, arg2: u128, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg0, 2);
        assert!(arg2 > 0, 11);
        assert!(arg2 >= 1000000000000000 && arg2 <= 10000000000000000000, 13);
        if (delayed(arg1)) {
            assert!(arg6 >= 5000 && arg6 <= 600000, 15);
        } else {
            assert!(arg6 == 0, 15);
        };
        assert!(arg3 >= 10 && arg3 <= 5000, 4);
        assert!(arg4 <= 100, 5);
        assert!(arg5 > arg7 && arg5 - arg7 <= 2592000000, 6);
    }

    fun close<T0>(arg0: Order<T0>, arg1: address, arg2: bool, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let Order {
            id         : v0,
            owner      : v1,
            curve_id   : _,
            kind       : _,
            trigger    : _,
            slip_bps   : _,
            sui_in     : v6,
            tokens_in  : v7,
            tip        : v8,
            fee_bps    : _,
            fee_to     : _,
            expires_ms : _,
            created_ms : _,
            confirm_ms : _,
            armed_ms   : _,
        } = arg0;
        let v15 = v8;
        let v16 = v7;
        let v17 = v6;
        let v18 = v0;
        if (0x2::balance::value<0x2::sui::SUI>(&v17) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v17, arg4), v1);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v17);
        };
        if (0x2::balance::value<T0>(&v16) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg4), v1);
        } else {
            0x2::balance::destroy_zero<T0>(v16);
        };
        let v19 = if (arg2) {
            arg3
        } else {
            v1
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v15) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v15, arg4), v19);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v15);
        };
        let v20 = OrderClosed{
            order_id : 0x2::object::uid_to_inner(&v18),
            owner    : v1,
            by       : arg1,
            expired  : arg2,
        };
        0x2::event::emit<OrderClosed>(v20);
        0x2::object::delete(v18);
    }

    public fun confirm_ms<T0>(arg0: &Order<T0>) : u64 {
        arg0.confirm_ms
    }

    public fun crossed(arg0: u8, arg1: u128, arg2: u128, arg3: u128) : bool {
        (arg0 == 0 || arg0 == 3) && arg2 * 1000000000000000000 <= arg1 * arg3 || arg2 * 1000000000000000000 >= arg1 * arg3
    }

    public fun curve_id<T0>(arg0: &Order<T0>) : 0x2::object::ID {
        arg0.curve_id
    }

    public fun delayed(arg0: u8) : bool {
        arg0 == 3 || arg0 == 1
    }

    fun emit_placed<T0>(arg0: &Order<T0>, arg1: u64, arg2: u64) {
        let v0 = OrderPlaced{
            order_id   : 0x2::object::id<Order<T0>>(arg0),
            owner      : arg0.owner,
            curve_id   : arg0.curve_id,
            coin       : 0x1::type_name::with_original_ids<T0>(),
            kind       : arg0.kind,
            trigger    : arg0.trigger,
            slip_bps   : arg0.slip_bps,
            amount     : arg1,
            tip        : arg2,
            fee_bps    : arg0.fee_bps,
            expires_ms : arg0.expires_ms,
            confirm_ms : arg0.confirm_ms,
        };
        0x2::event::emit<OrderPlaced>(v0);
    }

    public fun execute<T0>(arg0: Order<T0>, arg1: &mut 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg2: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::PriceConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg1) == arg0.curve_id, 9);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.expires_ms, 7);
        let (v0, v1) = reserves<T0>(arg1);
        assert!(crossed(arg0.kind, arg0.trigger, v0, v1), 8);
        if (delayed(arg0.kind)) {
            assert!(arg0.armed_ms > 0 && 0x2::clock::timestamp_ms(arg3) - arg0.armed_ms >= arg0.confirm_ms, 16);
        };
        let Order {
            id         : v2,
            owner      : v3,
            curve_id   : v4,
            kind       : v5,
            trigger    : v6,
            slip_bps   : v7,
            sui_in     : v8,
            tokens_in  : v9,
            tip        : v10,
            fee_bps    : v11,
            fee_to     : v12,
            expires_ms : _,
            created_ms : _,
            confirm_ms : _,
            armed_ms   : _,
        } = arg0;
        let v17 = v10;
        let v18 = v2;
        let v19 = 0x2::tx_context::sender(arg4);
        let v20 = 0x2::balance::value<0x2::sui::SUI>(&v17);
        let v21 = 0;
        let (v22, v23) = if (v5 == 0 || v5 == 1) {
            0x2::balance::destroy_zero<T0>(v9);
            let v24 = 0x2::coin::from_balance<0x2::sui::SUI>(v8, arg4);
            let v25 = 0x2::coin::value<0x2::sui::SUI>(&v24);
            if (v11 > 0) {
                let v26 = v25 * v11 / 10000;
                v21 = v26;
                if (v26 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v24, v26, arg4), v12);
                };
            };
            let (v27, v28) = 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::buy<T0>(arg1, v24, min_tokens_for(v25, v6, v7), 0x1::option::none<address>(), arg2, arg3, arg4);
            let v29 = v28;
            let v30 = v27;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v30, v3);
            if (0x2::coin::value<0x2::sui::SUI>(&v29) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v29, v3);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(v29);
            };
            (v25, 0x2::coin::value<T0>(&v30))
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v8);
            let v31 = 0x2::coin::from_balance<T0>(v9, arg4);
            let v32 = 0x2::coin::value<T0>(&v31);
            let v33 = 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::sell<T0>(arg1, v31, ((((min_sui_for(v32, v6, v7) as u128) * (10000 as u128) + ((10000 - v11) as u128) - 1) / ((10000 - v11) as u128)) as u64), 0x1::option::none<address>(), arg4);
            if (v11 > 0) {
                let v34 = 0x2::coin::value<0x2::sui::SUI>(&v33) * v11 / 10000;
                v21 = v34;
                if (v34 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v33, v34, arg4), v12);
                };
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v33, v3);
            (v32, 0x2::coin::value<0x2::sui::SUI>(&v33))
        };
        if (v20 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v17, arg4), v19);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v17);
        };
        let v35 = OrderFilled{
            order_id   : 0x2::object::uid_to_inner(&v18),
            owner      : v3,
            keeper     : v19,
            curve_id   : v4,
            kind       : v5,
            amount_in  : v22,
            amount_out : v23,
            fee        : v21,
            tip        : v20,
        };
        0x2::event::emit<OrderFilled>(v35);
        0x2::object::delete(v18);
    }

    public fun expires_ms<T0>(arg0: &Order<T0>) : u64 {
        arg0.expires_ms
    }

    public fun is_triggered<T0>(arg0: &Order<T0>, arg1: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg2: &0x2::clock::Clock) : bool {
        if (0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg1) != arg0.curve_id) {
            return false
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 >= arg0.expires_ms) {
            return false
        };
        if (0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::graduated<T0>(arg1)) {
            return false
        };
        let (v1, v2) = reserves<T0>(arg1);
        if (!crossed(arg0.kind, arg0.trigger, v1, v2)) {
            return false
        };
        !delayed(arg0.kind) || arg0.armed_ms > 0 && v0 - arg0.armed_ms >= arg0.confirm_ms
    }

    public fun kind<T0>(arg0: &Order<T0>) : u8 {
        arg0.kind
    }

    public fun min_sui_for(arg0: u64, arg1: u128, arg2: u64) : u64 {
        (((arg0 as u128) * arg1 * ((10000 - arg2) as u128) / 1000000000000000000 * (10000 as u128)) as u64)
    }

    public fun min_tokens_for(arg0: u64, arg1: u128, arg2: u64) : u64 {
        (((arg0 as u128) * 1000000000000000000 * (10000 as u128) / arg1 * ((10000 + arg2) as u128)) as u64)
    }

    public fun owner<T0>(arg0: &Order<T0>) : address {
        arg0.owner
    }

    public fun place_buy<T0>(arg0: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u8, arg4: u128, arg5: u64, arg6: u64, arg7: address, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::clock::timestamp_ms(arg10);
        let v1 = arg3 == 0 || arg3 == 1;
        check_common(v1, arg3, arg4, arg5, arg6, arg8, arg9, v0);
        assert!(!0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::graduated<T0>(arg0), 12);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v2 > 0, 3);
        assert!(v2 <= 1000000000000000, 14);
        let v3 = Order<T0>{
            id         : 0x2::object::new(arg11),
            owner      : 0x2::tx_context::sender(arg11),
            curve_id   : 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg0),
            kind       : arg3,
            trigger    : arg4,
            slip_bps   : arg5,
            sui_in     : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            tokens_in  : 0x2::balance::zero<T0>(),
            tip        : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            fee_bps    : arg6,
            fee_to     : arg7,
            expires_ms : arg8,
            created_ms : v0,
            confirm_ms : arg9,
            armed_ms   : 0,
        };
        emit_placed<T0>(&v3, v2, 0x2::coin::value<0x2::sui::SUI>(&arg2));
        0x2::transfer::share_object<Order<T0>>(v3);
        0x2::object::id<Order<T0>>(&v3)
    }

    public fun place_sell<T0>(arg0: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u8, arg4: u128, arg5: u64, arg6: u64, arg7: address, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::clock::timestamp_ms(arg10);
        let v1 = arg3 == 2 || arg3 == 3;
        check_common(v1, arg3, arg4, arg5, arg6, arg8, arg9, v0);
        assert!(!0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::graduated<T0>(arg0), 12);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 > 0, 3);
        let v3 = Order<T0>{
            id         : 0x2::object::new(arg11),
            owner      : 0x2::tx_context::sender(arg11),
            curve_id   : 0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg0),
            kind       : arg3,
            trigger    : arg4,
            slip_bps   : arg5,
            sui_in     : 0x2::balance::zero<0x2::sui::SUI>(),
            tokens_in  : 0x2::coin::into_balance<T0>(arg1),
            tip        : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            fee_bps    : arg6,
            fee_to     : arg7,
            expires_ms : arg8,
            created_ms : v0,
            confirm_ms : arg9,
            armed_ms   : 0,
        };
        emit_placed<T0>(&v3, v2, 0x2::coin::value<0x2::sui::SUI>(&arg2));
        0x2::transfer::share_object<Order<T0>>(v3);
        0x2::object::id<Order<T0>>(&v3)
    }

    public fun poke<T0>(arg0: &mut Order<T0>, arg1: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>, arg2: &0x2::clock::Clock) {
        assert!(0x2::object::id<0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>>(arg1) == arg0.curve_id, 9);
        if (!delayed(arg0.kind)) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let (v1, v2) = reserves<T0>(arg1);
        let v3 = crossed(arg0.kind, arg0.trigger, v1, v2) && v0 < arg0.expires_ms;
        if (v3 && arg0.armed_ms == 0) {
            arg0.armed_ms = v0;
            let v4 = OrderArmed{
                order_id : 0x2::object::id<Order<T0>>(arg0),
                armed    : true,
                at_ms    : v0,
            };
            0x2::event::emit<OrderArmed>(v4);
        } else if (!v3 && arg0.armed_ms > 0) {
            arg0.armed_ms = 0;
            let v5 = OrderArmed{
                order_id : 0x2::object::id<Order<T0>>(arg0),
                armed    : false,
                at_ms    : v0,
            };
            0x2::event::emit<OrderArmed>(v5);
        };
    }

    public fun refund_expired<T0>(arg0: Order<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expires_ms, 10);
        let v0 = 0x2::tx_context::sender(arg2);
        close<T0>(arg0, v0, true, v0, arg2);
    }

    public fun reserves<T0>(arg0: &0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::Curve<T0>) : (u128, u128) {
        (((0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::sui_reserve<T0>(arg0) + 4369000000000) as u128), ((1073000000000000 - 800000000000000 - 0xb205fea41ccedac051bc66498e6ca68cb802c4a6ea06da12e524bed09c80d9b0::bonding_curve::token_reserve<T0>(arg0)) as u128))
    }

    public fun slip_bps<T0>(arg0: &Order<T0>) : u64 {
        arg0.slip_bps
    }

    public fun sui_amount<T0>(arg0: &Order<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_in)
    }

    public fun tip_amount<T0>(arg0: &Order<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.tip)
    }

    public fun token_amount<T0>(arg0: &Order<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.tokens_in)
    }

    public fun trigger<T0>(arg0: &Order<T0>) : u128 {
        arg0.trigger
    }

    // decompiled from Move bytecode v7
}

