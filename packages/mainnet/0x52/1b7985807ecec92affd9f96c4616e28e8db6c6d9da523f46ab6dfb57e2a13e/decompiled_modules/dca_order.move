module 0x521b7985807ecec92affd9f96c4616e28e8db6c6d9da523f46ab6dfb57e2a13e::dca_order {
    struct DcaOrderCreated has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        pay_amount: vector<u64>,
        interval: u64,
        slippage: u64,
        min_rate: u64,
        max_rate: u64,
    }

    struct DcaOrderCanceled has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
    }

    struct DcaOrderPrefilled has copy, drop {
        order_id: 0x2::object::ID,
        min_repay_amount: u64,
        max_repay_amount: u64,
    }

    struct DcaOrderFilled has copy, drop {
        order_id: 0x2::object::ID,
        obtained_amount: u64,
    }

    struct DcaOrderClaimed has copy, drop {
        order_id: 0x2::object::ID,
        claimed_amount: u64,
    }

    struct DcaOrderRefunded has copy, drop {
        order_id: 0x2::object::ID,
        owner: address,
        pay_amount: u64,
        target_amount: u64,
    }

    struct DcaOrder<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        owner: address,
        pay_balance: vector<0x2::balance::Balance<T0>>,
        target_balance: 0x2::balance::Balance<T1>,
        total_pay_amount: u64,
        obtained_amount: u64,
        claimed_amount: u64,
        interval: u64,
        slippage: u64,
        min_rate: u64,
        max_rate: u64,
        created_ts: u64,
        canceled_ts: u64,
        last_filled_ts: u64,
    }

    struct DcaOrderPrefill {
        order_id: 0x2::object::ID,
        min_repay_amount: u64,
        max_repay_amount: u64,
    }

    public entry fun cancel_dca_order<T0, T1>(arg0: &mut DcaOrder<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        only_valid_order<T0, T1>(arg0, arg1);
        only_order_owner<T0, T1>(arg0, arg2);
        arg0.canceled_ts = 0x2::clock::timestamp_ms(arg1);
        refund_order<T0, T1>(arg0, arg2);
        let v0 = DcaOrderCanceled{
            order_id : 0x2::object::id<DcaOrder<T0, T1>>(arg0),
            owner    : arg0.owner,
        };
        0x2::event::emit<DcaOrderCanceled>(v0);
    }

    public entry fun claim<T0, T1>(arg0: &mut DcaOrder<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        only_order_owner<T0, T1>(arg0, arg2);
        send_target_balance<T0, T1>(arg0, arg1, arg2);
    }

    public fun fill_dca_order<T0, T1>(arg0: &0x521b7985807ecec92affd9f96c4616e28e8db6c6d9da523f46ab6dfb57e2a13e::config::GlobalConfig, arg1: &mut DcaOrder<T0, T1>, arg2: DcaOrderPrefill, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x521b7985807ecec92affd9f96c4616e28e8db6c6d9da523f46ab6dfb57e2a13e::config::only_operator(arg0, arg6);
        only_valid_order<T0, T1>(arg1, arg5);
        let DcaOrderPrefill {
            order_id         : v0,
            min_repay_amount : v1,
            max_repay_amount : v2,
        } = arg2;
        assert!(0x2::object::id<DcaOrder<T0, T1>>(arg1) == v0, 5);
        let v3 = 0x2::coin::into_balance<T1>(arg3);
        let v4 = 0x2::balance::value<T1>(&v3);
        assert!(v4 >= v1, 6);
        assert!(v4 <= v2, 7);
        arg1.obtained_amount = arg1.obtained_amount + v4;
        let v5 = DcaOrderFilled{
            order_id        : 0x2::object::id<DcaOrder<T0, T1>>(arg1),
            obtained_amount : v4,
        };
        0x2::event::emit<DcaOrderFilled>(v5);
        0x2::balance::join<T1>(&mut arg1.target_balance, v3);
        if (arg4) {
            send_target_balance<T0, T1>(arg1, v4, arg6);
        };
    }

    fun only_order_owner<T0, T1>(arg0: &DcaOrder<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
    }

    fun only_valid_order<T0, T1>(arg0: &DcaOrder<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.created_ts, 2);
        assert!(arg0.canceled_ts == 0, 3);
        assert!(arg0.last_filled_ts <= v0, 9);
    }

    public entry fun place_dca_order<T0, T1>(arg0: &0x521b7985807ecec92affd9f96c4616e28e8db6c6d9da523f46ab6dfb57e2a13e::config::GlobalConfig, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg1) > 0, 0);
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg1) <= 0x521b7985807ecec92affd9f96c4616e28e8db6c6d9da523f46ab6dfb57e2a13e::config::get_max_dca_order_count(arg0), 0);
        assert!(arg2 <= 0x521b7985807ecec92affd9f96c4616e28e8db6c6d9da523f46ab6dfb57e2a13e::config::get_max_interval(arg0), 10);
        assert!(arg3 <= 10000, 11);
        assert!(arg4 <= arg5, 12);
        let v0 = 0x1::vector::empty<0x2::balance::Balance<T0>>();
        let v1 = vector[];
        let v2 = 0;
        while (0x1::vector::length<0x2::coin::Coin<T0>>(&arg1) > 0) {
            let v3 = 0x2::coin::into_balance<T0>(0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg1));
            v2 = v2 + 0x2::balance::value<T0>(&v3);
            0x1::vector::push_back<u64>(&mut v1, 0x2::balance::value<T0>(&v3));
            0x1::vector::push_back<0x2::balance::Balance<T0>>(&mut v0, v3);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg1);
        let v4 = 0x2::object::new(arg7);
        let v5 = 0x2::tx_context::sender(arg7);
        let v6 = DcaOrder<T0, T1>{
            id               : v4,
            owner            : v5,
            pay_balance      : v0,
            target_balance   : 0x2::balance::zero<T1>(),
            total_pay_amount : v2,
            obtained_amount  : 0,
            claimed_amount   : 0,
            interval         : arg2,
            slippage         : arg3,
            min_rate         : arg4,
            max_rate         : arg5,
            created_ts       : 0x2::clock::timestamp_ms(arg6),
            canceled_ts      : 0,
            last_filled_ts   : 0,
        };
        let v7 = DcaOrderCreated{
            order_id   : 0x2::object::uid_to_inner(&v4),
            owner      : v5,
            pay_amount : v1,
            interval   : arg2,
            slippage   : arg3,
            min_rate   : arg4,
            max_rate   : arg5,
        };
        0x2::event::emit<DcaOrderCreated>(v7);
        0x2::transfer::share_object<DcaOrder<T0, T1>>(v6);
    }

    public fun prefill_dca_order<T0, T1>(arg0: &0x521b7985807ecec92affd9f96c4616e28e8db6c6d9da523f46ab6dfb57e2a13e::config::GlobalConfig, arg1: &mut DcaOrder<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, DcaOrderPrefill) {
        assert!(0x1::vector::length<0x2::balance::Balance<T0>>(&arg1.pay_balance) > 0, 4);
        0x521b7985807ecec92affd9f96c4616e28e8db6c6d9da523f46ab6dfb57e2a13e::config::only_operator(arg0, arg4);
        only_valid_order<T0, T1>(arg1, arg3);
        validate_ts<T0, T1>(arg1, arg3);
        let v0 = 0x1::vector::pop_back<0x2::balance::Balance<T0>>(&mut arg1.pay_balance);
        let v1 = (((0x2::balance::value<T0>(&v0) as u256) * (arg1.min_rate as u256) * ((10000 - arg1.slippage) as u256) / (1000000000000 as u256) * (10000 as u256)) as u64);
        0x521b7985807ecec92affd9f96c4616e28e8db6c6d9da523f46ab6dfb57e2a13e::config::only_valid_fee(arg0, arg2, v1);
        let v2 = v1 - arg2;
        let v3 = (((0x2::balance::value<T0>(&v0) as u256) * (arg1.max_rate as u256) * ((10000 + arg1.slippage) as u256) / (1000000000000 as u256) * (10000 as u256)) as u64);
        arg1.last_filled_ts = 0x2::clock::timestamp_ms(arg3);
        let v4 = DcaOrderPrefilled{
            order_id         : 0x2::object::id<DcaOrder<T0, T1>>(arg1),
            min_repay_amount : v2,
            max_repay_amount : v3,
        };
        0x2::event::emit<DcaOrderPrefilled>(v4);
        let v5 = DcaOrderPrefill{
            order_id         : 0x2::object::id<DcaOrder<T0, T1>>(arg1),
            min_repay_amount : v2,
            max_repay_amount : v3,
        };
        (0x2::coin::from_balance<T0>(v0, arg4), v5)
    }

    fun refund_order<T0, T1>(arg0: &mut DcaOrder<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (0x1::vector::length<0x2::balance::Balance<T0>>(&arg0.pay_balance) > 0) {
            let v1 = 0x1::vector::pop_back<0x2::balance::Balance<T0>>(&mut arg0.pay_balance);
            v0 = v0 + 0x2::balance::value<T0>(&v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg1), arg0.owner);
        };
        let v2 = DcaOrderRefunded{
            order_id      : 0x2::object::id<DcaOrder<T0, T1>>(arg0),
            owner         : arg0.owner,
            pay_amount    : v0,
            target_amount : 0x2::balance::value<T1>(&arg0.target_balance),
        };
        0x2::event::emit<DcaOrderRefunded>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.target_balance), arg1), arg0.owner);
    }

    fun send_target_balance<T0, T1>(arg0: &mut DcaOrder<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.claimed_amount = arg0.claimed_amount + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.target_balance, arg1), arg2), arg0.owner);
        let v0 = DcaOrderClaimed{
            order_id       : 0x2::object::id<DcaOrder<T0, T1>>(arg0),
            claimed_amount : arg1,
        };
        0x2::event::emit<DcaOrderClaimed>(v0);
    }

    fun validate_ts<T0, T1>(arg0: &DcaOrder<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = (v0 - arg0.created_ts) / arg0.interval * arg0.interval + arg0.created_ts;
        let v2 = v1 + arg0.interval;
        if (arg0.last_filled_ts > v0) {
            abort 9
        };
        if (!(v0 - v1 < 60000) && !(v2 - v0 < 60000)) {
            abort 9
        };
        if (v0 - v1 < 60000 && 0x1::u64::diff(arg0.last_filled_ts, v1) < 60000) {
            abort 9
        };
        if (v2 - v0 < 60000 && 0x1::u64::diff(arg0.last_filled_ts, v2) < 60000) {
            abort 9
        };
    }

    // decompiled from Move bytecode v6
}

