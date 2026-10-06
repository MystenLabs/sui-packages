module 0x5ca9b9dcbfef0dc82d04ebaace5c7917f407c208c879fcf2d175c9b59b4c9998::order {
    struct Order<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        pay: 0x2::balance::Balance<T0>,
        target: 0x2::balance::Balance<T1>,
        pay_total: u64,
        min_out_total: u64,
        filled_in: u64,
        filled_out: u64,
        fee_on_pay: bool,
        created_ms: u64,
        expires_ms: u64,
    }

    struct Fill<phantom T0, phantom T1> {
        order: 0x2::object::ID,
        amount_in: u64,
        fee_in: u64,
        required_out: u64,
    }

    struct OrderPlaced has copy, drop {
        order: 0x2::object::ID,
        owner: address,
        pay: 0x1::ascii::String,
        target: 0x1::ascii::String,
        pay_total: u64,
        min_out_total: u64,
        fee_on_pay: bool,
        expires_ms: u64,
    }

    struct OrderFilled has copy, drop {
        order: 0x2::object::ID,
        filler: address,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        fee_on_pay: bool,
        pay_left: u64,
    }

    struct OrderClaimed has copy, drop {
        order: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct OrderClosed has copy, drop {
        order: 0x2::object::ID,
        owner: address,
        reason: u8,
        pay_returned: u64,
        target_returned: u64,
    }

    public fun destroy_empty<T0, T1>(arg0: Order<T0, T1>) {
        assert!(0x2::balance::value<T0>(&arg0.pay) == 0 && 0x2::balance::value<T1>(&arg0.target) == 0, 210);
        let Order {
            id            : v0,
            owner         : _,
            pay           : v2,
            target        : v3,
            pay_total     : _,
            min_out_total : _,
            filled_in     : _,
            filled_out    : _,
            fee_on_pay    : _,
            created_ms    : _,
            expires_ms    : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v2);
        0x2::balance::destroy_zero<T1>(v3);
        0x2::object::delete(v0);
    }

    public fun cancel<T0, T1>(arg0: Order<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 207);
        close<T0, T1>(arg0, 1, arg1)
    }

    public fun claim<T0, T1>(arg0: &mut Order<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 207);
        let v0 = OrderClaimed{
            order  : 0x2::object::id<Order<T0, T1>>(arg0),
            owner  : arg0.owner,
            amount : 0x2::balance::value<T1>(&arg0.target),
        };
        0x2::event::emit<OrderClaimed>(v0);
        0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.target), arg1)
    }

    fun close<T0, T1>(arg0: Order<T0, T1>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let Order {
            id            : v0,
            owner         : v1,
            pay           : v2,
            target        : v3,
            pay_total     : _,
            min_out_total : _,
            filled_in     : _,
            filled_out    : _,
            fee_on_pay    : _,
            created_ms    : _,
            expires_ms    : _,
        } = arg0;
        let v11 = v3;
        let v12 = v2;
        let v13 = v0;
        if (0x2::balance::value<T0>(&v12) > 0 || 0x2::balance::value<T1>(&v11) > 0) {
            let v14 = OrderClosed{
                order           : 0x2::object::uid_to_inner(&v13),
                owner           : v1,
                reason          : arg1,
                pay_returned    : 0x2::balance::value<T0>(&v12),
                target_returned : 0x2::balance::value<T1>(&v11),
            };
            0x2::event::emit<OrderClosed>(v14);
        };
        0x2::object::delete(v13);
        (0x2::coin::from_balance<T0>(v12, arg2), 0x2::coin::from_balance<T1>(v11, arg2))
    }

    public fun close_expired<T0, T1>(arg0: Order<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expires_ms, 206);
        let v0 = arg0.owner;
        let (v1, v2) = close<T0, T1>(arg0, 2, arg2);
        send_or_destroy<T0>(v1, v0);
        send_or_destroy<T1>(v2, v0);
    }

    public fun expires_ms<T0, T1>(arg0: &Order<T0, T1>) : u64 {
        arg0.expires_ms
    }

    public fun fee_on_pay<T0, T1>(arg0: &Order<T0, T1>) : bool {
        arg0.fee_on_pay
    }

    public fun fill_amount_in<T0, T1>(arg0: &Fill<T0, T1>) : u64 {
        arg0.amount_in
    }

    public fun fill_fee_in<T0, T1>(arg0: &Fill<T0, T1>) : u64 {
        arg0.fee_in
    }

    public fun fill_order<T0, T1>(arg0: &Fill<T0, T1>) : 0x2::object::ID {
        arg0.order
    }

    public fun fill_required_out<T0, T1>(arg0: &Fill<T0, T1>) : u64 {
        arg0.required_out
    }

    public fun filled_in<T0, T1>(arg0: &Order<T0, T1>) : u64 {
        arg0.filled_in
    }

    public fun filled_out<T0, T1>(arg0: &Order<T0, T1>) : u64 {
        arg0.filled_out
    }

    public fun min_out_total<T0, T1>(arg0: &Order<T0, T1>) : u64 {
        arg0.min_out_total
    }

    public fun owner<T0, T1>(arg0: &Order<T0, T1>) : address {
        arg0.owner
    }

    public fun pay_left<T0, T1>(arg0: &Order<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.pay)
    }

    public fun pay_total<T0, T1>(arg0: &Order<T0, T1>) : u64 {
        arg0.pay_total
    }

    public fun place<T0, T1>(arg0: &0x5ca9b9dcbfef0dc82d04ebaace5c7917f407c208c879fcf2d175c9b59b4c9998::config::Config, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x5ca9b9dcbfef0dc82d04ebaace5c7917f407c208c879fcf2d175c9b59b4c9998::config::assert_open(arg0);
        assert!(0x1::type_name::with_original_ids<T0>() != 0x1::type_name::with_original_ids<T1>(), 201);
        let (v0, v1) = 0x5ca9b9dcbfef0dc82d04ebaace5c7917f407c208c879fcf2d175c9b59b4c9998::config::base_min<T0>(arg0);
        let (v2, v3) = 0x5ca9b9dcbfef0dc82d04ebaace5c7917f407c208c879fcf2d175c9b59b4c9998::config::base_min<T1>(arg0);
        let v4 = 0x2::coin::value<T0>(&arg1);
        assert!(v4 > 0, 202);
        assert!(arg2 > 0, 211);
        if (v0) {
            assert!(v4 >= v1, 202);
        } else if (v2) {
            assert!(arg2 >= v3, 202);
        };
        let v5 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg3 > v5 && arg3 - v5 <= 0x5ca9b9dcbfef0dc82d04ebaace5c7917f407c208c879fcf2d175c9b59b4c9998::config::max_order_ms(arg0), 203);
        let v6 = Order<T0, T1>{
            id            : 0x2::object::new(arg5),
            owner         : 0x2::tx_context::sender(arg5),
            pay           : 0x2::coin::into_balance<T0>(arg1),
            target        : 0x2::balance::zero<T1>(),
            pay_total     : v4,
            min_out_total : arg2,
            filled_in     : 0,
            filled_out    : 0,
            fee_on_pay    : v0,
            created_ms    : v5,
            expires_ms    : arg3,
        };
        let v7 = 0x2::object::id<Order<T0, T1>>(&v6);
        let v8 = OrderPlaced{
            order         : v7,
            owner         : v6.owner,
            pay           : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            target        : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T1>()),
            pay_total     : v4,
            min_out_total : arg2,
            fee_on_pay    : v0,
            expires_ms    : arg3,
        };
        0x2::event::emit<OrderPlaced>(v8);
        0x2::transfer::share_object<Order<T0, T1>>(v6);
        v7
    }

    fun send_or_destroy<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public fun settle<T0, T1>(arg0: &0x5ca9b9dcbfef0dc82d04ebaace5c7917f407c208c879fcf2d175c9b59b4c9998::config::Config, arg1: &mut Order<T0, T1>, arg2: Fill<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x5ca9b9dcbfef0dc82d04ebaace5c7917f407c208c879fcf2d175c9b59b4c9998::config::assert_version(arg0);
        let Fill {
            order        : v0,
            amount_in    : v1,
            fee_in       : v2,
            required_out : v3,
        } = arg2;
        assert!(v0 == 0x2::object::id<Order<T0, T1>>(arg1), 208);
        let v4 = if (arg1.fee_on_pay) {
            0
        } else {
            0x5ca9b9dcbfef0dc82d04ebaace5c7917f407c208c879fcf2d175c9b59b4c9998::config::fee_on(arg0, 0x2::coin::value<T1>(&arg3))
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg3, v4, arg4), 0x5ca9b9dcbfef0dc82d04ebaace5c7917f407c208c879fcf2d175c9b59b4c9998::config::fee_recipient(arg0));
        };
        let v5 = 0x2::coin::value<T1>(&arg3);
        assert!(v5 >= v3, 209);
        arg1.filled_out = arg1.filled_out + v5;
        0x2::balance::join<T1>(&mut arg1.target, 0x2::coin::into_balance<T1>(arg3));
        let v6 = OrderFilled{
            order      : v0,
            filler     : 0x2::tx_context::sender(arg4),
            amount_in  : v1,
            amount_out : v5,
            fee        : v2 + v4,
            fee_on_pay : arg1.fee_on_pay,
            pay_left   : 0x2::balance::value<T0>(&arg1.pay),
        };
        0x2::event::emit<OrderFilled>(v6);
        if (0x2::balance::value<T0>(&arg1.pay) == 0) {
            let v7 = 0x2::balance::value<T1>(&arg1.target);
            if (v7 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.target), arg4), arg1.owner);
            };
            let v8 = OrderClosed{
                order           : v0,
                owner           : arg1.owner,
                reason          : 0,
                pay_returned    : 0,
                target_returned : v7,
            };
            0x2::event::emit<OrderClosed>(v8);
        };
    }

    public fun take<T0, T1>(arg0: &0x5ca9b9dcbfef0dc82d04ebaace5c7917f407c208c879fcf2d175c9b59b4c9998::config::Config, arg1: &mut Order<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Fill<T0, T1>) {
        0x5ca9b9dcbfef0dc82d04ebaace5c7917f407c208c879fcf2d175c9b59b4c9998::config::assert_open(arg0);
        0x5ca9b9dcbfef0dc82d04ebaace5c7917f407c208c879fcf2d175c9b59b4c9998::config::assert_filler(arg0, 0x2::tx_context::sender(arg4));
        assert!(0x2::clock::timestamp_ms(arg3) < arg1.expires_ms, 205);
        assert!(arg2 > 0 && arg2 <= 0x2::balance::value<T0>(&arg1.pay), 204);
        arg1.filled_in = arg1.filled_in + arg2;
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pay, arg2), arg4);
        let v1 = if (arg1.fee_on_pay) {
            0x5ca9b9dcbfef0dc82d04ebaace5c7917f407c208c879fcf2d175c9b59b4c9998::config::fee_on(arg0, arg2)
        } else {
            0
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, v1, arg4), 0x5ca9b9dcbfef0dc82d04ebaace5c7917f407c208c879fcf2d175c9b59b4c9998::config::fee_recipient(arg0));
        };
        let v2 = Fill<T0, T1>{
            order        : 0x2::object::id<Order<T0, T1>>(arg1),
            amount_in    : arg2,
            fee_in       : v1,
            required_out : 0x5ca9b9dcbfef0dc82d04ebaace5c7917f407c208c879fcf2d175c9b59b4c9998::math::mul_div_up(arg2, arg1.min_out_total, arg1.pay_total),
        };
        (v0, v2)
    }

    public fun target_held<T0, T1>(arg0: &Order<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.target)
    }

    // decompiled from Move bytecode v7
}

