module 0xa759cc971b91a61f2c16ab4cff9424da531d942f9fff4d191801e0e0dffe2111::limit_order {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        admin: address,
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
        created_ts: u64,
        expire_ts: u64,
        canceled_ts: u64,
    }

    struct LimitOrderPrefill {
        order_id: 0x2::object::ID,
        repay_amount: u64,
    }

    public entry fun cancel_limit_order<T0, T1>(arg0: &GlobalConfig, arg1: &mut LimitOrder<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 0);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        assert!(v0 < arg1.expire_ts, 1);
        assert!(v0 > arg1.created_ts, 2);
        arg1.canceled_ts = v0;
    }

    public entry fun claim<T0, T1>(arg0: &GlobalConfig, arg1: &mut LimitOrder<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 0);
        assert!(0x2::tx_context::epoch_timestamp_ms(arg3) > arg1.created_ts, 2);
        assert!(arg1.canceled_ts == 0, 3);
        arg1.claimed_amount = arg1.claimed_amount + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.target_balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun fill_limit_order<T0, T1>(arg0: &GlobalConfig, arg1: &mut LimitOrder<T0, T1>, arg2: LimitOrderPrefill, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        assert!(v0 < arg1.expire_ts, 1);
        assert!(v0 > arg1.created_ts, 2);
        assert!(arg1.canceled_ts == 0, 3);
        let LimitOrderPrefill {
            order_id     : v1,
            repay_amount : v2,
        } = arg2;
        assert!(0x2::object::id<LimitOrder<T0, T1>>(arg1) == v1, 4);
        let v3 = 0x2::coin::into_balance<T1>(arg3);
        assert!(0x2::balance::value<T1>(&v3) >= v2, 5);
        arg1.obtained_amount = arg1.obtained_amount + 0x2::balance::value<T1>(&v3);
        0x2::balance::join<T1>(&mut arg1.target_balance, v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<GlobalConfig>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun place_limit_order<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg0);
        let v1 = LimitOrder<T0, T1>{
            id               : 0x2::object::new(arg3),
            owner            : 0x2::tx_context::sender(arg3),
            pay_balance      : v0,
            target_balance   : 0x2::balance::zero<T1>(),
            total_pay_amount : 0x2::balance::value<T0>(&v0),
            obtained_amount  : 0,
            claimed_amount   : 0,
            rate             : arg1,
            created_ts       : 0x2::tx_context::epoch_timestamp_ms(arg3),
            expire_ts        : arg2,
            canceled_ts      : 0,
        };
        0x2::transfer::transfer<LimitOrder<T0, T1>>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun prefill_limit_order<T0, T1>(arg0: &GlobalConfig, arg1: &mut LimitOrder<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, LimitOrderPrefill) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        assert!(v0 < arg1.expire_ts, 1);
        assert!(v0 > arg1.created_ts, 2);
        assert!(arg1.canceled_ts == 0, 3);
        let v1 = LimitOrderPrefill{
            order_id     : 0x2::object::id<LimitOrder<T0, T1>>(arg1),
            repay_amount : (((arg2 as u128) * (arg1.rate as u128) / (1000000000000 as u128)) as u64),
        };
        (0x2::coin::take<T0>(&mut arg1.pay_balance, arg2, arg3), v1)
    }

    // decompiled from Move bytecode v6
}

