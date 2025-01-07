module 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::seed_pool {
    struct SeedPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance_m: 0x2::balance::Balance<T1>,
        balance_s: 0x2::balance::Balance<T0>,
        admin_balance_m: 0x2::balance::Balance<T1>,
        admin_balance_s: 0x2::balance::Balance<T0>,
        launch_balance: 0x2::balance::Balance<T1>,
        accounting: 0x2::table::Table<address, 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::vesting::VestingData>,
        meme_cap: 0x2::coin::TreasuryCap<T1>,
        policy_cap: 0x2::token::TokenPolicyCap<T1>,
        fees: 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::fees::Fees,
        params: Params,
        locked: bool,
    }

    struct Params has drop, store {
        alpha_abs: u256,
        beta: u256,
        price_factor: u64,
        gamma_s: u64,
        gamma_m: u64,
        omega_m: u64,
        sell_delay_ms: u64,
        alpha_decimals: u256,
        beta_decimals: u256,
    }

    struct SwapAmount has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        admin_fee_in: u64,
        admin_fee_out: u64,
    }

    public entry fun new<T0, T1>(arg0: &mut 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::index::Registry, arg1: 0x2::coin::TreasuryCap<T1>, arg2: u256, arg3: u256, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<SeedPool<T0, T1>>(new_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public entry fun transfer<T0, T1>(arg0: &mut SeedPool<T0, T1>, arg1: &0x2::token::TokenPolicy<T1>, arg2: 0x2::token::Token<T1>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::token::value<T1>(&arg2);
        subtract_from_token_acc<T0, T1>(arg0, v0, 0x2::tx_context::sender(arg4));
        add_from_token_acc<T0, T1>(arg0, v0, arg3);
        0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::token_ir::transfer<T1>(arg1, arg2, arg3, arg4);
    }

    public fun fees<T0, T1>(arg0: &SeedPool<T0, T1>) : 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::fees::Fees {
        arg0.fees
    }

    public fun accounting<T0, T1>(arg0: &SeedPool<T0, T1>) : &0x2::table::Table<address, 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::vesting::VestingData> {
        &arg0.accounting
    }

    public fun accounting_len<T0, T1>(arg0: &SeedPool<T0, T1>) : u64 {
        0x2::table::length<address, 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::vesting::VestingData>(&arg0.accounting)
    }

    fun add_from_token_acc<T0, T1>(arg0: &mut SeedPool<T0, T1>, arg1: u64, arg2: address) {
        if (!0x2::table::contains<address, 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::vesting::VestingData>(&arg0.accounting, arg2)) {
            0x2::table::add<address, 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::vesting::VestingData>(&mut arg0.accounting, arg2, 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::vesting::new_vesting_data(arg1));
        };
        let v0 = 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::vesting::notional_mut(0x2::table::borrow_mut<address, 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::vesting::VestingData>(&mut arg0.accounting, arg2));
        *v0 = *v0 + arg1;
    }

    public fun admin_balance_m<T0, T1>(arg0: &SeedPool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.admin_balance_m)
    }

    public fun admin_balance_s<T0, T1>(arg0: &SeedPool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.admin_balance_s)
    }

    public fun alpha_abs(arg0: &Params) : u256 {
        arg0.alpha_abs
    }

    public fun balance_m<T0, T1>(arg0: &SeedPool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.balance_m)
    }

    public fun balance_s<T0, T1>(arg0: &SeedPool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance_s)
    }

    fun balances<T0, T1>(arg0: &SeedPool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T1>(&arg0.balance_m), 0x2::balance::value<T0>(&arg0.balance_s))
    }

    public fun beta(arg0: &Params) : u256 {
        arg0.beta
    }

    public fun buy_meme<T0, T1>(arg0: &mut SeedPool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::staked_lp::StakedLP<T1> {
        assert!(0x2::coin::value<T0>(arg1) != 0, 0);
        assert!(!arg0.locked, 3);
        let v0 = 0x2::coin::value<T0>(arg1);
        let v1 = swap_amounts<T0, T1>(arg0, v0, arg2, true);
        if (v1.admin_fee_in != 0) {
            0x2::balance::join<T0>(&mut arg0.admin_balance_s, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v1.admin_fee_in, arg4)));
        };
        if (v1.admin_fee_out != 0) {
            0x2::balance::join<T1>(&mut arg0.admin_balance_m, 0x2::balance::split<T1>(&mut arg0.balance_m, v1.admin_fee_out));
        };
        0x2::balance::join<T0>(&mut arg0.balance_s, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v1.amount_in, arg4)));
        0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::events::swap<T0, T1, SwapAmount>(0x2::object::uid_to_address(&arg0.id), v0, v1);
        let v2 = 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::staked_lp::new<T1>(0x2::balance::split<T1>(&mut arg0.balance_m, v1.amount_out), arg0.params.sell_delay_ms, arg3, arg4);
        if (0x2::balance::value<T1>(&arg0.balance_m) == 0) {
            arg0.locked = true;
        };
        add_from_token_acc<T0, T1>(arg0, v1.amount_out, 0x2::tx_context::sender(arg4));
        v2
    }

    fun buy_meme_swap_amounts<T0, T1>(arg0: &SeedPool<T0, T1>, arg1: u64, arg2: u64) : SwapAmount {
        let (v0, v1) = balances<T0, T1>(arg0);
        let v2 = gamma_s_mist<T0, T1>(arg0) - v1;
        let v3 = 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::fees::get_gross_amount(&arg0.fees, v2);
        let v4 = 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::fees::get_fee_in_amount(&arg0.fees, arg1);
        let v5 = v4;
        let v6 = arg1 - v4 >= v3;
        let v7 = if (v6) {
            v5 = 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::fees::get_fee_in_amount(&arg0.fees, v3);
            v2
        } else {
            arg1 - v4
        };
        let v8 = if (v6) {
            v0
        } else {
            compute_delta_m<T0, T1>(arg0, v1, v1 + v7)
        };
        let v9 = 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::fees::get_fee_out_amount(&arg0.fees, v8);
        let v10 = v8 - v9;
        assert!(v10 >= arg2, 8);
        SwapAmount{
            amount_in     : v7,
            amount_out    : v10,
            admin_fee_in  : v5,
            admin_fee_out : v9,
        }
    }

    public fun compute_alpha_abs(arg0: u256, arg1: u256, arg2: u256, arg3: u64) : (u256, u256) {
        let v0 = arg2 * (arg3 as u256);
        assert!(v0 < arg1, 1);
        let v1 = 2 * (arg1 - v0);
        let v2 = 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::math256::pow_2((arg0 as u256));
        assert!(v1 > v2, 9);
        let v3 = compute_decimals(compute_scale(v1) - compute_scale(v2));
        (v1 * v3 / v2, v3)
    }

    public fun compute_beta(arg0: u256, arg1: u256, arg2: u256, arg3: u64, arg4: u256) : (u256, u256) {
        let v0 = 2 * arg1;
        let v1 = arg2 * (arg3 as u256);
        assert!(v0 > v1, 2);
        ((v0 - v1) * arg4 / arg0, arg4)
    }

    public fun compute_decimals(arg0: u64) : u256 {
        assert!(arg0 >= 5, 10);
        if (arg0 == 5) {
            return 100000000
        };
        if (arg0 == 6) {
            return 10000000
        };
        if (arg0 == 7) {
            return 1000000
        };
        if (arg0 == 8) {
            return 100000
        };
        if (arg0 == 9) {
            return 10000
        };
        if (arg0 == 10) {
            return 1000
        };
        if (arg0 == 11) {
            return 100
        };
        if (arg0 == 12) {
            return 10
        };
        1
    }

    public fun compute_delta_m<T0, T1>(arg0: &SeedPool<T0, T1>, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg1 as u256);
        let v1 = (arg2 as u256);
        let v2 = arg0.params.alpha_decimals;
        let v3 = arg0.params.beta_decimals;
        (((arg0.params.beta * 1000000000 * 2 * v2 * (v1 - v0) - arg0.params.alpha_abs * v3 * (0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::math256::pow_2(v1) - 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::math256::pow_2(v0))) / 2 * v2 * v3 * 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::math256::pow_2(1000000000)) as u64)
    }

    public fun compute_delta_s<T0, T1>(arg0: &SeedPool<T0, T1>, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg1 as u256);
        let v1 = arg0.params.alpha_abs;
        let v2 = arg0.params.beta;
        let v3 = arg0.params.alpha_decimals;
        let v4 = arg0.params.beta_decimals;
        let v5 = v4 * v4 * 1000000000;
        let v6 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::sqrt_down(v3 * 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::math256::pow_2(v5));
        let v7 = v3 * v4 * 1000000000;
        (((0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::sqrt_down(0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::math256::pow_2(2 * v2 * v3 * 1000000000 - 2 * v1 * v0 * v4) * v3 + 8 * (arg2 as u256) * v1 * 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::math256::pow_2(v5)) * v7 - (2 * v2 * v3 * 1000000000 - 2 * v1 * v0 * v4) * v6) * 1000000000 * v3 / 2 * v1 * v6 * v7) as u64)
    }

    public fun compute_delta_s_(arg0: u256, arg1: u256, arg2: u64, arg3: u64, arg4: u256, arg5: u256) : u64 {
        let v0 = (arg2 as u256);
        let v1 = arg4 * arg5 * 1000000000;
        let v2 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::sqrt_down(arg4 * 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::math256::pow_2(v1));
        let v3 = arg4 * arg5 * 1000000000;
        (((0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::sqrt_down(0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::math256::pow_2(2 * arg1 * arg4 * 1000000000 - 2 * arg0 * v0 * arg5) * arg4 + 8 * (arg3 as u256) * arg0 * 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::math256::pow_2(v1)) * v3 - (2 * arg1 * arg4 * 1000000000 - 2 * arg0 * v0 * arg5) * v2) * 1000000000 * arg4 / 2 * arg0 * v2 * v3) as u64)
    }

    fun compute_scale(arg0: u256) : u64 {
        if (arg0 == 0) {
            return 1
        };
        let v0 = 1;
        while (arg0 >= 10) {
            arg0 = arg0 / 10;
            v0 = v0 + 1;
        };
        v0
    }

    public fun decimals_alpha() : u64 {
        (1000000 as u64)
    }

    public fun decimals_alpha_<T0, T1>(arg0: &SeedPool<T0, T1>) : u256 {
        arg0.params.alpha_decimals
    }

    public fun decimals_beta() : u64 {
        (1000000 as u64)
    }

    public fun decimals_beta_<T0, T1>(arg0: &SeedPool<T0, T1>) : u256 {
        arg0.params.beta_decimals
    }

    public fun decimals_s() : u64 {
        (1000000000 as u64)
    }

    public fun default_admin_fee() : u256 {
        5000000000000000
    }

    public fun default_gamma_m() : u256 {
        900000000000000
    }

    public fun default_gamma_s() : u256 {
        30000
    }

    public fun default_omega_m() : u256 {
        200000000000000
    }

    public fun default_price_factor() : u64 {
        2
    }

    public(friend) fun destroy_pool<T0, T1>(arg0: SeedPool<T0, T1>) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::table::Table<address, 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::vesting::VestingData>, 0x2::coin::TreasuryCap<T1>, 0x2::token::TokenPolicyCap<T1>, 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::fees::Fees, Params, bool) {
        let SeedPool {
            id              : v0,
            balance_m       : v1,
            balance_s       : v2,
            admin_balance_m : v3,
            admin_balance_s : v4,
            launch_balance  : v5,
            accounting      : v6,
            meme_cap        : v7,
            policy_cap      : v8,
            fees            : v9,
            params          : v10,
            locked          : v11,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11)
    }

    public fun gamma_m(arg0: &Params) : u64 {
        arg0.gamma_m
    }

    public fun gamma_s(arg0: &Params) : u64 {
        arg0.gamma_s
    }

    public fun gamma_s_mist<T0, T1>(arg0: &SeedPool<T0, T1>) : u64 {
        0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::utils::mist(arg0.params.gamma_s)
    }

    public fun is_ready_to_launch<T0, T1>(arg0: &SeedPool<T0, T1>) : bool {
        arg0.locked
    }

    public fun meme_coin_supply<T0, T1>(arg0: &SeedPool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.launch_balance)
    }

    fun new_<T0, T1>(arg0: &mut 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::index::Registry, arg1: 0x2::coin::TreasuryCap<T1>, arg2: u256, arg3: u256, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : SeedPool<T0, T1> {
        assert!(0x2::balance::supply_value<T1>(0x2::coin::supply<T1>(&mut arg1)) == 0, 7);
        let v0 = 0x2::coin::mint<T1>(&mut arg1, ((arg6 + arg7) as u64), arg9);
        let v1 = 0x2::balance::increase_supply<T1>(0x2::coin::supply_mut<T1>(&mut arg1), (arg6 as u64));
        let (v2, v3) = 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::token_ir::init_token<T1>(&arg1, arg9);
        let v4 = v2;
        let v5 = 0x2::coin::zero<T0>(arg9);
        let v6 = new_pool_internal<T0, T1>(arg0, v1, v5, v0, arg1, v3, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v7 = 0x2::object::uid_to_address(&v6.id);
        let v8 = 0x2::object::id<0x2::token::TokenPolicy<T1>>(&v4);
        let v9 = 0x2::object::id_to_address(&v8);
        0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::index::add_seed_pool<T0, T1>(arg0, v7, v9);
        0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::events::new_pool<T0, T1>(v7, 0x2::balance::value<T1>(&v1), 0, v9);
        0x2::token::share_policy<T1>(v4);
        v6
    }

    public entry fun new_default<T0, T1>(arg0: &mut 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::index::Registry, arg1: 0x2::coin::TreasuryCap<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<SeedPool<T0, T1>>(new_<T0, T1>(arg0, arg1, 5000000000000000, 5000000000000000, 2, (default_gamma_s() as u64), (default_gamma_m() as u64), (default_omega_m() as u64), 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::staked_lp::default_sell_delay_ms(), arg2));
    }

    fun new_fees(arg0: u256, arg1: u256) : 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::fees::Fees {
        0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::fees::new(arg0, arg1)
    }

    fun new_pool_internal<T0, T1>(arg0: &0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::index::Registry, arg1: 0x2::balance::Balance<T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::TreasuryCap<T1>, arg5: 0x2::token::TokenPolicyCap<T1>, arg6: u256, arg7: u256, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) : SeedPool<T0, T1> {
        assert!(0x2::balance::value<T1>(&arg1) == (arg10 as u64), 4);
        assert!(0x2::coin::value<T0>(&arg2) == 0, 5);
        assert!(0x2::coin::value<T1>(&arg3) == ((arg10 + arg11) as u64), 6);
        0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::index::assert_new_pool<T0, T1>(arg0);
        let (v0, v1) = compute_alpha_abs((arg9 as u256), (arg10 as u256), (arg11 as u256), arg8);
        let (v2, v3) = compute_beta((arg9 as u256), (arg10 as u256), (arg11 as u256), arg8, v1);
        let v4 = Params{
            alpha_abs      : v0,
            beta           : v2,
            price_factor   : arg8,
            gamma_s        : arg9,
            gamma_m        : arg10,
            omega_m        : arg11,
            sell_delay_ms  : arg12,
            alpha_decimals : v1,
            beta_decimals  : v3,
        };
        SeedPool<T0, T1>{
            id              : 0x2::object::new(arg13),
            balance_m       : arg1,
            balance_s       : 0x2::coin::into_balance<T0>(arg2),
            admin_balance_m : 0x2::balance::zero<T1>(),
            admin_balance_s : 0x2::balance::zero<T0>(),
            launch_balance  : 0x2::coin::into_balance<T1>(arg3),
            accounting      : 0x2::table::new<address, 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::vesting::VestingData>(arg13),
            meme_cap        : arg4,
            policy_cap      : arg5,
            fees            : new_fees(arg6, arg7),
            params          : v4,
            locked          : false,
        }
    }

    public fun omega_m(arg0: &Params) : u64 {
        arg0.omega_m
    }

    public fun price_factor(arg0: &Params) : u64 {
        arg0.price_factor
    }

    public fun quote_buy_meme<T0, T1>(arg0: &mut SeedPool<T0, T1>, arg1: u64) : u64 {
        assert!(arg1 != 0, 0);
        assert!(!arg0.locked, 3);
        let v0 = swap_amounts<T0, T1>(arg0, arg1, 0, true);
        v0.amount_out
    }

    public fun quote_sell_meme<T0, T1>(arg0: &mut SeedPool<T0, T1>, arg1: u64) : u64 {
        assert!(arg1 != 0, 0);
        assert!(!arg0.locked, 3);
        let v0 = swap_amounts<T0, T1>(arg0, arg1, 0, false);
        v0.amount_out
    }

    public fun sell_delay_ms(arg0: &Params) : u64 {
        arg0.sell_delay_ms
    }

    public fun sell_meme<T0, T1>(arg0: &mut SeedPool<T0, T1>, arg1: 0x2::token::Token<T1>, arg2: u64, arg3: &0x2::token::TokenPolicy<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::token::value<T1>(&arg1) != 0, 0);
        assert!(!arg0.locked, 3);
        let v0 = 0x2::token::value<T1>(&arg1);
        let v1 = swap_amounts<T0, T1>(arg0, v0, arg2, false);
        if (v1.admin_fee_in != 0) {
            0x2::balance::join<T1>(&mut arg0.admin_balance_m, 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::token_ir::into_balance<T1>(arg3, 0x2::token::split<T1>(&mut arg1, v1.admin_fee_in, arg4), arg4));
        };
        if (v1.admin_fee_out != 0) {
            0x2::balance::join<T0>(&mut arg0.admin_balance_s, 0x2::balance::split<T0>(&mut arg0.balance_s, v1.admin_fee_out));
        };
        0x2::balance::join<T1>(&mut arg0.balance_m, 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::token_ir::into_balance<T1>(arg3, arg1, arg4));
        0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::events::swap<T0, T1, SwapAmount>(0x2::object::uid_to_address(&arg0.id), v0, v1);
        let v2 = 0x2::coin::take<T0>(&mut arg0.balance_s, v1.amount_out, arg4);
        subtract_from_token_acc<T0, T1>(arg0, v0, 0x2::tx_context::sender(arg4));
        v2
    }

    fun sell_meme_swap_amounts<T0, T1>(arg0: &SeedPool<T0, T1>, arg1: u64, arg2: u64) : SwapAmount {
        let (v0, v1) = balances<T0, T1>(arg0);
        let v2 = (arg0.params.gamma_m as u64) - v0;
        let v3 = 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::fees::get_fee_in_amount(&arg0.fees, arg1);
        let v4 = 0x2::math::min(arg1 - v3, v2);
        let v5 = if (arg1 - v3 > v2) {
            v1
        } else {
            compute_delta_s<T0, T1>(arg0, v1, v4)
        };
        let v6 = 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::fees::get_fee_out_amount(&arg0.fees, v5);
        let v7 = v5 - v6;
        assert!(v7 >= arg2, 8);
        SwapAmount{
            amount_in     : v4,
            amount_out    : v7,
            admin_fee_in  : v3,
            admin_fee_out : v6,
        }
    }

    fun subtract_from_token_acc<T0, T1>(arg0: &mut SeedPool<T0, T1>, arg1: u64, arg2: address) {
        let v0 = 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::vesting::notional_mut(0x2::table::borrow_mut<address, 0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::vesting::VestingData>(&mut arg0.accounting, arg2));
        *v0 = *v0 - arg1;
    }

    fun swap_amounts<T0, T1>(arg0: &SeedPool<T0, T1>, arg1: u64, arg2: u64, arg3: bool) : SwapAmount {
        if (arg3) {
            buy_meme_swap_amounts<T0, T1>(arg0, arg1, arg2)
        } else {
            sell_meme_swap_amounts<T0, T1>(arg0, arg1, arg2)
        }
    }

    public fun take_fees<T0, T1>(arg0: &0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::admin::Admin, arg1: &mut SeedPool<T0, T1>, arg2: &0x2::token::TokenPolicy<T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::token::Token<T1>, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::balance::value<T1>(&arg1.admin_balance_m);
        let v1 = 0x2::balance::value<T0>(&arg1.admin_balance_s);
        add_from_token_acc<T0, T1>(arg1, v0, 0x2::tx_context::sender(arg3));
        (0xe857abf98342c16cbb963d2f78628a7451b6efaa609866a0ba042ca3fa8e351a::token_ir::take<T1>(arg2, &mut arg1.admin_balance_m, v0, arg3), 0x2::coin::take<T0>(&mut arg1.admin_balance_s, v1, arg3))
    }

    public fun ticket_coin_supply<T0, T1>(arg0: &SeedPool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.balance_m)
    }

    // decompiled from Move bytecode v6
}

