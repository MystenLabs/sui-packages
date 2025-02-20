module 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::pool {
    struct Pool<phantom T0, phantom T1, T2: store, phantom T3: drop> has store, key {
        id: 0x2::object::UID,
        quoter: T2,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<T3>,
        protocol_fees: 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::fees::Fees<T0, T1>,
        pool_fee_config: 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::fees::FeeConfig,
        trading_data: TradingData,
        version: 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::version::Version,
    }

    struct TradingData has store {
        swap_a_in_amount: u128,
        swap_b_out_amount: u128,
        swap_a_out_amount: u128,
        swap_b_in_amount: u128,
        protocol_fees_a: u64,
        protocol_fees_b: u64,
        pool_fees_a: u64,
        pool_fees_b: u64,
    }

    struct NewPoolResult has copy, drop, store {
        pool_id: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        quoter_type: 0x1::type_name::TypeName,
        lp_token_type: 0x1::type_name::TypeName,
        swap_fee_bps: u64,
    }

    struct SwapResult has copy, drop, store {
        user: address,
        pool_id: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        output_fees: 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::SwapFee,
        a2b: bool,
    }

    struct DepositResult has copy, drop, store {
        user: address,
        pool_id: 0x2::object::ID,
        deposit_a: u64,
        deposit_b: u64,
        mint_lp: u64,
    }

    struct RedeemResult has copy, drop, store {
        user: address,
        pool_id: 0x2::object::ID,
        withdraw_a: u64,
        withdraw_b: u64,
        burn_lp: u64,
    }

    public(friend) fun swap<T0, T1, T2: store, T3: drop>(arg0: &mut Pool<T0, T1, T2, T3>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::SwapQuote, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : SwapResult {
        0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::version::assert_version_and_upgrade(&mut arg0.version, 1);
        let v0 = 0x2::coin::value<T0>(arg1) == 0 && 0x2::coin::value<T1>(arg2) == 0;
        assert!(!v0, 9);
        assert!(0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::amount_out(&arg3) > 0, 6);
        assert!(0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::amount_out(&arg3) >= arg4, 3);
        let (v1, v2) = 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::fees::balances_mut<T0, T1>(&mut arg0.protocol_fees);
        if (0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::a2b(&arg3)) {
            let v3 = &mut arg0.balance_a;
            let v4 = &mut arg0.trading_data.swap_a_in_amount;
            let v5 = &mut arg0.balance_b;
            let v6 = &mut arg0.trading_data.swap_b_out_amount;
            let v7 = &mut arg0.trading_data.protocol_fees_b;
            let v8 = &mut arg0.trading_data.pool_fees_b;
            swap_inner<T0, T1>(&arg3, v3, arg1, v4, v2, v5, arg2, v6, v7, v8);
        } else {
            let v9 = &mut arg0.balance_b;
            let v10 = &mut arg0.trading_data.swap_b_in_amount;
            let v11 = &mut arg0.balance_a;
            let v12 = &mut arg0.trading_data.swap_a_out_amount;
            let v13 = &mut arg0.trading_data.protocol_fees_a;
            let v14 = &mut arg0.trading_data.pool_fees_a;
            swap_inner<T1, T0>(&arg3, v9, arg2, v10, v1, v11, arg1, v12, v13, v14);
        };
        let v15 = SwapResult{
            user        : 0x2::tx_context::sender(arg5),
            pool_id     : 0x2::object::id<Pool<T0, T1, T2, T3>>(arg0),
            amount_in   : 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::amount_in(&arg3),
            amount_out  : 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::amount_out(&arg3),
            output_fees : *0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::output_fees(&arg3),
            a2b         : 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::a2b(&arg3),
        };
        0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::events::emit_event<SwapResult>(v15);
        v15
    }

    public(friend) fun new<T0, T1, T2: store, T3: drop>(arg0: &mut 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::registry::Registry, arg1: u64, arg2: T2, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::coin::CoinMetadata<T1>, arg5: &mut 0x2::coin::CoinMetadata<T3>, arg6: 0x2::coin::TreasuryCap<T3>, arg7: &mut 0x2::tx_context::TxContext) : Pool<T0, T1, T2, T3> {
        assert!(0x2::coin::total_supply<T3>(&arg6) == 0, 1);
        assert_swap_fee_bps(arg1);
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<T1>(), 8);
        update_lp_metadata<T0, T1, T3>(arg3, arg4, arg5, &arg6);
        let v0 = TradingData{
            swap_a_in_amount  : 0,
            swap_b_out_amount : 0,
            swap_a_out_amount : 0,
            swap_b_in_amount  : 0,
            protocol_fees_a   : 0,
            protocol_fees_b   : 0,
            pool_fees_a       : 0,
            pool_fees_b       : 0,
        };
        let v1 = Pool<T0, T1, T2, T3>{
            id              : 0x2::object::new(arg7),
            quoter          : arg2,
            balance_a       : 0x2::balance::zero<T0>(),
            balance_b       : 0x2::balance::zero<T1>(),
            lp_supply       : 0x2::coin::treasury_into_supply<T3>(arg6),
            protocol_fees   : 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::fees::new<T0, T1>(2000, 10000, 0),
            pool_fee_config : 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::fees::new_config(arg1, 10000, 0),
            trading_data    : v0,
            version         : 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::version::new(1),
        };
        let v2 = NewPoolResult{
            pool_id       : 0x2::object::id<Pool<T0, T1, T2, T3>>(&v1),
            coin_type_a   : 0x1::type_name::get<T0>(),
            coin_type_b   : 0x1::type_name::get<T1>(),
            quoter_type   : 0x1::type_name::get<T2>(),
            lp_token_type : 0x1::type_name::get<T3>(),
            swap_fee_bps  : arg1,
        };
        0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::events::emit_event<NewPoolResult>(v2);
        0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::registry::register_pool(arg0, v2.pool_id, v2.coin_type_a, v2.coin_type_b, v2.lp_token_type, v2.swap_fee_bps, v2.quoter_type);
        v1
    }

    public(friend) fun assert_liquidity(arg0: u64, arg1: u64) {
        assert!(arg1 <= arg0, 4);
    }

    fun assert_lp_supply_reserve_ratio(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg2 as u128) * (arg1 as u128) >= (arg0 as u128) * (arg3 as u128), 5);
    }

    fun assert_swap_fee_bps(arg0: u64) {
        let v0 = if (arg0 == 1) {
            true
        } else if (arg0 == 5) {
            true
        } else if (arg0 == 30) {
            true
        } else if (arg0 == 100) {
            true
        } else {
            arg0 == 200
        };
        assert!(v0, 2);
    }

    public fun balance_amount_a<T0, T1, T2: store, T3: drop>(arg0: &Pool<T0, T1, T2, T3>) : u64 {
        0x2::balance::value<T0>(&arg0.balance_a)
    }

    public fun balance_amount_b<T0, T1, T2: store, T3: drop>(arg0: &Pool<T0, T1, T2, T3>) : u64 {
        0x2::balance::value<T1>(&arg0.balance_b)
    }

    public fun balance_amounts<T0, T1, T2: store, T3: drop>(arg0: &Pool<T0, T1, T2, T3>) : (u64, u64) {
        (balance_amount_a<T0, T1, T2, T3>(arg0), balance_amount_b<T0, T1, T2, T3>(arg0))
    }

    public fun collect_protocol_fees<T0, T1, T2: store, T3: drop>(arg0: &mut Pool<T0, T1, T2, T3>, arg1: &0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::global_admin::GlobalAdmin, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::version::assert_version_and_upgrade(&mut arg0.version, 1);
        let (v0, v1) = 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::fees::withdraw<T0, T1>(&mut arg0.protocol_fees);
        (0x2::coin::from_balance<T0>(v0, arg2), 0x2::coin::from_balance<T1>(v1, arg2))
    }

    public(friend) fun compute_swap_fees_<T0, T1, T2: store, T3: drop>(arg0: &Pool<T0, T1, T2, T3>, arg1: u64) : (u64, u64) {
        let (v0, v1) = 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::fees::fee_ratio<T0, T1>(&arg0.protocol_fees);
        let (v2, v3) = 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::fees::fee_ratio_(&arg0.pool_fee_config);
        let v4 = 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::math::safe_mul_div_up(arg1, v2, v3);
        let v5 = 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::math::safe_mul_div_up(v4, v0, v1);
        (v5, v4 - v5)
    }

    public fun deposit_liquidity<T0, T1, T2: store, T3: drop>(arg0: &mut Pool<T0, T1, T2, T3>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T3>, DepositResult) {
        0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::version::assert_version_and_upgrade(&mut arg0.version, 1);
        let v0 = 0x2::coin::value<T0>(arg1) == 0 && 0x2::coin::value<T1>(arg2) == 0;
        assert!(!v0, 9);
        let v1 = quote_deposit_<T0, T1, T2, T3>(arg0, arg3, arg4);
        let v2 = 0x2::balance::supply_value<T3>(&arg0.lp_supply);
        let (v3, v4) = balance_amounts<T0, T1, T2, T3>(arg0);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg1), 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::deposit_a(&v1)));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg2), 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::deposit_b(&v1)));
        let v5 = 0x2::coin::from_balance<T3>(0x2::balance::increase_supply<T3>(&mut arg0.lp_supply, 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::mint_lp(&v1)), arg5);
        let v6 = DepositResult{
            user      : 0x2::tx_context::sender(arg5),
            pool_id   : 0x2::object::id<Pool<T0, T1, T2, T3>>(arg0),
            deposit_a : 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::deposit_a(&v1),
            deposit_b : 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::deposit_b(&v1),
            mint_lp   : 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::mint_lp(&v1),
        };
        0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::events::emit_event<DepositResult>(v6);
        if (0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::initial_deposit(&v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T3>>(0x2::coin::split<T3>(&mut v5, 1000, arg5), @0x0);
        };
        assert!(0x2::coin::value<T3>(&v5) > 0, 10);
        assert_lp_supply_reserve_ratio(v3, v2, balance_amount_a<T0, T1, T2, T3>(arg0), 0x2::balance::supply_value<T3>(&arg0.lp_supply));
        assert_lp_supply_reserve_ratio(v4, v2, balance_amount_b<T0, T1, T2, T3>(arg0), 0x2::balance::supply_value<T3>(&arg0.lp_supply));
        (v5, v6)
    }

    public fun deposit_result_deposit_a(arg0: &DepositResult) : u64 {
        arg0.deposit_a
    }

    public fun deposit_result_deposit_b(arg0: &DepositResult) : u64 {
        arg0.deposit_b
    }

    public fun deposit_result_mint_lp(arg0: &DepositResult) : u64 {
        arg0.mint_lp
    }

    public fun deposit_result_pool_id(arg0: &DepositResult) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun deposit_result_user(arg0: &DepositResult) : address {
        arg0.user
    }

    public(friend) fun get_quote<T0, T1, T2: store, T3: drop>(arg0: &Pool<T0, T1, T2, T3>, arg1: u64, arg2: u64, arg3: bool) : 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::SwapQuote {
        let (v0, v1) = compute_swap_fees_<T0, T1, T2, T3>(arg0, arg2);
        0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::quote(arg1, arg2 - v0 - v1, v0, v1, arg3)
    }

    public fun lp_supply_val<T0, T1, T2: store, T3: drop>(arg0: &Pool<T0, T1, T2, T3>) : u64 {
        0x2::balance::supply_value<T3>(&arg0.lp_supply)
    }

    entry fun migrate<T0, T1, T2: store, T3: drop>(arg0: &mut Pool<T0, T1, T2, T3>, arg1: &0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::global_admin::GlobalAdmin) {
        0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::version::migrate_(&mut arg0.version, 1);
    }

    public fun minimum_liquidity() : u64 {
        1000
    }

    public fun pool_fee_config<T0, T1, T2: store, T3: drop>(arg0: &Pool<T0, T1, T2, T3>) : &0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::fees::FeeConfig {
        &arg0.pool_fee_config
    }

    public fun pool_fees_a(arg0: &TradingData) : u64 {
        arg0.pool_fees_a
    }

    public fun pool_fees_b(arg0: &TradingData) : u64 {
        arg0.pool_fees_b
    }

    public fun protocol_fees<T0, T1, T2: store, T3: drop>(arg0: &Pool<T0, T1, T2, T3>) : &0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::fees::Fees<T0, T1> {
        &arg0.protocol_fees
    }

    public fun protocol_fees_a(arg0: &TradingData) : u64 {
        arg0.protocol_fees_a
    }

    public fun protocol_fees_b(arg0: &TradingData) : u64 {
        arg0.protocol_fees_b
    }

    public fun quote_deposit<T0, T1, T2: store, T3: drop>(arg0: &Pool<T0, T1, T2, T3>, arg1: u64, arg2: u64) : 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::DepositQuote {
        quote_deposit_<T0, T1, T2, T3>(arg0, arg1, arg2)
    }

    fun quote_deposit_<T0, T1, T2: store, T3: drop>(arg0: &Pool<T0, T1, T2, T3>, arg1: u64, arg2: u64) : 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::DepositQuote {
        let (v0, v1) = balance_amounts<T0, T1, T2, T3>(arg0);
        let (v2, v3, v4) = 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::pool_math::quote_deposit(v0, v1, lp_supply_val<T0, T1, T2, T3>(arg0), arg1, arg2);
        0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::deposit_quote(lp_supply_val<T0, T1, T2, T3>(arg0) == 0, v2, v3, v4)
    }

    public fun quote_redeem<T0, T1, T2: store, T3: drop>(arg0: &Pool<T0, T1, T2, T3>, arg1: u64) : 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::RedeemQuote {
        quote_redeem_<T0, T1, T2, T3>(arg0, arg1, 0, 0)
    }

    fun quote_redeem_<T0, T1, T2: store, T3: drop>(arg0: &Pool<T0, T1, T2, T3>, arg1: u64, arg2: u64, arg3: u64) : 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::RedeemQuote {
        let (v0, v1) = balance_amounts<T0, T1, T2, T3>(arg0);
        let (v2, v3) = 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::pool_math::quote_redeem(v0, v1, lp_supply_val<T0, T1, T2, T3>(arg0), arg1, arg2, arg3);
        0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::redeem_quote(v2, v3, arg1)
    }

    public fun quoter<T0, T1, T2: store, T3: drop>(arg0: &Pool<T0, T1, T2, T3>) : &T2 {
        &arg0.quoter
    }

    public(friend) fun quoter_mut<T0, T1, T2: store, T3: drop>(arg0: &mut Pool<T0, T1, T2, T3>) : &mut T2 {
        &mut arg0.quoter
    }

    public fun redeem_liquidity<T0, T1, T2: store, T3: drop>(arg0: &mut Pool<T0, T1, T2, T3>, arg1: 0x2::coin::Coin<T3>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, RedeemResult) {
        assert!(0x2::coin::value<T3>(&arg1) > 0, 9);
        0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::version::assert_version_and_upgrade(&mut arg0.version, 1);
        let v0 = quote_redeem_<T0, T1, T2, T3>(arg0, 0x2::coin::value<T3>(&arg1), arg2, arg3);
        let v1 = 0x2::balance::supply_value<T3>(&arg0.lp_supply);
        let v2 = 0x2::coin::value<T3>(&arg1);
        assert!(0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::burn_lp(&v0) == v2, 0);
        0x2::balance::decrease_supply<T3>(&mut arg0.lp_supply, 0x2::coin::into_balance<T3>(arg1));
        let v3 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a, 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::withdraw_a(&v0)), arg4);
        let v4 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_b, 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::withdraw_b(&v0)), arg4);
        assert_lp_supply_reserve_ratio(balance_amount_a<T0, T1, T2, T3>(arg0), v1, balance_amount_a<T0, T1, T2, T3>(arg0), 0x2::balance::supply_value<T3>(&arg0.lp_supply));
        assert_lp_supply_reserve_ratio(balance_amount_b<T0, T1, T2, T3>(arg0), v1, balance_amount_b<T0, T1, T2, T3>(arg0), 0x2::balance::supply_value<T3>(&arg0.lp_supply));
        let v5 = RedeemResult{
            user       : 0x2::tx_context::sender(arg4),
            pool_id    : 0x2::object::id<Pool<T0, T1, T2, T3>>(arg0),
            withdraw_a : 0x2::coin::value<T0>(&v3),
            withdraw_b : 0x2::coin::value<T1>(&v4),
            burn_lp    : v2,
        };
        0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::events::emit_event<RedeemResult>(v5);
        (v3, v4, v5)
    }

    public fun redeem_result_burn_lp(arg0: &RedeemResult) : u64 {
        arg0.burn_lp
    }

    public fun redeem_result_pool_id(arg0: &RedeemResult) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun redeem_result_user(arg0: &RedeemResult) : address {
        arg0.user
    }

    public fun redeem_result_withdraw_a(arg0: &RedeemResult) : u64 {
        arg0.withdraw_a
    }

    public fun redeem_result_withdraw_b(arg0: &RedeemResult) : u64 {
        arg0.withdraw_a
    }

    fun swap_inner<T0, T1>(arg0: &0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::SwapQuote, arg1: &mut 0x2::balance::Balance<T0>, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut u128, arg4: &mut 0x2::balance::Balance<T1>, arg5: &mut 0x2::balance::Balance<T1>, arg6: &mut 0x2::coin::Coin<T1>, arg7: &mut u128, arg8: &mut u64, arg9: &mut u64) {
        assert!(0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::amount_out(arg0) <= 0x2::balance::value<T1>(arg5), 4);
        assert!(0x2::coin::value<T0>(arg2) >= 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::amount_in(arg0), 7);
        0x2::balance::join<T0>(arg1, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::amount_in(arg0)));
        let v0 = 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::protocol_fees(0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::output_fees(arg0));
        0x2::balance::join<T1>(arg4, 0x2::balance::split<T1>(arg5, v0));
        0x2::balance::join<T1>(0x2::coin::balance_mut<T1>(arg6), 0x2::balance::split<T1>(arg5, 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::amount_out(arg0)));
        *arg8 = *arg8 + v0;
        *arg9 = *arg9 + 0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::pool_fees(0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::output_fees(arg0));
        *arg3 = *arg3 + (0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::amount_in(arg0) as u128);
        *arg7 = *arg7 + (0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::amount_out(arg0) as u128);
    }

    public fun swap_result_a2b(arg0: &SwapResult) : bool {
        arg0.a2b
    }

    public fun swap_result_amount_in(arg0: &SwapResult) : u64 {
        arg0.amount_in
    }

    public fun swap_result_amount_out(arg0: &SwapResult) : u64 {
        arg0.amount_out
    }

    public fun swap_result_pool_fees(arg0: &SwapResult) : u64 {
        0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::pool_fees(&arg0.output_fees)
    }

    public fun swap_result_pool_id(arg0: &SwapResult) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun swap_result_protocol_fees(arg0: &SwapResult) : u64 {
        0x10e03a93cf1e3d676677cd2904b003af1511a2b68127aac333371c930f819cba::quote::protocol_fees(&arg0.output_fees)
    }

    public fun swap_result_user(arg0: &SwapResult) : address {
        arg0.user
    }

    public fun total_swap_a_in_amount(arg0: &TradingData) : u128 {
        arg0.swap_a_in_amount
    }

    public fun total_swap_a_out_amount(arg0: &TradingData) : u128 {
        arg0.swap_a_out_amount
    }

    public fun total_swap_b_in_amount(arg0: &TradingData) : u128 {
        arg0.swap_b_in_amount
    }

    public fun total_swap_b_out_amount(arg0: &TradingData) : u128 {
        arg0.swap_b_out_amount
    }

    public fun trading_data<T0, T1, T2: store, T3: drop>(arg0: &Pool<T0, T1, T2, T3>) : &TradingData {
        &arg0.trading_data
    }

    fun update_lp_metadata<T0, T1, T2: drop>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: &0x2::coin::CoinMetadata<T1>, arg2: &mut 0x2::coin::CoinMetadata<T2>, arg3: &0x2::coin::TreasuryCap<T2>) {
        assert!(0x2::coin::get_decimals<T2>(arg2) == 9, 0);
        let v0 = 0x1::string::utf8(b"Steamm LP Token ");
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x2::coin::get_symbol<T0>(arg0)));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x2::coin::get_symbol<T1>(arg1)));
        0x2::coin::update_name<T2>(arg3, arg2, v0);
        let v1 = 0x1::ascii::string(b"steammLP ");
        0x1::ascii::append(&mut v1, 0x2::coin::get_symbol<T0>(arg0));
        0x1::ascii::append(&mut v1, 0x1::ascii::string(b"-"));
        0x1::ascii::append(&mut v1, 0x2::coin::get_symbol<T1>(arg1));
        0x2::coin::update_symbol<T2>(arg3, arg2, v1);
        0x2::coin::update_description<T2>(arg3, arg2, 0x1::string::utf8(b"Steamm LP Token"));
        0x2::coin::update_icon_url<T2>(arg3, arg2, 0x1::ascii::string(b"TODO"));
    }

    // decompiled from Move bytecode v6
}

