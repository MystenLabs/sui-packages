module 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::lp_pool {
    struct WlpPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        is_active: bool,
        allowed_versions: 0x2::vec_set::VecSet<u16>,
        lp_treasury_cap: 0x2::coin::TreasuryCap<T0>,
        lp_decimal: u8,
        token_types: vector<0x1::type_name::TypeName>,
        token_pools: vector<TokenPoolInfo>,
        tvl_usd: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        redeem_requests: 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::KeyedBigVector,
        next_redeem_id: u64,
    }

    struct TokenPoolInfo has copy, drop, store {
        token_type: 0x1::type_name::TypeName,
        token_decimal: u8,
        target_weight_bps: u64,
        mint_fee_bps: u64,
        burn_fee_bps: u64,
        max_capacity: u64,
        min_deposit: u64,
        basic_borrow_rate_0: u64,
        basic_borrow_rate_1: u64,
        basic_borrow_rate_2: u64,
        utilization_threshold_0_bps: u64,
        utilization_threshold_1_bps: u64,
        borrow_interval_ms: u64,
        max_reserve_ratio_bps: u64,
        liquidity_amount: u64,
        value_usd: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        reserved_amount: u64,
        last_borrow_timestamp: u64,
        cumulative_borrow_rate: u64,
        last_price_refresh_timestamp: u64,
    }

    struct RedeemRequest<phantom T0> has store {
        recipient: address,
        lp_balance: 0x2::balance::Balance<T0>,
        token_type: 0x1::type_name::TypeName,
        request_timestamp: u64,
    }

    public fun assert_version<T0>(arg0: &WlpPool<T0>) {
        let v0 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::version::package_version();
        if (!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &v0)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_invalid_version();
        };
    }

    public fun add_token<T0, T1>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut WlpPool<T0>, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg1.token_types)) {
            if (*0x1::vector::borrow<0x1::type_name::TypeName>(&arg1.token_types, v1) == v0) {
                0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_token_already_supported();
            };
            v1 = v1 + 1;
        };
        assert_valid_borrow_config(arg8, arg9, arg10, arg13);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.token_types, v0);
        let v2 = TokenPoolInfo{
            token_type                   : v0,
            token_decimal                : arg2,
            target_weight_bps            : arg3,
            mint_fee_bps                 : arg4,
            burn_fee_bps                 : arg5,
            max_capacity                 : arg6,
            min_deposit                  : arg7,
            basic_borrow_rate_0          : arg8,
            basic_borrow_rate_1          : arg9,
            basic_borrow_rate_2          : arg10,
            utilization_threshold_0_bps  : arg11,
            utilization_threshold_1_bps  : arg12,
            borrow_interval_ms           : arg13,
            max_reserve_ratio_bps        : arg14,
            liquidity_amount             : 0,
            value_usd                    : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero(),
            reserved_amount              : 0,
            last_borrow_timestamp        : 0x2::clock::timestamp_ms(arg15),
            cumulative_borrow_rate       : 0,
            last_price_refresh_timestamp : 0x2::clock::timestamp_ms(arg15),
        };
        0x1::vector::push_back<TokenPoolInfo>(&mut arg1.token_pools, v2);
    }

    public fun allow_version<T0>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut WlpPool<T0>, arg2: u16) {
        if (!0x2::vec_set::contains<u16>(&arg1.allowed_versions, &arg2)) {
            0x2::vec_set::insert<u16>(&mut arg1.allowed_versions, arg2);
        };
    }

    fun assert_prices_fresh<T0>(arg0: &WlpPool<T0>, arg1: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config::GlobalConfig, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<TokenPoolInfo>(&arg0.token_pools)) {
            let v2 = 0x1::vector::borrow<TokenPoolInfo>(&arg0.token_pools, v1).last_price_refresh_timestamp;
            if (v0 < v2) {
                0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_stale_price();
            };
            if (v0 - v2 > 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config::price_refresh_threshold_ms(arg1)) {
                0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_stale_price();
            };
            v1 = v1 + 1;
        };
    }

    fun assert_redeem_allowed<T0>(arg0: &WlpPool<T0>) {
        if (calculate_total_wlp_utilization_bps<T0>(arg0) > 8000) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_redeem_blocked_by_utilization();
        };
    }

    fun assert_valid_borrow_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        if (arg3 == 0) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_invalid_config();
        };
        if (arg1 < arg0 || arg2 < arg1) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_invalid_config();
        };
    }

    fun borrow_mut_token_pool<T0>(arg0: &mut WlpPool<T0>, arg1: &0x1::type_name::TypeName) : &mut TokenPoolInfo {
        0x1::vector::borrow_mut<TokenPoolInfo>(&mut arg0.token_pools, find_token_pool_index<T0>(arg0, arg1))
    }

    public(friend) fun borrow_redeem_requests<T0>(arg0: &WlpPool<T0>) : &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::KeyedBigVector {
        &arg0.redeem_requests
    }

    fun borrow_token_pool<T0>(arg0: &WlpPool<T0>, arg1: &0x1::type_name::TypeName) : &TokenPoolInfo {
        0x1::vector::borrow<TokenPoolInfo>(&arg0.token_pools, find_token_pool_index<T0>(arg0, arg1))
    }

    public(friend) fun borrow_token_pool_by_index<T0>(arg0: &WlpPool<T0>, arg1: u64) : &TokenPoolInfo {
        0x1::vector::borrow<TokenPoolInfo>(&arg0.token_pools, arg1)
    }

    fun calculate_borrow_rate(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        if (arg0 <= arg4) {
            arg1
        } else if (arg0 <= arg5) {
            if (arg5 == arg4) {
                arg2
            } else {
                arg1 + ((((arg2 - arg1) as u128) * ((arg0 - arg4) as u128) / ((arg5 - arg4) as u128)) as u64)
            }
        } else {
            let v1 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::math::bp_scale() - arg5;
            if (v1 == 0) {
                arg3
            } else {
                arg2 + ((((arg3 - arg2) as u128) * ((arg0 - arg5) as u128) / (v1 as u128)) as u64)
            }
        }
    }

    fun calculate_borrow_rate_accrual(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return 0
        };
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
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
        let v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(arg1, arg3), 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::math::bp_scale());
        let v2 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::diff(arg0, v1);
        let (v3, v4) = if (arg5) {
            (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(arg0, arg2), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(arg1, arg2))
        } else {
            (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::saturating_sub(arg0, arg2), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::saturating_sub(arg1, arg2))
        };
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(v4, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            return arg4
        };
        let v5 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(v4, arg3), 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::math::bp_scale());
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
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div(v0, arg0.tvl_usd), 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::math::bp_scale()))
    }

    public fun cancel_redeem<T0>(arg0: &mut WlpPool<T0>, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<u64>(&arg0.redeem_requests, arg2)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_no_redeem_request();
        };
        let v0 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::swap_remove_by_key<u64, RedeemRequest<T0>>(&mut arg0.redeem_requests, arg2);
        if (v0.recipient != 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_unauthorized();
        };
        let RedeemRequest {
            recipient         : v1,
            lp_balance        : v2,
            token_type        : v3,
            request_timestamp : _,
        } = v0;
        let v5 = v2;
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::events::emit_wlp_redeem_cancelled(v1, 0x1::type_name::with_defining_ids<T0>(), v3, arg2, 0x2::balance::value<T0>(&v5), 0x2::clock::timestamp_ms(arg3));
        0x2::coin::from_balance<T0>(v5, arg4)
    }

    public fun cancel_redeem_and_transfer<T0>(arg0: &mut WlpPool<T0>, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(cancel_redeem<T0>(arg0, arg1, arg2, arg3, arg4), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1));
    }

    public(friend) fun check_oi_cap<T0>(arg0: &WlpPool<T0>, arg1: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config::GlobalConfig, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        let v0 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config::oi_cap_bps(arg1);
        if (v0 == 0) {
            return
        };
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gt(arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(tvl_usd<T0>(arg0), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(v0)))) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_exceed_oi_cap();
        };
    }

    public(friend) fun check_reserve_valid<T0>(arg0: &WlpPool<T0>, arg1: 0x1::type_name::TypeName, arg2: u64) : bool {
        let v0 = borrow_token_pool<T0>(arg0, &arg1);
        v0.reserved_amount + arg2 <= 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(v0.max_reserve_ratio_bps), v0.liquidity_amount))
    }

    public fun create_pool<T0>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: 0x2::coin::TreasuryCap<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : WlpPool<T0> {
        WlpPool<T0>{
            id               : 0x2::object::new(arg3),
            is_active        : true,
            allowed_versions : 0x2::vec_set::singleton<u16>(0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::version::package_version()),
            lp_treasury_cap  : arg1,
            lp_decimal       : arg2,
            token_types      : 0x1::vector::empty<0x1::type_name::TypeName>(),
            token_pools      : 0x1::vector::empty<TokenPoolInfo>(),
            tvl_usd          : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero(),
            redeem_requests  : 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::new<u64, RedeemRequest<T0>>(256, arg3),
            next_redeem_id   : 0,
        }
    }

    public(friend) fun cumulative_borrow_rate<T0>(arg0: &WlpPool<T0>, arg1: 0x1::type_name::TypeName) : u64 {
        borrow_token_pool<T0>(arg0, &arg1).cumulative_borrow_rate
    }

    public(friend) fun decrease_reserve<T0>(arg0: &mut WlpPool<T0>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = borrow_mut_token_pool<T0>(arg0, &arg1);
        v0.reserved_amount = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::math::saturating_sub(v0.reserved_amount, arg2);
    }

    public fun disallow_version<T0>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut WlpPool<T0>, arg2: u16) {
        if (0x2::vec_set::contains<u16>(&arg1.allowed_versions, &arg2)) {
            0x2::vec_set::remove<u16>(&mut arg1.allowed_versions, &arg2);
        };
    }

    fun find_token_pool_index<T0>(arg0: &WlpPool<T0>, arg1: &0x1::type_name::TypeName) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TokenPoolInfo>(&arg0.token_pools)) {
            if (&0x1::vector::borrow<TokenPoolInfo>(&arg0.token_pools, v0).token_type == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_token_not_supported();
        0
    }

    public(friend) fun increase_reserve<T0>(arg0: &mut WlpPool<T0>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = borrow_mut_token_pool<T0>(arg0, &arg1);
        v0.reserved_amount = v0.reserved_amount + arg2;
    }

    public(friend) fun is_active<T0>(arg0: &WlpPool<T0>) : bool {
        arg0.is_active
    }

    public(friend) fun lp_decimal<T0>(arg0: &WlpPool<T0>) : u8 {
        arg0.lp_decimal
    }

    public fun mint_wlp<T0, T1>(arg0: &mut WlpPool<T0>, arg1: &mut 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config::GlobalConfig, arg2: 0x2::coin::Coin<T1>, arg3: &0xe23120dae1a64fb48f38f1fc9a6e9ab4dd5b8bc9e6c54b5bf02286e3fc622faa::result::PriceResult<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config::assert_version(arg1);
        if (!arg0.is_active) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_pool_not_active();
        };
        assert_prices_fresh<T0>(arg0, arg1, arg5);
        let v0 = 0xe23120dae1a64fb48f38f1fc9a6e9ab4dd5b8bc9e6c54b5bf02286e3fc622faa::result::aggregated_price<T1>(arg3);
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_zero_price();
        };
        update_borrow_rates<T0>(arg0, arg5);
        refresh_token_value_with_price<T0, T1>(arg0, v0, 0x2::clock::timestamp_ms(arg5));
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x2::coin::value<T1>(&arg2);
        let v3 = borrow_token_pool<T0>(arg0, &v1);
        if (v2 < v3.min_deposit) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_insufficient_deposit();
        };
        if (v3.liquidity_amount + v2 > v3.max_capacity) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_exceed_capacity();
        };
        let v4 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::math::amount_to_usd(v2, v3.token_decimal, v0);
        let v5 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::ceil(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(calculate_dynamic_fee(v3.value_usd, arg0.tvl_usd, v4, v3.target_weight_bps, v3.mint_fee_bps, true)), v2));
        let v6 = if (0x2::coin::total_supply<T0>(&arg0.lp_treasury_cap) == 0 || 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg0.tvl_usd, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::math::amount_to_usd(v2 - v5, v3.token_decimal, v0), 0x1::u64::pow(10, arg0.lp_decimal)))
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::math::amount_to_usd(v2 - v5, v3.token_decimal, v0), 0x2::coin::total_supply<T0>(&arg0.lp_treasury_cap)), arg0.tvl_usd))
        };
        if (v6 < arg4) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_slippage_exceeded();
        };
        let v7 = borrow_mut_token_pool<T0>(arg0, &v1);
        v7.liquidity_amount = v7.liquidity_amount + v2;
        v7.value_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v7.value_usd, v4);
        arg0.tvl_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(arg0.tvl_usd, v4);
        0x2::balance::join<T1>(0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config::balance_mut<T1>(arg1), 0x2::coin::into_balance<T1>(arg2));
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::events::emit_wlp_minted(0x1::type_name::with_defining_ids<T0>(), v1, v2, v6, v5, 0x2::clock::timestamp_ms(arg5));
        0x2::coin::mint<T0>(&mut arg0.lp_treasury_cap, v6, arg6)
    }

    public fun mint_wlp_to<T0, T1>(arg0: &mut WlpPool<T0>, arg1: &mut 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config::GlobalConfig, arg2: 0x2::coin::Coin<T1>, arg3: &0xe23120dae1a64fb48f38f1fc9a6e9ab4dd5b8bc9e6c54b5bf02286e3fc622faa::result::PriceResult<T1>, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(mint_wlp<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6, arg7), arg5);
    }

    public(friend) fun pool_tvl_usd<T0>(arg0: &WlpPool<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.tvl_usd
    }

    public(friend) fun put_collateral<T0, T1>(arg0: &mut WlpPool<T0>, arg1: &mut 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config::GlobalConfig, arg2: 0x2::balance::Balance<T1>, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        let v0 = 0x2::balance::value<T1>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return
        };
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = borrow_mut_token_pool<T0>(arg0, &v1);
        v2.liquidity_amount = v2.liquidity_amount + v0;
        let v3 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::math::amount_to_usd(v0, v2.token_decimal, arg3);
        v2.value_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v2.value_usd, v3);
        arg0.tvl_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(arg0.tvl_usd, v3);
        0x2::balance::join<T1>(0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config::balance_mut<T1>(arg1), arg2);
    }

    public(friend) fun redeem_lp_amount<T0>(arg0: &RedeemRequest<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.lp_balance)
    }

    public(friend) fun redeem_recipient<T0>(arg0: &RedeemRequest<T0>) : address {
        arg0.recipient
    }

    public(friend) fun redeem_request_timestamp<T0>(arg0: &RedeemRequest<T0>) : u64 {
        arg0.request_timestamp
    }

    public(friend) fun redeem_token_type<T0>(arg0: &RedeemRequest<T0>) : 0x1::type_name::TypeName {
        arg0.token_type
    }

    fun refresh_token_value_with_price<T0, T1>(arg0: &mut WlpPool<T0>, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = find_token_pool_index<T0>(arg0, &v0);
        let v2 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::math::amount_to_usd(0x1::vector::borrow<TokenPoolInfo>(&arg0.token_pools, v1).liquidity_amount, 0x1::vector::borrow<TokenPoolInfo>(&arg0.token_pools, v1).token_decimal, arg1);
        0x1::vector::borrow_mut<TokenPoolInfo>(&mut arg0.token_pools, v1).value_usd = v2;
        0x1::vector::borrow_mut<TokenPoolInfo>(&mut arg0.token_pools, v1).last_price_refresh_timestamp = arg2;
        arg0.tvl_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::saturating_sub(arg0.tvl_usd, 0x1::vector::borrow<TokenPoolInfo>(&arg0.token_pools, v1).value_usd), v2);
    }

    public(friend) fun request_collateral<T0, T1>(arg0: &mut WlpPool<T0>, arg1: &mut 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config::GlobalConfig, arg2: u64, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : 0x2::balance::Balance<T1> {
        if (arg2 == 0) {
            return 0x2::balance::zero<T1>()
        };
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = borrow_mut_token_pool<T0>(arg0, &v0);
        if (arg2 > v1.liquidity_amount) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_insufficient_liquidity();
        };
        v1.liquidity_amount = v1.liquidity_amount - arg2;
        let v2 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::math::amount_to_usd(arg2, v1.token_decimal, arg3);
        v1.value_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::saturating_sub(v1.value_usd, v2);
        arg0.tvl_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::saturating_sub(arg0.tvl_usd, v2);
        0x2::balance::split<T1>(0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config::balance_mut<T1>(arg1), arg2)
    }

    public fun request_redeem<T0, T1>(arg0: &mut WlpPool<T0>, arg1: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: address) : u64 {
        assert_version<T0>(arg0);
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config::assert_version(arg1);
        if (!arg0.is_active) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_pool_not_active();
        };
        assert_prices_fresh<T0>(arg0, arg1, arg3);
        assert_redeem_allowed<T0>(arg0);
        let v0 = arg0.next_redeem_id;
        arg0.next_redeem_id = v0 + 1;
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = RedeemRequest<T0>{
            recipient         : arg4,
            lp_balance        : 0x2::coin::into_balance<T0>(arg2),
            token_type        : v1,
            request_timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::push_back<u64, RedeemRequest<T0>>(&mut arg0.redeem_requests, v0, v2);
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::events::emit_wlp_redeem_requested(arg4, 0x1::type_name::with_defining_ids<T0>(), v1, 0x2::coin::value<T0>(&arg2), v0, 0x2::clock::timestamp_ms(arg3));
        v0
    }

    public fun resume_pool<T0>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut WlpPool<T0>) {
        arg1.is_active = true;
    }

    public fun settle_redeem<T0, T1>(arg0: &mut WlpPool<T0>, arg1: &mut 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config::GlobalConfig, arg2: u64, arg3: &0xe23120dae1a64fb48f38f1fc9a6e9ab4dd5b8bc9e6c54b5bf02286e3fc622faa::result::PriceResult<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config::assert_version(arg1);
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<u64>(&arg0.redeem_requests, arg2)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_no_redeem_request();
        };
        let v0 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::swap_remove_by_key<u64, RedeemRequest<T0>>(&mut arg0.redeem_requests, arg2);
        if (0x2::clock::timestamp_ms(arg4) < v0.request_timestamp + 86400000) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_redeem_not_ready();
        };
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        if (v0.token_type != v1) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_token_not_supported();
        };
        let v2 = 0xe23120dae1a64fb48f38f1fc9a6e9ab4dd5b8bc9e6c54b5bf02286e3fc622faa::result::aggregated_price<T1>(arg3);
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(v2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_zero_price();
        };
        assert_prices_fresh<T0>(arg0, arg1, arg4);
        update_borrow_rates<T0>(arg0, arg4);
        refresh_token_value_with_price<T0, T1>(arg0, v2, 0x2::clock::timestamp_ms(arg4));
        assert_redeem_allowed<T0>(arg0);
        let v3 = borrow_token_pool<T0>(arg0, &v1);
        let v4 = if (0x2::coin::total_supply<T0>(&arg0.lp_treasury_cap) > 0) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(arg0.tvl_usd, 0x2::balance::value<T0>(&v0.lp_balance)), 0x2::coin::total_supply<T0>(&arg0.lp_treasury_cap))
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero()
        };
        let v5 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::math::usd_to_amount(v4, v3.token_decimal, v2);
        let v6 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::ceil(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(calculate_dynamic_fee(v3.value_usd, arg0.tvl_usd, v4, v3.target_weight_bps, v3.burn_fee_bps, false)), v5));
        let v7 = v5 - v6;
        if (v3.liquidity_amount < v3.reserved_amount + v7) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_insufficient_free_liquidity();
        };
        let RedeemRequest {
            recipient         : v8,
            lp_balance        : v9,
            token_type        : _,
            request_timestamp : _,
        } = v0;
        0x2::coin::burn<T0>(&mut arg0.lp_treasury_cap, 0x2::coin::from_balance<T0>(v9, arg5));
        let v12 = borrow_mut_token_pool<T0>(arg0, &v1);
        if (v12.liquidity_amount < v7) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_insufficient_liquidity();
        };
        v12.liquidity_amount = v12.liquidity_amount - v7;
        let v13 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::math::amount_to_usd(v12.liquidity_amount, v12.token_decimal, v2);
        v12.value_usd = v13;
        arg0.tvl_usd = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::saturating_sub(arg0.tvl_usd, v12.value_usd), v13);
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::events::emit_wlp_redeem_settled(v8, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), arg2, v7, v6, 0x2::clock::timestamp_ms(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::global_config::balance_mut<T1>(arg1), v7), arg5), v8);
    }

    public fun suspend_pool<T0>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut WlpPool<T0>) {
        arg1.is_active = false;
    }

    public(friend) fun token_count<T0>(arg0: &WlpPool<T0>) : u64 {
        0x1::vector::length<TokenPoolInfo>(&arg0.token_pools)
    }

    public(friend) fun token_decimal<T0>(arg0: &WlpPool<T0>, arg1: 0x1::type_name::TypeName) : u8 {
        borrow_token_pool<T0>(arg0, &arg1).token_decimal
    }

    public(friend) fun token_pool_info<T0>(arg0: &WlpPool<T0>, arg1: 0x1::type_name::TypeName) : TokenPoolInfo {
        *borrow_token_pool<T0>(arg0, &arg1)
    }

    public(friend) fun total_lp_supply<T0>(arg0: &WlpPool<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.lp_treasury_cap)
    }

    public(friend) fun tpi_burn_fee_bps(arg0: &TokenPoolInfo) : u64 {
        arg0.burn_fee_bps
    }

    public(friend) fun tpi_cumulative_borrow_rate(arg0: &TokenPoolInfo) : u64 {
        arg0.cumulative_borrow_rate
    }

    public(friend) fun tpi_last_price_refresh_timestamp(arg0: &TokenPoolInfo) : u64 {
        arg0.last_price_refresh_timestamp
    }

    public(friend) fun tpi_liquidity_amount(arg0: &TokenPoolInfo) : u64 {
        arg0.liquidity_amount
    }

    public(friend) fun tpi_mint_fee_bps(arg0: &TokenPoolInfo) : u64 {
        arg0.mint_fee_bps
    }

    public(friend) fun tpi_reserved_amount(arg0: &TokenPoolInfo) : u64 {
        arg0.reserved_amount
    }

    public(friend) fun tpi_target_weight_bps(arg0: &TokenPoolInfo) : u64 {
        arg0.target_weight_bps
    }

    public(friend) fun tpi_token_decimal(arg0: &TokenPoolInfo) : u8 {
        arg0.token_decimal
    }

    public(friend) fun tpi_token_type(arg0: &TokenPoolInfo) : 0x1::type_name::TypeName {
        arg0.token_type
    }

    public(friend) fun tpi_value_usd(arg0: &TokenPoolInfo) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
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
                    0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_fraction(v2.reserved_amount, v2.liquidity_amount), 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::math::bp_scale()))
                } else {
                    0
                };
                let v5 = calculate_borrow_rate(v4, v2.basic_borrow_rate_0, v2.basic_borrow_rate_1, v2.basic_borrow_rate_2, v2.utilization_threshold_0_bps, v2.utilization_threshold_1_bps);
                let v6 = calculate_borrow_rate_accrual(v5, v0 - v2.last_borrow_timestamp, v3);
                v2.cumulative_borrow_rate = v2.cumulative_borrow_rate + v6;
                v2.last_borrow_timestamp = v0;
                if (v6 > 0) {
                    0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::events::emit_borrow_rate_updated(v2.token_type, v5, v2.cumulative_borrow_rate, v4, v0);
                };
            };
            v1 = v1 + 1;
        };
    }

    public fun update_token_pool_config<T0, T1>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut WlpPool<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64) {
        assert_valid_borrow_config(arg7, arg8, arg9, arg12);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = borrow_mut_token_pool<T0>(arg1, &v0);
        v1.target_weight_bps = arg2;
        v1.mint_fee_bps = arg3;
        v1.burn_fee_bps = arg4;
        v1.max_capacity = arg5;
        v1.min_deposit = arg6;
        v1.basic_borrow_rate_0 = arg7;
        v1.basic_borrow_rate_1 = arg8;
        v1.basic_borrow_rate_2 = arg9;
        v1.utilization_threshold_0_bps = arg10;
        v1.utilization_threshold_1_bps = arg11;
        v1.borrow_interval_ms = arg12;
        v1.max_reserve_ratio_bps = arg13;
    }

    public fun update_token_value<T0, T1>(arg0: &mut WlpPool<T0>, arg1: &0xe23120dae1a64fb48f38f1fc9a6e9ab4dd5b8bc9e6c54b5bf02286e3fc622faa::result::PriceResult<T1>, arg2: &0x2::clock::Clock) {
        assert_version<T0>(arg0);
        let v0 = 0xe23120dae1a64fb48f38f1fc9a6e9ab4dd5b8bc9e6c54b5bf02286e3fc622faa::result::aggregated_price<T1>(arg1);
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_zero_price();
        };
        refresh_token_value_with_price<T0, T1>(arg0, v0, 0x2::clock::timestamp_ms(arg2));
    }

    // decompiled from Move bytecode v7
}

