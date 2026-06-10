module 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::lp_pool {
    struct WlpPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        is_active: bool,
        allowed_versions: 0x2::vec_set::VecSet<u16>,
        lp_treasury_cap: 0x2::coin::TreasuryCap<T0>,
        lp_decimal: u8,
        token_types: vector<0x1::type_name::TypeName>,
        token_pools: vector<TokenPoolInfo>,
        tvl_usd: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        redeem_requests: 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::KeyedBigVector,
        next_redeem_id: u64,
    }

    struct TokenPoolInfo has copy, drop, store {
        token_type: 0x1::type_name::TypeName,
        ticker: 0x1::string::String,
        token_decimal: u8,
        target_weight_bps: u64,
        mint_fee_bps: u64,
        burn_fee_bps: u64,
        max_capacity: u64,
        min_deposit: u64,
        basic_borrow_rate_0: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        basic_borrow_rate_1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        basic_borrow_rate_2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        utilization_threshold_0_bps: u64,
        utilization_threshold_1_bps: u64,
        borrow_interval_ms: u64,
        max_reserve_ratio_bps: u64,
        liquidity_amount: u64,
        value_usd: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        reserved_amount: u64,
        last_borrow_timestamp: u64,
        cumulative_borrow_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        last_price_refresh_timestamp: u64,
    }

    struct RedeemRequest<phantom T0> has store {
        recipient_account_id: 0x2::object::ID,
        lp_balance: 0x2::balance::Balance<T0>,
        token_type: 0x1::type_name::TypeName,
        request_timestamp: u64,
    }

    struct WlpAum<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        market_contributions: 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::KeyedBigVector,
        total_trader_profit_usd: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        total_trader_loss_usd: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
    }

    struct AumMarketContribution has copy, drop, store {
        is_trader_profit: bool,
        pnl_usd: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        last_refresh_timestamp: u64,
    }

    public fun assert_version<T0>(arg0: &WlpPool<T0>) {
        let v0 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::version::package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &v0)) {
            abort 13906835230905466883
        };
    }

    fun add_aum_contribution<T0>(arg0: &mut WlpAum<T0>, arg1: &AumMarketContribution) {
        if (arg1.is_trader_profit) {
            arg0.total_trader_profit_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(arg0.total_trader_profit_usd, arg1.pnl_usd);
        } else {
            arg0.total_trader_loss_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(arg0.total_trader_loss_usd, arg1.pnl_usd);
        };
    }

    public fun add_token<T0, T1>(arg0: &mut WlpPool<T0>, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: u128, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &0x2::clock::Clock) {
        assert_version<T0>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.token_types)) {
            if (*0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.token_types, v1) == v0) {
                abort 13906835389819781131
            };
            v1 = v1 + 1;
        };
        let v2 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(arg9);
        let v3 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(arg10);
        let v4 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(arg11);
        assert_valid_borrow_config(v2, v3, v4, arg14);
        assert_valid_max_reserve_ratio(arg15);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.token_types, v0);
        let v5 = TokenPoolInfo{
            token_type                   : v0,
            ticker                       : arg2,
            token_decimal                : arg3,
            target_weight_bps            : arg4,
            mint_fee_bps                 : arg5,
            burn_fee_bps                 : arg6,
            max_capacity                 : arg7,
            min_deposit                  : arg8,
            basic_borrow_rate_0          : v2,
            basic_borrow_rate_1          : v3,
            basic_borrow_rate_2          : v4,
            utilization_threshold_0_bps  : arg12,
            utilization_threshold_1_bps  : arg13,
            borrow_interval_ms           : arg14,
            max_reserve_ratio_bps        : arg15,
            liquidity_amount             : 0,
            value_usd                    : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero(),
            reserved_amount              : 0,
            last_borrow_timestamp        : 0x2::clock::timestamp_ms(arg16),
            cumulative_borrow_rate       : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero(),
            last_price_refresh_timestamp : 0x2::clock::timestamp_ms(arg16),
        };
        0x1::vector::push_back<TokenPoolInfo>(&mut arg0.token_pools, v5);
    }

    public fun allow_version<T0>(arg0: &mut WlpPool<T0>, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: u16) {
        if (!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2)) {
            0x2::vec_set::insert<u16>(&mut arg0.allowed_versions, arg2);
        };
    }

    fun assert_aum_fresh<T0>(arg0: &WlpAum<T0>, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::GlobalConfig, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0;
        while (v1 < 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::length(&arg0.market_contributions)) {
            let (_, v3) = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::borrow<0x2::object::ID, AumMarketContribution>(&arg0.market_contributions, v1);
            let v4 = v3.last_refresh_timestamp;
            if (v0 < v4) {
                abort 13906839976846295073
            };
            if (v0 - v4 > 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::price_refresh_threshold_ms(arg1)) {
                abort 13906839981141262369
            };
            v1 = v1 + 1;
        };
    }

    public(friend) fun assert_prices_fresh<T0>(arg0: &WlpPool<T0>, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::GlobalConfig, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<TokenPoolInfo>(&arg0.token_pools)) {
            let v2 = 0x1::vector::borrow<TokenPoolInfo>(&arg0.token_pools, v1).last_price_refresh_timestamp;
            if (v0 < v2) {
                abort 13906840049860739105
            };
            if (v0 - v2 > 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::price_refresh_threshold_ms(arg1)) {
                abort 13906840054155706401
            };
            v1 = v1 + 1;
        };
    }

    fun assert_redeem_allowed<T0>(arg0: &WlpPool<T0>) {
        if (calculate_total_wlp_utilization_bps<T0>(arg0) > 9500) {
            abort 13906840088515182621
        };
    }

    fun assert_token_redeem_allowed<T0>(arg0: &WlpPool<T0>, arg1: 0x1::type_name::TypeName) {
        let v0 = borrow_token_pool<T0>(arg0, &arg1);
        let v1 = if (v0.liquidity_amount > 0) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_fraction(v0.reserved_amount, v0.liquidity_amount), 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::bp_scale()))
        } else {
            0
        };
        if (v1 > 9500) {
            abort 13906840140054790173
        };
    }

    fun assert_valid_borrow_config(arg0: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg3: u64) {
        if (arg3 == 0) {
            abort 13906840591024521217
        };
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::lt(arg1, arg0) || 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::lt(arg2, arg1)) {
            abort 13906840595319488513
        };
    }

    fun assert_valid_max_reserve_ratio(arg0: u64) {
        if (arg0 > 9500) {
            abort 13906840612499357697
        };
    }

    fun assert_wxa_protocol_perm(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: 0x2::object::ID, arg2: address, arg3: u32, arg4: &0x2::clock::Clock) {
        if (0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::effective_protocol_permissions<0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data::WaterXPerp>(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg4)) & arg3 != arg3) {
            abort 13906834552300765189
        };
    }

    public fun aum_contribution_is_trader_profit(arg0: &AumMarketContribution) : bool {
        arg0.is_trader_profit
    }

    public fun aum_contribution_last_refresh_timestamp(arg0: &AumMarketContribution) : u64 {
        arg0.last_refresh_timestamp
    }

    public fun aum_contribution_pnl_usd(arg0: &AumMarketContribution) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.pnl_usd
    }

    public(friend) fun aum_equity_usd<T0>(arg0: &WlpPool<T0>, arg1: &WlpAum<T0>, arg2: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::GlobalConfig, arg3: &0x2::clock::Clock) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        if (arg1.pool_id != 0x2::object::id<WlpPool<T0>>(arg0)) {
            abort 13906838615339565057
        };
        assert_aum_fresh<T0>(arg1, arg2, arg3);
        let v0 = arg1.total_trader_profit_usd;
        let v1 = arg1.total_trader_loss_usd;
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(v0, v1)) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::saturating_sub(arg0.tvl_usd, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(v0, v1))
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(arg0.tvl_usd, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(v1, v0))
        }
    }

    public fun aum_market_contribution<T0>(arg0: &WlpAum<T0>, arg1: 0x2::object::ID) : AumMarketContribution {
        *0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::borrow_by_key<0x2::object::ID, AumMarketContribution>(&arg0.market_contributions, arg1)
    }

    public fun aum_market_contribution_by_index<T0>(arg0: &WlpAum<T0>, arg1: u64) : (0x2::object::ID, AumMarketContribution) {
        let (v0, v1) = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::borrow<0x2::object::ID, AumMarketContribution>(&arg0.market_contributions, arg1);
        (v0, *v1)
    }

    public fun aum_market_count<T0>(arg0: &WlpAum<T0>) : u64 {
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::length(&arg0.market_contributions)
    }

    public fun aum_pool_id<T0>(arg0: &WlpAum<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun aum_total_trader_loss_usd<T0>(arg0: &WlpAum<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.total_trader_loss_usd
    }

    public fun aum_total_trader_profit_usd<T0>(arg0: &WlpAum<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.total_trader_profit_usd
    }

    fun borrow_mut_token_pool<T0>(arg0: &mut WlpPool<T0>, arg1: &0x1::type_name::TypeName) : &mut TokenPoolInfo {
        0x1::vector::borrow_mut<TokenPoolInfo>(&mut arg0.token_pools, find_token_pool_index<T0>(arg0, arg1))
    }

    public fun borrow_redeem_requests<T0>(arg0: &WlpPool<T0>) : &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::KeyedBigVector {
        &arg0.redeem_requests
    }

    fun borrow_token_pool<T0>(arg0: &WlpPool<T0>, arg1: &0x1::type_name::TypeName) : &TokenPoolInfo {
        0x1::vector::borrow<TokenPoolInfo>(&arg0.token_pools, find_token_pool_index<T0>(arg0, arg1))
    }

    public fun borrow_token_pool_by_index<T0>(arg0: &WlpPool<T0>, arg1: u64) : &TokenPoolInfo {
        0x1::vector::borrow<TokenPoolInfo>(&arg0.token_pools, arg1)
    }

    fun calculate_borrow_rate(arg0: u64, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg4: u64, arg5: u64) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        if (arg0 <= arg4) {
            arg1
        } else if (arg0 <= arg5) {
            if (arg5 == arg4) {
                arg2
            } else {
                0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(arg1, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(arg2, arg1), arg0 - arg4), arg5 - arg4))
            }
        } else {
            let v1 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::bp_scale() - arg5;
            if (v1 == 0) {
                arg3
            } else {
                0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(arg3, arg2), arg0 - arg5), v1))
            }
        }
    }

    fun calculate_borrow_rate_accrual(arg0: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg1: u64, arg2: u64) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        let v0 = if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero()
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(arg0, arg1), arg2)
    }

    fun calculate_dynamic_fee(arg0: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg3: u64, arg4: u64, arg5: bool) : u64 {
        let v0 = if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg1, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            true
        } else if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            true
        } else {
            arg3 == 0
        };
        if (v0) {
            return arg4
        };
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(arg1, arg3), 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::bp_scale());
        let v2 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::diff(arg0, v1);
        let (v3, v4) = if (arg5) {
            (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(arg0, arg2), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(arg1, arg2))
        } else {
            (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::saturating_sub(arg0, arg2), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::saturating_sub(arg1, arg2))
        };
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(v4, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            return arg4
        };
        let v5 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(v4, arg3), 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::bp_scale());
        let v6 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::diff(v3, v5);
        if (!0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gt(v6, v2)) {
            return arg4
        };
        let v7 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v1, v5), 2);
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(v7, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            return arg4
        };
        arg4 + 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v2, v6), 2), v7), arg4))
    }

    fun calculate_total_wlp_utilization_bps<T0>(arg0: &WlpPool<T0>) : u64 {
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg0.tvl_usd, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            return 0
        };
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero();
        let v1 = 0;
        while (v1 < 0x1::vector::length<TokenPoolInfo>(&arg0.token_pools)) {
            let v2 = 0x1::vector::borrow<TokenPoolInfo>(&arg0.token_pools, v1);
            let v3 = if (v2.liquidity_amount > 0) {
                if (v2.reserved_amount > 0) {
                    !0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(v2.value_usd, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(v2.value_usd, v2.reserved_amount), v2.liquidity_amount));
            };
            v1 = v1 + 1;
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div(v0, arg0.tvl_usd), 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::bp_scale()))
    }

    public fun cancel_redeem<T0>(arg0: &mut WlpPool<T0>, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::GlobalConfig, arg2: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg4: u64, arg5: &0x2::clock::Clock) {
        assert_version<T0>(arg0);
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::assert_not_paused(arg1);
        if (!0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::contains<u64>(&arg0.redeem_requests, arg4)) {
            abort 13906836893059121175
        };
        let v0 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::swap_remove_by_key<u64, RedeemRequest<T0>>(&mut arg0.redeem_requests, arg4);
        assert_wxa_protocol_perm(arg2, v0.recipient_account_id, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg3), 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data::perm_redeem_wlp(), arg5);
        let RedeemRequest {
            recipient_account_id : v1,
            lp_balance           : v2,
            token_type           : v3,
            request_timestamp    : _,
        } = v0;
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x2::balance::value<T0>(&v5);
        if (v7 > 0) {
            0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::events::emit_wlp_redeem_cancelled(0x2::object::id_to_address(&v6), 0x1::type_name::with_defining_ids<T0>(), v3, arg4, v7);
        };
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::put<T0, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data::WaterXPerp>(arg2, v6, v5, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data::witness());
    }

    public(friend) fun check_oi_cap<T0>(arg0: &WlpPool<T0>, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::GlobalConfig, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        let v0 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::oi_cap_bps(arg1);
        if (v0 == 0) {
            return
        };
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gt(arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(tvl_usd<T0>(arg0), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(v0)))) {
            abort 13906838757075058713
        };
    }

    public(friend) fun check_reserve_valid<T0>(arg0: &WlpPool<T0>, arg1: 0x1::type_name::TypeName, arg2: u64) : bool {
        let v0 = borrow_token_pool<T0>(arg0, &arg1);
        v0.reserved_amount + arg2 <= 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(v0.max_reserve_ratio_bps), v0.liquidity_amount))
    }

    public fun create_aum<T0>(arg0: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg1: &WlpPool<T0>, arg2: &mut 0x2::tx_context::TxContext) : WlpAum<T0> {
        WlpAum<T0>{
            id                      : 0x2::object::new(arg2),
            pool_id                 : 0x2::object::id<WlpPool<T0>>(arg1),
            market_contributions    : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::new<0x2::object::ID, AumMarketContribution>(256, arg2),
            total_trader_profit_usd : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero(),
            total_trader_loss_usd   : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero(),
        }
    }

    public fun create_pool<T0>(arg0: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : WlpPool<T0> {
        WlpPool<T0>{
            id               : 0x2::object::new(arg3),
            is_active        : true,
            allowed_versions : 0x2::vec_set::singleton<u16>(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::version::package_version()),
            lp_treasury_cap  : arg1,
            lp_decimal       : arg2,
            token_types      : 0x1::vector::empty<0x1::type_name::TypeName>(),
            token_pools      : 0x1::vector::empty<TokenPoolInfo>(),
            tvl_usd          : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero(),
            redeem_requests  : 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::new<u64, RedeemRequest<T0>>(256, arg3),
            next_redeem_id   : 0,
        }
    }

    public fun cumulative_borrow_rate<T0>(arg0: &WlpPool<T0>, arg1: 0x1::type_name::TypeName) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        borrow_token_pool<T0>(arg0, &arg1).cumulative_borrow_rate
    }

    public(friend) fun decrease_reserve<T0>(arg0: &mut WlpPool<T0>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = borrow_mut_token_pool<T0>(arg0, &arg1);
        v0.reserved_amount = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::saturating_sub(v0.reserved_amount, arg2);
    }

    public fun disallow_version<T0>(arg0: &mut WlpPool<T0>, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: u16) {
        if (0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2)) {
            0x2::vec_set::remove<u16>(&mut arg0.allowed_versions, &arg2);
        };
    }

    fun do_request_redeem<T0, T1>(arg0: &mut WlpPool<T0>, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::GlobalConfig, arg2: 0x2::object::ID, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: &0x2::clock::Clock) : u64 {
        assert_version<T0>(arg0);
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::assert_active(arg1);
        if (!arg0.is_active) {
            abort 13906836699784544263
        };
        assert_prices_fresh<T0>(arg0, arg1, arg5);
        assert_redeem_allowed<T0>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert_token_redeem_allowed<T0>(arg0, v0);
        let v1 = 0x2::balance::value<T0>(&arg3);
        if (v1 != arg4) {
            abort 13906836725553954817
        };
        let v2 = arg0.next_redeem_id;
        arg0.next_redeem_id = v2 + 1;
        let v3 = RedeemRequest<T0>{
            recipient_account_id : arg2,
            lp_balance           : arg3,
            token_type           : v0,
            request_timestamp    : 0x2::clock::timestamp_ms(arg5),
        };
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::push_back<u64, RedeemRequest<T0>>(&mut arg0.redeem_requests, v2, v3);
        if (v1 > 0) {
            0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::events::emit_wlp_redeem_requested(0x2::object::id_to_address(&arg2), 0x1::type_name::with_defining_ids<T0>(), v0, v1, v2);
        };
        v2
    }

    fun find_token_pool_index<T0>(arg0: &WlpPool<T0>, arg1: &0x1::type_name::TypeName) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TokenPoolInfo>(&arg0.token_pools)) {
            if (&0x1::vector::borrow<TokenPoolInfo>(&arg0.token_pools, v0).token_type == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 13906839676197011465
    }

    public(friend) fun increase_reserve<T0>(arg0: &mut WlpPool<T0>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = borrow_mut_token_pool<T0>(arg0, &arg1);
        v0.reserved_amount = v0.reserved_amount + arg2;
    }

    public fun is_active<T0>(arg0: &WlpPool<T0>) : bool {
        arg0.is_active
    }

    public fun lp_decimal<T0>(arg0: &WlpPool<T0>) : u8 {
        arg0.lp_decimal
    }

    public fun mint_wlp<T0, T1>(arg0: &mut WlpPool<T0>, arg1: &mut 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::GlobalConfig, arg2: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg3: &WlpAum<T0>, arg4: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::Oracle, arg9: &0x2::clock::Clock) : u64 {
        assert_version<T0>(arg0);
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::assert_active(arg1);
        assert_wxa_protocol_perm(arg2, arg5, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg4), 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data::perm_mint_wlp(), arg9);
        let v0 = aum_equity_usd<T0>(arg0, arg3, arg1, arg9);
        let v1 = token_ticker<T0, T1>(arg0);
        let (v2, v3) = mint_wlp_with_pricing_tvl<T0, T1>(arg0, arg1, 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::take<T1, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data::WaterXPerp>(arg2, arg4, arg5, arg6, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data::witness(), arg9), arg8, v1, v0, arg7, 0x2::object::id_to_address(&arg5), arg9);
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::put<T0, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data::WaterXPerp>(arg2, arg5, v2, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data::witness());
        v3
    }

    fun mint_wlp_with_pricing_tvl<T0, T1>(arg0: &mut WlpPool<T0>, arg1: &mut 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::GlobalConfig, arg2: 0x2::balance::Balance<T1>, arg3: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::Oracle, arg4: 0x1::string::String, arg5: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg6: u64, arg7: address, arg8: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, u64) {
        assert_version<T0>(arg0);
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::assert_active(arg1);
        if (!arg0.is_active) {
            abort 13906836317532454919
        };
        assert_prices_fresh<T0>(arg0, arg1, arg8);
        let v0 = 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::get_price(arg3, arg4, arg8);
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            abort 13906836330418929695
        };
        update_borrow_rates<T0>(arg0, arg8);
        refresh_token_value_with_price<T0, T1>(arg0, v0, 0x2::clock::timestamp_ms(arg8));
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x2::balance::value<T1>(&arg2);
        let v3 = borrow_token_pool<T0>(arg0, &v1);
        if (v2 < v3.min_deposit) {
            abort 13906836364777881619
        };
        let v4 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::ceil(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(calculate_dynamic_fee(v3.value_usd, arg0.tvl_usd, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::amount_to_usd(v2, v3.token_decimal, v0), v3.target_weight_bps, v3.mint_fee_bps, true)), v2));
        let v5 = v2 - v4;
        let v6 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::amount_to_usd(v5, v3.token_decimal, v0);
        if (v3.liquidity_amount + v5 > v3.max_capacity) {
            abort 13906836429202128911
        };
        let v7 = if (0x2::coin::total_supply<T0>(&arg0.lp_treasury_cap) == 0 || 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg5, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(v6, 0x1::u64::pow(10, arg0.lp_decimal)))
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(v6, 0x2::coin::total_supply<T0>(&arg0.lp_treasury_cap)), arg5))
        };
        if (v7 < arg6) {
            abort 13906836476446900241
        };
        let v8 = borrow_mut_token_pool<T0>(arg0, &v1);
        v8.liquidity_amount = v8.liquidity_amount + v5;
        v8.value_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v8.value_usd, v6);
        arg0.tvl_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(arg0.tvl_usd, v6);
        if (v4 > 0) {
            0x2::balance::join<T1>(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::protocol_fee_balance_mut<T1>(arg1), 0x2::balance::split<T1>(&mut arg2, v4));
        };
        0x2::balance::join<T1>(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::balance_mut<T1>(arg1), arg2);
        let v9 = if (v7 > 0) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_float(v6), 0x1::u64::pow(10, arg0.lp_decimal)), v7)
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::zero()
        };
        if (v2 > 0) {
            0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::events::emit_wlp_minted(arg7, 0x1::type_name::with_defining_ids<T0>(), v1, v2, v7, v4, v9);
        };
        (0x2::coin::mint_balance<T0>(&mut arg0.lp_treasury_cap, v7), v7)
    }

    public fun pool_tvl_usd<T0>(arg0: &WlpPool<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.tvl_usd
    }

    public(friend) fun put_collateral<T0, T1>(arg0: &mut WlpPool<T0>, arg1: &mut 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::GlobalConfig, arg2: 0x2::balance::Balance<T1>, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        let v0 = 0x2::balance::value<T1>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return
        };
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = borrow_mut_token_pool<T0>(arg0, &v1);
        v2.liquidity_amount = v2.liquidity_amount + v0;
        let v3 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::amount_to_usd(v0, v2.token_decimal, arg3);
        v2.value_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v2.value_usd, v3);
        arg0.tvl_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(arg0.tvl_usd, v3);
        0x2::balance::join<T1>(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::balance_mut<T1>(arg1), arg2);
    }

    public fun redeem_lp_amount<T0>(arg0: &RedeemRequest<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.lp_balance)
    }

    public fun redeem_recipient_account_id<T0>(arg0: &RedeemRequest<T0>) : 0x2::object::ID {
        arg0.recipient_account_id
    }

    public fun redeem_request_timestamp<T0>(arg0: &RedeemRequest<T0>) : u64 {
        arg0.request_timestamp
    }

    public fun redeem_token_type<T0>(arg0: &RedeemRequest<T0>) : 0x1::type_name::TypeName {
        arg0.token_type
    }

    public(friend) fun refresh_market_aum<T0>(arg0: &mut WlpAum<T0>, arg1: 0x2::object::ID, arg2: bool, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg4: &0x2::clock::Clock) {
        if (!0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::contains<0x2::object::ID>(&arg0.market_contributions, arg1)) {
            abort 13906838486490546177
        };
        let v0 = *0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::borrow_by_key<0x2::object::ID, AumMarketContribution>(&arg0.market_contributions, arg1);
        remove_aum_contribution<T0>(arg0, &v0);
        let v1 = AumMarketContribution{
            is_trader_profit       : arg2,
            pnl_usd                : arg3,
            last_refresh_timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        let v2 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::borrow_by_key_mut<0x2::object::ID, AumMarketContribution>(&mut arg0.market_contributions, arg1);
        v2.is_trader_profit = v1.is_trader_profit;
        v2.pnl_usd = v1.pnl_usd;
        v2.last_refresh_timestamp = v1.last_refresh_timestamp;
        add_aum_contribution<T0>(arg0, &v1);
    }

    fun refresh_token_value_with_price<T0, T1>(arg0: &mut WlpPool<T0>, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = find_token_pool_index<T0>(arg0, &v0);
        let v2 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::amount_to_usd(0x1::vector::borrow<TokenPoolInfo>(&arg0.token_pools, v1).liquidity_amount, 0x1::vector::borrow<TokenPoolInfo>(&arg0.token_pools, v1).token_decimal, arg1);
        0x1::vector::borrow_mut<TokenPoolInfo>(&mut arg0.token_pools, v1).value_usd = v2;
        0x1::vector::borrow_mut<TokenPoolInfo>(&mut arg0.token_pools, v1).last_price_refresh_timestamp = arg2;
        arg0.tvl_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::saturating_sub(arg0.tvl_usd, 0x1::vector::borrow<TokenPoolInfo>(&arg0.token_pools, v1).value_usd), v2);
    }

    public(friend) fun register_market_aum<T0>(arg0: &mut WlpAum<T0>, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: 0x2::object::ID, arg3: bool, arg4: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg5: &0x2::clock::Clock) {
        if (0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::contains<0x2::object::ID>(&arg0.market_contributions, arg2)) {
            abort 13906838409181134849
        };
        let v0 = AumMarketContribution{
            is_trader_profit       : arg3,
            pnl_usd                : arg4,
            last_refresh_timestamp : 0x2::clock::timestamp_ms(arg5),
        };
        add_aum_contribution<T0>(arg0, &v0);
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::push_back<0x2::object::ID, AumMarketContribution>(&mut arg0.market_contributions, arg2, v0);
    }

    public fun reject_redeem_by_admin<T0>(arg0: &mut WlpPool<T0>, arg1: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg2: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        return_rejected_redeem_request<T0>(arg1, take_redeem_request<T0>(arg0, arg3), 0x2::tx_context::sender(arg4), arg3);
    }

    public fun reject_redeem_by_redeem_operator<T0>(arg0: &mut WlpPool<T0>, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::GlobalConfig, arg2: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg4: u64) {
        assert_version<T0>(arg0);
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::assert_not_paused(arg1);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg3);
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::verify_redeem_operator(arg1, v0);
        return_rejected_redeem_request<T0>(arg2, take_redeem_request<T0>(arg0, arg4), v0, arg4);
    }

    fun remove_aum_contribution<T0>(arg0: &mut WlpAum<T0>, arg1: &AumMarketContribution) {
        if (arg1.is_trader_profit) {
            arg0.total_trader_profit_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::saturating_sub(arg0.total_trader_profit_usd, arg1.pnl_usd);
        } else {
            arg0.total_trader_loss_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::saturating_sub(arg0.total_trader_loss_usd, arg1.pnl_usd);
        };
    }

    public(friend) fun request_collateral<T0, T1>(arg0: &mut WlpPool<T0>, arg1: &mut 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::GlobalConfig, arg2: u64, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : 0x2::balance::Balance<T1> {
        if (arg2 == 0) {
            return 0x2::balance::zero<T1>()
        };
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = borrow_mut_token_pool<T0>(arg0, &v0);
        if (arg2 > v1.liquidity_amount) {
            abort 13906839049132048397
        };
        v1.liquidity_amount = v1.liquidity_amount - arg2;
        let v2 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::amount_to_usd(arg2, v1.token_decimal, arg3);
        v1.value_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::saturating_sub(v1.value_usd, v2);
        arg0.tvl_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::saturating_sub(arg0.tvl_usd, v2);
        0x2::balance::split<T1>(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::balance_mut<T1>(arg1), arg2)
    }

    public fun request_redeem<T0, T1>(arg0: &mut WlpPool<T0>, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::GlobalConfig, arg2: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg4: 0x2::object::ID, arg5: u64, arg6: &0x2::clock::Clock) : u64 {
        assert_version<T0>(arg0);
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::assert_active(arg1);
        assert_wxa_protocol_perm(arg2, arg4, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg3), 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data::perm_redeem_wlp(), arg6);
        do_request_redeem<T0, T1>(arg0, arg1, arg4, 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::take<T0, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data::WaterXPerp>(arg2, arg3, arg4, arg5, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data::witness(), arg6), arg5, arg6)
    }

    public fun resume_pool<T0>(arg0: &mut WlpPool<T0>, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap) {
        arg0.is_active = true;
    }

    fun return_rejected_redeem_request<T0>(arg0: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg1: RedeemRequest<T0>, arg2: address, arg3: u64) {
        let RedeemRequest {
            recipient_account_id : v0,
            lp_balance           : v1,
            token_type           : v2,
            request_timestamp    : _,
        } = arg1;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x2::balance::value<T0>(&v4);
        if (v6 > 0) {
            0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::events::emit_wlp_redeem_rejected(0x2::object::id_to_address(&v5), arg2, 0x1::type_name::with_defining_ids<T0>(), v2, arg3, v6);
        };
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::put<T0, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data::WaterXPerp>(arg0, v5, v4, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data::witness());
    }

    public fun settle_redeem<T0, T1>(arg0: &mut WlpPool<T0>, arg1: &mut 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::GlobalConfig, arg2: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg3: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg4: &WlpAum<T0>, arg5: u64, arg6: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::Oracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::assert_active(arg1);
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::verify_redeem_operator(arg1, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg3));
        let v0 = aum_equity_usd<T0>(arg0, arg4, arg1, arg7);
        let v1 = token_ticker<T0, T1>(arg0);
        let (v2, v3) = settle_redeem_with_pricing_tvl<T0, T1>(arg0, arg1, arg5, arg6, v1, v0, arg7, arg8);
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::put<T1, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data::WaterXPerp>(arg2, v2, v3, 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::account_data::witness());
    }

    fun settle_redeem_with_pricing_tvl<T0, T1>(arg0: &mut WlpPool<T0>, arg1: &mut 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::GlobalConfig, arg2: u64, arg3: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::Oracle, arg4: 0x1::string::String, arg5: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::balance::Balance<T1>) {
        assert_version<T0>(arg0);
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::assert_version(arg1);
        if (!0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::contains<u64>(&arg0.redeem_requests, arg2)) {
            abort 13906837382685392919
        };
        let v0 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::swap_remove_by_key<u64, RedeemRequest<T0>>(&mut arg0.redeem_requests, arg2);
        if (0x2::clock::timestamp_ms(arg6) < v0.request_timestamp + 86400000) {
            abort 13906837404160098325
        };
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        if (v0.token_type != v1) {
            abort 13906837417044213769
        };
        let v2 = 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::get_price(arg3, arg4, arg6);
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(v2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            abort 13906837429930557471
        };
        assert_prices_fresh<T0>(arg0, arg1, arg6);
        update_borrow_rates<T0>(arg0, arg6);
        refresh_token_value_with_price<T0, T1>(arg0, v2, 0x2::clock::timestamp_ms(arg6));
        assert_redeem_allowed<T0>(arg0);
        assert_token_redeem_allowed<T0>(arg0, v1);
        let v3 = 0x2::balance::value<T0>(&v0.lp_balance);
        let v4 = borrow_token_pool<T0>(arg0, &v1);
        let v5 = if (0x2::coin::total_supply<T0>(&arg0.lp_treasury_cap) > 0) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(arg5, v3), 0x2::coin::total_supply<T0>(&arg0.lp_treasury_cap))
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero()
        };
        let v6 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::usd_to_amount(v5, v4.token_decimal, v2);
        let v7 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::ceil(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(calculate_dynamic_fee(v4.value_usd, arg0.tvl_usd, v5, v4.target_weight_bps, v4.burn_fee_bps, false)), v6));
        let v8 = v6 - v7;
        if (v4.liquidity_amount < v4.reserved_amount + v6) {
            abort 13906837571664216091
        };
        let RedeemRequest {
            recipient_account_id : v9,
            lp_balance           : v10,
            token_type           : _,
            request_timestamp    : _,
        } = v0;
        let v13 = v9;
        0x2::coin::burn<T0>(&mut arg0.lp_treasury_cap, 0x2::coin::from_balance<T0>(v10, arg7));
        let v14 = borrow_mut_token_pool<T0>(arg0, &v1);
        if (v14.liquidity_amount < v6) {
            abort 13906837627497873421
        };
        v14.liquidity_amount = v14.liquidity_amount - v6;
        let v15 = 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::amount_to_usd(v14.liquidity_amount, v14.token_decimal, v2);
        v14.value_usd = v15;
        arg0.tvl_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::saturating_sub(arg0.tvl_usd, v14.value_usd), v15);
        let v16 = 0x2::balance::split<T1>(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::balance_mut<T1>(arg1), v6);
        if (v7 > 0) {
            0x2::balance::join<T1>(0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::global_config::protocol_fee_balance_mut<T1>(arg1), 0x2::balance::split<T1>(&mut v16, v7));
        };
        let v17 = if (v3 > 0) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_float(v5), 0x1::u64::pow(10, arg0.lp_decimal)), v3)
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::zero()
        };
        if (v8 > 0) {
            0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::events::emit_wlp_redeem_settled(0x2::object::id_to_address(&v13), 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), arg2, v8, v7, v17);
        };
        (v13, v16)
    }

    public fun suspend_pool<T0>(arg0: &mut WlpPool<T0>, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap) {
        arg0.is_active = false;
    }

    fun take_redeem_request<T0>(arg0: &mut WlpPool<T0>, arg1: u64) : RedeemRequest<T0> {
        if (!0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::contains<u64>(&arg0.redeem_requests, arg1)) {
            abort 13906840260313481239
        };
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::keyed_big_vector::swap_remove_by_key<u64, RedeemRequest<T0>>(&mut arg0.redeem_requests, arg1)
    }

    public fun token_count<T0>(arg0: &WlpPool<T0>) : u64 {
        0x1::vector::length<TokenPoolInfo>(&arg0.token_pools)
    }

    public fun token_decimal<T0>(arg0: &WlpPool<T0>, arg1: 0x1::type_name::TypeName) : u8 {
        borrow_token_pool<T0>(arg0, &arg1).token_decimal
    }

    public(friend) fun token_pool_info<T0>(arg0: &WlpPool<T0>, arg1: 0x1::type_name::TypeName) : TokenPoolInfo {
        *borrow_token_pool<T0>(arg0, &arg1)
    }

    public fun token_ticker<T0, T1>(arg0: &WlpPool<T0>) : 0x1::string::String {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        borrow_token_pool<T0>(arg0, &v0).ticker
    }

    public fun total_lp_supply<T0>(arg0: &WlpPool<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.lp_treasury_cap)
    }

    public fun tpi_burn_fee_bps(arg0: &TokenPoolInfo) : u64 {
        arg0.burn_fee_bps
    }

    public fun tpi_cumulative_borrow_rate(arg0: &TokenPoolInfo) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.cumulative_borrow_rate
    }

    public fun tpi_last_price_refresh_timestamp(arg0: &TokenPoolInfo) : u64 {
        arg0.last_price_refresh_timestamp
    }

    public fun tpi_liquidity_amount(arg0: &TokenPoolInfo) : u64 {
        arg0.liquidity_amount
    }

    public fun tpi_mint_fee_bps(arg0: &TokenPoolInfo) : u64 {
        arg0.mint_fee_bps
    }

    public fun tpi_reserved_amount(arg0: &TokenPoolInfo) : u64 {
        arg0.reserved_amount
    }

    public fun tpi_target_weight_bps(arg0: &TokenPoolInfo) : u64 {
        arg0.target_weight_bps
    }

    public fun tpi_ticker(arg0: &TokenPoolInfo) : 0x1::string::String {
        arg0.ticker
    }

    public fun tpi_token_decimal(arg0: &TokenPoolInfo) : u8 {
        arg0.token_decimal
    }

    public fun tpi_token_type(arg0: &TokenPoolInfo) : 0x1::type_name::TypeName {
        arg0.token_type
    }

    public fun tpi_value_usd(arg0: &TokenPoolInfo) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.value_usd
    }

    public(friend) fun tvl_usd<T0>(arg0: &WlpPool<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.tvl_usd
    }

    public fun update_borrow_rates<T0>(arg0: &mut WlpPool<T0>, arg1: &0x2::clock::Clock) {
        assert_version<T0>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<TokenPoolInfo>(&arg0.token_pools)) {
            let v2 = 0x1::vector::borrow_mut<TokenPoolInfo>(&mut arg0.token_pools, v1);
            let v3 = v2.borrow_interval_ms;
            if (v3 > 0 && v0 > v2.last_borrow_timestamp) {
                let v4 = if (v2.liquidity_amount > 0) {
                    0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_fraction(v2.reserved_amount, v2.liquidity_amount), 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::bp_scale()))
                } else {
                    0
                };
                let v5 = calculate_borrow_rate(v4, v2.basic_borrow_rate_0, v2.basic_borrow_rate_1, v2.basic_borrow_rate_2, v2.utilization_threshold_0_bps, v2.utilization_threshold_1_bps);
                let v6 = calculate_borrow_rate_accrual(v5, v0 - v2.last_borrow_timestamp, v3);
                if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gt(v6, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
                    v2.cumulative_borrow_rate = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v2.cumulative_borrow_rate, v6);
                    v2.last_borrow_timestamp = v0;
                    0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::events::emit_borrow_rate_updated(v2.token_type, v5, v2.cumulative_borrow_rate, v4);
                } else if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(v5, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
                    v2.last_borrow_timestamp = v0;
                };
            };
            v1 = v1 + 1;
        };
    }

    public fun update_token_pool_config<T0, T1>(arg0: &mut WlpPool<T0>, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: u128, arg10: u64, arg11: u64, arg12: u64, arg13: u64) {
        assert_version<T0>(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(arg7);
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(arg8);
        let v2 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(arg9);
        assert_valid_borrow_config(v0, v1, v2, arg12);
        assert_valid_max_reserve_ratio(arg13);
        let v3 = 0x1::type_name::with_defining_ids<T1>();
        let v4 = borrow_mut_token_pool<T0>(arg0, &v3);
        v4.target_weight_bps = arg2;
        v4.mint_fee_bps = arg3;
        v4.burn_fee_bps = arg4;
        v4.max_capacity = arg5;
        v4.min_deposit = arg6;
        v4.basic_borrow_rate_0 = v0;
        v4.basic_borrow_rate_1 = v1;
        v4.basic_borrow_rate_2 = v2;
        v4.utilization_threshold_0_bps = arg10;
        v4.utilization_threshold_1_bps = arg11;
        v4.borrow_interval_ms = arg12;
        v4.max_reserve_ratio_bps = arg13;
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::events::emit_token_pool_info_updated(v3, v4.token_decimal, arg2, arg3, arg4, arg5, arg6, v0, v1, v2, arg10, arg11, arg12, arg13);
    }

    public fun update_token_value<T0, T1>(arg0: &mut WlpPool<T0>, arg1: &0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::Oracle, arg2: &0x2::clock::Clock) {
        assert_version<T0>(arg0);
        let v0 = 0xd6fd5fa8be2f2cb3042fbb11f31f26c27280676f6a08681b16cbb5e4cb64f24e::oracle::get_price(arg1, token_ticker<T0, T1>(arg0), arg2);
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            abort 13906838018341077023
        };
        refresh_token_value_with_price<T0, T1>(arg0, v0, 0x2::clock::timestamp_ms(arg2));
    }

    // decompiled from Move bytecode v7
}

