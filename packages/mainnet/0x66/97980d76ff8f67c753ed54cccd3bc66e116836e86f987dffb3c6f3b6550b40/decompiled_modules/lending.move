module 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::lending {
    struct DepositEvent has copy, drop {
        reserve: u8,
        sender: address,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        reserve: u8,
        sender: address,
        to: address,
        amount: u64,
    }

    struct BorrowEvent has copy, drop {
        reserve: u8,
        sender: address,
        amount: u64,
    }

    struct RepayEvent has copy, drop {
        reserve: u8,
        sender: address,
        amount: u64,
    }

    struct LiquidationCallEvent has copy, drop {
        reserve: u8,
        sender: address,
        liquidate_user: address,
        liquidate_amount: u64,
    }

    public entry fun borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg6);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::logic::execute_borrow<T0>(arg0, arg1, arg2, arg4, v0, (0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::normal_amount<T0>(arg3, arg5) as u256));
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::withdraw<T0>(arg3, arg5, v0, arg6);
        let v1 = BorrowEvent{
            reserve : arg4,
            sender  : 0x2::tx_context::sender(arg6),
            amount  : arg5,
        };
        0x2::event::emit<BorrowEvent>(v1);
    }

    fun base_borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: address) : 0x2::balance::Balance<T0> {
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::when_not_paused(arg2);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::version_verification(arg2);
        let v0 = 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::normal_amount<T0>(arg3, arg5);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::logic::execute_borrow<T0>(arg0, arg1, arg2, arg4, arg6, (v0 as u256));
        let v1 = BorrowEvent{
            reserve : arg4,
            sender  : arg6,
            amount  : arg5,
        };
        0x2::event::emit<BorrowEvent>(v1);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::withdraw_balance<T0>(arg3, v0, arg6)
    }

    fun base_deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg3: u8, arg4: address, arg5: 0x2::balance::Balance<T0>) {
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::when_not_paused(arg1);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::version_verification(arg1);
        let v0 = 0x2::balance::value<T0>(&arg5);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::deposit_balance<T0>(arg2, arg5, arg4);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::logic::execute_deposit<T0>(arg0, arg1, arg3, arg4, (0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::normal_amount<T0>(arg2, v0) as u256));
        let v1 = DepositEvent{
            reserve : arg3,
            sender  : arg4,
            amount  : v0,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    fun base_liquidation_call<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: u8, arg4: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u8, arg7: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T1>, arg8: address, arg9: address) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::when_not_paused(arg2);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::version_verification(arg2);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::deposit_balance<T0>(arg4, arg5, arg8);
        let (v0, v1, v2) = 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::logic::execute_liquidate<T0, T1>(arg0, arg1, arg2, arg9, arg6, arg3, (0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::normal_amount<T0>(arg4, 0x2::balance::value<T0>(&arg5)) as u256));
        let v3 = 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::unnormal_amount<T1>(arg7, (v2 as u64));
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::deposit_treasury<T1>(arg7, v3);
        let v4 = 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::unnormal_amount<T1>(arg7, (v0 as u64));
        let v5 = LiquidationCallEvent{
            reserve          : arg6,
            sender           : arg8,
            liquidate_user   : arg9,
            liquidate_amount : v4 + v3,
        };
        0x2::event::emit<LiquidationCallEvent>(v5);
        (0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::withdraw_balance<T0>(arg4, 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::unnormal_amount<T0>(arg4, (v1 as u64)), arg8), 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::withdraw_balance<T1>(arg7, v4, arg8))
    }

    fun base_repay<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg4: u8, arg5: 0x2::balance::Balance<T0>, arg6: address) : 0x2::balance::Balance<T0> {
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::when_not_paused(arg2);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::version_verification(arg2);
        let v0 = 0x2::balance::value<T0>(&arg5);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::deposit_balance<T0>(arg3, arg5, arg6);
        let v1 = 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::unnormal_amount<T0>(arg3, (0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::logic::execute_repay<T0>(arg0, arg1, arg2, arg4, arg6, (0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::normal_amount<T0>(arg3, v0) as u256)) as u64));
        let v2 = RepayEvent{
            reserve : arg4,
            sender  : arg6,
            amount  : v0 - v1,
        };
        0x2::event::emit<RepayEvent>(v2);
        if (v1 > 0) {
            return 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::withdraw_balance<T0>(arg3, v1, arg6)
        };
        0x2::balance::zero<T0>()
    }

    fun base_withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: address) : 0x2::balance::Balance<T0> {
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::when_not_paused(arg2);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::version_verification(arg2);
        let v0 = 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::logic::execute_withdraw<T0>(arg0, arg1, arg2, arg4, arg6, (0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::normal_amount<T0>(arg3, arg5) as u256));
        let v1 = WithdrawEvent{
            reserve : arg4,
            sender  : arg6,
            to      : arg6,
            amount  : 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::unnormal_amount<T0>(arg3, v0),
        };
        0x2::event::emit<WithdrawEvent>(v1);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::withdraw_balance<T0>(arg3, v0, arg6)
    }

    public fun borrow_coin<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        base_borrow<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::tx_context::sender(arg6))
    }

    public entry fun deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::incentive::Incentive, arg7: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg1);
        let v0 = 0x2::tx_context::sender(arg7);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::incentive::update_reward(arg6, arg0, arg1, arg3, v0);
        let v1 = 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::utils::split_coin<T0>(arg4, arg5, arg7);
        let v2 = 0x2::coin::value<T0>(&v1);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::deposit<T0>(arg2, v1, arg7);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::logic::execute_deposit<T0>(arg0, arg1, arg3, v0, (0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::normal_amount<T0>(arg2, v2) as u256));
        let v3 = DepositEvent{
            reserve : arg3,
            sender  : v0,
            amount  : v2,
        };
        0x2::event::emit<DepositEvent>(v3);
    }

    public entry fun entry_borrow_coin<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(base_borrow<T0>(arg0, arg1, arg2, arg3, arg4, arg5, v0), arg6), v0);
    }

    public entry fun entry_deposit_coin<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        base_deposit<T0>(arg0, arg1, arg2, arg3, 0x2::tx_context::sender(arg6), 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::utils::split_coin_to_balance<T0>(arg4, arg5, arg6));
    }

    public entry fun entry_repay_coin<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = base_repay<T0>(arg0, arg1, arg2, arg3, arg4, 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::utils::split_coin_to_balance<T0>(arg5, arg6, arg7), v0);
        if (0x2::balance::value<T0>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg7), v0);
        } else {
            0x2::balance::destroy_zero<T0>(v1);
        };
    }

    public entry fun entry_withdraw_coin<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(base_withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, v0), arg6), v0);
    }

    public entry fun liquidation<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: u8, arg4: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg5: 0x2::coin::Coin<T0>, arg6: u8, arg7: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T1>, arg8: address, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let (v1, v2) = base_liquidation_call<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::utils::split_coin_to_balance<T0>(arg5, arg9, arg10), arg6, arg7, v0, arg8);
        let v3 = v2;
        let v4 = v1;
        if (0x2::balance::value<T0>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg10), v0);
        } else {
            0x2::balance::destroy_zero<T0>(v4);
        };
        if (0x2::balance::value<T1>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg10), v0);
        } else {
            0x2::balance::destroy_zero<T1>(v3);
        };
    }

    public entry fun liquidation_call<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: u8, arg4: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg5: u8, arg6: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T1>, arg7: 0x2::coin::Coin<T0>, arg8: address, arg9: u64, arg10: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::incentive::Incentive, arg11: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg11);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::incentive::update_reward(arg10, arg0, arg2, arg5, arg8);
        let v1 = 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::utils::split_coin<T0>(arg7, arg9, arg11);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::deposit<T0>(arg4, v1, arg11);
        let (v2, v3, v4) = 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::logic::execute_liquidate<T0, T1>(arg0, arg1, arg2, arg8, arg5, arg3, (0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::normal_amount<T0>(arg4, 0x2::coin::value<T0>(&v1)) as u256));
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::withdraw<T0>(arg4, 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::unnormal_amount<T0>(arg4, (v3 as u64)), v0, arg11);
        let v5 = 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::unnormal_amount<T1>(arg6, (v2 as u64));
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::withdraw<T1>(arg6, v5, v0, arg11);
        let v6 = 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::unnormal_amount<T1>(arg6, (v4 as u64));
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::deposit_treasury<T1>(arg6, v6);
        let v7 = LiquidationCallEvent{
            reserve          : arg5,
            sender           : v0,
            liquidate_user   : arg8,
            liquidate_amount : v5 + v6,
        };
        0x2::event::emit<LiquidationCallEvent>(v7);
    }

    public entry fun repay<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::utils::split_coin<T0>(arg5, arg6, arg7);
        let v2 = 0x2::coin::value<T0>(&v1);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::deposit<T0>(arg3, v1, arg7);
        let v3 = 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::unnormal_amount<T0>(arg3, (0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::logic::execute_repay<T0>(arg0, arg1, arg2, arg4, v0, (0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::normal_amount<T0>(arg3, v2) as u256)) as u64));
        if (v3 > 0) {
            0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::withdraw<T0>(arg3, v3, v0, arg7);
        };
        let v4 = RepayEvent{
            reserve : arg4,
            sender  : 0x2::tx_context::sender(arg7),
            amount  : v2 - v3,
        };
        0x2::event::emit<RepayEvent>(v4);
    }

    public fun repay_coin<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        base_repay<T0>(arg0, arg1, arg2, arg3, arg4, 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::utils::split_coin_to_balance<T0>(arg5, arg6, arg7), 0x2::tx_context::sender(arg7))
    }

    fun when_not_paused(arg0: &0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage) {
        assert!(!0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::pause(arg0), 41001);
    }

    public entry fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: address, arg7: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::incentive::Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg2);
        let v0 = 0x2::tx_context::sender(arg8);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::incentive::update_reward(arg7, arg0, arg2, arg4, v0);
        let v1 = 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::unnormal_amount<T0>(arg3, 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::logic::execute_withdraw<T0>(arg0, arg1, arg2, arg4, v0, (0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::normal_amount<T0>(arg3, arg5) as u256)));
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::withdraw<T0>(arg3, v1, arg6, arg8);
        let v2 = WithdrawEvent{
            reserve : arg4,
            sender  : 0x2::tx_context::sender(arg8),
            to      : arg6,
            amount  : v1,
        };
        0x2::event::emit<WithdrawEvent>(v2);
    }

    public fun withdraw_coin<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        base_withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2::tx_context::sender(arg6))
    }

    // decompiled from Move bytecode v6
}

