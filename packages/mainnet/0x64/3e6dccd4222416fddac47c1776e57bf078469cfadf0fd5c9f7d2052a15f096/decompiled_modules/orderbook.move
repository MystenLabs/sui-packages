module 0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::orderbook {
    struct ORDERBOOK has drop {
        dummy_field: bool,
    }

    struct LimitOrder<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        owner: address,
        pay_balance: 0x2::balance::Balance<T0>,
        target_balance: 0x2::balance::Balance<T1>,
        total_pay_amount: u64,
        obtained_amount: u64,
        claimed_amount: u64,
        rate: u128,
        created_ts: u64,
        expire_ts: u64,
        canceled_ts: u64,
    }

    struct FlashLoanReceipt<phantom T0> {
        order_id: 0x2::object::ID,
        owner: address,
        target_repay_amount: u64,
    }

    struct OrderPlacedEvent has copy, drop, store {
        order_id: 0x2::object::ID,
        owner: address,
        pay_coin: 0x1::ascii::String,
        target_coin: 0x1::ascii::String,
        total_pay_amount: u64,
        rate: u128,
        created_ts: u64,
        expire_ts: u64,
    }

    struct OrderCanceledEvent has copy, drop, store {
        order_id: 0x2::object::ID,
        owner: address,
        total_pay_amount: u64,
        remaining_pay_amount: u64,
        remaining_target_amount: u64,
        rate: u128,
        expire_ts: u64,
        cancel_reason: u8,
    }

    struct FlashLoanEvent has copy, drop, store {
        order_id: 0x2::object::ID,
        amount: u64,
        remaining_amount: u64,
        target_repay_amount: u64,
        owner: address,
        borrower: address,
    }

    struct RepayFlashLoanEvent has copy, drop, store {
        order_id: 0x2::object::ID,
        repay_amount: u64,
        repayer: address,
    }

    struct ClaimTargetCoinEvent has copy, drop, store {
        order_id: 0x2::object::ID,
        claimed_amount: u64,
    }

    fun cancel_order<T0, T1>(arg0: &mut LimitOrder<T0, T1>, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.canceled_ts == 18446744073709551615, 8);
        let v0 = 0;
        let v1 = 0;
        if (0x2::balance::value<T0>(&arg0.pay_balance) > 0) {
            v0 = 0x2::balance::value<T0>(&arg0.pay_balance);
            v1 = 0x2::balance::value<T1>(&arg0.target_balance);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.pay_balance), arg3), arg0.owner);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.target_balance), arg3), arg0.owner);
        };
        arg0.canceled_ts = 0x2::clock::timestamp_ms(arg2);
        let v2 = OrderCanceledEvent{
            order_id                : 0x2::object::id<LimitOrder<T0, T1>>(arg0),
            owner                   : arg0.owner,
            total_pay_amount        : arg0.total_pay_amount,
            remaining_pay_amount    : v0,
            remaining_target_amount : v1,
            rate                    : arg0.rate,
            expire_ts               : arg0.expire_ts,
            cancel_reason           : arg1,
        };
        0x2::event::emit<OrderCanceledEvent>(v2);
    }

    public fun cancel_order_by_keeper<T0, T1>(arg0: &0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::GlobalConfig, arg1: &mut LimitOrder<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::checked_package_version(arg0);
        0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::checked_keeper(arg0, 0x2::tx_context::sender(arg3));
        let v0 = 0;
        if (0x2::balance::value<T0>(&arg1.pay_balance) == 0) {
            v0 = 3;
        } else if (arg1.expire_ts < 0x2::clock::timestamp_ms(arg2)) {
            v0 = 1;
        };
        assert!(v0 > 0, 9);
        cancel_order<T0, T1>(arg1, v0, arg2, arg3);
    }

    public fun cancel_order_by_owner<T0, T1>(arg0: &0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::GlobalConfig, arg1: &mut LimitOrder<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::checked_package_version(arg0);
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 13);
        cancel_order<T0, T1>(arg1, 2, arg2, arg3);
    }

    public fun claim_target_coin<T0, T1>(arg0: &0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::GlobalConfig, arg1: &mut LimitOrder<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::checked_package_version(arg0);
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 13);
        assert!(arg1.canceled_ts == 18446744073709551615, 8);
        let v0 = 0x2::balance::value<T1>(&arg1.target_balance);
        assert!(v0 > 0, 20);
        arg1.claimed_amount = arg1.claimed_amount + v0;
        let v1 = ClaimTargetCoinEvent{
            order_id       : 0x2::object::id<LimitOrder<T0, T1>>(arg1),
            claimed_amount : v0,
        };
        0x2::event::emit<ClaimTargetCoinEvent>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.target_balance), arg2)
    }

    fun delete_limit_order<T0, T1>(arg0: &0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::GlobalConfig, arg1: LimitOrder<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.canceled_ts != 18446744073709551615, 8);
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.canceled_ts + 0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::get_config_deletion_grace_period(arg0), 12);
        destroy_limit_order<T0, T1>(arg1);
    }

    public fun delete_order<T0, T1>(arg0: &0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::GlobalConfig, arg1: LimitOrder<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::checked_package_version(arg0);
        0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::checked_keeper(arg0, 0x2::tx_context::sender(arg3));
        delete_limit_order<T0, T1>(arg0, arg1, arg2, arg3);
    }

    fun destroy_limit_order<T0, T1>(arg0: LimitOrder<T0, T1>) {
        let LimitOrder {
            id               : v0,
            owner            : _,
            pay_balance      : v2,
            target_balance   : v3,
            total_pay_amount : _,
            obtained_amount  : _,
            claimed_amount   : _,
            rate             : _,
            created_ts       : _,
            expire_ts        : _,
            canceled_ts      : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v2);
        0x2::balance::destroy_zero<T1>(v3);
        0x2::object::delete(v0);
    }

    public fun flash_loan<T0, T1>(arg0: &0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::GlobalConfig, arg1: &mut LimitOrder<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanReceipt<T1>) {
        0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::checked_package_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        if (0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::get_config_require_flash_loan_auth(arg0)) {
            0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::checked_keeper(arg0, v0);
        };
        assert!(arg1.canceled_ts == 18446744073709551615, 8);
        assert!(arg2 > 0, 5);
        assert!(0x2::clock::timestamp_ms(arg3) < arg1.expire_ts, 6);
        assert!(0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::check_token_and_min_trade_amount<T0>(arg0, arg2), 14);
        assert!(arg1.rate > 0, 15);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg1.pay_balance), 21);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((arg2 as u128), 1000000000000000000, arg1.rate);
        if (v1 > (18446744073709551615 as u128)) {
            abort 16
        };
        let v2 = (v1 as u64);
        let v3 = v2;
        let v4 = FlashLoanReceipt<T1>{
            order_id            : 0x2::object::id<LimitOrder<T0, T1>>(arg1),
            owner               : arg1.owner,
            target_repay_amount : v2,
        };
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((arg1.total_pay_amount as u128), 1000000000000000000, arg1.rate);
        if (v5 > (18446744073709551615 as u128)) {
            abort 16
        };
        let v6 = (v5 as u64);
        if (arg1.obtained_amount + v2 >= v6) {
            v3 = v6 - arg1.obtained_amount;
            arg1.obtained_amount = v6;
        } else {
            arg1.obtained_amount = arg1.obtained_amount + v2;
        };
        let v7 = FlashLoanEvent{
            order_id            : 0x2::object::id<LimitOrder<T0, T1>>(arg1),
            amount              : arg2,
            remaining_amount    : 0x2::balance::value<T0>(&arg1.pay_balance) - arg2,
            target_repay_amount : v3,
            owner               : arg1.owner,
            borrower            : v0,
        };
        0x2::event::emit<FlashLoanEvent>(v7);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pay_balance, arg2), arg4), v4)
    }

    fun init(arg0: ORDERBOOK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ORDERBOOK>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    fun new_limit_order<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: u128, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : LimitOrder<T0, T1> {
        LimitOrder<T0, T1>{
            id               : 0x2::object::new(arg4),
            owner            : 0x2::tx_context::sender(arg4),
            pay_balance      : arg0,
            target_balance   : 0x2::balance::zero<T1>(),
            total_pay_amount : 0x2::balance::value<T0>(&arg0),
            obtained_amount  : 0,
            claimed_amount   : 0,
            rate             : arg1,
            created_ts       : arg2,
            expire_ts        : arg3,
            canceled_ts      : 18446744073709551615,
        }
    }

    public fun place_limit_order<T0, T1>(arg0: &0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::GlobalConfig, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::checked_package_version(arg0);
        0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::checked_pool_token_types<T0, T1>(arg0);
        assert!(arg2 > 0, 15);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 19);
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg3 > v1, 18);
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((0x2::balance::value<T0>(&v0) as u128), 1000000000000000000, arg2) > (18446744073709551615 as u128)) {
            abort 16
        };
        let v2 = new_limit_order<T0, T1>(v0, arg2, v1, arg3, arg5);
        let v3 = OrderPlacedEvent{
            order_id         : 0x2::object::id<LimitOrder<T0, T1>>(&v2),
            owner            : 0x2::tx_context::sender(arg5),
            pay_coin         : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            target_coin      : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            total_pay_amount : v2.total_pay_amount,
            rate             : v2.rate,
            created_ts       : v1,
            expire_ts        : arg3,
        };
        0x2::event::emit<OrderPlacedEvent>(v3);
        0x2::transfer::public_share_object<LimitOrder<T0, T1>>(v2);
    }

    public fun repay_flash_loan<T0, T1>(arg0: &0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::GlobalConfig, arg1: &mut 0x2::coin::Coin<T1>, arg2: &mut LimitOrder<T0, T1>, arg3: FlashLoanReceipt<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::checked_package_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        if (0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::get_config_require_flash_loan_auth(arg0)) {
            0x643e6dccd4222416fddac47c1776e57bf078469cfadf0fd5c9f7d2052a15f096::config::checked_keeper(arg0, v0);
        };
        assert!(arg2.canceled_ts == 18446744073709551615, 8);
        assert!(arg3.order_id == 0x2::object::id<LimitOrder<T0, T1>>(arg2), 17);
        assert!(0x2::coin::value<T1>(arg1) >= arg3.target_repay_amount, 7);
        let FlashLoanReceipt {
            order_id            : v1,
            owner               : v2,
            target_repay_amount : v3,
        } = arg3;
        assert!(v2 == arg2.owner, 17);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(arg1, v3, arg4), arg2.owner);
        arg2.claimed_amount = arg2.claimed_amount + v3;
        let v4 = RepayFlashLoanEvent{
            order_id     : v1,
            repay_amount : v3,
            repayer      : v0,
        };
        0x2::event::emit<RepayFlashLoanEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

