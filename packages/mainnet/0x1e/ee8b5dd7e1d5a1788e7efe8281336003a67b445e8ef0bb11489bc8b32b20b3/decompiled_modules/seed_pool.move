module 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::seed_pool {
    struct SeedPool has key {
        id: 0x2::object::UID,
        fields: 0x2::object::UID,
    }

    struct PoolStateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PoolState<phantom T0, phantom T1, phantom T2> has store {
        balance_m: 0x2::balance::Balance<T0>,
        balance_s: 0x2::balance::Balance<T1>,
        admin_balance_m: 0x2::balance::Balance<T0>,
        admin_balance_s: 0x2::balance::Balance<T1>,
        launch_balance: 0x2::balance::Balance<T2>,
        fees: 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::fees::Fees,
        config: Config,
        locked: bool,
    }

    struct Config has drop, store {
        alpha_abs: u256,
        beta: u256,
        price_factor: u64,
        gamma_s: u64,
        gamma_m: u64,
        omega_m: u64,
    }

    struct SwapAmount has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        admin_fee_in: u64,
        admin_fee_out: u64,
    }

    public fun new<T0, T1, T2>(arg0: &mut 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::index::Registry, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::TreasuryCap<T2>, arg3: &mut 0x2::coin::CoinMetadata<T0>, arg4: &0x2::coin::CoinMetadata<T2>, arg5: u256, arg6: u256, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::utils::assert_ticket_coin_integrity<T0, T1, T2>(arg3);
        0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::utils::assert_coin_integrity<T0, T1, T2>(&arg1, arg3, &arg2, arg4);
        0x2::coin::update_name<T0>(&arg1, arg3, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::utils::get_ticket_coin_name<T2>(arg4));
        0x2::coin::update_symbol<T0>(&arg1, arg3, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::utils::get_ticket_coin_symbol<T2>(arg4));
        let v0 = 0x2::coin::mint<T2>(&mut arg2, ((arg9 + arg10) as u64), arg11);
        let v1 = 0x2::balance::increase_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg1), (arg9 as u64));
        let v2 = 0x2::coin::zero<T1>(arg11);
        let v3 = new_pool_internal<T0, T1, T2>(arg0, v1, v2, v0, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let (v4, v5) = 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::token_ir::init_token<T0>(&mut v3.id, &arg1, arg11);
        0x2::table::add<0x1::type_name::TypeName, address>(0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::index::policies_mut(arg0), 0x1::type_name::get<T0>(), v5);
        0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::events::new_pool<T0, T1, T2>(0x2::object::uid_to_address(&v3.id), 0x2::balance::value<T0>(&v1), 0, v5);
        0x2::token::share_policy<T0>(v4);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T2>>(arg2, @0x2);
        0x2::transfer::share_object<SeedPool>(v3);
    }

    public fun transfer<T0, T1, T2>(arg0: &mut SeedPool, arg1: &0x2::token::TokenPolicy<T0>, arg2: 0x2::token::Token<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        pool_state_mut<T0, T1, T2>(arg0);
        let v0 = 0x2::token::value<T0>(&arg2);
        subtract_from_token_acc(arg0, v0, 0x2::tx_context::sender(arg4));
        add_from_token_acc(arg0, v0, arg3);
        0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::token_ir::transfer<T0>(arg1, arg2, arg3, arg4);
    }

    public fun fees<T0, T1, T2>(arg0: &SeedPool) : 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::fees::Fees {
        pool_state<T0, T1, T2>(arg0).fees
    }

    fun add_from_token_acc(arg0: &mut SeedPool, arg1: u64, arg2: address) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::AccountingDfKey, 0x2::table::Table<address, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::VestingData>>(fields_mut(arg0), 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::accounting_key());
        if (!0x2::table::contains<address, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::VestingData>(v0, arg2)) {
            0x2::table::add<address, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::VestingData>(v0, arg2, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::new_vesting_data(arg1));
        };
        let v1 = 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::notional_mut(0x2::table::borrow_mut<address, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::VestingData>(v0, arg2));
        *v1 = *v1 + arg1;
    }

    public fun admin_balance_m<T0, T1, T2>(arg0: &SeedPool) : u64 {
        0x2::balance::value<T0>(&pool_state<T0, T1, T2>(arg0).admin_balance_m)
    }

    public fun admin_balance_s<T0, T1, T2>(arg0: &SeedPool) : u64 {
        0x2::balance::value<T1>(&pool_state<T0, T1, T2>(arg0).admin_balance_s)
    }

    public fun balance_m<T0, T1, T2>(arg0: &SeedPool) : u64 {
        0x2::balance::value<T0>(&pool_state<T0, T1, T2>(arg0).balance_m)
    }

    public fun balance_s<T0, T1, T2>(arg0: &SeedPool) : u64 {
        0x2::balance::value<T1>(&pool_state<T0, T1, T2>(arg0).balance_s)
    }

    fun balances<T0, T1, T2>(arg0: &PoolState<T0, T1, T2>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance_m), 0x2::balance::value<T1>(&arg0.balance_s))
    }

    public fun buy_meme<T0, T1, T2>(arg0: &mut SeedPool, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::staked_lp::StakedLP<T0> {
        assert!(0x2::coin::value<T1>(arg1) != 0, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::errors::no_zero_coin());
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        let v1 = pool_state_mut<T0, T1, T2>(arg0);
        assert!(!v1.locked, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::errors::pool_is_locked());
        let v2 = 0x2::coin::value<T1>(arg1);
        let v3 = swap_amounts<T0, T1, T2>(v1, v2, arg2, true);
        if (v3.admin_fee_in != 0) {
            0x2::balance::join<T1>(&mut v1.admin_balance_s, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg1, v3.admin_fee_in, arg4)));
        };
        if (v3.admin_fee_out != 0) {
            0x2::balance::join<T0>(&mut v1.admin_balance_m, 0x2::balance::split<T0>(&mut v1.balance_m, v3.admin_fee_out));
        };
        0x2::balance::join<T1>(&mut v1.balance_s, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg1, v3.amount_in, arg4)));
        0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::events::swap<T1, T0, SwapAmount>(v0, v2, v3);
        let v4 = v3.amount_out;
        if (0x2::balance::value<T0>(&v1.balance_m) == 0) {
            v1.locked = true;
        };
        add_from_token_acc(arg0, v4, 0x2::tx_context::sender(arg4));
        0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::staked_lp::new<T0>(0x2::balance::split<T0>(&mut v1.balance_m, v4), arg3, arg4)
    }

    fun buy_meme_swap_amounts<T0, T1, T2>(arg0: &PoolState<T0, T1, T2>, arg1: u64, arg2: u64) : SwapAmount {
        let (v0, v1) = balances<T0, T1, T2>(arg0);
        let v2 = gamma_s_mist<T0, T1, T2>(arg0) - v1;
        let v3 = 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::fees::get_fee_in_amount(&arg0.fees, arg1);
        let v4 = 0x2::math::min(arg1 - v3, v2);
        let v5 = if (arg1 - v3 >= v2) {
            v0
        } else {
            compute_delta_m<T0, T1, T2>(arg0, v1, v1 + v4)
        };
        let v6 = 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::fees::get_fee_out_amount(&arg0.fees, v5);
        let v7 = v5 - v6;
        assert!(v7 >= arg2, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::errors::slippage());
        SwapAmount{
            amount_in     : v4,
            amount_out    : v7,
            admin_fee_in  : v3,
            admin_fee_out : v6,
        }
    }

    public fun compute_alpha_abs(arg0: u256, arg1: u256, arg2: u256, arg3: u64) : u256 {
        let v0 = arg2 * (arg3 as u256);
        assert!(v0 < arg1, 1);
        2 * (arg1 - v0) * 1000000 / 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::math256::pow_2((arg0 as u256))
    }

    public fun compute_beta(arg0: u256, arg1: u256, arg2: u256, arg3: u64) : u256 {
        let v0 = 2 * arg1;
        let v1 = arg2 * (arg3 as u256);
        assert!(v0 > v1, 1);
        (v0 - v1) * 1000000 / arg0
    }

    public fun compute_delta_m<T0, T1, T2>(arg0: &PoolState<T0, T1, T2>, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg1 as u256);
        let v1 = (arg2 as u256);
        ((arg0.config.beta * (v1 - v0) / 1000000 * 1000000000 - arg0.config.alpha_abs * (0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::math256::pow_2(v1) / 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::math256::pow_2(1000000000) - 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::math256::pow_2(v0) / 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::math256::pow_2(1000000000)) / 2 * 1000000) as u64)
    }

    public fun compute_delta_s<T0, T1, T2>(arg0: &PoolState<T0, T1, T2>, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg1 as u256);
        let v1 = arg0.config.alpha_abs;
        let v2 = arg0.config.beta;
        let v3 = 1000000 * 1000000 * 1000000000;
        let v4 = 0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::sqrt_down(1000000 * 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::math256::pow_2(v3));
        let v5 = 1000000 * 1000000 * 1000000000;
        (((0x7ba65fa88ed4026304b7f95ee86f96f8169170efe84b56d465b4fe305e2486cb::math256::sqrt_down(0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::math256::pow_2(2 * v2 * 1000000 * 1000000000 - 2 * v1 * v0 * 1000000) * 1000000 + 8 * (arg2 as u256) * v1 * 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::math256::pow_2(v3)) * v5 - (2 * v2 * 1000000 * 1000000000 - 2 * v1 * v0 * 1000000) * v4) * 1000000000 * 1000000 / 2 * v1 * v4 * v5) as u64)
    }

    public fun default_admin() : u256 {
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

    public(friend) fun destroy_pool<T0, T1, T2>(arg0: SeedPool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::fees::Fees, Config, bool, 0x2::object::UID) {
        let v0 = &mut arg0;
        let v1 = PoolStateKey{dummy_field: false};
        let SeedPool {
            id     : v2,
            fields : v3,
        } = arg0;
        0x2::object::delete(v2);
        let PoolState {
            balance_m       : v4,
            balance_s       : v5,
            admin_balance_m : v6,
            admin_balance_s : v7,
            launch_balance  : v8,
            fees            : v9,
            config          : v10,
            locked          : v11,
        } = 0x2::dynamic_field::remove<PoolStateKey, PoolState<T0, T1, T2>>(fields_mut(v0), v1);
        (v4, v5, v6, v7, v8, v9, v10, v11, v3)
    }

    public fun fields(arg0: &SeedPool) : &0x2::object::UID {
        &arg0.fields
    }

    fun fields_mut(arg0: &mut SeedPool) : &mut 0x2::object::UID {
        &mut arg0.fields
    }

    fun gamma_s_mist<T0, T1, T2>(arg0: &PoolState<T0, T1, T2>) : u64 {
        0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::utils::mist(arg0.config.gamma_s)
    }

    public fun is_ready_to_launch<T0, T1, T2>(arg0: &SeedPool) : bool {
        pool_state<T0, T1, T2>(arg0).locked
    }

    public fun meme_coin_supply<T0, T1, T2>(arg0: &SeedPool) : u64 {
        0x2::balance::value<T2>(&pool_state<T0, T1, T2>(arg0).launch_balance)
    }

    public fun new_default<T0, T1, T2>(arg0: &mut 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::index::Registry, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::TreasuryCap<T2>, arg3: &mut 0x2::coin::CoinMetadata<T0>, arg4: &0x2::coin::CoinMetadata<T2>, arg5: &mut 0x2::tx_context::TxContext) {
        new<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 5000000000000000, 5000000000000000, 2, (default_gamma_s() as u64), (default_gamma_m() as u64), (default_omega_m() as u64), arg5);
    }

    fun new_fees(arg0: u256, arg1: u256) : 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::fees::Fees {
        0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::fees::new(arg0, arg1)
    }

    fun new_pool_internal<T0, T1, T2>(arg0: &mut 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::index::Registry, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T2>, arg4: u256, arg5: u256, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : SeedPool {
        assert!(0x2::balance::value<T0>(&arg1) == (arg8 as u64), 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::errors::provide_both_coins());
        assert!(0x2::coin::value<T1>(&arg2) == 0, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::errors::provide_both_coins());
        assert!(0x2::coin::value<T2>(&arg3) == ((arg8 + arg9) as u64), 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::errors::provide_both_coins());
        0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::index::assert_new_pool<T0, T1, T2>(arg0);
        let v0 = Config{
            alpha_abs    : compute_alpha_abs((arg7 as u256), (arg8 as u256), (arg9 as u256), arg6),
            beta         : compute_beta((arg7 as u256), (arg8 as u256), (arg9 as u256), arg6),
            price_factor : arg6,
            gamma_s      : arg7,
            gamma_m      : arg8,
            omega_m      : arg9,
        };
        let v1 = PoolState<T0, T1, T2>{
            balance_m       : arg1,
            balance_s       : 0x2::coin::into_balance<T1>(arg2),
            admin_balance_m : 0x2::balance::zero<T0>(),
            admin_balance_s : 0x2::balance::zero<T1>(),
            launch_balance  : 0x2::coin::into_balance<T2>(arg3),
            fees            : new_fees(arg4, arg5),
            config          : v0,
            locked          : false,
        };
        let v2 = SeedPool{
            id     : 0x2::object::new(arg10),
            fields : 0x2::object::new(arg10),
        };
        let v3 = &mut v2;
        let v4 = PoolStateKey{dummy_field: false};
        0x2::dynamic_field::add<PoolStateKey, PoolState<T0, T1, T2>>(fields_mut(v3), v4, v1);
        let v5 = &mut v2;
        0x2::dynamic_field::add<0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::AccountingDfKey, 0x2::table::Table<address, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::VestingData>>(fields_mut(v5), 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::accounting_key(), 0x2::table::new<address, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::VestingData>(arg10));
        0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::index::add_seed_pool<T0, T1, T2>(arg0, 0x2::object::uid_to_address(&v2.id));
        v2
    }

    fun pool_state<T0, T1, T2>(arg0: &SeedPool) : &PoolState<T0, T1, T2> {
        let v0 = PoolStateKey{dummy_field: false};
        0x2::dynamic_field::borrow<PoolStateKey, PoolState<T0, T1, T2>>(fields(arg0), v0)
    }

    fun pool_state_mut<T0, T1, T2>(arg0: &mut SeedPool) : &mut PoolState<T0, T1, T2> {
        let v0 = PoolStateKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<PoolStateKey, PoolState<T0, T1, T2>>(fields_mut(arg0), v0)
    }

    public fun quote_buy_meme<T0, T1, T2>(arg0: &mut SeedPool, arg1: u64) : u64 {
        assert!(arg1 != 0, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::errors::no_zero_coin());
        let v0 = pool_state_mut<T0, T1, T2>(arg0);
        assert!(!v0.locked, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::errors::pool_is_locked());
        let v1 = swap_amounts<T0, T1, T2>(v0, arg1, 0, true);
        v1.amount_out
    }

    public fun quote_sell_meme<T0, T1, T2>(arg0: &mut SeedPool, arg1: u64) : u64 {
        assert!(arg1 != 0, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::errors::no_zero_coin());
        let v0 = pool_state_mut<T0, T1, T2>(arg0);
        assert!(!v0.locked, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::errors::pool_is_locked());
        let v1 = swap_amounts<T0, T1, T2>(v0, arg1, 0, false);
        v1.amount_out
    }

    public fun sell_meme<T0, T1, T2>(arg0: &mut SeedPool, arg1: 0x2::token::Token<T0>, arg2: u64, arg3: &0x2::token::TokenPolicy<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::token::value<T0>(&arg1) != 0, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::errors::no_zero_coin());
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        let v1 = pool_state_mut<T0, T1, T2>(arg0);
        assert!(!v1.locked, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::errors::pool_is_locked());
        let v2 = 0x2::token::value<T0>(&arg1);
        let v3 = swap_amounts<T0, T1, T2>(v1, v2, arg2, false);
        if (v3.admin_fee_in != 0) {
            0x2::balance::join<T0>(&mut v1.admin_balance_m, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::token_ir::into_balance<T0>(arg3, 0x2::token::split<T0>(&mut arg1, v3.admin_fee_in, arg4), arg4));
        };
        if (v3.admin_fee_out != 0) {
            0x2::balance::join<T1>(&mut v1.admin_balance_s, 0x2::balance::split<T1>(&mut v1.balance_s, v3.admin_fee_out));
        };
        0x2::balance::join<T0>(&mut v1.balance_m, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::token_ir::into_balance<T0>(arg3, arg1, arg4));
        0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::events::swap<T0, T1, SwapAmount>(v0, v2, v3);
        subtract_from_token_acc(arg0, v2, 0x2::tx_context::sender(arg4));
        0x2::coin::take<T1>(&mut v1.balance_s, v3.amount_out, arg4)
    }

    fun sell_meme_swap_amounts<T0, T1, T2>(arg0: &PoolState<T0, T1, T2>, arg1: u64, arg2: u64) : SwapAmount {
        let (v0, v1) = balances<T0, T1, T2>(arg0);
        let v2 = (arg0.config.gamma_m as u64) - v0;
        let v3 = 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::fees::get_fee_in_amount(&arg0.fees, arg1);
        let v4 = 0x2::math::min(arg1 - v3, v2);
        let v5 = if (arg1 - v3 > v2) {
            v1
        } else {
            compute_delta_s<T0, T1, T2>(arg0, v1, v4)
        };
        let v6 = 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::fees::get_fee_out_amount(&arg0.fees, v5);
        let v7 = v5 - v6;
        assert!(v7 >= arg2, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::errors::slippage());
        SwapAmount{
            amount_in     : v4,
            amount_out    : v7,
            admin_fee_in  : v3,
            admin_fee_out : v6,
        }
    }

    fun subtract_from_token_acc(arg0: &mut SeedPool, arg1: u64, arg2: address) {
        let v0 = 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::notional_mut(0x2::table::borrow_mut<address, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::VestingData>(0x2::dynamic_field::borrow_mut<0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::AccountingDfKey, 0x2::table::Table<address, 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::VestingData>>(fields_mut(arg0), 0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::vesting::accounting_key()), arg2));
        *v0 = *v0 - arg1;
    }

    fun swap_amounts<T0, T1, T2>(arg0: &PoolState<T0, T1, T2>, arg1: u64, arg2: u64, arg3: bool) : SwapAmount {
        if (arg3) {
            buy_meme_swap_amounts<T0, T1, T2>(arg0, arg1, arg2)
        } else {
            sell_meme_swap_amounts<T0, T1, T2>(arg0, arg1, arg2)
        }
    }

    public fun take_fees<T0, T1, T2>(arg0: &0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::admin::Admin, arg1: &mut SeedPool, arg2: &0x2::token::TokenPolicy<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::token::Token<T0>, 0x2::coin::Coin<T1>) {
        let v0 = pool_state_mut<T0, T1, T2>(arg1);
        let v1 = 0x2::balance::value<T0>(&v0.admin_balance_m);
        let v2 = 0x2::balance::value<T1>(&v0.admin_balance_s);
        add_from_token_acc(arg1, v1, 0x2::tx_context::sender(arg3));
        let v3 = pool_state_mut<T0, T1, T2>(arg1);
        (0x1eee8b5dd7e1d5a1788e7efe8281336003a67b445e8ef0bb11489bc8b32b20b3::token_ir::take<T0>(arg2, &mut v3.admin_balance_m, v1, arg3), 0x2::coin::take<T1>(&mut v3.admin_balance_s, v2, arg3))
    }

    public fun ticket_coin_supply<T0, T1, T2>(arg0: &SeedPool) : u64 {
        0x2::balance::value<T0>(&pool_state<T0, T1, T2>(arg0).balance_m)
    }

    // decompiled from Move bytecode v6
}

