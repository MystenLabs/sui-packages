module 0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    struct Account has store {
        clmm_base_nft: 0x1::option::Option<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>,
        clmm_limit_nft: 0x1::option::Option<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>,
        balances: 0x2::bag::Bag,
    }

    struct Strategy has store, key {
        id: 0x2::object::UID,
        clmm_pool_id: 0x2::object::ID,
        effective_tick_lower: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        effective_tick_upper: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        total_share: u128,
        rewarders: vector<0x1::type_name::TypeName>,
        coin_a_type_name: 0x1::type_name::TypeName,
        coin_b_type_name: 0x1::type_name::TypeName,
        fee_type_name: 0x1::type_name::TypeName,
        vaults: 0x2::linked_table::LinkedTable<0x2::object::ID, VaultInfo>,
        vault_index: u64,
        accounts: 0x2::table::Table<0x2::object::ID, Account>,
        management_fee_rate: u64,
        performance_fee_rate: u64,
        protocol_fees: 0x2::bag::Bag,
        image_url: 0x1::string::String,
        tick_spacing: u32,
        default_base_rebalance_percentage: u32,
        default_limit_rebalance_percentage: u32,
        base_tick_step_minimum: u32,
        limit_tick_step_minimum: u32,
        status: u8,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        index: u64,
        strategy_id: 0x2::object::ID,
        coin_a_type_name: 0x1::type_name::TypeName,
        coin_b_type_name: 0x1::type_name::TypeName,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct VaultRewardInfo has copy, drop, store {
        reward: u128,
        reward_debt: u128,
        reward_harvested: u128,
    }

    struct VaultInfo has copy, drop, store {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        coin_a_type_name: 0x1::type_name::TypeName,
        coin_b_type_name: 0x1::type_name::TypeName,
        base_clmm_position_id: 0x2::object::ID,
        base_lower_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        base_upper_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        base_liquidity: u128,
        limit_clmm_position_id: 0x2::object::ID,
        limit_lower_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        limit_upper_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        limit_liquidity: u128,
        sqrt_price: u128,
        base_last_tick_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        limit_last_tick_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        base_rebalance_threshold: u32,
        limit_rebalance_threshold: u32,
        base_tick_step: u32,
        limit_tick_step: u32,
        share: u128,
        rewards: 0x2::vec_map::VecMap<0x1::type_name::TypeName, VaultRewardInfo>,
        management_fee_rate: 0x1::option::Option<u64>,
        performance_fee_rate: 0x1::option::Option<u64>,
    }

    struct CheckRebalance has copy, drop {
        vault_id: 0x2::object::ID,
        rebalance: bool,
        base_lower_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        base_upper_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        base_just_increase: bool,
        limit_lower_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        limit_upper_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
    }

    struct CreateStrategyEvent has copy, drop {
        strategy_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        effective_tick_lower: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        effective_tick_upper: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        coin_a_type_name: 0x1::type_name::TypeName,
        coin_b_type_name: 0x1::type_name::TypeName,
        fee_type_name: 0x1::type_name::TypeName,
    }

    struct OpenVaultEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
    }

    struct CloseVaultEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
    }

    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        percentage: u64,
        burn_clmm_nft: bool,
        amount_a: u64,
        amount_b: u64,
        protocol_fee_a_amount: u64,
        protocol_fee_b_amount: u64,
    }

    struct RebalanceEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        checkRebalance: CheckRebalance,
        sqrt_price: u128,
        amount_a_left: u64,
        amount_b_left: u64,
        base_amount_a: u64,
        base_amount_b: u64,
        limit_amount_a: u64,
        limit_amount_b: u64,
    }

    struct CollectRebalanceFeeEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        fee_amount_a: u64,
        fee_amount_b: u64,
        remaining_fee_amount_a: u64,
        remaining_fee_amount_b: u64,
    }

    struct AddRewardEvent has copy, drop {
        strategy_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        rewarder_type: 0x1::type_name::TypeName,
        allocate_point: u64,
    }

    struct UpdateStrategyManagementFeeRateEvent has copy, drop {
        strategy_id: 0x2::object::ID,
        old_rate: u64,
        new_rate: u64,
    }

    struct UpdateStrategyPerformanceFeeRateEvent has copy, drop {
        strategy_id: 0x2::object::ID,
        old_rate: u64,
        new_rate: u64,
    }

    struct UpdateVaultPerformanceFeeRateEvent has copy, drop {
        strategy_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        old_rate: u64,
        new_rate: u64,
    }

    struct UpdateVaultManagementFeeRateEvent has copy, drop {
        strategy_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        old_rate: u64,
        new_rate: u64,
    }

    struct ClmmRewardClaimedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        clmm_nft_id: 0x2::object::ID,
        amount: u64,
        performance_fee: u64,
        reward_type_name: 0x1::type_name::TypeName,
    }

    struct VaultRewardClaimedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        amount: u64,
        reward_type_name: 0x1::type_name::TypeName,
    }

    struct ClmmFeeClaimedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        clmm_nft_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        performance_fee_a: u64,
        performance_fee_b: u64,
        coin_a_type_name: 0x1::type_name::TypeName,
        coin_b_type_name: 0x1::type_name::TypeName,
    }

    public fun add_rewarder<T0>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut 0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::rewarder::RewarderManager, arg3: &mut Strategy, arg4: u64, arg5: &0x2::clock::Clock) {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_vault_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg3.rewarders, &v0), 3);
        let v1 = 0x2::object::id<Strategy>(arg3);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::rewarder::add_strategy<T0>(arg2, v1, arg4, arg5);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg3.rewarders, v0);
        let v2 = AddRewardEvent{
            strategy_id    : v1,
            clmm_pool_id   : arg3.clmm_pool_id,
            rewarder_type  : v0,
            allocate_point : arg4,
        };
        0x2::event::emit<AddRewardEvent>(v2);
    }

    fun borrow_clmm_base_nft(arg0: &Strategy, arg1: 0x2::object::ID) : &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        0x1::option::borrow<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&borrow_vault_account(arg0, arg1).clmm_base_nft)
    }

    fun borrow_clmm_limit_nft(arg0: &Strategy, arg1: 0x2::object::ID) : &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        0x1::option::borrow<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&borrow_vault_account(arg0, arg1).clmm_limit_nft)
    }

    fun borrow_mut_clmm_base_nft(arg0: &mut Strategy, arg1: 0x2::object::ID) : &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        0x1::option::borrow_mut<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut borrow_mut_vault_account(arg0, arg1).clmm_base_nft)
    }

    fun borrow_mut_clmm_limit_nft(arg0: &mut Strategy, arg1: 0x2::object::ID) : &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        0x1::option::borrow_mut<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut borrow_mut_vault_account(arg0, arg1).clmm_limit_nft)
    }

    fun borrow_mut_vault_account(arg0: &mut Strategy, arg1: 0x2::object::ID) : &mut Account {
        0x2::table::borrow_mut<0x2::object::ID, Account>(&mut arg0.accounts, arg1)
    }

    fun borrow_mut_vault_info(arg0: &mut Strategy, arg1: 0x2::object::ID) : &mut VaultInfo {
        0x2::linked_table::borrow_mut<0x2::object::ID, VaultInfo>(&mut arg0.vaults, arg1)
    }

    public fun borrow_vault_account(arg0: &Strategy, arg1: 0x2::object::ID) : &Account {
        0x2::table::borrow<0x2::object::ID, Account>(&arg0.accounts, arg1)
    }

    public fun borrow_vault_info(arg0: &Strategy, arg1: 0x2::object::ID) : &VaultInfo {
        0x2::linked_table::borrow<0x2::object::ID, VaultInfo>(&arg0.vaults, arg1)
    }

    fun burn_clmm_base_nft<T0, T1, T2>(arg0: &mut Strategy, arg1: 0x2::object::ID, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::burn<T0, T1, T2>(arg2, extract_clmm_base_nft(arg0, arg1), arg3, arg4);
    }

    fun burn_clmm_limit_nft<T0, T1, T2>(arg0: &mut Strategy, arg1: 0x2::object::ID, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::burn<T0, T1, T2>(arg2, extract_clmm_limit_nft(arg0, arg1), arg3, arg4);
    }

    fun calculate_liquidity(arg0: u128, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: u64, arg4: u64) : u128 {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_liquidity_for_amounts(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg1), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(arg2), (arg3 as u128), (arg4 as u128))
    }

    public fun calculate_position_share(arg0: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: u128, arg3: u128, arg4: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg5: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32) : u128 {
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(arg0, arg1), 4);
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(arg4, arg5), 4);
        let v0 = (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lte(arg1, arg4) || 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gte(arg0, arg5)) && false || true;
        if (!v0) {
            return 0
        };
        let v1 = if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(arg0, arg4)) {
            arg4
        } else {
            arg0
        };
        let v2 = if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(arg1, arg5)) {
            arg1
        } else {
            arg5
        };
        let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_amount_for_liquidity(arg3, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v1), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v2), arg2);
        (((v3 as u256) * (arg3 as u256) * (arg3 as u256) * 1000000000 / 340282366920938463463374607431768211455 / 1000000000) as u128) + v4
    }

    public fun calculate_tick_index(arg0: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg1: u32, arg2: u32) : (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32) {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::mod(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg1)));
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg2 + 1);
        (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::mul(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg1), v1)), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::add(v0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::mul(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg1), v1)))
    }

    public fun check_rebalance<T0, T1, T2>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg1: &mut Strategy, arg2: 0x2::object::ID, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x2::tx_context::TxContext) : CheckRebalance {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg0);
        assert!(arg1.status == 0, 15);
        let v0 = false;
        let v1 = borrow_vault_info(arg1, arg2);
        let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg3);
        let v3 = v1.base_last_tick_index;
        let v4 = false;
        let v5 = v1.base_lower_index;
        let v6 = v1.base_upper_index;
        let v7 = v1.base_tick_step;
        let v8 = v1.limit_tick_step;
        let v9 = if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gt(v2, v3)) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(v2, v3))
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(v3, v2))
        };
        if (v9 >= 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u32::mul_div_floor(v7 * arg1.tick_spacing, v1.base_rebalance_threshold, 100)) {
            v0 = true;
        };
        let v10 = v1.limit_lower_index;
        let v11 = v1.limit_upper_index;
        if (!v0 && is_clmm_limit_nft_exists(arg1, arg2)) {
            let v12 = v1.limit_last_tick_index;
            let v13 = if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gt(v2, v12)) {
                0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(v2, v12))
            } else {
                0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(v12, v2))
            };
            if (v13 >= 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u32::mul_div_floor(v8 * arg1.tick_spacing, v1.limit_rebalance_threshold, 100)) {
                v0 = true;
                if (is_clmm_base_nft_exists(arg1, arg2)) {
                    v4 = true;
                };
            };
        };
        if (v0 && !v4) {
            let (v14, v15) = calculate_tick_index(v2, arg1.tick_spacing, v7);
            v6 = v15;
            v5 = v14;
        };
        if (v0) {
            let (v16, v17) = calculate_tick_index(v2, arg1.tick_spacing, v8);
            v11 = v17;
            v10 = v16;
        };
        CheckRebalance{
            vault_id           : arg2,
            rebalance          : v0,
            base_lower_index   : v5,
            base_upper_index   : v6,
            base_just_increase : v4,
            limit_lower_index  : v10,
            limit_upper_index  : v11,
        }
    }

    public fun check_rebalance_loop<T0, T1, T2>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg1: &mut Strategy, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg5: &mut 0x2::tx_context::TxContext) : (vector<CheckRebalance>, 0x1::option::Option<0x2::object::ID>) {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg0);
        assert!(arg1.status == 0, 15);
        let v0 = 0x1::vector::empty<CheckRebalance>();
        let v1 = 0;
        let v2 = 0x1::option::some<0x2::object::ID>(arg2);
        let v3 = &v2;
        let v4 = 0;
        while (!0x1::option::is_none<0x2::object::ID>(v3) && v1 < arg3 && v4 < 200) {
            let v5 = *0x1::option::borrow<0x2::object::ID>(v3);
            let v6 = check_rebalance<T0, T1, T2>(arg0, arg1, v5, arg4, arg5);
            if (v6.rebalance) {
                0x1::vector::push_back<CheckRebalance>(&mut v0, v6);
                v1 = v1 + 1;
            };
            v3 = 0x2::linked_table::next<0x2::object::ID, VaultInfo>(&arg1.vaults, v5);
            v4 = v4 + 1;
        };
        (v0, *v3)
    }

    fun check_tick_range(arg0: u32, arg1: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg4: u32) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32(arg4);
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(arg2, arg1) && 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lt(arg1, arg3), 4);
        let (v0, v1) = calculate_tick_index(arg1, arg4, arg0 - 1);
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::lte(arg2, v0), 14);
        assert!(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gte(arg3, v1), 14);
    }

    public fun close_vault<T0, T1>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg1: &mut Strategy, arg2: Vault, arg3: &mut 0x2::tx_context::TxContext) {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg0);
        assert!(arg1.status == 0, 15);
        let v0 = 0x2::object::id<Vault>(&arg2);
        borrow_vault_account(arg1, v0);
        assert!(!is_clmm_base_nft_exists(arg1, v0), 7);
        assert!(!is_clmm_limit_nft_exists(arg1, v0), 8);
        assert!(get_vault_balance<T0>(arg1, v0) == 0, 9);
        assert!(get_vault_balance<T1>(arg1, v0) == 0, 10);
        remove_vault_info(arg1, v0);
        let Vault {
            id               : v1,
            index            : _,
            strategy_id      : _,
            coin_a_type_name : _,
            coin_b_type_name : _,
            name             : _,
            description      : _,
            url              : _,
        } = arg2;
        0x2::object::delete(v1);
        let v9 = CloseVaultEvent{
            vault_id    : v0,
            strategy_id : 0x2::object::id<Strategy>(arg1),
        };
        0x2::event::emit<CloseVaultEvent>(v9);
    }

    fun coin_to_vec<T0>(arg0: 0x2::coin::Coin<T0>) : vector<0x2::coin::Coin<T0>> {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg0);
        v0
    }

    fun collect_clmm_base_fees<T0, T1, T2>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg1: &mut Strategy, arg2: 0x2::object::ID, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Strategy>(arg1);
        let v1 = borrow_mut_clmm_base_nft(arg1, arg2);
        let v2 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v1);
        let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<T0, T1, T2>(arg3, arg4, v1, 18446744073709551615, 18446744073709551615, 0x2::object::id_to_address(&arg2), 0x2::clock::timestamp_ms(arg5) + 60000, arg5, arg6, arg7);
        let v5 = v4;
        let v6 = v3;
        let v7 = get_performance_fee_rate(arg0, arg1, arg2, arg7);
        let (v8, v9) = if (v7 == 0) {
            (0, 0)
        } else {
            let v10 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u64::mul_div_ceil(0x2::coin::value<T0>(&v6), v7, 1000000);
            let v11 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u64::mul_div_ceil(0x2::coin::value<T1>(&v5), v7, 1000000);
            merge_protocol_asset<T0>(arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v6, v10, arg7)));
            merge_protocol_asset<T1>(arg1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v5, v11, arg7)));
            (v10, v11)
        };
        merge_vault_balance<T0>(arg1, arg2, 0x2::coin::into_balance<T0>(v6));
        merge_vault_balance<T1>(arg1, arg2, 0x2::coin::into_balance<T1>(v5));
        let v12 = ClmmFeeClaimedEvent{
            vault_id          : arg2,
            strategy_id       : v0,
            clmm_pool_id      : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3),
            clmm_nft_id       : v2,
            amount_a          : 0x2::coin::value<T0>(&v6),
            amount_b          : 0x2::coin::value<T1>(&v5),
            performance_fee_a : v8,
            performance_fee_b : v9,
            coin_a_type_name  : 0x1::type_name::get<T0>(),
            coin_b_type_name  : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<ClmmFeeClaimedEvent>(v12);
    }

    fun collect_clmm_base_reward<T0, T1, T2, T3>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg1: &mut Strategy, arg2: 0x2::object::ID, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg6: u64, arg7: address, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let v0 = 0x2::object::id<Strategy>(arg1);
        let v1 = borrow_mut_clmm_base_nft(arg1, arg2);
        let v2 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v1);
        let v3 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_reward_with_return_<T0, T1, T2, T3>(arg3, arg4, v1, arg5, arg6, 18446744073709551615, arg7, 0x2::clock::timestamp_ms(arg8) + 60000, arg8, arg9, arg10);
        let v4 = get_performance_fee_rate(arg0, arg1, arg2, arg10);
        let v5 = if (v4 == 0) {
            0
        } else {
            let v6 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u64::mul_div_ceil(0x2::coin::value<T3>(&v3), v4, 1000000);
            merge_protocol_asset<T3>(arg1, 0x2::coin::into_balance<T3>(0x2::coin::split<T3>(&mut v3, v6, arg10)));
            v6
        };
        let v7 = ClmmRewardClaimedEvent{
            vault_id         : arg2,
            strategy_id      : v0,
            clmm_pool_id     : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3),
            clmm_nft_id      : v2,
            amount           : 0x2::coin::value<T3>(&v3),
            performance_fee  : v5,
            reward_type_name : 0x1::type_name::get<T3>(),
        };
        0x2::event::emit<ClmmRewardClaimedEvent>(v7);
        v3
    }

    fun collect_clmm_fees<T0, T1, T2>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg1: &mut Strategy, arg2: 0x2::object::ID, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x2::tx_context::TxContext) {
        if (is_clmm_base_nft_exists(arg1, arg2)) {
            collect_clmm_base_fees<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        };
        if (is_clmm_limit_nft_exists(arg1, arg2)) {
            collect_clmm_limit_fees<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        };
    }

    fun collect_clmm_limit_fees<T0, T1, T2>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg1: &mut Strategy, arg2: 0x2::object::ID, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &0x2::clock::Clock, arg6: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Strategy>(arg1);
        let v1 = borrow_mut_clmm_limit_nft(arg1, arg2);
        let v2 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v1);
        let (v3, v4) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_with_return_<T0, T1, T2>(arg3, arg4, v1, 18446744073709551615, 18446744073709551615, 0x2::object::id_to_address(&arg2), 0x2::clock::timestamp_ms(arg5) + 60000, arg5, arg6, arg7);
        let v5 = v4;
        let v6 = v3;
        let v7 = get_performance_fee_rate(arg0, arg1, arg2, arg7);
        let (v8, v9) = if (v7 == 0) {
            (0, 0)
        } else {
            let v10 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u64::mul_div_ceil(0x2::coin::value<T0>(&v6), v7, 1000000);
            let v11 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u64::mul_div_ceil(0x2::coin::value<T1>(&v5), v7, 1000000);
            merge_protocol_asset<T0>(arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v6, v10, arg7)));
            merge_protocol_asset<T1>(arg1, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v5, v11, arg7)));
            (v10, v11)
        };
        merge_vault_balance<T0>(arg1, arg2, 0x2::coin::into_balance<T0>(v6));
        merge_vault_balance<T1>(arg1, arg2, 0x2::coin::into_balance<T1>(v5));
        let v12 = ClmmFeeClaimedEvent{
            vault_id          : arg2,
            strategy_id       : v0,
            clmm_pool_id      : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3),
            clmm_nft_id       : v2,
            amount_a          : 0x2::coin::value<T0>(&v6),
            amount_b          : 0x2::coin::value<T1>(&v5),
            performance_fee_a : v8,
            performance_fee_b : v9,
            coin_a_type_name  : 0x1::type_name::get<T0>(),
            coin_b_type_name  : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<ClmmFeeClaimedEvent>(v12);
    }

    fun collect_clmm_limit_reward<T0, T1, T2, T3>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg1: &mut Strategy, arg2: 0x2::object::ID, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg6: u64, arg7: address, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let v0 = 0x2::object::id<Strategy>(arg1);
        let v1 = borrow_mut_clmm_limit_nft(arg1, arg2);
        let v2 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v1);
        let v3 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::collect_reward_with_return_<T0, T1, T2, T3>(arg3, arg4, v1, arg5, arg6, 18446744073709551615, arg7, 0x2::clock::timestamp_ms(arg8) + 60000, arg8, arg9, arg10);
        let v4 = get_performance_fee_rate(arg0, arg1, arg2, arg10);
        let v5 = if (v4 == 0) {
            0
        } else {
            let v6 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u64::mul_div_ceil(0x2::coin::value<T3>(&v3), v4, 1000000);
            merge_protocol_asset<T3>(arg1, 0x2::coin::into_balance<T3>(0x2::coin::split<T3>(&mut v3, v6, arg10)));
            v6
        };
        let v7 = ClmmRewardClaimedEvent{
            vault_id         : arg2,
            strategy_id      : v0,
            clmm_pool_id     : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3),
            clmm_nft_id      : v2,
            amount           : 0x2::coin::value<T3>(&v3),
            performance_fee  : v5,
            reward_type_name : 0x1::type_name::get<T3>(),
        };
        0x2::event::emit<ClmmRewardClaimedEvent>(v7);
        v3
    }

    fun collect_clmm_reward<T0, T1, T2, T3>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg1: &mut Strategy, arg2: 0x2::object::ID, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg6: u64, arg7: address, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        let v0 = 0x2::balance::zero<T3>();
        if (is_clmm_base_nft_exists(arg1, arg2)) {
            let v1 = collect_clmm_base_reward<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
            0x2::balance::join<T3>(&mut v0, 0x2::coin::into_balance<T3>(v1));
        };
        if (is_clmm_limit_nft_exists(arg1, arg2)) {
            0x2::balance::join<T3>(&mut v0, 0x2::coin::into_balance<T3>(collect_clmm_limit_reward<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)));
        };
        v0
    }

    public fun collect_clmm_reward_direct_return<T0, T1, T2, T3>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg1: &mut Strategy, arg2: &Vault, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg6: u64, arg7: address, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg0);
        assert!(arg1.status == 0, 15);
        assert!(arg1.clmm_pool_id == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3), 17);
        let v0 = 0x1::type_name::get<T3>();
        let v1 = collect_clmm_reward<T0, T1, T2, T3>(arg0, arg1, 0x2::object::id<Vault>(arg2), arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        let v2 = borrow_mut_vault_account(arg1, 0x2::object::id<Vault>(arg2));
        let v3 = get_type_name_str<T3>();
        if (v0 != arg2.coin_a_type_name && v0 != arg2.coin_b_type_name) {
            if (0x2::bag::contains<0x1::string::String>(&v2.balances, v3)) {
                0x2::balance::join<T3>(&mut v1, 0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T3>>(&mut v2.balances, v3));
            };
        };
        0x2::coin::from_balance<T3>(v1, arg10)
    }

    public fun collect_clmm_reward_to_vault<T0, T1, T2, T3>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut Strategy, arg3: 0x2::object::ID, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::PoolRewardVault<T3>, arg7: u64, arg8: address, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: &mut 0x2::tx_context::TxContext) {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        assert!(arg2.status == 0, 15);
        assert!(arg2.clmm_pool_id == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg4), 17);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_rebalance_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        let v0 = collect_clmm_reward<T0, T1, T2, T3>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        merge_vault_balance<T3>(arg2, arg3, v0);
    }

    public(friend) fun collect_protocol_fee<T0>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut Strategy, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        assert!(arg2.status == 0, 15);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_vault_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        0x2::coin::from_balance<T0>(take_protocol_asset_by_amount<T0>(arg2, arg3), arg4)
    }

    fun collect_rebalance_fee<T0, T1>(arg0: &mut Strategy, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T1>) {
        let v0 = arg2 - 0x2::balance::value<T0>(arg4);
        let v1 = arg3 - 0x2::balance::value<T1>(arg5);
        if (v0 > 0) {
            let v2 = take_vault_balance_by_amount<T0>(arg0, arg1, v0);
            0x2::balance::join<T0>(arg4, v2);
        };
        if (v1 > 0) {
            let v3 = take_vault_balance_by_amount<T1>(arg0, arg1, v1);
            0x2::balance::join<T1>(arg5, v3);
        };
        let v4 = CollectRebalanceFeeEvent{
            vault_id               : arg1,
            strategy_id            : 0x2::object::id<Strategy>(arg0),
            fee_amount_a           : arg2,
            fee_amount_b           : arg3,
            remaining_fee_amount_a : arg2 - 0x2::balance::value<T0>(arg4),
            remaining_fee_amount_b : arg3 - 0x2::balance::value<T1>(arg5),
        };
        0x2::event::emit<CollectRebalanceFeeEvent>(v4);
    }

    public fun collect_reward<T0>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg1: &mut 0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::rewarder::RewarderManager, arg2: &mut Strategy, arg3: &Vault, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg0);
        assert!(arg2.status == 0, 15);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg2.rewarders, &v0), 16);
        let v1 = 0x2::object::id<Strategy>(arg2);
        let v2 = 0x2::object::id<Vault>(arg3);
        let v3 = 0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::rewarder::strategy_rewards_settle(arg1, arg2.rewarders, v1, arg4);
        let v4 = borrow_vault_info(arg2, v2).share;
        update_vault_reward_info(arg2, v2, v3, v4);
        let v5 = update_vault_reward_info_on_claim(arg2, v2, v0);
        let v6 = VaultRewardClaimedEvent{
            vault_id         : v2,
            strategy_id      : v1,
            amount           : v5,
            reward_type_name : v0,
        };
        0x2::event::emit<VaultRewardClaimedEvent>(v6);
        0x2::coin::from_balance<T0>(0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::rewarder::withdraw_reward<T0>(arg1, v1, v5), arg5)
    }

    public fun create_strategy<T0, T1, T2>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut 0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::rewarder::RewarderManager, arg3: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: u32, arg5: bool, arg6: u32, arg7: bool, arg8: 0x1::string::String, arg9: u32, arg10: u32, arg11: u32, arg12: u32, arg13: &mut 0x2::tx_context::TxContext) : Strategy {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_vault_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32_neg(arg4, arg5);
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32_neg(arg6, arg7);
        let v2 = 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg3);
        let v3 = 0x1::type_name::get<T0>();
        let v4 = 0x1::type_name::get<T1>();
        let v5 = 0x1::type_name::get<T2>();
        let v6 = Strategy{
            id                                 : 0x2::object::new(arg13),
            clmm_pool_id                       : v2,
            effective_tick_lower               : v0,
            effective_tick_upper               : v1,
            total_share                        : 0,
            rewarders                          : 0x1::vector::empty<0x1::type_name::TypeName>(),
            coin_a_type_name                   : v3,
            coin_b_type_name                   : v4,
            fee_type_name                      : v5,
            vaults                             : 0x2::linked_table::new<0x2::object::ID, VaultInfo>(arg13),
            vault_index                        : 0,
            accounts                           : 0x2::table::new<0x2::object::ID, Account>(arg13),
            management_fee_rate                : 0,
            performance_fee_rate               : 0,
            protocol_fees                      : 0x2::bag::new(arg13),
            image_url                          : arg8,
            tick_spacing                       : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_tick_spacing<T0, T1, T2>(arg3),
            default_base_rebalance_percentage  : arg9,
            default_limit_rebalance_percentage : arg10,
            base_tick_step_minimum             : arg11,
            limit_tick_step_minimum            : arg12,
            status                             : 0,
        };
        let v7 = 0x2::object::id<Strategy>(&v6);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::rewarder::register_strategy(arg2, v7);
        let v8 = CreateStrategyEvent{
            strategy_id          : v7,
            clmm_pool_id         : v2,
            effective_tick_lower : v0,
            effective_tick_upper : v1,
            coin_a_type_name     : v3,
            coin_b_type_name     : v4,
            fee_type_name        : v5,
        };
        0x2::event::emit<CreateStrategyEvent>(v8);
        v6
    }

    fun decrease_clmm_liquidity<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::decrease_liquidity_with_return_<T0, T1, T2>(arg1, arg2, arg0, arg3, 0, 0, 0x2::clock::timestamp_ms(arg4) + 60000, arg4, arg5, arg6)
    }

    public fun deposit<T0, T1, T2>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg1: &mut 0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::rewarder::RewarderManager, arg2: &mut Strategy, arg3: &mut Vault, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg0);
        assert!(arg2.status == 0, 15);
        assert!(arg2.clmm_pool_id == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg4), 17);
        0x2::tx_context::sender(arg10);
        let v0 = 0x2::object::id<Vault>(arg3);
        let v1 = 0x2::coin::value<T0>(&arg6);
        let v2 = 0x2::coin::value<T1>(&arg7);
        assert!(v1 > 0 || v2 > 0, 1);
        merge_vault_balance<T0>(arg2, v0, 0x2::coin::into_balance<T0>(arg6));
        merge_vault_balance<T1>(arg2, v0, 0x2::coin::into_balance<T1>(arg7));
        let v3 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg4);
        let v4 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg4);
        let v5 = get_vault_base_lower_index(arg2, v0);
        let v6 = v5;
        let v7 = get_vault_base_upper_index(arg2, v0);
        let v8 = v7;
        let v9 = get_vault_base_clmm_position_id(arg2, v0);
        let v10 = get_vault_base_liquidity(arg2, v0);
        let v11 = get_vault_base_last_tick_index(arg2, v0);
        if (is_clmm_base_nft_exists(arg2, v0)) {
            if (calculate_liquidity(v3, v5, v7, get_vault_balance<T0>(arg2, v0), get_vault_balance<T1>(arg2, v0)) > 0) {
                let v12 = take_vault_balance<T0>(arg2, v0);
                let v13 = 0x2::coin::from_balance<T0>(v12, arg10);
                let v14 = take_vault_balance<T1>(arg2, v0);
                let v15 = 0x2::coin::from_balance<T1>(v14, arg10);
                let (v16, v17, v18, v19, v20) = increase_clmm_liquidity<T0, T1, T2>(arg2, v0, true, arg4, arg5, v13, v15, arg8, arg9, arg10);
                v10 = v20;
                v8 = v19;
                v6 = v18;
                merge_vault_balance<T0>(arg2, v0, 0x2::coin::into_balance<T0>(v16));
                merge_vault_balance<T1>(arg2, v0, 0x2::coin::into_balance<T1>(v17));
            };
        } else {
            if (calculate_liquidity(v3, v5, v7, get_vault_balance<T0>(arg2, v0), get_vault_balance<T1>(arg2, v0)) > 0) {
                let v21 = take_vault_balance<T0>(arg2, v0);
                let v22 = 0x2::coin::from_balance<T0>(v21, arg10);
                let v23 = take_vault_balance<T1>(arg2, v0);
                let v24 = 0x2::coin::from_balance<T1>(v23, arg10);
                let (v25, v26, v27) = mint_clmm_liquidity<T0, T1, T2>(arg4, arg5, v22, v24, v5, v7, arg8, arg9, arg10);
                let v28 = v25;
                merge_vault_balance<T0>(arg2, v0, 0x2::coin::into_balance<T0>(v26));
                merge_vault_balance<T1>(arg2, v0, 0x2::coin::into_balance<T1>(v27));
                let (v29, v30, v31) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg5, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v28));
                v10 = v31;
                v8 = v30;
                v6 = v29;
                v9 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::position_id(&v28);
                fill_clmm_base_nft(arg2, v0, v28);
            };
            v11 = v4;
        };
        let v32 = get_vault_limit_lower_index(arg2, v0);
        let v33 = v32;
        let v34 = get_vault_limit_upper_index(arg2, v0);
        let v35 = v34;
        let v36 = get_vault_limit_clmm_position_id(arg2, v0);
        let v37 = get_vault_limit_liquidity(arg2, v0);
        let v38 = get_vault_limit_last_tick_index(arg2, v0);
        if (is_clmm_limit_nft_exists(arg2, v0)) {
            if (calculate_liquidity(v3, v32, v34, get_vault_balance<T0>(arg2, v0), get_vault_balance<T1>(arg2, v0)) > 0) {
                let v39 = take_vault_balance<T0>(arg2, v0);
                let v40 = 0x2::coin::from_balance<T0>(v39, arg10);
                let v41 = take_vault_balance<T1>(arg2, v0);
                let v42 = 0x2::coin::from_balance<T1>(v41, arg10);
                let (v43, v44, v45, v46, v47) = increase_clmm_liquidity<T0, T1, T2>(arg2, v0, false, arg4, arg5, v40, v42, arg8, arg9, arg10);
                v37 = v47;
                v35 = v46;
                v33 = v45;
                merge_vault_balance<T0>(arg2, v0, 0x2::coin::into_balance<T0>(v43));
                merge_vault_balance<T1>(arg2, v0, 0x2::coin::into_balance<T1>(v44));
            };
        };
        update_vault_info_with_tick_range(arg2, v0, v9, v6, v8, v10, v36, v33, v35, v37, v3, v11, v38);
        update_strategy_reward_info(arg1, arg2, v0, arg8);
        let v48 = DepositEvent{
            vault_id     : v0,
            strategy_id  : 0x2::object::id<Strategy>(arg2),
            clmm_pool_id : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg4),
            amount_a     : v1,
            amount_b     : v2,
        };
        0x2::event::emit<DepositEvent>(v48);
    }

    fun extract_clmm_base_nft(arg0: &mut Strategy, arg1: 0x2::object::ID) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        0x1::option::extract<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut borrow_mut_vault_account(arg0, arg1).clmm_base_nft)
    }

    fun extract_clmm_limit_nft(arg0: &mut Strategy, arg1: 0x2::object::ID) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT {
        0x1::option::extract<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut borrow_mut_vault_account(arg0, arg1).clmm_limit_nft)
    }

    fun fill_clmm_base_nft(arg0: &mut Strategy, arg1: 0x2::object::ID, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT) {
        0x1::option::fill<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut borrow_mut_vault_account(arg0, arg1).clmm_base_nft, arg2);
    }

    fun fill_clmm_limit_nft(arg0: &mut Strategy, arg1: 0x2::object::ID, arg2: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT) {
        0x1::option::fill<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&mut borrow_mut_vault_account(arg0, arg1).clmm_limit_nft, arg2);
    }

    public fun floor_tick_index(arg0: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg1: u32, arg2: bool) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32 {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(arg1);
        if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::eq(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::mod(arg0, v0), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::zero())) {
            if (arg2) {
                return 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(arg0, v0)
            };
            return 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::add(arg0, v0)
        };
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::mod(arg0, v0));
        let v2 = v1;
        if (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::gt(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::zero())) {
            if (!arg2) {
                v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::add(v1, v0);
            };
        } else if (arg2) {
            v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::sub(v1, v0);
        };
        v2
    }

    public fun get_check_rebalance_info(arg0: &CheckRebalance) : (bool, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, bool, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32) {
        (arg0.rebalance, arg0.base_lower_index, arg0.base_upper_index, arg0.base_just_increase, arg0.limit_lower_index, arg0.limit_upper_index)
    }

    public fun get_management_fee_rate(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg1: &Strategy, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        abort 0
    }

    public fun get_management_fee_rate_v2(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg1: &mut 0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::UserTierConfig, arg2: &Strategy, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg0);
        let v0 = borrow_vault_info(arg2, arg3);
        let v1 = if (!0x1::option::is_none<u64>(&v0.management_fee_rate)) {
            *0x1::option::borrow<u64>(&v0.management_fee_rate)
        } else {
            arg2.management_fee_rate
        };
        let v2 = v1;
        let (_, v4) = 0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::get_tier_v2(arg0, arg1, 0x2::tx_context::sender(arg4));
        if (v4 > 0) {
            v2 = v1 * (1000000 - v4) / 1000000;
        };
        v2
    }

    public fun get_performance_fee_rate(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg1: &Strategy, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = borrow_vault_info(arg1, arg2);
        if (!0x1::option::is_none<u64>(&v0.performance_fee_rate)) {
            *0x1::option::borrow<u64>(&v0.performance_fee_rate)
        } else {
            arg1.performance_fee_rate
        }
    }

    public fun get_strategy_status(arg0: &Strategy) : u8 {
        arg0.status
    }

    public fun get_strategy_tick_spacing(arg0: &Strategy) : u32 {
        arg0.tick_spacing
    }

    public fun get_strategy_total_share(arg0: &Strategy) : u128 {
        arg0.total_share
    }

    fun get_type_name_str<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun get_vault_amount<T0, T1, T2>(arg0: &Strategy, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: 0x2::object::ID) : (u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::linked_table::borrow<0x2::object::ID, VaultInfo>(&arg0.vaults, arg2);
        let v1 = v0.base_liquidity;
        let v2 = v0.limit_liquidity;
        let v3 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg1);
        let v4 = 0;
        let v5 = 0;
        if (v1 > 0) {
            let (v6, v7) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_amount_for_liquidity(v3, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v0.base_lower_index), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v0.base_upper_index), v1);
            v4 = v7;
            v5 = v6;
        };
        let v8 = 0;
        let v9 = 0;
        if (v2 > 0) {
            let (v10, v11) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::get_amount_for_liquidity(v3, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v0.limit_lower_index), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(v0.limit_upper_index), v2);
            v8 = v11;
            v9 = v10;
        };
        (get_vault_balance<T0>(arg0, arg2), get_vault_balance<T1>(arg0, arg2), (v5 as u64), (v4 as u64), (v9 as u64), (v8 as u64))
    }

    public fun get_vault_balance<T0>(arg0: &Strategy, arg1: 0x2::object::ID) : u64 {
        let v0 = borrow_vault_account(arg0, arg1);
        let v1 = get_type_name_str<T0>();
        if (0x2::bag::contains<0x1::string::String>(&v0.balances, v1)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(&v0.balances, v1))
        } else {
            0
        }
    }

    public fun get_vault_base_clmm_position_id(arg0: &Strategy, arg1: 0x2::object::ID) : 0x2::object::ID {
        0x2::linked_table::borrow<0x2::object::ID, VaultInfo>(&arg0.vaults, arg1).base_clmm_position_id
    }

    public fun get_vault_base_last_tick_index(arg0: &Strategy, arg1: 0x2::object::ID) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32 {
        0x2::linked_table::borrow<0x2::object::ID, VaultInfo>(&arg0.vaults, arg1).base_last_tick_index
    }

    public fun get_vault_base_liquidity(arg0: &Strategy, arg1: 0x2::object::ID) : u128 {
        0x2::linked_table::borrow<0x2::object::ID, VaultInfo>(&arg0.vaults, arg1).base_liquidity
    }

    public fun get_vault_base_lower_index(arg0: &Strategy, arg1: 0x2::object::ID) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32 {
        0x2::linked_table::borrow<0x2::object::ID, VaultInfo>(&arg0.vaults, arg1).base_lower_index
    }

    public fun get_vault_base_upper_index(arg0: &Strategy, arg1: 0x2::object::ID) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32 {
        0x2::linked_table::borrow<0x2::object::ID, VaultInfo>(&arg0.vaults, arg1).base_upper_index
    }

    public fun get_vault_info(arg0: &Strategy, arg1: 0x2::object::ID) : (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, u128, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, u128, u128, u128, 0x2::vec_map::VecMap<0x1::type_name::TypeName, VaultRewardInfo>) {
        let v0 = 0x2::linked_table::borrow<0x2::object::ID, VaultInfo>(&arg0.vaults, arg1);
        (v0.base_lower_index, v0.base_upper_index, v0.base_liquidity, v0.limit_lower_index, v0.limit_upper_index, v0.limit_liquidity, v0.sqrt_price, v0.share, v0.rewards)
    }

    public fun get_vault_limit_clmm_position_id(arg0: &Strategy, arg1: 0x2::object::ID) : 0x2::object::ID {
        0x2::linked_table::borrow<0x2::object::ID, VaultInfo>(&arg0.vaults, arg1).limit_clmm_position_id
    }

    public fun get_vault_limit_last_tick_index(arg0: &Strategy, arg1: 0x2::object::ID) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32 {
        0x2::linked_table::borrow<0x2::object::ID, VaultInfo>(&arg0.vaults, arg1).limit_last_tick_index
    }

    public fun get_vault_limit_liquidity(arg0: &Strategy, arg1: 0x2::object::ID) : u128 {
        0x2::linked_table::borrow<0x2::object::ID, VaultInfo>(&arg0.vaults, arg1).limit_liquidity
    }

    public fun get_vault_limit_lower_index(arg0: &Strategy, arg1: 0x2::object::ID) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32 {
        0x2::linked_table::borrow<0x2::object::ID, VaultInfo>(&arg0.vaults, arg1).limit_lower_index
    }

    public fun get_vault_limit_upper_index(arg0: &Strategy, arg1: 0x2::object::ID) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32 {
        0x2::linked_table::borrow<0x2::object::ID, VaultInfo>(&arg0.vaults, arg1).limit_upper_index
    }

    public fun get_vault_share(arg0: &Strategy, arg1: 0x2::object::ID) : u128 {
        0x2::linked_table::borrow<0x2::object::ID, VaultInfo>(&arg0.vaults, arg1).share
    }

    public fun get_vault_sqrt_price(arg0: &Strategy, arg1: 0x2::object::ID) : u128 {
        0x2::linked_table::borrow<0x2::object::ID, VaultInfo>(&arg0.vaults, arg1).sqrt_price
    }

    public fun get_vault_total_amount<T0, T1, T2>(arg0: &Strategy, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: 0x2::object::ID) : (u64, u64) {
        let (v0, v1, v2, v3, v4, v5) = get_vault_amount<T0, T1, T2>(arg0, arg1, arg2);
        (v0 + v2 + v4, v1 + v3 + v5)
    }

    fun increase_clmm_liquidity<T0, T1, T2>(arg0: &mut Strategy, arg1: 0x2::object::ID, arg2: bool, arg3: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, u128) {
        let v0 = if (arg2) {
            borrow_mut_clmm_base_nft(arg0, arg1)
        } else {
            borrow_mut_clmm_limit_nft(arg0, arg1)
        };
        let (v1, v2) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::increase_liquidity_with_return_<T0, T1, T2>(arg3, arg4, coin_to_vec<T0>(arg5), coin_to_vec<T1>(arg6), v0, 0x2::coin::value<T0>(&arg5), 0x2::coin::value<T1>(&arg6), 0, 0, 0x2::clock::timestamp_ms(arg7) + 60000, arg7, arg8, arg9);
        let (v3, v4, v5) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg4, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v0));
        (v1, v2, v3, v4, v5)
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"coin_type_a"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"coin_type_b"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"creator"));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{coin_type_a}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{coin_type_b}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"https://turbos.finance"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"Turbos Team"));
        let v2 = 0x2::package::claim<VAULT>(arg0, arg1);
        let v3 = 0x2::display::new<Vault>(&v2, arg1);
        0x2::display::add_multiple<Vault>(&mut v3, v0, v1);
        0x2::display::update_version<Vault>(&mut v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Vault>>(v3, 0x2::tx_context::sender(arg1));
    }

    fun init_account_balance(arg0: &mut Strategy, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Account{
            clmm_base_nft  : 0x1::option::none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(),
            clmm_limit_nft : 0x1::option::none<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(),
            balances       : 0x2::bag::new(arg2),
        };
        0x2::table::add<0x2::object::ID, Account>(&mut arg0.accounts, arg1, v0);
    }

    public fun is_clmm_base_nft_exists(arg0: &Strategy, arg1: 0x2::object::ID) : bool {
        0x1::option::is_some<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&borrow_vault_account(arg0, arg1).clmm_base_nft)
    }

    public fun is_clmm_limit_nft_exists(arg0: &Strategy, arg1: 0x2::object::ID) : bool {
        0x1::option::is_some<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&borrow_vault_account(arg0, arg1).clmm_limit_nft)
    }

    fun merge_protocol_asset<T0>(arg0: &mut Strategy, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::value<T0>(&arg1);
        let v0 = get_type_name_str<T0>();
        if (0x2::bag::contains<0x1::string::String>(&arg0.protocol_fees, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0), arg1);
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0, arg1);
        };
    }

    fun merge_vault_balance<T0>(arg0: &mut Strategy, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>) {
        0x2::balance::value<T0>(&arg2);
        let v0 = get_type_name_str<T0>();
        let v1 = borrow_mut_vault_account(arg0, arg1);
        if (0x2::bag::contains<0x1::string::String>(&v1.balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v1.balances, v0), arg2);
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v1.balances, v0, arg2);
        };
    }

    fun mint_clmm_liquidity<T0, T1, T2>(arg0: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg5: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg6: &0x2::clock::Clock, arg7: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg8: &mut 0x2::tx_context::TxContext) : (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::mint_with_return_<T0, T1, T2>(arg0, arg1, coin_to_vec<T0>(arg2), coin_to_vec<T1>(arg3), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(arg4), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(arg4), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::abs_u32(arg5), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::is_neg(arg5), 0x2::coin::value<T0>(&arg2), 0x2::coin::value<T1>(&arg3), 0, 0, 0x2::clock::timestamp_ms(arg6) + 60000, arg6, arg7, arg8)
    }

    public fun open_vault<T0, T1, T2>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg1: &mut Strategy, arg2: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg3: u32, arg4: bool, arg5: u32, arg6: bool, arg7: u32, arg8: bool, arg9: u32, arg10: bool, arg11: u32, arg12: u32, arg13: &mut 0x2::tx_context::TxContext) : Vault {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg0);
        assert!(arg1.status == 0, 15);
        assert!(arg1.clmm_pool_id == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg2), 17);
        assert!(arg11 >= arg1.base_tick_step_minimum && arg12 >= arg1.limit_tick_step_minimum, 14);
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32_neg(arg3, arg4);
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32_neg(arg5, arg6);
        let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32_neg(arg7, arg8);
        let v3 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32_neg(arg9, arg10);
        let v4 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg2);
        check_tick_range(arg1.base_tick_step_minimum, v4, v0, v1, arg1.tick_spacing);
        check_tick_range(arg1.limit_tick_step_minimum, v4, v2, v3, arg1.tick_spacing);
        let v5 = 0x1::type_name::get<T0>();
        let v6 = 0x1::type_name::get<T1>();
        let v7 = arg1.vault_index + 1;
        let v8 = 0x2::object::id<Strategy>(arg1);
        let v9 = Vault{
            id               : 0x2::object::new(arg13),
            index            : v7,
            strategy_id      : v8,
            coin_a_type_name : v5,
            coin_b_type_name : v6,
            name             : 0x1::string::utf8(b"Turbos Vault's NFT"),
            description      : 0x1::string::utf8(b"Turbos Vault's NFT"),
            url              : arg1.image_url,
        };
        init_account_balance(arg1, 0x2::object::id<Vault>(&v9), arg13);
        let v10 = 0x2::object::id<Vault>(&v9);
        let v11 = VaultInfo{
            vault_id                  : v10,
            strategy_id               : v8,
            coin_a_type_name          : v5,
            coin_b_type_name          : v6,
            base_clmm_position_id     : 0x2::object::id_from_address(@0x0),
            base_lower_index          : v0,
            base_upper_index          : v1,
            base_liquidity            : 0,
            limit_clmm_position_id    : 0x2::object::id_from_address(@0x0),
            limit_lower_index         : v2,
            limit_upper_index         : v3,
            limit_liquidity           : 0,
            sqrt_price                : 0,
            base_last_tick_index      : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::zero(),
            limit_last_tick_index     : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::zero(),
            base_rebalance_threshold  : arg1.default_base_rebalance_percentage,
            limit_rebalance_threshold : arg1.default_limit_rebalance_percentage,
            base_tick_step            : arg11,
            limit_tick_step           : arg12,
            share                     : 0,
            rewards                   : 0x2::vec_map::empty<0x1::type_name::TypeName, VaultRewardInfo>(),
            management_fee_rate       : 0x1::option::none<u64>(),
            performance_fee_rate      : 0x1::option::none<u64>(),
        };
        0x2::linked_table::push_back<0x2::object::ID, VaultInfo>(&mut arg1.vaults, v10, v11);
        arg1.vault_index = v7;
        let v12 = OpenVaultEvent{
            vault_id     : v10,
            strategy_id  : v8,
            clmm_pool_id : arg1.clmm_pool_id,
        };
        0x2::event::emit<OpenVaultEvent>(v12);
        v9
    }

    public fun rebalance<T0, T1, T2>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut 0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::rewarder::RewarderManager, arg3: &mut Strategy, arg4: 0x2::object::ID, arg5: bool, arg6: bool, arg7: u32, arg8: bool, arg9: u32, arg10: bool, arg11: u32, arg12: bool, arg13: u32, arg14: bool, arg15: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg16: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg17: &0x2::clock::Clock, arg18: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg19: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun rebalance_with_fee<T0, T1, T2>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut 0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::rewarder::RewarderManager, arg3: &mut Strategy, arg4: 0x2::object::ID, arg5: bool, arg6: bool, arg7: u32, arg8: bool, arg9: u32, arg10: bool, arg11: u32, arg12: bool, arg13: u32, arg14: bool, arg15: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg16: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg17: u64, arg18: u64, arg19: &0x2::clock::Clock, arg20: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg21: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        assert!(arg3.status == 0, 15);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_rebalance_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32_neg(arg7, arg8);
        let v1 = v0;
        let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32_neg(arg9, arg10);
        let v3 = v2;
        let v4 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32_neg(arg11, arg12);
        let v5 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from_u32_neg(arg13, arg14);
        let v6 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg15);
        let v7 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg15);
        let v8 = 0x2::balance::zero<T0>();
        let v9 = 0x2::balance::zero<T1>();
        if (!arg6) {
            check_tick_range(arg3.base_tick_step_minimum, v7, v0, v2, arg3.tick_spacing);
        };
        check_tick_range(arg3.limit_tick_step_minimum, v7, v4, v5, arg3.tick_spacing);
        collect_clmm_fees<T0, T1, T2>(arg1, arg3, arg4, arg15, arg16, arg19, arg20, arg21);
        let v10 = get_vault_base_clmm_position_id(arg3, arg4);
        let v11 = get_vault_base_liquidity(arg3, arg4);
        let v12 = get_vault_limit_clmm_position_id(arg3, arg4);
        let v13 = get_vault_limit_liquidity(arg3, arg4);
        let v14 = get_vault_base_last_tick_index(arg3, arg4);
        get_vault_limit_last_tick_index(arg3, arg4);
        if (is_clmm_limit_nft_exists(arg3, arg4)) {
            let v15 = borrow_mut_clmm_limit_nft(arg3, arg4);
            let (_, _, v18) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg16, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v15));
            if (v18 > 0) {
                let (v19, v20) = decrease_clmm_liquidity<T0, T1, T2>(v15, arg15, arg16, v18, arg19, arg20, arg21);
                v13 = 0;
                merge_vault_balance<T0>(arg3, arg4, 0x2::coin::into_balance<T0>(v19));
                merge_vault_balance<T1>(arg3, arg4, 0x2::coin::into_balance<T1>(v20));
            };
            burn_clmm_limit_nft<T0, T1, T2>(arg3, arg4, arg16, arg20, arg21);
        };
        let v21 = v5;
        let v22 = v4;
        if (is_clmm_base_nft_exists(arg3, arg4)) {
            if (arg6) {
                if (calculate_liquidity(v6, v0, v2, get_vault_balance<T0>(arg3, arg4), get_vault_balance<T1>(arg3, arg4)) > 0) {
                    let v23 = take_vault_balance<T0>(arg3, arg4);
                    let v24 = 0x2::coin::from_balance<T0>(v23, arg21);
                    let v25 = take_vault_balance<T1>(arg3, arg4);
                    let v26 = 0x2::coin::from_balance<T1>(v25, arg21);
                    let (v27, v28, v29, v30, v31) = increase_clmm_liquidity<T0, T1, T2>(arg3, arg4, true, arg15, arg16, v24, v26, arg19, arg20, arg21);
                    v11 = v31;
                    v3 = v30;
                    v1 = v29;
                    merge_vault_balance<T0>(arg3, arg4, 0x2::coin::into_balance<T0>(v27));
                    merge_vault_balance<T1>(arg3, arg4, 0x2::coin::into_balance<T1>(v28));
                };
            } else {
                let v32 = borrow_mut_clmm_base_nft(arg3, arg4);
                let (_, _, v35) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg16, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v32));
                let (v36, v37) = decrease_clmm_liquidity<T0, T1, T2>(v32, arg15, arg16, v35, arg19, arg20, arg21);
                merge_vault_balance<T0>(arg3, arg4, 0x2::coin::into_balance<T0>(v36));
                merge_vault_balance<T1>(arg3, arg4, 0x2::coin::into_balance<T1>(v37));
                burn_clmm_base_nft<T0, T1, T2>(arg3, arg4, arg16, arg20, arg21);
                v11 = 0;
                if (calculate_liquidity(v6, v0, v2, get_vault_balance<T0>(arg3, arg4), get_vault_balance<T1>(arg3, arg4)) > 0) {
                    let v38 = take_vault_balance<T0>(arg3, arg4);
                    let v39 = 0x2::coin::from_balance<T0>(v38, arg21);
                    let v40 = take_vault_balance<T1>(arg3, arg4);
                    let v41 = 0x2::coin::from_balance<T1>(v40, arg21);
                    let (v42, v43, v44) = mint_clmm_liquidity<T0, T1, T2>(arg15, arg16, v39, v41, v0, v2, arg19, arg20, arg21);
                    let v45 = v42;
                    merge_vault_balance<T0>(arg3, arg4, 0x2::coin::into_balance<T0>(v43));
                    merge_vault_balance<T1>(arg3, arg4, 0x2::coin::into_balance<T1>(v44));
                    let (_, _, v48) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg16, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v45));
                    v11 = v48;
                    v10 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::position_id(&v45);
                    fill_clmm_base_nft(arg3, arg4, v45);
                };
                v14 = v7;
            };
        } else {
            if (calculate_liquidity(v6, v0, v2, get_vault_balance<T0>(arg3, arg4), get_vault_balance<T1>(arg3, arg4)) > 0) {
                let v49 = take_vault_balance<T0>(arg3, arg4);
                let v50 = 0x2::coin::from_balance<T0>(v49, arg21);
                let v51 = take_vault_balance<T1>(arg3, arg4);
                let v52 = 0x2::coin::from_balance<T1>(v51, arg21);
                let (v53, v54, v55) = mint_clmm_liquidity<T0, T1, T2>(arg15, arg16, v50, v52, v0, v2, arg19, arg20, arg21);
                let v56 = v53;
                merge_vault_balance<T0>(arg3, arg4, 0x2::coin::into_balance<T0>(v54));
                merge_vault_balance<T1>(arg3, arg4, 0x2::coin::into_balance<T1>(v55));
                let (_, _, v59) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg16, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v56));
                v11 = v59;
                v10 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::position_id(&v56);
                fill_clmm_base_nft(arg3, arg4, v56);
            };
            v14 = v7;
        };
        let v60 = get_vault_balance<T0>(arg3, arg4);
        let v61 = get_vault_balance<T1>(arg3, arg4);
        let v62 = floor_tick_index(v7, arg3.tick_spacing, true);
        let v63 = floor_tick_index(v7, arg3.tick_spacing, false);
        let v64 = calculate_liquidity(v6, v4, v62, v60, v61);
        let v65 = calculate_liquidity(v6, v63, v5, v60, v61);
        if (v64 > 0 || v65 > 0) {
            let (v66, v67) = if (v64 > v65) {
                arg17 = 0;
                (v4, v62)
            } else {
                arg18 = 0;
                (v63, v5)
            };
            v21 = v67;
            v22 = v66;
            let v68 = &mut v8;
            let v69 = &mut v9;
            collect_rebalance_fee<T0, T1>(arg3, arg4, arg17, arg18, v68, v69);
            let v70 = take_vault_balance<T0>(arg3, arg4);
            let v71 = 0x2::coin::from_balance<T0>(v70, arg21);
            let v72 = take_vault_balance<T1>(arg3, arg4);
            let v73 = 0x2::coin::from_balance<T1>(v72, arg21);
            let (v74, v75, v76) = mint_clmm_liquidity<T0, T1, T2>(arg15, arg16, v71, v73, v66, v67, arg19, arg20, arg21);
            let v77 = v74;
            let (_, _, v80) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg16, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(&v77));
            v13 = v80;
            v12 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::position_id(&v77);
            fill_clmm_limit_nft(arg3, arg4, v77);
            merge_vault_balance<T0>(arg3, arg4, 0x2::coin::into_balance<T0>(v75));
            merge_vault_balance<T1>(arg3, arg4, 0x2::coin::into_balance<T1>(v76));
        };
        update_vault_info_with_tick_range(arg3, arg4, v10, v1, v3, v11, v12, v22, v21, v13, v6, v14, v7);
        update_strategy_reward_info(arg2, arg3, arg4, arg19);
        let v81 = CheckRebalance{
            vault_id           : arg4,
            rebalance          : arg5,
            base_lower_index   : v1,
            base_upper_index   : v3,
            base_just_increase : arg6,
            limit_lower_index  : v22,
            limit_upper_index  : v21,
        };
        let (v82, v83, v84, v85, v86, v87) = get_vault_amount<T0, T1, T2>(arg3, arg15, arg4);
        let v88 = RebalanceEvent{
            vault_id       : arg4,
            strategy_id    : 0x2::object::id<Strategy>(arg3),
            clmm_pool_id   : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg15),
            checkRebalance : v81,
            sqrt_price     : v6,
            amount_a_left  : v82,
            amount_b_left  : v83,
            base_amount_a  : v84,
            base_amount_b  : v85,
            limit_amount_a : v86,
            limit_amount_b : v87,
        };
        0x2::event::emit<RebalanceEvent>(v88);
        (0x2::coin::from_balance<T0>(v8, arg21), 0x2::coin::from_balance<T1>(v9, arg21))
    }

    fun remove_vault_info(arg0: &mut Strategy, arg1: 0x2::object::ID) : VaultInfo {
        0x2::linked_table::remove<0x2::object::ID, VaultInfo>(&mut arg0.vaults, arg1)
    }

    fun take_protocol_asset_by_amount<T0>(arg0: &mut Strategy, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = get_type_name_str<T0>();
        assert!(0x2::bag::contains<0x1::string::String>(&arg0.protocol_fees, v0), 11);
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fees, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 12);
        0x2::balance::split<T0>(v1, arg1)
    }

    fun take_vault_balance<T0>(arg0: &mut Strategy, arg1: 0x2::object::ID) : 0x2::balance::Balance<T0> {
        let v0 = get_type_name_str<T0>();
        let v1 = borrow_mut_vault_account(arg0, arg1);
        if (0x2::bag::contains<0x1::string::String>(&v1.balances, v0)) {
            0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v1.balances, v0)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    fun take_vault_balance_by_amount<T0>(arg0: &mut Strategy, arg1: 0x2::object::ID, arg2: u64) : 0x2::balance::Balance<T0> {
        let v0 = get_type_name_str<T0>();
        let v1 = borrow_mut_vault_account(arg0, arg1);
        if (0x2::bag::contains<0x1::string::String>(&v1.balances, v0) && arg2 > 0) {
            let v3 = 0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v1.balances, v0);
            let v4 = 0x2::balance::value<T0>(v3);
            let v5 = if (v4 >= arg2) {
                arg2
            } else {
                v4
            };
            0x2::balance::split<T0>(v3, v5)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public(friend) fun update_strategy_base_minimum_threshold(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut Strategy, arg3: u32) : u32 {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_vault_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        arg2.base_tick_step_minimum = arg3;
        arg3
    }

    public(friend) fun update_strategy_default_base_rebalance_threshold(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut Strategy, arg3: u32) : u32 {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_vault_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        arg2.default_base_rebalance_percentage = arg3;
        arg3
    }

    public(friend) fun update_strategy_default_limit_rebalance_threshold(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut Strategy, arg3: u32) : u32 {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_vault_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        arg2.default_limit_rebalance_percentage = arg3;
        arg3
    }

    public(friend) fun update_strategy_image_url(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut Strategy, arg3: 0x1::string::String) : 0x1::string::String {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_vault_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        arg2.image_url = arg3;
        arg3
    }

    public(friend) fun update_strategy_limit_minimum_threshold(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut Strategy, arg3: u32) : u32 {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_vault_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        arg2.limit_tick_step_minimum = arg3;
        arg3
    }

    public(friend) fun update_strategy_management_fee_rate(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut Strategy, arg3: u64) : u64 {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_vault_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        assert!(arg3 <= 1000000, 5);
        arg2.management_fee_rate = arg3;
        let v0 = UpdateStrategyManagementFeeRateEvent{
            strategy_id : 0x2::object::id<Strategy>(arg2),
            old_rate    : arg2.management_fee_rate,
            new_rate    : arg3,
        };
        0x2::event::emit<UpdateStrategyManagementFeeRateEvent>(v0);
        arg3
    }

    public(friend) fun update_strategy_performance_fee_rate(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut Strategy, arg3: u64) : u64 {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_vault_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        assert!(arg3 <= 1000000, 5);
        arg2.performance_fee_rate = arg3;
        let v0 = UpdateStrategyPerformanceFeeRateEvent{
            strategy_id : 0x2::object::id<Strategy>(arg2),
            old_rate    : arg2.performance_fee_rate,
            new_rate    : arg3,
        };
        0x2::event::emit<UpdateStrategyPerformanceFeeRateEvent>(v0);
        arg3
    }

    fun update_strategy_reward_info(arg0: &mut 0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::rewarder::RewarderManager, arg1: &mut Strategy, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u128 {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0x2::object::id<Strategy>(arg1);
        let (v3, v4, v5, v6, v7, v8, v9, v10, _) = get_vault_info(arg1, arg2);
        if (!0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::rewarder::is_in_black_list(arg0, 0x2::object::id_to_address(&arg2))) {
            if (is_clmm_base_nft_exists(arg1, arg2)) {
                v1 = v0 + calculate_position_share(v3, v4, v5, v9, arg1.effective_tick_lower, arg1.effective_tick_upper);
            };
            if (is_clmm_limit_nft_exists(arg1, arg2)) {
                v1 = v1 + calculate_position_share(v6, v7, v8, v9, arg1.effective_tick_lower, arg1.effective_tick_upper);
            };
        };
        let v12 = arg1.total_share - v10 + v1;
        let v13 = 0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::rewarder::strategy_rewards_settle(arg0, arg1.rewarders, v2, arg3);
        update_vault_reward_info(arg1, arg2, v13, v1);
        arg1.total_share = v12;
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::rewarder::set_strategy_share(arg0, v2, v12);
        v1
    }

    public(friend) fun update_strategy_status(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut Strategy, arg3: u8) : u8 {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_vault_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        arg2.status = arg3;
        arg3
    }

    public(friend) fun update_vault_base_rebalance_threshold(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut Strategy, arg3: 0x2::object::ID, arg4: u32) : u32 {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_vault_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        borrow_mut_vault_info(arg2, arg3).base_rebalance_threshold = arg4;
        arg4
    }

    fun update_vault_info(arg0: &mut Strategy, arg1: 0x2::object::ID, arg2: u128, arg3: u128, arg4: u128) {
        let v0 = borrow_mut_vault_info(arg0, arg1);
        v0.base_liquidity = arg2;
        v0.limit_liquidity = arg3;
        v0.sqrt_price = arg4;
    }

    fun update_vault_info_with_tick_range(arg0: &mut Strategy, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg4: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg5: u128, arg6: 0x2::object::ID, arg7: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg8: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg9: u128, arg10: u128, arg11: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32, arg12: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32) {
        let v0 = borrow_mut_vault_info(arg0, arg1);
        v0.base_clmm_position_id = arg2;
        v0.base_lower_index = arg3;
        v0.base_upper_index = arg4;
        v0.base_liquidity = arg5;
        v0.limit_clmm_position_id = arg6;
        v0.limit_lower_index = arg7;
        v0.limit_upper_index = arg8;
        v0.limit_liquidity = arg9;
        v0.sqrt_price = arg10;
        v0.base_last_tick_index = arg11;
        v0.limit_last_tick_index = arg12;
    }

    public(friend) fun update_vault_limit_rebalance_threshold(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut Strategy, arg3: 0x2::object::ID, arg4: u32) : u32 {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_vault_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        borrow_mut_vault_info(arg2, arg3).limit_rebalance_threshold = arg4;
        arg4
    }

    public(friend) fun update_vault_management_fee_rate(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut Strategy, arg3: 0x2::object::ID, arg4: u64) : u64 {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_vault_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        let v0 = borrow_mut_vault_info(arg2, arg3);
        assert!(arg4 <= 1000000, 5);
        0x1::option::fill<u64>(&mut v0.management_fee_rate, arg4);
        let v1 = UpdateVaultManagementFeeRateEvent{
            strategy_id : 0x2::object::id<Strategy>(arg2),
            vault_id    : arg3,
            old_rate    : 0x1::option::get_with_default<u64>(&v0.management_fee_rate, 0),
            new_rate    : arg4,
        };
        0x2::event::emit<UpdateVaultManagementFeeRateEvent>(v1);
        arg4
    }

    public(friend) fun update_vault_performance_fee_rate(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap, arg1: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg2: &mut Strategy, arg3: 0x2::object::ID, arg4: u64) : u64 {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg1);
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::check_vault_manager_role(arg1, 0x2::object::id_address<0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::OperatorCap>(arg0));
        let v0 = borrow_mut_vault_info(arg2, arg3);
        assert!(arg4 <= 1000000, 5);
        0x1::option::fill<u64>(&mut v0.performance_fee_rate, arg4);
        let v1 = UpdateVaultPerformanceFeeRateEvent{
            strategy_id : 0x2::object::id<Strategy>(arg2),
            vault_id    : arg3,
            old_rate    : 0x1::option::get_with_default<u64>(&v0.performance_fee_rate, 0),
            new_rate    : arg4,
        };
        0x2::event::emit<UpdateVaultPerformanceFeeRateEvent>(v1);
        arg4
    }

    fun update_vault_reward_info(arg0: &mut Strategy, arg1: 0x2::object::ID, arg2: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u128>, arg3: u128) {
        let v0 = borrow_mut_vault_info(arg0, arg1);
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x1::type_name::TypeName, u128>(&arg2)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, u128>(&arg2, v1);
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, VaultRewardInfo>(&v0.rewards, v2)) {
                let v4 = VaultRewardInfo{
                    reward           : 0,
                    reward_debt      : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_floor(*v3, arg3, 1000000000),
                    reward_harvested : 0,
                };
                0x2::vec_map::insert<0x1::type_name::TypeName, VaultRewardInfo>(&mut v0.rewards, *v2, v4);
            } else {
                let v5 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, VaultRewardInfo>(&mut v0.rewards, v2);
                v5.reward = v5.reward + 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_floor(*v3, v0.share, 1000000000) - v5.reward_debt;
                v5.reward_debt = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_floor(*v3, arg3, 1000000000);
            };
            v1 = v1 + 1;
        };
        v0.share = arg3;
    }

    fun update_vault_reward_info_on_claim(arg0: &mut Strategy, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName) : u64 {
        let v0 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, VaultRewardInfo>(&mut borrow_mut_vault_info(arg0, arg1).rewards, &arg2);
        let v1 = v0.reward;
        v0.reward = 0;
        v0.reward_harvested = v0.reward_harvested + v1;
        (v1 as u64)
    }

    public fun vault_balance_amount<T0>(arg0: &Strategy, arg1: 0x2::object::ID) : u64 {
        let v0 = get_type_name_str<T0>();
        let v1 = borrow_vault_account(arg0, arg1);
        if (0x2::bag::contains<0x1::string::String>(&v1.balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(&v1.balances, v0))
        } else {
            0
        }
    }

    public fun withdraw<T0, T1, T2>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg1: &mut 0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::rewarder::RewarderManager, arg2: &mut Strategy, arg3: &mut Vault, arg4: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        abort 0
    }

    public fun withdraw_v2<T0, T1, T2>(arg0: &0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::GlobalConfig, arg1: &mut 0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::UserTierConfig, arg2: &mut 0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::rewarder::RewarderManager, arg3: &mut Strategy, arg4: &mut Vault, arg5: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg6: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::Positions, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xa0d6e83196f523bb0623187d789ce602d1f63b3e7baa02b580df7ff0ccd17e0::config::checked_package_version(arg0);
        assert!(arg3.status == 0, 15);
        assert!(arg7 > 0 && arg7 <= 1000000, 2);
        assert!(arg3.clmm_pool_id == 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg5), 17);
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg5);
        let v1 = 0x2::object::id<Vault>(arg4);
        collect_clmm_fees<T0, T1, T2>(arg0, arg3, v1, arg5, arg6, arg9, arg10, arg11);
        let v2 = 0x2::coin::zero<T0>(arg11);
        let v3 = 0x2::coin::zero<T1>(arg11);
        let v4 = 0;
        let v5 = is_clmm_base_nft_exists(arg3, v1);
        if (v5) {
            let v6 = borrow_mut_clmm_base_nft(arg3, v1);
            let (_, _, v9) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg6, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v6));
            if (v9 > 0) {
                let (v10, v11) = decrease_clmm_liquidity<T0, T1, T2>(v6, arg5, arg6, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_floor(v9, (arg7 as u128), (1000000 as u128)), arg9, arg10, arg11);
                let (_, _, v14) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg6, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v6));
                v4 = v14;
                0x2::coin::join<T0>(&mut v2, v10);
                0x2::coin::join<T1>(&mut v3, v11);
            };
        };
        let v15 = 0;
        let v16 = is_clmm_limit_nft_exists(arg3, v1);
        if (v16) {
            let v17 = borrow_mut_clmm_limit_nft(arg3, v1);
            let (_, _, v20) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg6, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v17));
            if (v20 > 0) {
                let (v21, v22) = decrease_clmm_liquidity<T0, T1, T2>(v17, arg5, arg6, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u128::mul_div_floor(v20, (arg7 as u128), (1000000 as u128)), arg9, arg10, arg11);
                let (_, _, v25) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_manager::get_position_info(arg6, 0x2::object::id_address<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft::TurbosPositionNFT>(v17));
                v15 = v25;
                0x2::coin::join<T0>(&mut v2, v21);
                0x2::coin::join<T1>(&mut v3, v22);
            };
        };
        let v26 = vault_balance_amount<T1>(arg3, v1);
        let v27 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u64::mul_div_floor(vault_balance_amount<T0>(arg3, v1), arg7, 1000000);
        let v28 = take_vault_balance_by_amount<T0>(arg3, v1, v27);
        let v29 = take_vault_balance_by_amount<T1>(arg3, v1, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u64::mul_div_floor(v26, arg7, 1000000));
        0x2::coin::join<T0>(&mut v2, 0x2::coin::from_balance<T0>(v28, arg11));
        0x2::coin::join<T1>(&mut v3, 0x2::coin::from_balance<T1>(v29, arg11));
        let v30 = get_management_fee_rate_v2(arg0, arg1, arg3, v1, arg11);
        let (v31, v32) = if (v30 == 0) {
            (0, 0)
        } else {
            let v33 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u64::mul_div_ceil(0x2::coin::value<T0>(&v2), v30, 1000000);
            let v34 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::full_math_u64::mul_div_ceil(0x2::coin::value<T1>(&v3), v30, 1000000);
            merge_protocol_asset<T0>(arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v2, v33, arg11)));
            merge_protocol_asset<T1>(arg3, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v3, v34, arg11)));
            (v33, v34)
        };
        if (arg8 && arg7 == 1000000) {
            if (v5) {
                burn_clmm_base_nft<T0, T1, T2>(arg3, v1, arg6, arg10, arg11);
            };
            if (v16) {
                burn_clmm_limit_nft<T0, T1, T2>(arg3, v1, arg6, arg10, arg11);
            };
        };
        update_vault_info(arg3, v1, v4, v15, v0);
        update_strategy_reward_info(arg2, arg3, v1, arg9);
        borrow_vault_info(arg3, v1);
        let v35 = WithdrawEvent{
            vault_id              : v1,
            strategy_id           : 0x2::object::id<Strategy>(arg3),
            clmm_pool_id          : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>>(arg5),
            percentage            : arg7,
            burn_clmm_nft         : arg8,
            amount_a              : 0x2::coin::value<T0>(&v2),
            amount_b              : 0x2::coin::value<T1>(&v3),
            protocol_fee_a_amount : v31,
            protocol_fee_b_amount : v32,
        };
        0x2::event::emit<WithdrawEvent>(v35);
        (v2, v3)
    }

    // decompiled from Move bytecode v6
}

