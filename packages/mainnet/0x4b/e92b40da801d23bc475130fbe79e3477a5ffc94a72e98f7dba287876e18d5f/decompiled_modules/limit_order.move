module 0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::limit_order {
    struct LimitOrder<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        slippage: u64,
        balance_quote: 0x2::balance::Balance<T1>,
        target_price: u64,
        created_at: u64,
        expire_at: u64,
    }

    struct FillPromise {
        owner: address,
        order_id: 0x2::object::ID,
        min_base_out: u64,
    }

    struct OrderCreated has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        quote_amount: u64,
        target_price: u64,
        slippage: u64,
        expire_at: u64,
    }

    struct OrderFilled has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        base_amount: u64,
        fee_amount: u64,
    }

    struct OrderCancelled has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
    }

    struct OrderExpireClaimed has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
    }

    public fun borrow_to_fill<T0, T1>(arg0: &0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::config::KeeperCap, arg1: &mut LimitOrder<T0, T1>, arg2: &0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, FillPromise) {
        0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::config::assert_version(arg2);
        0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::config::assert_is_keeper(arg0, arg2, arg4);
        if (arg1.expire_at > 0) {
            assert!(0x2::clock::timestamp_ms(arg3) < arg1.expire_at, 6);
        };
        let v0 = &mut arg1.balance_quote;
        let v1 = 0x2::balance::value<T1>(v0);
        let v2 = 0x2::coin::take<T1>(v0, v1, arg4);
        let v3 = FillPromise{
            owner        : arg1.owner,
            order_id     : 0x2::object::id<LimitOrder<T0, T1>>(arg1),
            min_base_out : 0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::safe_math::safe_mul_div_u64(v1, 1000000000 * (10000 - arg1.slippage), arg1.target_price * 10000),
        };
        (v2, v3)
    }

    public fun cancel_order<T0, T1>(arg0: LimitOrder<T0, T1>, arg1: &0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::config::Config, arg2: &mut 0x2::tx_context::TxContext) {
        0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::config::assert_version(arg1);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        let v0 = arg0.owner;
        let LimitOrder {
            id            : v1,
            owner         : _,
            slippage      : _,
            balance_quote : v4,
            target_price  : _,
            created_at    : _,
            expire_at     : _,
        } = arg0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg2), v0);
        0x2::object::delete(v1);
        let v8 = OrderCancelled{
            order_id : 0x2::object::id<LimitOrder<T0, T1>>(&arg0),
            owner    : v0,
        };
        0x2::event::emit<OrderCancelled>(v8);
    }

    public fun claim_expired<T0, T1>(arg0: LimitOrder<T0, T1>, arg1: &0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::config::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::config::assert_version(arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.owner == v0 || 0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::config::is_keeper(arg1, v0), 1);
        assert!(arg0.expire_at > 0 && 0x2::clock::timestamp_ms(arg2) >= arg0.expire_at, 7);
        let v1 = arg0.owner;
        let LimitOrder {
            id            : v2,
            owner         : _,
            slippage      : _,
            balance_quote : v5,
            target_price  : _,
            created_at    : _,
            expire_at     : _,
        } = arg0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg3), v1);
        0x2::object::delete(v2);
        let v9 = OrderExpireClaimed{
            order_id : 0x2::object::id<LimitOrder<T0, T1>>(&arg0),
            owner    : v1,
        };
        0x2::event::emit<OrderExpireClaimed>(v9);
    }

    public fun complete_fill<T0, T1>(arg0: &0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::config::KeeperCap, arg1: LimitOrder<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: FillPromise, arg4: &0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::config::Config, arg5: &mut 0x2::tx_context::TxContext) {
        0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::config::assert_version(arg4);
        0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::config::assert_is_keeper(arg0, arg4, arg5);
        let FillPromise {
            owner        : v0,
            order_id     : v1,
            min_base_out : v2,
        } = arg3;
        assert!(arg1.owner == v0, 3);
        assert!(0x2::object::id<LimitOrder<T0, T1>>(&arg1) == v1, 4);
        let v3 = 0x2::coin::value<T0>(&arg2);
        assert!(v3 >= v2, 5);
        let v4 = v3 * 0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::config::fee_bps(arg4) / 10000;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v4, arg5), 0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::config::fee_wallet(arg4));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v0);
        let LimitOrder {
            id            : v5,
            owner         : _,
            slippage      : _,
            balance_quote : v8,
            target_price  : _,
            created_at    : _,
            expire_at     : _,
        } = arg1;
        0x2::balance::destroy_zero<T1>(v8);
        0x2::object::delete(v5);
        let v12 = OrderFilled{
            order_id    : v1,
            owner       : v0,
            base_amount : v3 - v4,
            fee_amount  : v4,
        };
        0x2::event::emit<OrderFilled>(v12);
    }

    public fun place_limit_buy<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::config::Config, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::config::assert_version(arg4);
        let v0 = 0x2::coin::value<T1>(&arg0);
        assert!(v0 > 0, 8);
        assert!(arg1 > 0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = if (arg3 > 0) {
            v1 + arg3 * 1000
        } else {
            0
        };
        let v3 = LimitOrder<T0, T1>{
            id            : 0x2::object::new(arg6),
            owner         : 0x2::tx_context::sender(arg6),
            slippage      : arg2,
            balance_quote : 0x2::coin::into_balance<T1>(arg0),
            target_price  : arg1,
            created_at    : v1,
            expire_at     : v2,
        };
        let v4 = OrderCreated{
            order_id     : 0x2::object::id<LimitOrder<T0, T1>>(&v3),
            owner        : 0x2::tx_context::sender(arg6),
            quote_amount : v0,
            target_price : arg1,
            slippage     : arg2,
            expire_at    : v2,
        };
        0x2::event::emit<OrderCreated>(v4);
        0x2::transfer::share_object<LimitOrder<T0, T1>>(v3);
    }

    // decompiled from Move bytecode v6
}

