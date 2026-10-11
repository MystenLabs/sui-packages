module 0x39e34cdc25e2c107a6d3f6b6c98d981fc1d56150fc40d05e019ac5793324ec18::dex_order {
    struct Order<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        filler: address,
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
    }

    struct Fill<phantom T0> {
        order_id: 0x2::object::ID,
        owner: address,
        filler: address,
        kind: u8,
        amount_in: u64,
        min_out: u64,
        fee_bps: u64,
        fee_to: address,
        fee_paid: u64,
        tip: u64,
    }

    struct OrderPlaced has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        filler: address,
        coin: 0x1::type_name::TypeName,
        kind: u8,
        trigger: u128,
        slip_bps: u64,
        amount: u64,
        tip: u64,
        fee_bps: u64,
        expires_ms: u64,
    }

    struct OrderFilled has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        filler: address,
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

    public fun cancel<T0>(arg0: Order<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        close<T0>(arg0, false, arg1);
    }

    fun cap(arg0: u256) : u64 {
        if (arg0 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (arg0 as u64)
        }
    }

    fun check_common(arg0: bool, arg1: u128, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg0, 2);
        assert!(arg1 > 0 && arg1 <= 1000000000000000000000000000000000000, 10);
        assert!(arg2 >= 10 && arg2 <= 5000, 4);
        assert!(arg3 <= 100, 5);
        assert!(arg4 > arg5 && arg4 - arg5 <= 2592000000, 6);
    }

    fun close<T0>(arg0: Order<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let Order {
            id         : v1,
            owner      : v2,
            filler     : _,
            kind       : _,
            trigger    : _,
            slip_bps   : _,
            sui_in     : v7,
            tokens_in  : v8,
            tip        : v9,
            fee_bps    : _,
            fee_to     : _,
            expires_ms : _,
            created_ms : _,
        } = arg0;
        let v14 = v8;
        let v15 = v7;
        let v16 = v1;
        if (0x2::balance::value<0x2::sui::SUI>(&v15) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v15, arg2), v2);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v15);
        };
        if (0x2::balance::value<T0>(&v14) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v14, arg2), v2);
        } else {
            0x2::balance::destroy_zero<T0>(v14);
        };
        let v17 = if (arg1) {
            v0
        } else {
            v2
        };
        pay_out(v9, v17, arg2);
        let v18 = OrderClosed{
            order_id : 0x2::object::uid_to_inner(&v16),
            owner    : v2,
            by       : v0,
            expired  : arg1,
        };
        0x2::event::emit<OrderClosed>(v18);
        0x2::object::delete(v16);
    }

    fun emit_placed<T0>(arg0: &Order<T0>, arg1: u64, arg2: u64) {
        let v0 = OrderPlaced{
            order_id   : 0x2::object::id<Order<T0>>(arg0),
            owner      : arg0.owner,
            filler     : arg0.filler,
            coin       : 0x1::type_name::with_original_ids<T0>(),
            kind       : arg0.kind,
            trigger    : arg0.trigger,
            slip_bps   : arg0.slip_bps,
            amount     : arg1,
            tip        : arg2,
            fee_bps    : arg0.fee_bps,
            expires_ms : arg0.expires_ms,
        };
        0x2::event::emit<OrderPlaced>(v0);
    }

    public fun expires_ms<T0>(arg0: &Order<T0>) : u64 {
        arg0.expires_ms
    }

    public fun fee_bps<T0>(arg0: &Order<T0>) : u64 {
        arg0.fee_bps
    }

    public fun fill_min_out<T0>(arg0: &Fill<T0>) : u64 {
        arg0.min_out
    }

    public fun fill_owner<T0>(arg0: &Fill<T0>) : address {
        arg0.owner
    }

    public fun filler<T0>(arg0: &Order<T0>) : address {
        arg0.filler
    }

    public fun gross_for(arg0: u64, arg1: u64) : u64 {
        let v0 = ((10000 - arg1) as u256);
        cap(((arg0 as u256) * (10000 as u256) + v0 - 1) / v0)
    }

    public fun kind<T0>(arg0: &Order<T0>) : u8 {
        arg0.kind
    }

    public fun min_sui_for(arg0: u64, arg1: u128, arg2: u64) : u64 {
        let v0 = 1000000000000000000 * (10000 as u256);
        cap(((arg0 as u256) * (arg1 as u256) * ((10000 - arg2) as u256) + v0 - 1) / v0)
    }

    public fun min_tokens_for(arg0: u64, arg1: u128, arg2: u64) : u64 {
        cap((arg0 as u256) * 1000000000000000000 * (10000 as u256) / (arg1 as u256) * ((10000 + arg2) as u256))
    }

    public fun owner<T0>(arg0: &Order<T0>) : address {
        arg0.owner
    }

    fun pay_out(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg0);
        };
        v0
    }

    public fun place_buy<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: u8, arg4: u128, arg5: u64, arg6: u64, arg7: address, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::clock::timestamp_ms(arg9);
        let v1 = arg3 == 0 || arg3 == 1;
        check_common(v1, arg4, arg5, arg6, arg8, v0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v2 > 0, 3);
        assert!(v2 <= 1000000000000000, 11);
        let v3 = Order<T0>{
            id         : 0x2::object::new(arg10),
            owner      : 0x2::tx_context::sender(arg10),
            filler     : arg2,
            kind       : arg3,
            trigger    : arg4,
            slip_bps   : arg5,
            sui_in     : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            tokens_in  : 0x2::balance::zero<T0>(),
            tip        : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            fee_bps    : arg6,
            fee_to     : arg7,
            expires_ms : arg8,
            created_ms : v0,
        };
        emit_placed<T0>(&v3, v2, 0x2::coin::value<0x2::sui::SUI>(&arg1));
        0x2::transfer::share_object<Order<T0>>(v3);
        0x2::object::id<Order<T0>>(&v3)
    }

    public fun place_sell<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: u8, arg4: u128, arg5: u64, arg6: u64, arg7: address, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::clock::timestamp_ms(arg9);
        let v1 = arg3 == 2 || arg3 == 3;
        check_common(v1, arg4, arg5, arg6, arg8, v0);
        let v2 = 0x2::coin::value<T0>(&arg0);
        assert!(v2 > 0, 3);
        let v3 = Order<T0>{
            id         : 0x2::object::new(arg10),
            owner      : 0x2::tx_context::sender(arg10),
            filler     : arg2,
            kind       : arg3,
            trigger    : arg4,
            slip_bps   : arg5,
            sui_in     : 0x2::balance::zero<0x2::sui::SUI>(),
            tokens_in  : 0x2::coin::into_balance<T0>(arg0),
            tip        : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            fee_bps    : arg6,
            fee_to     : arg7,
            expires_ms : arg8,
            created_ms : v0,
        };
        emit_placed<T0>(&v3, v2, 0x2::coin::value<0x2::sui::SUI>(&arg1));
        0x2::transfer::share_object<Order<T0>>(v3);
        0x2::object::id<Order<T0>>(&v3)
    }

    public fun refund_expired<T0>(arg0: Order<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expires_ms, 9);
        close<T0>(arg0, true, arg2);
    }

    fun send_or_destroy<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun settle_buy<T0>(arg0: Fill<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let Fill {
            order_id  : v0,
            owner     : v1,
            filler    : v2,
            kind      : v3,
            amount_in : v4,
            min_out   : v5,
            fee_bps   : _,
            fee_to    : _,
            fee_paid  : v8,
            tip       : v9,
        } = arg0;
        assert!(v3 == 0 || v3 == 1, 13);
        let v10 = 0x2::coin::value<T0>(&arg1);
        assert!(v10 >= v5, 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v1);
        send_or_destroy<0x2::sui::SUI>(arg2, v1);
        let v11 = OrderFilled{
            order_id   : v0,
            owner      : v1,
            filler     : v2,
            kind       : v3,
            amount_in  : v4,
            amount_out : v10,
            fee        : v8,
            tip        : v9,
        };
        0x2::event::emit<OrderFilled>(v11);
    }

    public fun settle_sell<T0>(arg0: Fill<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let Fill {
            order_id  : v0,
            owner     : v1,
            filler    : v2,
            kind      : v3,
            amount_in : v4,
            min_out   : v5,
            fee_bps   : v6,
            fee_to    : v7,
            fee_paid  : _,
            tip       : v9,
        } = arg0;
        assert!(v3 == 2 || v3 == 3, 13);
        let v10 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v10 >= v5, 12);
        let v11 = v10 * v6 / 10000;
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v11, arg3), v7);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v1);
        send_or_destroy<T0>(arg2, v1);
        let v12 = OrderFilled{
            order_id   : v0,
            owner      : v1,
            filler     : v2,
            kind       : v3,
            amount_in  : v4,
            amount_out : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            fee        : v11,
            tip        : v9,
        };
        0x2::event::emit<OrderFilled>(v12);
    }

    public fun slip_bps<T0>(arg0: &Order<T0>) : u64 {
        arg0.slip_bps
    }

    public fun sui_amount<T0>(arg0: &Order<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_in)
    }

    public fun take_buy<T0>(arg0: Order<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, Fill<T0>) {
        assert!(arg0.kind == 0 || arg0.kind == 1, 13);
        assert!(0x2::tx_context::sender(arg2) == arg0.filler, 8);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.expires_ms, 7);
        let Order {
            id         : v0,
            owner      : v1,
            filler     : v2,
            kind       : v3,
            trigger    : v4,
            slip_bps   : v5,
            sui_in     : v6,
            tokens_in  : v7,
            tip        : v8,
            fee_bps    : v9,
            fee_to     : v10,
            expires_ms : _,
            created_ms : _,
        } = arg0;
        let v13 = v0;
        0x2::balance::destroy_zero<T0>(v7);
        let v14 = pay_out(v8, v2, arg2);
        let v15 = 0x2::coin::from_balance<0x2::sui::SUI>(v6, arg2);
        let v16 = 0x2::coin::value<0x2::sui::SUI>(&v15);
        let v17 = v16 * v9 / 10000;
        if (v17 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v15, v17, arg2), v10);
        };
        0x2::object::delete(v13);
        let v18 = Fill<T0>{
            order_id  : 0x2::object::uid_to_inner(&v13),
            owner     : v1,
            filler    : v2,
            kind      : v3,
            amount_in : v16,
            min_out   : min_tokens_for(v16, v4, v5),
            fee_bps   : v9,
            fee_to    : v10,
            fee_paid  : v17,
            tip       : v14,
        };
        (v15, v18)
    }

    public fun take_sell<T0>(arg0: Order<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Fill<T0>) {
        assert!(arg0.kind == 2 || arg0.kind == 3, 13);
        assert!(0x2::tx_context::sender(arg2) == arg0.filler, 8);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.expires_ms, 7);
        let Order {
            id         : v0,
            owner      : v1,
            filler     : v2,
            kind       : v3,
            trigger    : v4,
            slip_bps   : v5,
            sui_in     : v6,
            tokens_in  : v7,
            tip        : v8,
            fee_bps    : v9,
            fee_to     : v10,
            expires_ms : _,
            created_ms : _,
        } = arg0;
        let v13 = v0;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v6);
        let v14 = pay_out(v8, v2, arg2);
        let v15 = 0x2::coin::from_balance<T0>(v7, arg2);
        let v16 = 0x2::coin::value<T0>(&v15);
        0x2::object::delete(v13);
        let v17 = Fill<T0>{
            order_id  : 0x2::object::uid_to_inner(&v13),
            owner     : v1,
            filler    : v2,
            kind      : v3,
            amount_in : v16,
            min_out   : gross_for(min_sui_for(v16, v4, v5), v9),
            fee_bps   : v9,
            fee_to    : v10,
            fee_paid  : 0,
            tip       : v14,
        };
        (v15, v17)
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

