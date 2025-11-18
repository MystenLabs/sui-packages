module 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool {
    struct LPPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        shares: u64,
        paid_rps: 0x2::table::Table<0x1::ascii::String, u128>,
        claimable_rewards: 0x2::table::Table<0x1::ascii::String, u64>,
    }

    struct ProtocolFeeClaimCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        config_cap: 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::admin::GlobalConfigCap,
        max_quote_assets_per_pool: u64,
        max_swap_fee_pct: u64,
        max_lp_withdrawal_fee_pct: u64,
        max_lp_fee_share: u64,
        max_dynamic_fee: u64,
        is_protocol_paused: bool,
        total_pools_created: u64,
        version: u64,
        bag: 0x2::bag::Bag,
    }

    struct LiquidityPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        base_reserve: 0x2::balance::Balance<T0>,
        min_base_out: u64,
        total_lp_shares: u64,
        swap_fee_pct: u64,
        lp_withdrawal_fee_pct: u64,
        lp_fee_pct: u64,
        max_dynamic_fee: u64,
        limit_ratio: u64,
        admin: address,
        is_permissioned: bool,
        whitelisted_lps: vector<address>,
        is_paused: bool,
        supported_assets: vector<0x1::ascii::String>,
        reward_rps: 0x2::table::Table<0x1::ascii::String, u128>,
        protocol_base_fees: 0x2::balance::Balance<T0>,
        version: u64,
        bag: 0x2::bag::Bag,
    }

    struct QuoteAssetReserve<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        collected_rewards: 0x2::balance::Balance<T0>,
        ideal_reserve_pct: u64,
        max_reserve_pct: u64,
        ideal_reserve_calc: u128,
        fee_base: u64,
        fee_max: u64,
        min_out: u64,
        limit_ratio: 0x1::option::Option<u64>,
        limit_fixed: 0x1::option::Option<u64>,
        is_trading: bool,
    }

    struct MarketPausedEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        reason: 0x1::string::String,
    }

    struct MarketUnpausedEvent<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct GlobalConfigCreated has copy, drop {
        global_config_id: 0x2::object::ID,
    }

    struct GlobalConfigUpdated has copy, drop {
        global_config_id: 0x2::object::ID,
        updated_by: address,
    }

    struct ProtocolPausedUpdated has copy, drop {
        global_config_id: 0x2::object::ID,
        is_paused: bool,
        updated_by: address,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        base_asset: 0x1::type_name::TypeName,
        admin: address,
        created_via_global_config: bool,
    }

    struct PoolConfigUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        new_swap_fee_pct: 0x1::option::Option<u64>,
        new_lp_withdrawal_fee_pct: 0x1::option::Option<u64>,
        new_lp_fee: 0x1::option::Option<u64>,
        new_max_dynamic_fee_bps: 0x1::option::Option<u64>,
        new_limit_ratio_bps: 0x1::option::Option<u64>,
        updated_by: address,
    }

    struct LPWhitelisted<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        lp_addresses: vector<address>,
    }

    struct LpRemovedFromWhitelist<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        lp_addresses: vector<address>,
    }

    struct PoolPermissionUpdated<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        is_permissioned: bool,
    }

    struct LiquidityAdded<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        provider: address,
        base_amount: u64,
        lp_shares_minted: u64,
        total_lp_shares: u64,
        is_new_lp: bool,
    }

    struct LiquidityRemoved<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        provider: address,
        base_amount: u64,
        lp_shares_burned: u64,
        total_lp_shares: u64,
    }

    struct RewardsClaimed<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        provider: address,
        reward_asset: 0x1::ascii::String,
        claimed_amount: u64,
    }

    struct SwapExecuted<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        trader: address,
        amount_in: u64,
        amount_out: u64,
        is_buy: bool,
        dynamic_fee_pct: u64,
        ideal_quote_amt: u128,
        total_fee_pct: u64,
        swap_fee: u64,
        lp_fee: u64,
        protocol_fee: u64,
        price_used: u128,
    }

    struct PriceUpdated has copy, drop {
        dummy_field: bool,
    }

    struct AdminUpdated<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        old_admin: address,
        new_admin: address,
    }

    struct ClaimableRewardsInfo has copy, drop {
        asset: 0x1::ascii::String,
        amount: u64,
        reward_rps: u128,
        paid_rps: u128,
    }

    struct WithdrawSharesSimulationResult has copy, drop {
        shares_burn: u64,
        base_out_gross: u64,
        base_fee: u64,
        total_base_fees: u64,
        base_out: u64,
        total_lp_shares: u64,
        net_base_added: u64,
    }

    struct SwapSimulationResult has copy, drop {
        base_out: u64,
        quote_out: u64,
        swap_fee_pct: u64,
        dynamic_fee_pct: u64,
        ideal_quote_amt: u128,
        swap_fee: u64,
        lp_fee: u64,
        protocol_fee: u64,
        price_used: u128,
    }

    struct GlobalConfigInfo has copy, drop {
        total_pools_created: u64,
        max_quote_assets_per_pool: u64,
    }

    struct GlobalFeeInfo has copy, drop {
        max_swap_fee_pct: u64,
        max_lp_withdrawal_fee_pct: u64,
        max_lp_fee_share: u64,
        max_dynamic_fee: u64,
    }

    struct PoolDetailedInfo<phantom T0> has drop {
        base_asset: 0x1::ascii::String,
        info: PoolInfo,
        config: PoolConfig,
        supported_quotes: vector<0x1::ascii::String>,
        reward_rps: vector<RewardRPSEntry>,
        is_paused: bool,
        admin: address,
        limit_ratio: u64,
        is_permissioned: bool,
    }

    struct RewardRPSEntry has copy, drop {
        asset: 0x1::ascii::String,
        rps: u128,
    }

    struct PaidRPSEntry has copy, drop {
        asset: 0x1::ascii::String,
        rps: u128,
    }

    struct PoolInfo has copy, drop {
        id: 0x2::object::ID,
        base_liquidity: u64,
        net_base_added: u64,
        total_lp_shares: u64,
        protocol_base_fees: u64,
        admin: address,
        is_paused: bool,
    }

    struct PoolConfig has copy, drop {
        swap_fee_pct: u64,
        lp_withdrawal_fee_pct: u64,
        lp_fee_pct: u64,
        max_dynamic_fee: u64,
        limit_ratio: u64,
        min_base_out: u64,
    }

    struct SupportedAssetsInfo has copy, drop {
        base_asset: 0x1::ascii::String,
        supported_quotes: vector<0x1::ascii::String>,
    }

    struct WithdrawableBaseByLp has copy, drop {
        withdrawable_base: u64,
        withdraw_fee: u64,
        shares_to_burn: u64,
    }

    struct BaseLiquidityInfo<phantom T0> has drop {
        base_reserve: u64,
        total_lp_shares: u64,
    }

    struct LPPositionInfo has copy, drop {
        pool_id: 0x2::object::ID,
        shares: u64,
        claimable_rewards: vector<ClaimableRewardsInfo>,
        paid_rps: vector<PaidRPSEntry>,
    }

    struct ProtocolFeesInfo has copy, drop {
        swap_fee_pct: u64,
        lp_withdrawal_fee_pct: u64,
    }

    struct QuoteAssetInfo has copy, drop {
        asset: 0x1::ascii::String,
        balance: u64,
        ideal_reserve_pct: u64,
        max_reserve_pct: u64,
        fee_base: u64,
        fee_max: u64,
        limit_ratio: 0x1::option::Option<u64>,
        limit_fixed: 0x1::option::Option<u64>,
        min_out: u64,
        is_trading: bool,
    }

    fun get_price<T0, T1>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg1: &0x2::clock::Clock) : (u128, bool) {
        let (v0, v1) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::get_valid_price<T0, T1>(arg0, arg1);
        let v2 = v0;
        let v3 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::price_data_price<T0, T1>(&v2);
        (0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::internal_price::get_price<T0, T1>(&v3), v1)
    }

    public fun add_quote_asset<T0, T1>(arg0: &GlobalConfig, arg1: &mut LiquidityPool<T0>, arg2: &mut 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg10) == arg1.admin, 4002);
        assert!(arg3 <= 10000, 4010);
        assert!(arg4 <= 10000, 4010);
        assert!(arg5 <= 10000, 4010);
        assert!(arg6 <= 10000, 4010);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        if (!0x1::vector::contains<0x1::ascii::String>(&arg1.supported_assets, &v0)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut arg1.supported_assets, v0);
        };
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1.supported_assets) <= arg0.max_quote_assets_per_pool, 4013);
        assert!(0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::check_asset_pair_exists<T0, T1>(arg2) || 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::check_asset_pair_exists<T1, T0>(arg2), 4014);
        if (!0x2::dynamic_field::exists_<0x1::ascii::String>(&arg1.id, v0)) {
            let v1 = if (0x1::option::is_some<u64>(&arg7)) {
                0x1::option::some<u64>(*0x1::option::borrow<u64>(&arg7))
            } else {
                0x1::option::none<u64>()
            };
            let v2 = if (0x1::option::is_some<u64>(&arg8)) {
                0x1::option::some<u64>(*0x1::option::borrow<u64>(&arg8))
            } else {
                0x1::option::none<u64>()
            };
            let v3 = QuoteAssetReserve<T1>{
                balance            : 0x2::balance::zero<T1>(),
                collected_rewards  : 0x2::balance::zero<T1>(),
                ideal_reserve_pct  : arg3,
                max_reserve_pct    : arg4,
                ideal_reserve_calc : 0,
                fee_base           : arg5,
                fee_max            : arg6,
                min_out            : arg9,
                limit_ratio        : v1,
                limit_fixed        : v2,
                is_trading         : true,
            };
            0x2::dynamic_field::add<0x1::ascii::String, QuoteAssetReserve<T1>>(&mut arg1.id, v0, v3);
        };
        if (!0x2::table::contains<0x1::ascii::String, u128>(&arg1.reward_rps, v0)) {
            0x2::table::add<0x1::ascii::String, u128>(&mut arg1.reward_rps, v0, 0);
        };
    }

    public fun add_to_whitelist<T0>(arg0: &mut LiquidityPool<T0>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4002);
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg1);
            if (!0x1::vector::contains<address>(&arg0.whitelisted_lps, &v0)) {
                0x1::vector::push_back<address>(&mut arg0.whitelisted_lps, v0);
            };
        };
        let v1 = LPWhitelisted<T0>{
            pool_id      : 0x2::object::uid_to_inner(&arg0.id),
            lp_addresses : arg1,
        };
        0x2::event::emit<LPWhitelisted<T0>>(v1);
    }

    fun assert_global_config(arg0: &GlobalConfig, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>) {
        assert!(0x1::option::get_with_default<u64>(&arg1, arg0.max_swap_fee_pct) + 0x1::option::get_with_default<u64>(&arg4, arg0.max_dynamic_fee) <= 10000, 4010);
        assert!(0x1::option::get_with_default<u64>(&arg2, arg0.max_lp_withdrawal_fee_pct) <= 10000, 4010);
        assert!(0x1::option::get_with_default<u64>(&arg3, arg0.max_lp_fee_share) <= 9000, 4010);
    }

    fun assert_pool_fees(arg0: &GlobalConfig, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>) {
        assert!(0x1::option::get_with_default<u64>(&arg1, 0) <= arg0.max_swap_fee_pct, 4010);
        assert!(0x1::option::get_with_default<u64>(&arg2, 0) <= arg0.max_lp_withdrawal_fee_pct, 4010);
        assert!(0x1::option::get_with_default<u64>(&arg3, 0) <= arg0.max_lp_fee_share, 4010);
        assert!(0x1::option::get_with_default<u64>(&arg4, 0) <= arg0.max_dynamic_fee, 4010);
        assert!(0x1::option::get_with_default<u64>(&arg5, 0) <= 10000, 4010);
    }

    fun assert_quote_is_trading<T0, T1>(arg0: &LiquidityPool<T0>) {
        assert!(0x2::dynamic_field::borrow<0x1::ascii::String, QuoteAssetReserve<T1>>(&arg0.id, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())).is_trading, 4018);
    }

    public fun calc_claimable_rewards<T0>(arg0: &LiquidityPool<T0>, arg1: &LPPosition<T0>, arg2: u64) : ClaimableRewardsInfo {
        let v0 = *0x1::vector::borrow<0x1::ascii::String>(&arg0.supported_assets, arg2);
        let v1 = *0x2::table::borrow<0x1::ascii::String, u128>(&arg0.reward_rps, v0);
        let v2 = if (0x2::table::contains<0x1::ascii::String, u128>(&arg1.paid_rps, v0)) {
            *0x2::table::borrow<0x1::ascii::String, u128>(&arg1.paid_rps, v0)
        } else {
            0
        };
        let v3 = (0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128(v1 - v2, (arg1.shares as u128), (1000000000000000000 as u128)) as u64);
        let v4 = v3;
        if (0x2::table::contains<0x1::ascii::String, u64>(&arg1.claimable_rewards, v0)) {
            v4 = *0x2::table::borrow<0x1::ascii::String, u64>(&arg1.claimable_rewards, v0) + v3;
        };
        ClaimableRewardsInfo{
            asset      : v0,
            amount     : v4,
            reward_rps : v1,
            paid_rps   : v2,
        }
    }

    fun calc_dynamic_fee<T0, T1>(arg0: &LiquidityPool<T0>, arg1: u64, arg2: u128, arg3: bool) : (u64, u128) {
        let (v0, _) = get_pool_liquidity<T0>(arg0);
        let v2 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128((v0 as u128), 1000000000000000000, arg2);
        let v3 = 0x2::dynamic_field::borrow<0x1::ascii::String, QuoteAssetReserve<T1>>(&arg0.id, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()));
        let v4 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128(v2, (v3.ideal_reserve_pct as u128), 10000);
        let v5 = 0x2::balance::value<T1>(&v3.balance);
        let v6 = if (arg3) {
            assert!(v5 >= arg1, 4000);
            v5 - arg1
        } else {
            assert!(v5 + arg1 <= quote_limit<T0, T1>(arg0, arg2, v3), 4009);
            v5 + arg1
        };
        let v7 = (v6 as u128);
        let v8 = if (v7 <= v4) {
            (0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128((v3.fee_base as u128), v7, v4) as u64)
        } else {
            v3.fee_base + (0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128((v3.fee_max as u128), v7, (0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128(v2, (v3.max_reserve_pct as u128), 10000) as u128)) as u64)
        };
        (v8, v4)
    }

    fun calculate_net_and_fee_amount(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = (0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128((arg0 as u128), ((10000 - arg1) as u128), (10000 as u128)) as u64);
        (v0, arg0 - v0)
    }

    fun calculate_swap_fees<T0>(arg0: &LiquidityPool<T0>, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let v0 = arg1 - (0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128((arg1 as u128), 10000 - ((arg2 + arg0.swap_fee_pct) as u128), 10000) as u64);
        let v1 = (0x1::u128::max(0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128((v0 as u128), (arg0.lp_fee_pct as u128), 10000), 1) as u64);
        let v2 = (0x1::u64::max(v0 - v1, 1) as u64);
        (arg1 - v1 - v2, v2, v1)
    }

    public fun claim_rewards<T0, T1>(arg0: &mut LiquidityPool<T0>, arg1: &mut LPPosition<T0>, arg2: 0x1::option::Option<address>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 4005);
        assert!(0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<T1>(), 4017);
        let v0 = 0x1::option::get_with_default<address>(&arg2, 0x2::tx_context::sender(arg3));
        validate_pool_version<T0>(arg0);
        assert!(arg1.pool_id == 0x2::object::uid_to_inner(&arg0.id), 4012);
        update_claimable_rewards<T0>(arg0, arg1);
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        let v2 = *0x2::table::borrow<0x1::ascii::String, u64>(&arg1.claimable_rewards, v1);
        if (v2 > 0) {
            if (0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()) == v1) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.base_reserve, (v2 as u64)), arg3), v0);
            };
            if (0x2::table::contains<0x1::ascii::String, u64>(&arg1.claimable_rewards, v1)) {
                *0x2::table::borrow_mut<0x1::ascii::String, u64>(&mut arg1.claimable_rewards, v1) = 0;
            } else {
                0x2::table::add<0x1::ascii::String, u64>(&mut arg1.claimable_rewards, v1, 0);
            };
        };
        let v3 = RewardsClaimed<T0, T1>{
            pool_id        : 0x2::object::uid_to_inner(&arg0.id),
            provider       : v0,
            reward_asset   : v1,
            claimed_amount : v2,
        };
        0x2::event::emit<RewardsClaimed<T0, T1>>(v3);
    }

    public fun claimable_rewards_info_inner(arg0: &ClaimableRewardsInfo) : (0x1::ascii::String, u64, u128, u128) {
        (arg0.asset, arg0.amount, arg0.reward_rps, arg0.paid_rps)
    }

    public fun create_pool<T0>(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::admin::ProtocolAdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        assert!(!arg1.is_protocol_paused, 4005);
        assert_pool_fees(arg1, 0x1::option::some<u64>(arg2), 0x1::option::some<u64>(arg3), 0x1::option::some<u64>(arg4), 0x1::option::some<u64>(arg5), 0x1::option::some<u64>(arg6));
        let v2 = LiquidityPool<T0>{
            id                    : 0x2::object::new(arg9),
            base_reserve          : 0x2::balance::zero<T0>(),
            min_base_out          : arg8,
            total_lp_shares       : 0,
            swap_fee_pct          : arg2,
            lp_withdrawal_fee_pct : arg3,
            lp_fee_pct            : arg4,
            max_dynamic_fee       : arg5,
            limit_ratio           : arg6,
            admin                 : v0,
            is_permissioned       : arg7,
            whitelisted_lps       : 0x1::vector::empty<address>(),
            is_paused             : false,
            supported_assets      : 0x1::vector::empty<0x1::ascii::String>(),
            reward_rps            : 0x2::table::new<0x1::ascii::String, u128>(arg9),
            protocol_base_fees    : 0x2::balance::zero<T0>(),
            version               : 1,
            bag                   : 0x2::bag::new(arg9),
        };
        0x2::table::add<0x1::ascii::String, u128>(&mut v2.reward_rps, v1, 0);
        0x1::vector::push_back<0x1::ascii::String>(&mut v2.supported_assets, v1);
        arg1.total_pools_created = arg1.total_pools_created + 1;
        let v3 = PoolCreated{
            pool_id                   : 0x2::object::uid_to_inner(&v2.id),
            base_asset                : 0x1::type_name::with_defining_ids<T0>(),
            admin                     : v0,
            created_via_global_config : true,
        };
        0x2::event::emit<PoolCreated>(v3);
        0x2::transfer::share_object<LiquidityPool<T0>>(v2);
        0x2::object::uid_to_inner(&v2.id)
    }

    public fun deposit_base<T0>(arg0: &mut LiquidityPool<T0>, arg1: &mut LPPosition<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 4005);
        validate_pool_version<T0>(arg0);
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 4001);
        assert!(arg1.pool_id == 0x2::object::uid_to_inner(&arg0.id), 4012);
        update_claimable_rewards<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg4));
        arg1.shares = arg1.shares + internal_deposit_base<T0>(arg0, 0x2::coin::split<T0>(&mut arg2, arg3, arg4), false, arg4);
    }

    public fun get_admin<T0>(arg0: &LiquidityPool<T0>) : address {
        arg0.admin
    }

    public fun get_base_by_lp<T0>(arg0: &LPPosition<T0>) : u64 {
        arg0.shares / 1000
    }

    public fun get_base_liquidity_info<T0>(arg0: &LiquidityPool<T0>) : BaseLiquidityInfo<T0> {
        BaseLiquidityInfo<T0>{
            base_reserve    : 0x2::balance::value<T0>(&arg0.base_reserve),
            total_lp_shares : arg0.total_lp_shares,
        }
    }

    public fun get_base_liquidity_inner<T0>(arg0: &LiquidityPool<T0>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.base_reserve), arg0.total_lp_shares)
    }

    public fun get_basis_points() : u64 {
        10000
    }

    public fun get_claimable_rewards_info<T0>(arg0: &LiquidityPool<T0>, arg1: &LPPosition<T0>) : vector<ClaimableRewardsInfo> {
        let v0 = 0x1::vector::empty<ClaimableRewardsInfo>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg0.supported_assets)) {
            0x1::vector::push_back<ClaimableRewardsInfo>(&mut v0, calc_claimable_rewards<T0>(arg0, arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_global_config_info(arg0: &GlobalConfig) : GlobalConfigInfo {
        GlobalConfigInfo{
            total_pools_created       : arg0.total_pools_created,
            max_quote_assets_per_pool : arg0.max_quote_assets_per_pool,
        }
    }

    public fun get_global_config_inner(arg0: &GlobalConfigInfo) : (u64, u64) {
        (arg0.total_pools_created, arg0.max_quote_assets_per_pool)
    }

    public fun get_global_fee_info(arg0: &GlobalConfig) : GlobalFeeInfo {
        GlobalFeeInfo{
            max_swap_fee_pct          : arg0.max_swap_fee_pct,
            max_lp_withdrawal_fee_pct : arg0.max_lp_withdrawal_fee_pct,
            max_lp_fee_share          : arg0.max_lp_fee_share,
            max_dynamic_fee           : arg0.max_dynamic_fee,
        }
    }

    public fun get_global_fee_inner(arg0: &GlobalFeeInfo) : (u64, u64, u64, u64) {
        (arg0.max_swap_fee_pct, arg0.max_lp_withdrawal_fee_pct, arg0.max_lp_fee_share, arg0.max_dynamic_fee)
    }

    public fun get_initial_lp_multiplier() : u64 {
        1000
    }

    public fun get_lp_position_info<T0>(arg0: &LiquidityPool<T0>, arg1: &LPPosition<T0>) : LPPositionInfo {
        let v0 = 0x1::vector::empty<ClaimableRewardsInfo>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg0.supported_assets)) {
            0x1::vector::push_back<ClaimableRewardsInfo>(&mut v0, calc_claimable_rewards<T0>(arg0, arg1, v1));
            v1 = v1 + 1;
        };
        let v2 = 0x1::vector::empty<PaidRPSEntry>();
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        0x1::vector::append<0x1::ascii::String>(&mut v3, get_supported_quotes<T0>(arg0));
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::ascii::String>(&v3)) {
            let v5 = *0x1::vector::borrow<0x1::ascii::String>(&v3, v4);
            let v6 = if (0x2::table::contains<0x1::ascii::String, u128>(&arg1.paid_rps, v5)) {
                *0x2::table::borrow<0x1::ascii::String, u128>(&arg1.paid_rps, v5)
            } else {
                0
            };
            let v7 = PaidRPSEntry{
                asset : v5,
                rps   : v6,
            };
            0x1::vector::push_back<PaidRPSEntry>(&mut v2, v7);
            v4 = v4 + 1;
        };
        LPPositionInfo{
            pool_id           : arg1.pool_id,
            shares            : arg1.shares,
            claimable_rewards : v0,
            paid_rps          : v2,
        }
    }

    public fun get_max_lp_fee_share() : u64 {
        9000
    }

    public fun get_permissioned<T0>(arg0: &LiquidityPool<T0>) : bool {
        arg0.is_permissioned
    }

    public fun get_pool_config<T0>(arg0: &LiquidityPool<T0>) : PoolConfig {
        PoolConfig{
            swap_fee_pct          : arg0.swap_fee_pct,
            lp_withdrawal_fee_pct : arg0.lp_withdrawal_fee_pct,
            lp_fee_pct            : arg0.lp_fee_pct,
            max_dynamic_fee       : arg0.max_dynamic_fee,
            limit_ratio           : arg0.limit_ratio,
            min_base_out          : arg0.min_base_out,
        }
    }

    public fun get_pool_detailed_info<T0>(arg0: &LiquidityPool<T0>) : PoolDetailedInfo<T0> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v1 = get_supported_quotes<T0>(arg0);
        let v2 = 0x1::vector::empty<RewardRPSEntry>();
        let v3 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v3, v0);
        0x1::vector::append<0x1::ascii::String>(&mut v3, v1);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::ascii::String>(&v3)) {
            let v5 = *0x1::vector::borrow<0x1::ascii::String>(&v3, v4);
            let v6 = if (0x2::table::contains<0x1::ascii::String, u128>(&arg0.reward_rps, v5)) {
                *0x2::table::borrow<0x1::ascii::String, u128>(&arg0.reward_rps, v5)
            } else {
                0
            };
            let v7 = RewardRPSEntry{
                asset : v5,
                rps   : v6,
            };
            0x1::vector::push_back<RewardRPSEntry>(&mut v2, v7);
            v4 = v4 + 1;
        };
        PoolDetailedInfo<T0>{
            base_asset       : v0,
            info             : get_pool_info<T0>(arg0),
            config           : get_pool_config<T0>(arg0),
            supported_quotes : v1,
            reward_rps       : v2,
            is_paused        : arg0.is_paused,
            admin            : arg0.admin,
            limit_ratio      : arg0.limit_ratio,
            is_permissioned  : arg0.is_permissioned,
        }
    }

    public fun get_pool_detailed_info_inner<T0>(arg0: &PoolDetailedInfo<T0>) : (0x1::ascii::String, PoolInfo, PoolConfig, vector<0x1::ascii::String>, vector<RewardRPSEntry>, bool, address, u64, bool) {
        (arg0.base_asset, arg0.info, arg0.config, arg0.supported_quotes, arg0.reward_rps, arg0.is_paused, arg0.admin, arg0.limit_ratio, arg0.is_permissioned)
    }

    public fun get_pool_info<T0>(arg0: &LiquidityPool<T0>) : PoolInfo {
        PoolInfo{
            id                 : 0x2::object::uid_to_inner(&arg0.id),
            base_liquidity     : (0x2::balance::value<T0>(&arg0.base_reserve) as u64),
            net_base_added     : net_base_added<T0>(arg0),
            total_lp_shares    : arg0.total_lp_shares,
            protocol_base_fees : (0x2::balance::value<T0>(&arg0.protocol_base_fees) as u64),
            admin              : arg0.admin,
            is_paused          : arg0.is_paused,
        }
    }

    fun get_pool_liquidity<T0>(arg0: &LiquidityPool<T0>) : (u64, u64) {
        (net_base_added<T0>(arg0), 0x2::balance::value<T0>(&arg0.base_reserve))
    }

    public fun get_precision() : u128 {
        1000000000000000000
    }

    public fun get_protocol_fees_info<T0>(arg0: &LiquidityPool<T0>) : ProtocolFeesInfo {
        ProtocolFeesInfo{
            swap_fee_pct          : arg0.swap_fee_pct,
            lp_withdrawal_fee_pct : arg0.lp_withdrawal_fee_pct,
        }
    }

    public fun get_protocol_fees_inner<T0>(arg0: &LiquidityPool<T0>) : (u64, u64) {
        (arg0.swap_fee_pct, arg0.lp_withdrawal_fee_pct)
    }

    public fun get_quote_asset_info<T0, T1>(arg0: &LiquidityPool<T0>) : QuoteAssetInfo {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        assert!(0x2::dynamic_field::exists_<0x1::ascii::String>(&arg0.id, v0), 4003);
        let v1 = 0x2::dynamic_field::borrow<0x1::ascii::String, QuoteAssetReserve<T1>>(&arg0.id, v0);
        QuoteAssetInfo{
            asset             : v0,
            balance           : 0x2::balance::value<T1>(&v1.balance),
            ideal_reserve_pct : v1.ideal_reserve_pct,
            max_reserve_pct   : v1.max_reserve_pct,
            fee_base          : v1.fee_base,
            fee_max           : v1.fee_max,
            limit_ratio       : v1.limit_ratio,
            limit_fixed       : v1.limit_fixed,
            min_out           : v1.min_out,
            is_trading        : v1.is_trading,
        }
    }

    public fun get_supported_assets_info<T0>(arg0: &LiquidityPool<T0>) : SupportedAssetsInfo {
        SupportedAssetsInfo{
            base_asset       : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            supported_quotes : get_supported_quotes<T0>(arg0),
        }
    }

    public fun get_supported_assets_inner<T0>(arg0: &LiquidityPool<T0>) : (0x1::ascii::String, vector<0x1::ascii::String>) {
        let v0 = get_supported_assets_info<T0>(arg0);
        (v0.base_asset, v0.supported_quotes)
    }

    public fun get_supported_quotes<T0>(arg0: &LiquidityPool<T0>) : vector<0x1::ascii::String> {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg0.supported_assets)) {
            let v2 = *0x1::vector::borrow<0x1::ascii::String>(&arg0.supported_assets, v1);
            if (v2 != 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) {
                0x1::vector::push_back<0x1::ascii::String>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_whitelisted_lps<T0>(arg0: &LiquidityPool<T0>) : vector<address> {
        arg0.whitelisted_lps
    }

    public fun get_withdrawable_base_by_lp<T0>(arg0: &LiquidityPool<T0>, arg1: &LPPosition<T0>) : WithdrawableBaseByLp {
        let v0 = 0x1::u64::min(get_base_by_lp<T0>(arg1), 0x2::balance::value<T0>(&arg0.base_reserve));
        let (v1, v2) = calculate_net_and_fee_amount(v0, arg0.lp_withdrawal_fee_pct);
        WithdrawableBaseByLp{
            withdrawable_base : v1,
            withdraw_fee      : v2,
            shares_to_burn    : v0 * 1000,
        }
    }

    fun increment_reward_rps<T0>(arg0: &mut LiquidityPool<T0>, arg1: u64) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        *0x2::table::borrow_mut<0x1::ascii::String, u128>(&mut arg0.reward_rps, v0) = *0x2::table::borrow<0x1::ascii::String, u128>(&arg0.reward_rps, v0) + 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128((arg1 as u128), (1000000000000000000 as u128), (arg0.total_lp_shares as u128));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolFeeClaimCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ProtocolFeeClaimCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initial_deposit_base<T0>(arg0: &mut LiquidityPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 4005);
        validate_pool_version<T0>(arg0);
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 4001);
        let v0 = internal_deposit_base<T0>(arg0, 0x2::coin::split<T0>(&mut arg1, arg2, arg3), true, arg3);
        let v1 = 0x2::table::new<0x1::ascii::String, u128>(arg3);
        let v2 = 0x2::table::new<0x1::ascii::String, u64>(arg3);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::ascii::String>(&arg0.supported_assets)) {
            let v4 = *0x1::vector::borrow<0x1::ascii::String>(&arg0.supported_assets, v3);
            0x2::table::add<0x1::ascii::String, u128>(&mut v1, v4, *0x2::table::borrow<0x1::ascii::String, u128>(&arg0.reward_rps, v4));
            0x2::table::add<0x1::ascii::String, u64>(&mut v2, v4, 0);
            v3 = v3 + 1;
        };
        let v5 = LPPosition<T0>{
            id                : 0x2::object::new(arg3),
            pool_id           : 0x2::object::uid_to_inner(&arg0.id),
            shares            : v0,
            paid_rps          : v1,
            claimable_rewards : v2,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<LPPosition<T0>>(v5, 0x2::tx_context::sender(arg3));
    }

    public fun initialize_global_config(arg0: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::admin::ProtocolAdminCap, arg1: 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::admin::GlobalConfigCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg7);
        let v1 = GlobalConfig{
            id                        : v0,
            config_cap                : arg1,
            max_quote_assets_per_pool : arg2,
            max_swap_fee_pct          : arg3,
            max_lp_withdrawal_fee_pct : arg4,
            max_lp_fee_share          : arg5,
            max_dynamic_fee           : arg6,
            is_protocol_paused        : false,
            total_pools_created       : 0,
            version                   : 1,
            bag                       : 0x2::bag::new(arg7),
        };
        assert_global_config(&v1, 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<u64>());
        let v2 = GlobalConfigCreated{global_config_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<GlobalConfigCreated>(v2);
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    fun internal_deposit_base<T0>(arg0: &mut LiquidityPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<T0>(&arg1);
        if (arg0.is_permissioned) {
            assert!(0x1::vector::contains<address>(&arg0.whitelisted_lps, &v0) || v0 == arg0.admin, 4008);
        };
        let v2 = v1 * 1000;
        assert!(v2 > 0, 4001);
        0x2::balance::join<T0>(&mut arg0.base_reserve, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_lp_shares = arg0.total_lp_shares + v2;
        let v3 = LiquidityAdded<T0>{
            pool_id          : 0x2::object::uid_to_inner(&arg0.id),
            provider         : v0,
            base_amount      : v1,
            lp_shares_minted : v2,
            total_lp_shares  : arg0.total_lp_shares,
            is_new_lp        : arg2,
        };
        0x2::event::emit<LiquidityAdded<T0>>(v3);
        v2
    }

    public fun is_protocol_paused(arg0: &GlobalConfig) : bool {
        arg0.is_protocol_paused
    }

    public fun lp_position_info_inner(arg0: &LPPositionInfo) : (0x2::object::ID, u64, vector<ClaimableRewardsInfo>, vector<PaidRPSEntry>) {
        (arg0.pool_id, arg0.shares, arg0.claimable_rewards, arg0.paid_rps)
    }

    fun net_base_added<T0>(arg0: &LiquidityPool<T0>) : u64 {
        arg0.total_lp_shares / 1000
    }

    public fun pause_market<T0>(arg0: &mut LiquidityPool<T0>, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 4002);
        arg0.is_paused = true;
        let v0 = MarketPausedEvent<T0>{
            pool_id : 0x2::object::uid_to_inner(&arg0.id),
            reason  : arg1,
        };
        0x2::event::emit<MarketPausedEvent<T0>>(v0);
    }

    public fun pool_config_inner(arg0: &PoolConfig) : (u64, u64, u64, u64, u64, u64) {
        (arg0.swap_fee_pct, arg0.lp_withdrawal_fee_pct, arg0.lp_fee_pct, arg0.max_dynamic_fee, arg0.limit_ratio, arg0.min_base_out)
    }

    public fun pool_info_inner(arg0: &PoolInfo) : (0x2::object::ID, u64, u64, u64, u64, address, bool) {
        (arg0.id, arg0.base_liquidity, arg0.net_base_added, arg0.total_lp_shares, arg0.protocol_base_fees, arg0.admin, arg0.is_paused)
    }

    public fun quote_asset_info_inner(arg0: QuoteAssetInfo) : (u64, u64, u64, u64, 0x1::option::Option<u64>, 0x1::option::Option<u64>, u64, bool) {
        (arg0.ideal_reserve_pct, arg0.max_reserve_pct, arg0.fee_base, arg0.fee_max, arg0.limit_ratio, arg0.limit_fixed, arg0.min_out, arg0.is_trading)
    }

    fun quote_limit<T0, T1>(arg0: &LiquidityPool<T0>, arg1: u128, arg2: &QuoteAssetReserve<T1>) : u64 {
        let (v0, _) = get_pool_liquidity<T0>(arg0);
        0x1::u64::min((0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128((0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128((v0 as u128), 1000000000000000000, arg1) as u128), (0x1::option::get_with_default<u64>(&arg2.limit_ratio, arg0.limit_ratio) as u128), 100) as u64), 0x1::option::get_with_default<u64>(&arg2.limit_fixed, 18446744073709551615))
    }

    public fun remove_from_whitelist<T0>(arg0: &mut LiquidityPool<T0>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4002);
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg1);
            let (v1, v2) = 0x1::vector::index_of<address>(&arg0.whitelisted_lps, &v0);
            if (v1) {
                0x1::vector::remove<address>(&mut arg0.whitelisted_lps, v2);
            };
        };
        let v3 = LpRemovedFromWhitelist<T0>{
            pool_id      : 0x2::object::uid_to_inner(&arg0.id),
            lp_addresses : arg1,
        };
        0x2::event::emit<LpRemovedFromWhitelist<T0>>(v3);
    }

    public fun set_permissioned<T0>(arg0: &mut LiquidityPool<T0>, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4002);
        arg0.is_permissioned = arg1;
        let v0 = PoolPermissionUpdated<T0>{
            pool_id         : 0x2::object::uid_to_inner(&arg0.id),
            is_permissioned : arg1,
        };
        0x2::event::emit<PoolPermissionUpdated<T0>>(v0);
    }

    public fun set_protocol_pause(arg0: &mut GlobalConfig, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::admin::ProtocolAdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.is_protocol_paused = arg2;
        let v0 = ProtocolPausedUpdated{
            global_config_id : 0x2::object::uid_to_inner(&arg0.id),
            is_paused        : arg2,
            updated_by       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ProtocolPausedUpdated>(v0);
    }

    public fun simulate_buy_swap<T0, T1>(arg0: &LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: u64) : SwapSimulationResult {
        validate_pool_version<T0>(arg0);
        assert!(arg3 > 0, 4001);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        assert!(0x1::vector::contains<0x1::ascii::String>(&arg0.supported_assets, &v0), 4003);
        assert!(0x2::dynamic_field::exists_<0x1::ascii::String>(&arg0.id, v0), 4003);
        let (v1, _) = get_price<T1, T0>(arg1, arg2);
        let v3 = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128((arg3 as u128), v1, 1000000000000000000);
        assert!(v3 != 0, 4016);
        let (v4, v5) = calc_dynamic_fee<T0, T1>(arg0, arg3, v1, false);
        let (v6, v7, v8) = calculate_swap_fees<T0>(arg0, (v3 as u64), v4);
        SwapSimulationResult{
            base_out        : (v6 as u64),
            quote_out       : (0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128((v6 as u128), 1000000000000000000, v1) as u64),
            swap_fee_pct    : arg0.swap_fee_pct,
            dynamic_fee_pct : v4,
            ideal_quote_amt : v5,
            swap_fee        : ((v8 + v7) as u64),
            lp_fee          : (v8 as u64),
            protocol_fee    : (v7 as u64),
            price_used      : v1,
        }
    }

    public fun simulate_sell_swap<T0, T1>(arg0: &LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: u64) : SwapSimulationResult {
        validate_pool_version<T0>(arg0);
        assert!(arg3 > 0, 4001);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        assert!(0x1::vector::contains<0x1::ascii::String>(&arg0.supported_assets, &v0), 4003);
        assert!(0x2::dynamic_field::exists_<0x1::ascii::String>(&arg0.id, v0), 4003);
        let (v1, _) = get_price<T1, T0>(arg1, arg2);
        let (v3, v4) = calc_dynamic_fee<T0, T1>(arg0, (0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128((arg3 as u128), 1000000000000000000, v1) as u64), v1, true);
        let (v5, v6, v7) = calculate_swap_fees<T0>(arg0, arg3, v3);
        SwapSimulationResult{
            base_out        : (v5 as u64),
            quote_out       : (0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::math::mul_div_u128((v5 as u128), 1000000000000000000, v1) as u64),
            swap_fee_pct    : arg0.swap_fee_pct,
            dynamic_fee_pct : v3,
            ideal_quote_amt : v4,
            swap_fee        : ((v7 + v6) as u64),
            lp_fee          : (v7 as u64),
            protocol_fee    : (v6 as u64),
            price_used      : v1,
        }
    }

    public fun simulate_swap<T0, T1>(arg0: &LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: u64, arg4: bool) : SwapSimulationResult {
        if (arg4) {
            simulate_buy_swap<T0, T1>(arg0, arg1, arg2, arg3)
        } else {
            simulate_sell_swap<T0, T1>(arg0, arg1, arg2, arg3)
        }
    }

    public fun simulate_withdraw_shares<T0>(arg0: &LiquidityPool<T0>, arg1: &LPPosition<T0>, arg2: u64) : WithdrawSharesSimulationResult {
        validate_pool_version<T0>(arg0);
        assert!(arg1.pool_id == 0x2::object::uid_to_inner(&arg0.id), 4012);
        assert!(arg1.shares >= arg2, 4001);
        let v0 = arg2 / 1000;
        let (v1, v2) = calculate_net_and_fee_amount(v0, arg0.lp_withdrawal_fee_pct);
        assert!(v1 <= 0x2::balance::value<T0>(&arg0.base_reserve), 4000);
        WithdrawSharesSimulationResult{
            shares_burn     : arg2,
            base_out_gross  : v0,
            base_fee        : v2,
            total_base_fees : 0x2::balance::value<T0>(&arg0.protocol_base_fees) + v2,
            base_out        : v1,
            total_lp_shares : arg0.total_lp_shares - arg2,
            net_base_added  : net_base_added<T0>(arg0) - v0,
        }
    }

    public fun simulation_result_inner(arg0: &SwapSimulationResult) : (u64, u64, u64, u64, u128, u64, u64, u64, u128) {
        (arg0.base_out, arg0.quote_out, arg0.swap_fee_pct, arg0.dynamic_fee_pct, arg0.ideal_quote_amt, arg0.swap_fee, arg0.lp_fee, arg0.protocol_fee, arg0.price_used)
    }

    public fun swap_buy<T0, T1>(arg0: &mut LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T1>, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.is_paused, 4005);
        let v0 = 0x2::balance::value<T1>(&arg3);
        let v1 = simulate_buy_swap<T0, T1>(arg0, arg1, arg2, v0);
        let (v2, _, v4, v5, v6, v7, v8, v9, v10) = simulation_result_inner(&v1);
        assert_quote_is_trading<T0, T1>(arg0);
        assert!(v2 >= arg0.min_base_out, 4001);
        0x2::balance::join<T0>(&mut arg0.protocol_base_fees, 0x2::balance::split<T0>(&mut arg0.base_reserve, v9));
        increment_reward_rps<T0>(arg0, v8);
        if (0x1::option::is_some<u64>(&arg4)) {
            assert!(v2 >= *0x1::option::borrow<u64>(&arg4), 4007);
        };
        let v11 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, QuoteAssetReserve<T1>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()));
        0x2::balance::join<T1>(&mut v11.balance, 0x2::balance::split<T1>(&mut arg3, v0));
        v11.ideal_reserve_calc = v6;
        assert!(v2 <= 0x2::balance::value<T0>(&arg0.base_reserve), 4000);
        let v12 = SwapExecuted<T0, T1>{
            pool_id         : 0x2::object::uid_to_inner(&arg0.id),
            trader          : 0x2::tx_context::sender(arg5),
            amount_in       : v0,
            amount_out      : v2,
            is_buy          : true,
            dynamic_fee_pct : v5,
            ideal_quote_amt : v6,
            total_fee_pct   : v4 + v5,
            swap_fee        : (v7 as u64),
            lp_fee          : (v8 as u64),
            protocol_fee    : v9,
            price_used      : v10,
        };
        0x2::event::emit<SwapExecuted<T0, T1>>(v12);
        (0x2::balance::split<T0>(&mut arg0.base_reserve, v2), arg3)
    }

    public fun swap_sell<T0, T1>(arg0: &mut LiquidityPool<T0>, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.is_paused, 4005);
        let v0 = 0x2::balance::value<T0>(&arg3);
        let v1 = simulate_sell_swap<T0, T1>(arg0, arg1, arg2, v0);
        let (v2, v3, v4, v5, v6, v7, v8, v9, v10) = simulation_result_inner(&v1);
        assert_quote_is_trading<T0, T1>(arg0);
        0x2::balance::join<T0>(&mut arg0.protocol_base_fees, 0x2::balance::split<T0>(&mut arg3, v9));
        increment_reward_rps<T0>(arg0, v8);
        if (0x1::option::is_some<u64>(&arg4)) {
            assert!(v3 >= *0x1::option::borrow<u64>(&arg4), 4007);
        };
        0x2::balance::join<T0>(&mut arg0.base_reserve, 0x2::balance::split<T0>(&mut arg3, v2 + v8));
        let v11 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, QuoteAssetReserve<T1>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()));
        let v12 = 0x2::balance::split<T1>(&mut v11.balance, v3);
        assert!(0x2::balance::value<T1>(&v12) >= v11.min_out, 4001);
        v11.ideal_reserve_calc = v6;
        let v13 = SwapExecuted<T0, T1>{
            pool_id         : 0x2::object::uid_to_inner(&arg0.id),
            trader          : 0x2::tx_context::sender(arg5),
            amount_in       : v0,
            amount_out      : v3,
            is_buy          : false,
            dynamic_fee_pct : v5,
            ideal_quote_amt : v6,
            total_fee_pct   : v4 + v5,
            swap_fee        : v7,
            lp_fee          : v8,
            protocol_fee    : v9,
            price_used      : v10,
        };
        0x2::event::emit<SwapExecuted<T0, T1>>(v13);
        (arg3, v12)
    }

    public fun unpause_market<T0>(arg0: &mut LiquidityPool<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 4002);
        arg0.is_paused = false;
        let v0 = MarketUnpausedEvent<T0>{pool_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<MarketUnpausedEvent<T0>>(v0);
    }

    public fun update_admin<T0>(arg0: &mut LiquidityPool<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 4002);
        arg0.admin = arg1;
        let v0 = AdminUpdated<T0>{
            pool_id   : 0x2::object::uid_to_inner(&arg0.id),
            old_admin : arg0.admin,
            new_admin : arg1,
        };
        0x2::event::emit<AdminUpdated<T0>>(v0);
    }

    public fun update_claimable_rewards<T0>(arg0: &LiquidityPool<T0>, arg1: &mut LPPosition<T0>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::ascii::String>(&arg0.supported_assets)) {
            let v1 = calc_claimable_rewards<T0>(arg0, arg1, v0);
            if (0x2::table::contains<0x1::ascii::String, u64>(&arg1.claimable_rewards, v1.asset)) {
                *0x2::table::borrow_mut<0x1::ascii::String, u64>(&mut arg1.claimable_rewards, v1.asset) = v1.amount;
            } else {
                0x2::table::add<0x1::ascii::String, u64>(&mut arg1.claimable_rewards, v1.asset, v1.amount);
            };
            *0x2::table::borrow_mut<0x1::ascii::String, u128>(&mut arg1.paid_rps, v1.asset) = v1.reward_rps;
            v0 = v0 + 1;
        };
    }

    public fun update_config<T0>(arg0: &GlobalConfig, arg1: &mut LiquidityPool<T0>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg8), 4002);
        assert_pool_fees(arg0, arg2, arg3, arg4, arg5, arg6);
        if (0x1::option::is_some<u64>(&arg2)) {
            arg1.swap_fee_pct = *0x1::option::borrow<u64>(&arg2);
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            arg1.lp_withdrawal_fee_pct = *0x1::option::borrow<u64>(&arg3);
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            arg1.lp_fee_pct = *0x1::option::borrow<u64>(&arg4);
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            arg1.max_dynamic_fee = *0x1::option::borrow<u64>(&arg5);
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            arg1.limit_ratio = *0x1::option::borrow<u64>(&arg6);
        };
        if (0x1::option::is_some<u64>(&arg7)) {
            arg1.min_base_out = *0x1::option::borrow<u64>(&arg7);
        };
        let v0 = PoolConfigUpdated{
            pool_id                   : 0x2::object::uid_to_inner(&arg1.id),
            new_swap_fee_pct          : arg2,
            new_lp_withdrawal_fee_pct : arg3,
            new_lp_fee                : arg4,
            new_max_dynamic_fee_bps   : arg5,
            new_limit_ratio_bps       : arg6,
            updated_by                : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<PoolConfigUpdated>(v0);
    }

    public fun update_global_config(arg0: &mut GlobalConfig, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::admin::ProtocolAdminCap, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        validate_global_config_version(arg0);
        assert_global_config(arg0, arg3, arg4, arg5, arg6);
        if (0x1::option::is_some<u64>(&arg2)) {
            arg0.max_quote_assets_per_pool = *0x1::option::borrow<u64>(&arg2);
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            arg0.max_swap_fee_pct = *0x1::option::borrow<u64>(&arg3);
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            arg0.max_lp_withdrawal_fee_pct = *0x1::option::borrow<u64>(&arg4);
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            arg0.max_lp_fee_share = *0x1::option::borrow<u64>(&arg5);
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            arg0.max_dynamic_fee = *0x1::option::borrow<u64>(&arg6);
        };
        let v0 = GlobalConfigUpdated{
            global_config_id : 0x2::object::uid_to_inner(&arg0.id),
            updated_by       : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<GlobalConfigUpdated>(v0);
    }

    public fun update_module_version(arg0: &mut GlobalConfig) {
        assert!(arg0.version < 1, 4011);
        arg0.version = 1;
    }

    public fun update_pool_version<T0>(arg0: &mut LiquidityPool<T0>) {
        assert!(arg0.version < 1, 4011);
        arg0.version = 1;
    }

    public fun update_quote_asset<T0, T1>(arg0: &mut LiquidityPool<T0>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<bool>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg9) == arg0.admin, 4002);
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>());
        assert!(0x2::dynamic_field::exists_<0x1::ascii::String>(&arg0.id, v0), 4003);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, QuoteAssetReserve<T1>>(&mut arg0.id, v0);
        if (0x1::option::is_some<u64>(&arg1)) {
            assert!(*0x1::option::borrow<u64>(&arg1) <= 10000, 4010);
            v1.ideal_reserve_pct = *0x1::option::borrow<u64>(&arg1);
        };
        if (0x1::option::is_some<u64>(&arg2)) {
            assert!(*0x1::option::borrow<u64>(&arg2) <= 10000, 4010);
            v1.max_reserve_pct = *0x1::option::borrow<u64>(&arg2);
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            assert!(*0x1::option::borrow<u64>(&arg3) <= 10000, 4010);
            v1.fee_base = *0x1::option::borrow<u64>(&arg3);
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            assert!(*0x1::option::borrow<u64>(&arg4) <= 10000, 4010);
            v1.fee_max = *0x1::option::borrow<u64>(&arg4);
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            v1.limit_ratio = 0x1::option::some<u64>(*0x1::option::borrow<u64>(&arg5));
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            v1.limit_fixed = 0x1::option::some<u64>(*0x1::option::borrow<u64>(&arg6));
        };
        if (0x1::option::is_some<u64>(&arg7)) {
            v1.min_out = *0x1::option::borrow<u64>(&arg7);
        };
        if (0x1::option::is_some<bool>(&arg8)) {
            v1.is_trading = *0x1::option::borrow<bool>(&arg8);
        };
    }

    public fun validate_global_config_version(arg0: &GlobalConfig) {
        assert!(arg0.version == 1, 4011);
    }

    public fun validate_pool_version<T0>(arg0: &LiquidityPool<T0>) {
        assert!(arg0.version == 1, 4011);
    }

    public fun version() : u64 {
        1
    }

    public fun withdraw_base<T0>(arg0: &mut LiquidityPool<T0>, arg1: &mut LPPosition<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.shares;
        withdraw_shares<T0>(arg0, arg1, v0, arg2, arg3);
    }

    public fun withdraw_protocol_fees<T0>(arg0: &ProtocolFeeClaimCap, arg1: &mut LiquidityPool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.protocol_base_fees), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_shares<T0>(arg0: &mut LiquidityPool<T0>, arg1: &mut LPPosition<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 4005);
        validate_pool_version<T0>(arg0);
        let v0 = simulate_withdraw_shares<T0>(arg0, arg1, arg2);
        arg0.total_lp_shares = v0.total_lp_shares;
        0x2::balance::join<T0>(&mut arg0.protocol_base_fees, 0x2::balance::split<T0>(&mut arg0.base_reserve, v0.base_fee));
        update_claimable_rewards<T0>(arg0, arg1);
        arg1.shares = arg1.shares - arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.base_reserve, v0.base_out), arg4), arg3);
        let v1 = LiquidityRemoved<T0>{
            pool_id          : 0x2::object::uid_to_inner(&arg0.id),
            provider         : 0x2::tx_context::sender(arg4),
            base_amount      : v0.base_out,
            lp_shares_burned : arg2,
            total_lp_shares  : arg0.total_lp_shares,
        };
        0x2::event::emit<LiquidityRemoved<T0>>(v1);
    }

    public fun withdraw_shares_simulation_result_inner(arg0: &WithdrawSharesSimulationResult) : (u64, u64, u64, u64, u64, u64, u64) {
        (arg0.shares_burn, arg0.base_out_gross, arg0.base_fee, arg0.total_base_fees, arg0.base_out, arg0.total_lp_shares, arg0.net_base_added)
    }

    public fun withdrawable_base_by_lp_inner(arg0: &WithdrawableBaseByLp) : (u64, u64, u64) {
        (arg0.withdrawable_base, arg0.withdraw_fee, arg0.shares_to_burn)
    }

    // decompiled from Move bytecode v6
}

