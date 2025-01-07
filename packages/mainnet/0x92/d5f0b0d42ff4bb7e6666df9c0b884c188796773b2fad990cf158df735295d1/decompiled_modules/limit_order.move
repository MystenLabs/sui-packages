module 0x92d5f0b0d42ff4bb7e6666df9c0b884c188796773b2fad990cf158df735295d1::limit_order {
    struct LimitOrderCreated has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        pay_amount: u64,
        rate: u64,
        slippage: u64,
        expire_ts: u64,
    }

    struct LimitOrderCanceled has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
    }

    struct LimitOrderPrefilled has copy, drop {
        order_id: 0x2::object::ID,
        repay_amount: u64,
    }

    struct LimitOrderFilled has copy, drop {
        order_id: 0x2::object::ID,
        obtained_amount: u64,
    }

    struct LimitOrderClaimed has copy, drop {
        order_id: 0x2::object::ID,
        claimed_amount: u64,
    }

    struct LimitOrder<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        owner: address,
        pay_balance: 0x2::balance::Balance<T0>,
        target_balance: 0x2::balance::Balance<T1>,
        total_pay_amount: u64,
        obtained_amount: u64,
        claimed_amount: u64,
        rate: u64,
        slippage: u64,
        created_ts: u64,
        expire_ts: u64,
        canceled_ts: u64,
    }

    struct LimitOrderPrefill {
        order_id: 0x2::object::ID,
        repay_amount: u64,
    }

    public entry fun cancel_limit_order<T0, T1>(arg0: &mut LimitOrder<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        only_order_owner<T0, T1>(arg0, arg1);
        only_valid_order<T0, T1>(arg0, arg1);
        arg0.canceled_ts = 0x2::tx_context::epoch_timestamp_ms(arg1);
        refund_order<T0, T1>(arg0, arg1);
        let v0 = LimitOrderCanceled{
            order_id : 0x2::object::id<LimitOrder<T0, T1>>(arg0),
            owner    : arg0.owner,
        };
        0x2::event::emit<LimitOrderCanceled>(v0);
    }

    public entry fun claim<T0, T1>(arg0: &mut LimitOrder<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        only_order_owner<T0, T1>(arg0, arg2);
        send_target_balance<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun claim_expired_order<T0, T1>(arg0: &mut LimitOrder<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        only_expired_order<T0, T1>(arg0, arg1);
        refund_order<T0, T1>(arg0, arg1);
    }

    public fun fill_limit_order<T0, T1>(arg0: &0x92d5f0b0d42ff4bb7e6666df9c0b884c188796773b2fad990cf158df735295d1::config::GlobalConfig, arg1: &mut LimitOrder<T0, T1>, arg2: LimitOrderPrefill, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0x92d5f0b0d42ff4bb7e6666df9c0b884c188796773b2fad990cf158df735295d1::config::only_operator(arg0, arg5);
        only_valid_order<T0, T1>(arg1, arg5);
        let LimitOrderPrefill {
            order_id     : v0,
            repay_amount : v1,
        } = arg2;
        assert!(0x2::object::id<LimitOrder<T0, T1>>(arg1) == v0, 4);
        let v2 = 0x2::coin::value<T1>(&arg3);
        let v3 = 0x2::coin::into_balance<T1>(arg3);
        assert!(0x2::balance::value<T1>(&v3) >= v1, 5);
        let v4 = LimitOrderFilled{
            order_id        : 0x2::object::id<LimitOrder<T0, T1>>(arg1),
            obtained_amount : 0x2::balance::value<T1>(&v3),
        };
        0x2::event::emit<LimitOrderFilled>(v4);
        arg1.obtained_amount = arg1.obtained_amount + v2;
        0x2::balance::join<T1>(&mut arg1.target_balance, v3);
        if (arg4) {
            send_target_balance<T0, T1>(arg1, v2, arg5);
        };
    }

    fun only_expired_order<T0, T1>(arg0: &LimitOrder<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch_timestamp_ms(arg1) > arg0.expire_ts, 1);
    }

    fun only_order_owner<T0, T1>(arg0: &LimitOrder<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
    }

    fun only_valid_order<T0, T1>(arg0: &LimitOrder<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg1);
        assert!(v0 <= arg0.expire_ts, 1);
        assert!(v0 >= arg0.created_ts, 2);
        assert!(arg0.canceled_ts == 0, 3);
    }

    public entry fun place_limit_order<T0, T1>(arg0: &0x92d5f0b0d42ff4bb7e6666df9c0b884c188796773b2fad990cf158df735295d1::config::GlobalConfig, arg1: &mut 0x92d5f0b0d42ff4bb7e6666df9c0b884c188796773b2fad990cf158df735295d1::config::GlobalFeeConfig, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::balance::value<T0>(&v0);
        0x92d5f0b0d42ff4bb7e6666df9c0b884c188796773b2fad990cf158df735295d1::config::add_fee(arg1, arg3, v1);
        let v2 = 0x2::tx_context::epoch_timestamp_ms(arg7);
        let v3 = 0x2::object::new(arg7);
        let v4 = 0x2::tx_context::sender(arg7);
        let v5 = arg6 - v2;
        assert!(v5 >= 0, 1);
        assert!(v5 <= 0x92d5f0b0d42ff4bb7e6666df9c0b884c188796773b2fad990cf158df735295d1::config::get_max_time_to_live_limit_order(arg0), 1);
        let v6 = LimitOrder<T0, T1>{
            id               : v3,
            owner            : v4,
            pay_balance      : v0,
            target_balance   : 0x2::balance::zero<T1>(),
            total_pay_amount : v1,
            obtained_amount  : 0,
            claimed_amount   : 0,
            rate             : arg4,
            slippage         : arg5,
            created_ts       : v2,
            expire_ts        : arg6,
            canceled_ts      : 0,
        };
        let v7 = LimitOrderCreated{
            order_id   : 0x2::object::uid_to_inner(&v3),
            owner      : v4,
            pay_amount : v1,
            rate       : arg4,
            slippage   : arg5,
            expire_ts  : arg6,
        };
        0x2::event::emit<LimitOrderCreated>(v7);
        0x2::transfer::share_object<LimitOrder<T0, T1>>(v6);
    }

    public fun prefill_limit_order<T0, T1>(arg0: &0x92d5f0b0d42ff4bb7e6666df9c0b884c188796773b2fad990cf158df735295d1::config::GlobalConfig, arg1: &mut LimitOrder<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, LimitOrderPrefill) {
        0x92d5f0b0d42ff4bb7e6666df9c0b884c188796773b2fad990cf158df735295d1::config::only_operator(arg0, arg3);
        only_valid_order<T0, T1>(arg1, arg3);
        let v0 = ((((((arg2 as u128) * (arg1.rate as u128) / (1000000000000 as u128)) as u64) as u128) * ((10000 - arg1.slippage) as u128) / (10000 as u128)) as u64);
        let v1 = LimitOrderPrefilled{
            order_id     : 0x2::object::id<LimitOrder<T0, T1>>(arg1),
            repay_amount : v0,
        };
        0x2::event::emit<LimitOrderPrefilled>(v1);
        let v2 = LimitOrderPrefill{
            order_id     : 0x2::object::id<LimitOrder<T0, T1>>(arg1),
            repay_amount : v0,
        };
        (0x2::coin::take<T0>(&mut arg1.pay_balance, arg2, arg3), v2)
    }

    fun refund_order<T0, T1>(arg0: &mut LimitOrder<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.pay_balance), arg1), arg0.owner);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.target_balance), arg1), arg0.owner);
    }

    fun send_target_balance<T0, T1>(arg0: &mut LimitOrder<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.claimed_amount = arg0.claimed_amount + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.target_balance, arg1), arg2), arg0.owner);
        let v0 = LimitOrderClaimed{
            order_id       : 0x2::object::id<LimitOrder<T0, T1>>(arg0),
            claimed_amount : arg1,
        };
        0x2::event::emit<LimitOrderClaimed>(v0);
    }

    // decompiled from Move bytecode v6
}

