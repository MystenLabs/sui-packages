module 0xfcfa552dec4d7ca59ed03ce30cece596402939ef45fe5d68971999fc1e75bc77::lockdrop {
    struct LockdropRewardsCapabilityHolder has key {
        id: 0x2::object::UID,
        capability: 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::ProfileDofOwnershipCapability,
    }

    struct LockdropVault has store, key {
        id: 0x2::object::UID,
        hive_profile: 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveProfile,
        user_profile_access_cap: 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::ProfileDofOwnershipCapability,
        krafted_pools: 0x2::table::Table<0x1::string::String, address>,
        sui_total_locked: u64,
        sui_total_weighted_units: u128,
        hive_sui_total_received: u64,
        hive_available: 0x2::balance::Balance<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>,
        total_hive_incentives: u64,
        degenhive_lps_krafted: 0x2::balance::Balance<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<0x2::sui::SUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::curves::Curved>>,
        total_lp_krafted: u64,
        are_staked_with_pool_hive: bool,
        dlps_staked_amount: u64,
        hive_gems_per_share: u256,
        bee_fruit_indexes: 0x2::linked_table::LinkedTable<0x1::ascii::String, u256>,
    }

    struct LockdropForPool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        hive_profile: 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveProfile,
        user_profile_access_cap: 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::ProfileDofOwnershipCapability,
        cetus_state: LockdropCetusState<T0, T1>,
        kriya_state: LockdropKriyaState,
        flowx_state: LockdropFlowxState,
        total_withdrawn_x_balance: 0x2::balance::Balance<T0>,
        total_withdrawn_y_balance: 0x2::balance::Balance<T1>,
        degenhive_lps_krafted: 0x2::balance::Balance<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<T0, T1, T2>>,
        total_lp_krafted: u128,
        are_staked_with_pool_hive: bool,
        dlps_staked_amount: u64,
        hive_gems_per_share: u256,
        bee_fruit_indexes: 0x2::linked_table::LinkedTable<0x1::ascii::String, u256>,
    }

    struct LockdropCetusState<phantom T0, phantom T1> has store {
        total_positions_liquidity: u128,
        total_weighted_units: u128,
        total_x_withdrawn: u64,
        total_y_withdrawn: u64,
        x_fee_withdrawn: 0x2::balance::Balance<T0>,
        y_fee_withdrawn: 0x2::balance::Balance<T1>,
        total_sui_earned: u64,
        total_cetus_earned: u64,
        sui_earned_bal: 0x2::balance::Balance<0x2::sui::SUI>,
        cetus_earned_bal: 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>,
        total_hive_incentives: u64,
        total_dlps_amount: u64,
    }

    struct LockdropKriyaState has store {
        total_lp_locked: u128,
        total_weighted_units: u128,
        total_x_withdrawn: u64,
        total_y_withdrawn: u64,
        total_hive_incentives: u64,
        total_dlps_amount: u64,
    }

    struct LockdropFlowxState has store {
        total_lp_locked: u128,
        total_weighted_units: u128,
        total_x_withdrawn: u64,
        total_y_withdrawn: u64,
        total_hive_incentives: u64,
        total_dlps_amount: u64,
    }

    struct BeeFruitDistributor<phantom T0> has store, key {
        id: 0x2::object::UID,
        claim_index: u256,
        available_bee_fruits: 0x2::balance::Balance<T0>,
        total_bee_fruits_earned: u64,
    }

    struct UserLockdropRewardsPosition has store, key {
        id: 0x2::object::UID,
        available_hive_rewards: 0x2::balance::Balance<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>,
        total_hive_rewards: u64,
        delegated_hive_rewards: u64,
        claimed_hive_rewards: u64,
    }

    struct UserLockdropHivePosition has store, key {
        id: 0x2::object::UID,
        vesting_init_timestamp: u64,
        sui_lockdrop: UserSuiLockdropState,
        cetus_lockdrop: UserCetusLockdropState,
        kriya_lockdrop: UserKriyaLockdropState,
        flowx_lockdrop: UserFlowxLockdropState,
        total_degenhive_lp_tokens: u64,
        unbonded_degenhive_lp_tokens: u64,
        lp_to_unlock: 0x2::linked_table::LinkedTable<u64, u64>,
        claimed_lp_shares: u64,
        hive_gems_per_share: u256,
        gems_streamed_from_staking: u64,
        bee_fruit_indexes: 0x2::linked_table::LinkedTable<0x1::ascii::String, u256>,
        total_bee_fruits_earned: 0x2::linked_table::LinkedTable<0x1::ascii::String, u128>,
    }

    struct UserSuiLockdropState has store {
        lockup_weeks: vector<u64>,
        locked_per_position: 0x2::table::Table<u64, u64>,
        lockup_weighted_units: 0x2::table::Table<u64, u128>,
        unlock_timestamps: 0x2::table::Table<u64, u64>,
        dlp_per_lockup: 0x2::table::Table<u64, u64>,
        dlp_claim_flag: 0x2::table::Table<u64, bool>,
        hive_rewards_per_lockup: 0x2::table::Table<u64, u64>,
    }

    struct UserCetusLockdropState has store {
        lockup_weeks: vector<u64>,
        x_withdrawn: 0x2::table::Table<u64, u64>,
        y_withdrawn: 0x2::table::Table<u64, u64>,
        fee_earned_x: 0x2::table::Table<u64, u64>,
        fee_earned_y: 0x2::table::Table<u64, u64>,
        sui_earned: 0x2::table::Table<u64, u64>,
        earned: 0x2::table::Table<u64, u64>,
        position_liquidity: 0x2::table::Table<u64, u128>,
        weighted_units: 0x2::table::Table<u64, u128>,
        hive_rewards_per_lockup: 0x2::table::Table<u64, u64>,
        unlock_timestamps: 0x2::table::Table<u64, u64>,
        dlp_per_lockup: 0x2::table::Table<u64, u64>,
        dlp_claim_flag: 0x2::table::Table<u64, bool>,
    }

    struct UserKriyaLockdropState has store {
        lockup_weeks: vector<u64>,
        lp_tokens_locked: 0x2::table::Table<u64, u64>,
        lockup_weighted_units: 0x2::table::Table<u64, u128>,
        hive_rewards_per_lockup: 0x2::table::Table<u64, u64>,
        unlock_timestamps: 0x2::table::Table<u64, u64>,
        dlp_per_lockup: 0x2::table::Table<u64, u64>,
        dlp_claim_flag: 0x2::table::Table<u64, bool>,
    }

    struct UserFlowxLockdropState has store {
        lockup_weeks: vector<u64>,
        lp_tokens_locked: 0x2::table::Table<u64, u64>,
        lockup_weighted_units: 0x2::table::Table<u64, u128>,
        hive_rewards_per_lockup: 0x2::table::Table<u64, u64>,
        unlock_timestamps: 0x2::table::Table<u64, u64>,
        dlp_per_lockup: 0x2::table::Table<u64, u64>,
        dlp_claim_flag: 0x2::table::Table<u64, bool>,
    }

    struct LockdropRewardsCapabilityHolderInitialized has copy, drop {
        addr: address,
    }

    struct LockdropVaultInitialized has copy, drop {
        vault_addr: address,
        profile_addr: address,
        profile_username: 0x1::string::String,
    }

    struct LockdropPoolInitialized<phantom T0, phantom T1, phantom T2> has copy, drop {
        pool_addr: address,
        profile_addr: address,
        profile_username: 0x1::string::String,
    }

    struct DegenHiveLpTokensKrafted<phantom T0, phantom T1, phantom T2> has copy, drop {
        dlp_shares_krafted: u64,
        cetus_total_dlps_amount: u64,
        kriya_total_dlps_amount: u64,
        flowx_total_dlps_amount: u64,
    }

    struct UserSuiLockupPositionMigrated has copy, drop {
        user_addr: address,
        username: 0x1::string::String,
        profile_addr: address,
        total_sui_locked: u128,
        hive_earned_from_sui_lockdrop: u64,
        dlp_claimable_for_sui_lockdrop: u64,
    }

    struct UserCetusPositionMigrated has copy, drop {
        user_addr: address,
        username: 0x1::string::String,
        profile_addr: address,
        total_user_cetus_positions: u64,
        hive_earned_from_cetus_attack: u64,
        dlp_claimable_for_cetus_attack: u64,
    }

    struct UserKriyaPositionMigrated has copy, drop {
        user_addr: address,
        username: 0x1::string::String,
        profile_addr: address,
        total_user_kriya_positions: u64,
        hive_earned_from_kriya_attack: u64,
        dlp_claimable_for_kriya_attack: u64,
    }

    struct UserFlowxPositionMigrated has copy, drop {
        user_addr: address,
        username: 0x1::string::String,
        profile_addr: address,
        total_user_flowx_positions: u64,
        hive_earned_from_flowx_attack: u64,
        dlp_claimable_for_flowx_attack: u64,
    }

    struct PositionsUnlockedAndRewardsClaimed has copy, drop {
        user_addr: address,
        username: 0x1::string::String,
        profile_addr: address,
        unbondable_sui_lp_positions: vector<u64>,
        unbondable_cetus_positions: vector<u64>,
        unbondable_kriya_positions: vector<u64>,
        unbondable_flowx_positions: vector<u64>,
        unbond_lp_shares_amt: u64,
        claimable_hive: u64,
        gems_via_staking_yield: u64,
    }

    struct FruitsEarnedByUser has copy, drop {
        type: 0x1::ascii::String,
        username: 0x1::string::String,
        new_fruits_received_from_hive: u64,
        distributor_claim_index: u256,
        distributor_total_bee_fruits_earned: u64,
        user_claim_index: u256,
        user_total_fruits_earned: u128,
        new_fruits_earned_by_user: u128,
    }

    public entry fun infuse_sui_hsui_pool(arg0: &0x2::clock::Clock, arg1: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg2: &mut LockdropVault, arg3: &mut 0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LiquidityPool<0x2::sui::SUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::curves::Curved>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2974b604af3d56e1eed6889e78c3f0f1434ae5e8d088e2e16a1ebb94fc76889f::hsui_vault::HSuiVault, arg6: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HiveVault, arg7: &mut 0x30f1432c9b62a8f25f48d95751367a69539513fd06f23ed7b69cd5f4db90ad61::lsd_lockdrop::LsdLockdropVault, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        let (v0, v1, v2, v3, v4) = 0x30f1432c9b62a8f25f48d95751367a69539513fd06f23ed7b69cd5f4db90ad61::lsd_lockdrop::infuse_sui_hsui_pool(arg0, arg1, arg7, arg4, arg5, arg8);
        let v5 = v2;
        let v6 = v1;
        let v7 = v0;
        let v8 = 0x2::balance::value<0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI>(&v7);
        let v9 = 0x2::balance::value<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>(&v5);
        arg2.sui_total_locked = arg2.sui_total_locked + v3;
        arg2.sui_total_weighted_units = arg2.sui_total_weighted_units + v4;
        arg2.hive_sui_total_received = arg2.hive_sui_total_received + v8;
        arg2.total_hive_incentives = arg2.total_hive_incentives + v9;
        0x2::balance::destroy_zero<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>(0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::burn_hive_and_return(arg6, &mut arg2.hive_profile, v5, v9, arg8));
        let v10 = 0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::add_liquidity<0x2::sui::SUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::curves::Curved>(arg0, arg3, v6, v7, 0);
        arg2.total_lp_krafted = arg2.total_lp_krafted + 0x2::balance::value<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<0x2::sui::SUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::curves::Curved>>(&v10);
        0x2::balance::join<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<0x2::sui::SUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::curves::Curved>>(&mut arg2.degenhive_lps_krafted, v10);
        (v8, 0x2::balance::value<0x2::sui::SUI>(&v6), 0x2::balance::value<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<0x2::sui::SUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::curves::Curved>>(&v10), v9)
    }

    public entry fun extract_liquidity_from_kriya<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg2: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HiveVault, arg3: &mut LockdropForPool<T0, T1, T2>, arg4: &0x87b123b22b31e4f373691e389a181f1e294695a834089bec9bad15bc875203d2::kriya_vampire_attack::KriyaAttackConfig, arg5: &mut 0x87b123b22b31e4f373691e389a181f1e294695a834089bec9bad15bc875203d2::kriya_vampire_attack::KriyaLockdropForPool<T0, T1>, arg6: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg7: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, u64, u64) {
        let (v0, v1, v2, v3, v4, v5) = 0x87b123b22b31e4f373691e389a181f1e294695a834089bec9bad15bc875203d2::kriya_vampire_attack::extract_liquidity_from_kriya<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7);
        let v6 = v4;
        let v7 = v3;
        let v8 = 0x2::balance::value<T0>(&v7);
        let v9 = 0x2::balance::value<T1>(&v6);
        arg3.kriya_state.total_lp_locked = arg3.kriya_state.total_lp_locked + v0;
        arg3.kriya_state.total_weighted_units = arg3.kriya_state.total_weighted_units + v1;
        arg3.kriya_state.total_hive_incentives = arg3.kriya_state.total_hive_incentives + v2;
        arg3.kriya_state.total_x_withdrawn = arg3.kriya_state.total_x_withdrawn + v8;
        arg3.kriya_state.total_y_withdrawn = arg3.kriya_state.total_y_withdrawn + v9;
        0x2::balance::join<T0>(&mut arg3.total_withdrawn_x_balance, v7);
        0x2::balance::join<T1>(&mut arg3.total_withdrawn_y_balance, v6);
        0x2::balance::destroy_zero<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>(0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::burn_hive_and_return(arg2, &mut arg3.hive_profile, v5, v2, arg7));
        (v0, v1, v2, v8, v9)
    }

    public entry fun extract_liquidity_from_flowx<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg2: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HiveVault, arg3: &mut LockdropForPool<T0, T1, T2>, arg4: &0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::FlowxAttackConfig, arg5: &mut 0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::FlowxLockdropForPool<T0, T1>, arg6: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg7: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, u64, u64) {
        let (v0, v1, v2, v3, v4, v5) = 0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::extract_liquidity_from_flowx<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7);
        internal_extract_flowx_liquidity<T0, T1, T2>(arg3, arg2, v0, v1, v2, v3, v4, v5, arg7)
    }

    public fun add_incentives_for_cetus_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::LockdropForPool<T0, T1>, arg2: &0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::CetusAttackConfig, arg3: 0x2::coin::Coin<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x1::string::String) {
        0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::add_incentives_for_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun add_incentives_for_flowx_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::FlowxLockdropForPool<T0, T1>, arg2: &0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::FlowxAttackConfig, arg3: 0x2::coin::Coin<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x1::string::String) {
        0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::add_incentives_for_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun add_incentives_for_kriya_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x87b123b22b31e4f373691e389a181f1e294695a834089bec9bad15bc875203d2::kriya_vampire_attack::KriyaLockdropForPool<T0, T1>, arg2: &0x87b123b22b31e4f373691e389a181f1e294695a834089bec9bad15bc875203d2::kriya_vampire_attack::KriyaAttackConfig, arg3: 0x2::coin::Coin<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x1::string::String) {
        0x87b123b22b31e4f373691e389a181f1e294695a834089bec9bad15bc875203d2::kriya_vampire_attack::add_incentives_for_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun add_incentives_for_lsd_lockdrop(arg0: &0x2::clock::Clock, arg1: &mut 0x30f1432c9b62a8f25f48d95751367a69539513fd06f23ed7b69cd5f4db90ad61::lsd_lockdrop::LsdLockdropVault, arg2: 0x2::coin::Coin<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0x30f1432c9b62a8f25f48d95751367a69539513fd06f23ed7b69cd5f4db90ad61::lsd_lockdrop::add_hive_incentives(arg0, arg1, arg2, arg3, arg4)
    }

    public entry fun add_liquidity_to_degenhive<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg2: &mut LockdropForPool<T0, T1, T2>, arg3: &mut 0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LiquidityPool<T0, T1, T2>, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        assert!(0x2::balance::value<T0>(&arg2.total_withdrawn_x_balance) > 0 && 0x2::balance::value<T1>(&arg2.total_withdrawn_y_balance) > 0, 1800);
        let v0 = 0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::add_liquidity<T0, T1, T2>(arg0, arg3, 0x2::balance::withdraw_all<T0>(&mut arg2.total_withdrawn_x_balance), 0x2::balance::withdraw_all<T1>(&mut arg2.total_withdrawn_y_balance), 0);
        arg2.total_lp_krafted = arg2.total_lp_krafted + (0x2::balance::value<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<T0, T1, T2>>(&v0) as u128);
        0x2::balance::join<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<T0, T1, T2>>(&mut arg2.degenhive_lps_krafted, v0);
        let v1 = ((arg2.cetus_state.total_x_withdrawn + arg2.kriya_state.total_x_withdrawn + arg2.flowx_state.total_x_withdrawn) as u256);
        let v2 = ((arg2.cetus_state.total_y_withdrawn + arg2.kriya_state.total_y_withdrawn + arg2.flowx_state.total_y_withdrawn) as u256);
        let v3 = ((0x2::balance::value<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<T0, T1, T2>>(&v0) / 2) as u256);
        arg2.cetus_state.total_dlps_amount = (0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::math::mul_div_u256((arg2.cetus_state.total_x_withdrawn as u256), v3, v1) as u64);
        arg2.cetus_state.total_dlps_amount = arg2.cetus_state.total_dlps_amount + (0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::math::mul_div_u256((arg2.cetus_state.total_y_withdrawn as u256), v3, v2) as u64);
        arg2.kriya_state.total_dlps_amount = (0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::math::mul_div_u256((arg2.kriya_state.total_x_withdrawn as u256), v3, v1) as u64);
        arg2.kriya_state.total_dlps_amount = arg2.kriya_state.total_dlps_amount + (0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::math::mul_div_u256((arg2.flowx_state.total_y_withdrawn as u256), v3, v2) as u64);
        arg2.flowx_state.total_dlps_amount = (0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::math::mul_div_u256((arg2.flowx_state.total_x_withdrawn as u256), v3, v1) as u64);
        arg2.flowx_state.total_dlps_amount = arg2.flowx_state.total_dlps_amount + (0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::math::mul_div_u256((arg2.flowx_state.total_y_withdrawn as u256), v3, v2) as u64);
        let v4 = DegenHiveLpTokensKrafted<T0, T1, T2>{
            dlp_shares_krafted      : (arg2.total_lp_krafted as u64),
            cetus_total_dlps_amount : arg2.cetus_state.total_dlps_amount,
            kriya_total_dlps_amount : arg2.kriya_state.total_dlps_amount,
            flowx_total_dlps_amount : arg2.flowx_state.total_dlps_amount,
        };
        0x2::event::emit<DegenHiveLpTokensKrafted<T0, T1, T2>>(v4);
        ((arg2.total_lp_krafted as u64), arg2.cetus_state.total_dlps_amount, arg2.kriya_state.total_dlps_amount, arg2.flowx_state.total_dlps_amount)
    }

    fun calculate_dlp_for_cetus_position(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u128) : u64 {
        (0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::math::mul_div_u256((arg0 as u256), ((arg4 / 2) as u256), (arg1 as u256)) as u64) + (0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::math::mul_div_u256((arg2 as u256), ((arg4 / 2) as u256), (arg3 as u256)) as u64)
    }

    fun calculate_dlp_for_position(arg0: u128, arg1: u128, arg2: u128) : u64 {
        if (arg2 == 0) {
            0
        } else {
            (0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::math::mul_div_u256((arg0 as u256), (arg1 as u256), (arg2 as u256)) as u64)
        }
    }

    fun calculate_hive_rewards(arg0: u128, arg1: u128, arg2: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            (0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::math::mul_div_u256((arg2 as u256), (arg0 as u256), (arg1 as u256)) as u64)
        }
    }

    fun calculate_withdrawable_hive(arg0: u64, arg1: u64) : u64 {
        if (arg0 > 1700161652000 + 15552000000) {
            arg1
        } else {
            (0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::math::mul_div_u256((arg1 as u256), ((arg0 - 1700161652000) as u256), (15552000000 as u256)) as u64)
        }
    }

    fun calculate_withdrawable_lp_shares(arg0: u64, arg1: &UserLockdropHivePosition) : (u64, vector<u64>, vector<u64>, vector<u64>, vector<u64>) {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(&arg1.sui_lockdrop.lockup_weeks)) {
            let v6 = *0x1::vector::borrow<u64>(&arg1.sui_lockdrop.lockup_weeks, v5);
            if (arg0 >= *0x2::table::borrow<u64, u64>(&arg1.sui_lockdrop.unlock_timestamps, v6) && !*0x2::table::borrow<u64, bool>(&arg1.sui_lockdrop.dlp_claim_flag, v6)) {
                0x1::vector::push_back<u64>(&mut v1, v6);
                v0 = v0 + *0x2::table::borrow<u64, u64>(&arg1.sui_lockdrop.dlp_per_lockup, v6);
            };
            v5 = v5 + 1;
        };
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&arg1.cetus_lockdrop.lockup_weeks)) {
            let v8 = *0x1::vector::borrow<u64>(&arg1.cetus_lockdrop.lockup_weeks, v7);
            if (arg0 >= *0x2::table::borrow<u64, u64>(&arg1.cetus_lockdrop.unlock_timestamps, v8) && !*0x2::table::borrow<u64, bool>(&arg1.cetus_lockdrop.dlp_claim_flag, v8)) {
                0x1::vector::push_back<u64>(&mut v2, v8);
                v0 = v0 + *0x2::table::borrow<u64, u64>(&arg1.cetus_lockdrop.dlp_per_lockup, v8);
            };
            v7 = v7 + 1;
        };
        let v9 = 0;
        while (v9 < 0x1::vector::length<u64>(&arg1.kriya_lockdrop.lockup_weeks)) {
            let v10 = *0x1::vector::borrow<u64>(&arg1.kriya_lockdrop.lockup_weeks, v9);
            if (arg0 >= *0x2::table::borrow<u64, u64>(&arg1.kriya_lockdrop.unlock_timestamps, v10) && !*0x2::table::borrow<u64, bool>(&arg1.kriya_lockdrop.dlp_claim_flag, v10)) {
                0x1::vector::push_back<u64>(&mut v3, v10);
                v0 = v0 + *0x2::table::borrow<u64, u64>(&arg1.kriya_lockdrop.dlp_per_lockup, v10);
            };
            v9 = v9 + 1;
        };
        v9 = 0;
        while (v9 < 0x1::vector::length<u64>(&arg1.flowx_lockdrop.lockup_weeks)) {
            let v11 = *0x1::vector::borrow<u64>(&arg1.flowx_lockdrop.lockup_weeks, v9);
            if (arg0 >= *0x2::table::borrow<u64, u64>(&arg1.flowx_lockdrop.unlock_timestamps, v11) && !*0x2::table::borrow<u64, bool>(&arg1.flowx_lockdrop.dlp_claim_flag, v11)) {
                0x1::vector::push_back<u64>(&mut v4, v11);
                v0 = v0 + *0x2::table::borrow<u64, u64>(&arg1.flowx_lockdrop.dlp_per_lockup, v11);
            };
            v9 = v9 + 1;
        };
        (v0, v1, v2, v3, v4)
    }

    fun claim_gems_and_increment_states<T0, T1, T2>(arg0: &mut LockdropForPool<T0, T1, T2>, arg1: &mut UserLockdropHivePosition, arg2: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveProfile, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        arg0.hive_gems_per_share = arg0.hive_gems_per_share + 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::math::mul_div_u256(((arg4 - arg3) as u256), (1000000000 as u256), (arg0.dlps_staked_amount as u256));
        let v0 = (0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::math::mul_div_u256(arg0.hive_gems_per_share - arg1.hive_gems_per_share, ((arg1.total_degenhive_lp_tokens - arg1.unbonded_degenhive_lp_tokens) as u256), (1000000000 as u256)) as u64);
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::transfer_hive_gems(&mut arg0.hive_profile, arg2, v0, arg5);
        arg1.hive_gems_per_share = arg0.hive_gems_per_share;
        arg1.gems_streamed_from_staking = arg1.gems_streamed_from_staking + v0;
        v0
    }

    public fun claim_liquidity_from_cetus<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg2: &0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::CetusAttackConfig, arg3: &mut 0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::LockdropForPool<T0, T1>, arg4: &mut LockdropForPool<T0, T1, T2>, arg5: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HiveVault, arg6: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, u64, u64, u64, u64, u64, u64) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8) = 0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::transfer_liquidity_from_cetus<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        internal_claim_cetus_liquidity<T0, T1, T2>(arg4, arg5, v0, v1, v2, v3, v4, v5, v6, v7, v8, arg6)
    }

    public fun claim_liquidity_from_rev_cetus<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg2: &0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::CetusAttackConfig, arg3: &mut 0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::LockdropForPool<T1, T0>, arg4: &mut LockdropForPool<T0, T1, T2>, arg5: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HiveVault, arg6: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, u64, u64, u64, u64, u64, u64) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8) = 0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::transfer_liquidity_from_cetus<T1, T0>(arg0, arg1, arg2, arg3, arg6);
        internal_claim_cetus_liquidity<T0, T1, T2>(arg4, arg5, v0, v1, v3, v2, v5, v4, v6, v7, v8, arg6)
    }

    public fun delegate_hive_for_infusion(arg0: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg1: &LockdropRewardsCapabilityHolder, arg2: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE> {
        let v0 = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, arg4);
        assert!(v0.total_hive_rewards - v0.delegated_hive_rewards >= arg3, 1811);
        v0.delegated_hive_rewards = v0.delegated_hive_rewards + arg3;
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, v0, arg4);
        0x2::balance::split<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>(&mut v0.available_hive_rewards, arg3)
    }

    public entry fun extract_liquidity_from_rev_flowx<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg2: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HiveVault, arg3: &mut LockdropForPool<T0, T1, T2>, arg4: &0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::FlowxAttackConfig, arg5: &mut 0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::FlowxLockdropForPool<T1, T0>, arg6: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg7: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, u64, u64) {
        let (v0, v1, v2, v3, v4, v5) = 0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::extract_liquidity_from_flowx<T1, T0>(arg0, arg1, arg4, arg5, arg6, arg7);
        internal_extract_flowx_liquidity<T0, T1, T2>(arg3, arg2, v0, v1, v2, v4, v3, v5, arg7)
    }

    fun increment_bee_fruit_indexes<T0, T1, T2, T3>(arg0: 0x1::string::String, arg1: &mut LockdropForPool<T0, T1, T2>, arg2: &mut UserLockdropHivePosition, arg3: 0x2::balance::Balance<T3>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T3> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T3>());
        let v1 = 0x2::balance::value<T3>(&arg3);
        if (!0x2::linked_table::contains<0x1::ascii::String, u256>(&arg1.bee_fruit_indexes, v0)) {
            0x2::linked_table::push_back<0x1::ascii::String, u256>(&mut arg1.bee_fruit_indexes, v0, 0);
            let v2 = BeeFruitDistributor<T3>{
                id                      : 0x2::object::new(arg4),
                claim_index             : 0,
                available_bee_fruits    : 0x2::balance::zero<T3>(),
                total_bee_fruits_earned : 0,
            };
            0x2::dynamic_object_field::add<0x1::ascii::String, BeeFruitDistributor<T3>>(&mut arg1.id, v0, v2);
        };
        let v3 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruitDistributor<T3>>(&mut arg1.id, v0);
        v3.claim_index = v3.claim_index + 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::math::mul_div_u256((v1 as u256), (1000000000 as u256), (arg1.dlps_staked_amount as u256));
        v3.total_bee_fruits_earned = v3.total_bee_fruits_earned + v1;
        let v4 = (0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::math::mul_div_u256(v3.claim_index - *0x2::linked_table::borrow<0x1::ascii::String, u256>(&arg2.bee_fruit_indexes, v0), ((arg2.total_degenhive_lp_tokens - arg2.unbonded_degenhive_lp_tokens) as u256), (1000000000 as u256)) as u128);
        *0x2::linked_table::borrow_mut<0x1::ascii::String, u256>(&mut arg2.bee_fruit_indexes, v0) = v3.claim_index;
        *0x2::linked_table::borrow_mut<0x1::ascii::String, u128>(&mut arg2.total_bee_fruits_earned, v0) = *0x2::linked_table::borrow<0x1::ascii::String, u128>(&arg2.total_bee_fruits_earned, v0) + v4;
        0x2::balance::join<T3>(&mut v3.available_bee_fruits, arg3);
        let v5 = FruitsEarnedByUser{
            type                                : v0,
            username                            : arg0,
            new_fruits_received_from_hive       : v1,
            distributor_claim_index             : v3.claim_index,
            distributor_total_bee_fruits_earned : v3.total_bee_fruits_earned,
            user_claim_index                    : *0x2::linked_table::borrow<0x1::ascii::String, u256>(&arg2.bee_fruit_indexes, v0),
            user_total_fruits_earned            : *0x2::linked_table::borrow<0x1::ascii::String, u128>(&arg2.total_bee_fruits_earned, v0),
            new_fruits_earned_by_user           : v4,
        };
        0x2::event::emit<FruitsEarnedByUser>(v5);
        0x2::balance::split<T3>(&mut v3.available_bee_fruits, (v4 as u64))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun initialize_attack_on_cetus_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg2: 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::ProfileDofOwnershipCapability, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &LockdropForPool<T0, T1, T2>, arg5: &0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::CetusAttackConfig, arg6: 0x1::string::String, arg7: 0x2::coin::Coin<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : address {
        0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::initialize_attack_on_pool<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8, arg9)
    }

    public fun initialize_attack_on_flowx_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg2: 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::ProfileDofOwnershipCapability, arg3: &LockdropForPool<T0, T1, T2>, arg4: &mut 0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::FlowxAttackConfig, arg5: 0x1::string::String, arg6: 0x2::coin::Coin<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : address {
        0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::initialize_attack_on_pool<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8)
    }

    public fun initialize_attack_on_kriya_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg2: 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::ProfileDofOwnershipCapability, arg3: &LockdropForPool<T0, T1, T2>, arg4: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>, arg5: &mut 0x87b123b22b31e4f373691e389a181f1e294695a834089bec9bad15bc875203d2::kriya_vampire_attack::KriyaAttackConfig, arg6: 0x1::string::String, arg7: 0x2::coin::Coin<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : address {
        0x87b123b22b31e4f373691e389a181f1e294695a834089bec9bad15bc875203d2::kriya_vampire_attack::initialize_attack_on_pool<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun initialize_attack_on_rev_flowx_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg2: 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::ProfileDofOwnershipCapability, arg3: &LockdropForPool<T0, T1, T2>, arg4: &mut 0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::FlowxAttackConfig, arg5: 0x1::string::String, arg6: 0x2::coin::Coin<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : address {
        0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::initialize_attack_on_pool<T1, T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8)
    }

    public fun initialize_attack_on_reverse_cetus_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg2: 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::ProfileDofOwnershipCapability, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &LockdropForPool<T0, T1, T2>, arg5: &0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::CetusAttackConfig, arg6: 0x1::string::String, arg7: 0x2::coin::Coin<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : address {
        0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::initialize_attack_on_pool<T1, T0>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8, arg9)
    }

    public entry fun initialize_lockdrop_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg2: 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::ProfileDofOwnershipCapability, arg3: &mut LockdropVault, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2974b604af3d56e1eed6889e78c3f0f1434ae5e8d088e2e16a1ebb94fc76889f::hsui_vault::HSuiVault, arg6: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveProfileMappingStore, arg7: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveManager, arg8: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HSuiDisperser<0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) : address {
        let (v0, v1) = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::kraft_owned_hive_profile(arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v2 = v0;
        0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg12), arg12);
        let (v3, v4, _, _) = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_meta_info(&v2);
        let v7 = LockdropCetusState<T0, T1>{
            total_positions_liquidity : 0,
            total_weighted_units      : 0,
            total_x_withdrawn         : 0,
            total_y_withdrawn         : 0,
            x_fee_withdrawn           : 0x2::balance::zero<T0>(),
            y_fee_withdrawn           : 0x2::balance::zero<T1>(),
            total_sui_earned          : 0,
            total_cetus_earned        : 0,
            sui_earned_bal            : 0x2::balance::zero<0x2::sui::SUI>(),
            cetus_earned_bal          : 0x2::balance::zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(),
            total_hive_incentives     : 0,
            total_dlps_amount         : 0,
        };
        let v8 = LockdropKriyaState{
            total_lp_locked       : 0,
            total_weighted_units  : 0,
            total_x_withdrawn     : 0,
            total_y_withdrawn     : 0,
            total_hive_incentives : 0,
            total_dlps_amount     : 0,
        };
        let v9 = LockdropFlowxState{
            total_lp_locked       : 0,
            total_weighted_units  : 0,
            total_x_withdrawn     : 0,
            total_y_withdrawn     : 0,
            total_hive_incentives : 0,
            total_dlps_amount     : 0,
        };
        let v10 = LockdropForPool<T0, T1, T2>{
            id                        : 0x2::object::new(arg12),
            hive_profile              : v2,
            user_profile_access_cap   : arg2,
            cetus_state               : v7,
            kriya_state               : v8,
            flowx_state               : v9,
            total_withdrawn_x_balance : 0x2::balance::zero<T0>(),
            total_withdrawn_y_balance : 0x2::balance::zero<T1>(),
            degenhive_lps_krafted     : 0x2::balance::zero<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<T0, T1, T2>>(),
            total_lp_krafted          : 0,
            are_staked_with_pool_hive : false,
            dlps_staked_amount        : 0,
            hive_gems_per_share       : 0,
            bee_fruit_indexes         : 0x2::linked_table::new<0x1::ascii::String, u256>(arg12),
        };
        let v11 = 0x2::object::uid_to_address(&v10.id);
        let v12 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x1::string::append(&mut v12, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg3.krafted_pools, v12), 1806);
        0x2::table::add<0x1::string::String, address>(&mut arg3.krafted_pools, v12, v11);
        let v13 = LockdropPoolInitialized<T0, T1, T2>{
            pool_addr        : 0x2::object::uid_to_address(&v10.id),
            profile_addr     : v3,
            profile_username : v4,
        };
        0x2::event::emit<LockdropPoolInitialized<T0, T1, T2>>(v13);
        0x2::transfer::share_object<LockdropForPool<T0, T1, T2>>(v10);
        v11
    }

    public entry fun initialize_lockdrops(arg0: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg1: 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::ProfileDofOwnershipCapability, arg2: 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::ProfileDofOwnershipCapability, arg3: 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::ProfileDofOwnershipCapability, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2974b604af3d56e1eed6889e78c3f0f1434ae5e8d088e2e16a1ebb94fc76889f::hsui_vault::HSuiVault, arg6: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveProfileMappingStore, arg7: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveManager, arg8: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HSuiDisperser<0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::clock::Clock, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: &mut 0x2::tx_context::TxContext) : (address, address, address, address, address) {
        let (v0, v1) = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::kraft_owned_hive_profile(arg10, arg4, arg5, arg6, arg7, arg8, arg9, arg11, arg12, arg21);
        let v2 = v0;
        0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg21), arg21);
        let (v3, v4, _, _) = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_meta_info(&v2);
        let v7 = LockdropVault{
            id                        : 0x2::object::new(arg21),
            hive_profile              : v2,
            user_profile_access_cap   : arg3,
            krafted_pools             : 0x2::table::new<0x1::string::String, address>(arg21),
            sui_total_locked          : 0,
            sui_total_weighted_units  : 0,
            hive_sui_total_received   : 0,
            hive_available            : 0x2::balance::zero<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>(),
            total_hive_incentives     : 0,
            degenhive_lps_krafted     : 0x2::balance::zero<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<0x2::sui::SUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::curves::Curved>>(),
            total_lp_krafted          : 0,
            are_staked_with_pool_hive : false,
            dlps_staked_amount        : 0,
            hive_gems_per_share       : 0,
            bee_fruit_indexes         : 0x2::linked_table::new<0x1::ascii::String, u256>(arg21),
        };
        let v8 = LockdropVaultInitialized{
            vault_addr       : 0x2::object::uid_to_address(&v7.id),
            profile_addr     : v3,
            profile_username : v4,
        };
        0x2::event::emit<LockdropVaultInitialized>(v8);
        0x2::transfer::share_object<LockdropVault>(v7);
        let v9 = 0x2::object::new(arg21);
        let v10 = LockdropRewardsCapabilityHolderInitialized{addr: 0x2::object::uid_to_address(&v9)};
        0x2::event::emit<LockdropRewardsCapabilityHolderInitialized>(v10);
        let v11 = LockdropRewardsCapabilityHolder{
            id         : v9,
            capability : arg1,
        };
        0x2::transfer::share_object<LockdropRewardsCapabilityHolder>(v11);
        (0x2::object::uid_to_address(&v7.id), 0x30f1432c9b62a8f25f48d95751367a69539513fd06f23ed7b69cd5f4db90ad61::lsd_lockdrop::initialize_global_lsd_lockdrop(arg0, arg2, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21), 0x87b123b22b31e4f373691e389a181f1e294695a834089bec9bad15bc875203d2::kriya_vampire_attack::initialize_kriya_attack_config(arg10, arg0, arg14, arg15, arg16, arg17, arg18, arg19, arg20, (arg13 as u8), arg21), 0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::initialize_flowx_attack_config(arg10, arg0, arg14, arg15, arg16, arg17, arg18, arg19, arg20, (arg13 as u8), arg21), 0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::initialize_cetus_attack(arg10, arg0, arg14, arg15, arg16, arg17, arg18, arg19, arg20, (arg13 as u8), arg21))
    }

    fun internal_claim_cetus_liquidity<T0, T1, T2>(arg0: &mut LockdropForPool<T0, T1, T2>, arg1: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HiveVault, arg2: u128, arg3: u128, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: 0x2::balance::Balance<0x2::sui::SUI>, arg9: 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg10: 0x2::balance::Balance<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>, arg11: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg4);
        let v1 = 0x2::balance::value<T1>(&arg5);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg8);
        let v3 = 0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&arg9);
        let v4 = 0x2::balance::value<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>(&arg10);
        arg0.cetus_state.total_positions_liquidity = arg0.cetus_state.total_positions_liquidity + arg2;
        arg0.cetus_state.total_weighted_units = arg0.cetus_state.total_weighted_units + arg3;
        arg0.cetus_state.total_x_withdrawn = arg0.cetus_state.total_x_withdrawn + v0;
        arg0.cetus_state.total_y_withdrawn = arg0.cetus_state.total_y_withdrawn + v1;
        arg0.cetus_state.total_sui_earned = arg0.cetus_state.total_sui_earned + v2;
        arg0.cetus_state.total_cetus_earned = arg0.cetus_state.total_cetus_earned + v3;
        arg0.cetus_state.total_hive_incentives = arg0.cetus_state.total_hive_incentives + v4;
        0x2::balance::join<T0>(&mut arg0.total_withdrawn_x_balance, arg4);
        0x2::balance::join<T1>(&mut arg0.total_withdrawn_y_balance, arg5);
        0x2::balance::join<T0>(&mut arg0.cetus_state.x_fee_withdrawn, arg6);
        0x2::balance::join<T1>(&mut arg0.cetus_state.y_fee_withdrawn, arg7);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.cetus_state.sui_earned_bal, arg8);
        0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg0.cetus_state.cetus_earned_bal, arg9);
        0x2::balance::destroy_zero<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>(0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::burn_hive_and_return(arg1, &mut arg0.hive_profile, arg10, v4, arg11));
        (arg2, arg3, v0, v1, 0x2::balance::value<T0>(&arg6), 0x2::balance::value<T1>(&arg7), v2, v3, v4)
    }

    fun internal_extract_flowx_liquidity<T0, T1, T2>(arg0: &mut LockdropForPool<T0, T1, T2>, arg1: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HiveVault, arg2: u128, arg3: u128, arg4: u64, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: 0x2::balance::Balance<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>, arg8: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg5);
        let v1 = 0x2::balance::value<T1>(&arg6);
        arg0.flowx_state.total_lp_locked = arg0.flowx_state.total_lp_locked + arg2;
        arg0.flowx_state.total_weighted_units = arg0.flowx_state.total_weighted_units + arg3;
        arg0.flowx_state.total_hive_incentives = arg0.flowx_state.total_hive_incentives + arg4;
        arg0.flowx_state.total_x_withdrawn = arg0.flowx_state.total_x_withdrawn + v0;
        arg0.flowx_state.total_y_withdrawn = arg0.flowx_state.total_y_withdrawn + v1;
        0x2::balance::join<T0>(&mut arg0.total_withdrawn_x_balance, arg5);
        0x2::balance::join<T1>(&mut arg0.total_withdrawn_y_balance, arg6);
        0x2::balance::destroy_zero<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>(0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::burn_hive_and_return(arg1, &mut arg0.hive_profile, arg7, arg4, arg8));
        (arg2, arg3, arg4, v0, v1)
    }

    fun internal_lps_from_lockdrop_vault(arg0: &mut LockdropVault) : 0x2::balance::Balance<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<0x2::sui::SUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::curves::Curved>> {
        assert!(0x2::balance::value<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<0x2::sui::SUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::curves::Curved>>(&arg0.degenhive_lps_krafted) > 0, 1802);
        let v0 = 0x2::balance::withdraw_all<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<0x2::sui::SUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::curves::Curved>>(&mut arg0.degenhive_lps_krafted);
        arg0.are_staked_with_pool_hive = true;
        arg0.dlps_staked_amount = arg0.dlps_staked_amount + 0x2::balance::value<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<0x2::sui::SUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::curves::Curved>>(&v0);
        v0
    }

    fun internal_lps_from_pooldrop<T0, T1, T2>(arg0: &mut LockdropForPool<T0, T1, T2>) : 0x2::balance::Balance<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<T0, T1, T2>> {
        assert!(0x2::balance::value<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<T0, T1, T2>>(&arg0.degenhive_lps_krafted) > 0, 1802);
        let v0 = 0x2::balance::withdraw_all<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<T0, T1, T2>>(&mut arg0.degenhive_lps_krafted);
        arg0.are_staked_with_pool_hive = true;
        arg0.dlps_staked_amount = arg0.dlps_staked_amount + 0x2::balance::value<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<T0, T1, T2>>(&v0);
        v0
    }

    fun internal_migrate_user_cetus_position<T0, T1, T2>(arg0: 0x1::string::String, arg1: address, arg2: &mut LockdropForPool<T0, T1, T2>, arg3: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HiveVault, arg4: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveProfile, arg5: UserLockdropRewardsPosition, arg6: UserLockdropHivePosition, arg7: vector<u64>, arg8: 0x2::table::Table<u64, u64>, arg9: 0x2::table::Table<u64, u128>, arg10: 0x2::table::Table<u64, u128>, arg11: 0x2::table::Table<u64, u64>, arg12: 0x2::table::Table<u64, u64>, arg13: 0x2::table::Table<u64, u64>, arg14: 0x2::table::Table<u64, u64>, arg15: 0x2::table::Table<u64, u64>, arg16: 0x2::table::Table<u64, u64>, arg17: u128, arg18: &mut 0x2::tx_context::TxContext) : (UserLockdropRewardsPosition, UserLockdropHivePosition) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::length<u64>(&arg7);
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u64>(&arg7, v3);
            0x1::vector::push_back<u64>(&mut arg6.cetus_lockdrop.lockup_weeks, v4);
            0x2::table::add<u64, u64>(&mut arg6.cetus_lockdrop.unlock_timestamps, v4, *0x2::table::borrow<u64, u64>(&arg8, v4));
            let v5 = *0x2::table::borrow<u64, u64>(&arg11, v4);
            0x2::table::add<u64, u64>(&mut arg6.cetus_lockdrop.x_withdrawn, v4, v5);
            let v6 = *0x2::table::borrow<u64, u64>(&arg12, v4);
            0x2::table::add<u64, u64>(&mut arg6.cetus_lockdrop.y_withdrawn, v4, v6);
            0x2::table::add<u64, u64>(&mut arg6.cetus_lockdrop.fee_earned_x, v4, *0x2::table::borrow<u64, u64>(&arg13, v4));
            0x2::table::add<u64, u64>(&mut arg6.cetus_lockdrop.fee_earned_y, v4, *0x2::table::borrow<u64, u64>(&arg14, v4));
            0x2::table::add<u64, u64>(&mut arg6.cetus_lockdrop.sui_earned, v4, *0x2::table::borrow<u64, u64>(&arg16, v4));
            0x2::table::add<u64, u64>(&mut arg6.cetus_lockdrop.earned, v4, *0x2::table::borrow<u64, u64>(&arg15, v4));
            0x2::table::add<u64, u128>(&mut arg6.cetus_lockdrop.position_liquidity, v4, *0x2::table::borrow<u64, u128>(&arg9, v4));
            let v7 = *0x2::table::borrow<u64, u128>(&arg10, v4);
            0x2::table::add<u64, u128>(&mut arg6.cetus_lockdrop.weighted_units, v4, v7);
            let v8 = calculate_hive_rewards(v7, arg2.cetus_state.total_weighted_units, arg2.cetus_state.total_hive_incentives);
            v0 = v0 + v8;
            0x2::table::add<u64, u64>(&mut arg6.cetus_lockdrop.hive_rewards_per_lockup, v4, v8);
            let v9 = calculate_dlp_for_cetus_position(v5, arg2.cetus_state.total_x_withdrawn, v6, arg2.cetus_state.total_y_withdrawn, (arg2.cetus_state.total_dlps_amount as u128));
            v1 = v1 + v9;
            0x2::table::add<u64, u64>(&mut arg6.cetus_lockdrop.dlp_per_lockup, v4, v9);
            0x2::table::add<u64, bool>(&mut arg6.cetus_lockdrop.dlp_claim_flag, v4, false);
            v3 = v3 + 1;
        };
        arg6.total_degenhive_lp_tokens = arg6.total_degenhive_lp_tokens + v1;
        arg5.total_hive_rewards = arg5.total_hive_rewards + v0;
        0x2::balance::join<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>(&mut arg5.available_hive_rewards, 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::deposit_gems_via_profile_and_return(arg3, &mut arg2.hive_profile, v0, arg18));
        0x2::table::drop<u64, u64>(arg8);
        0x2::table::drop<u64, u128>(arg9);
        0x2::table::drop<u64, u128>(arg10);
        0x2::table::drop<u64, u64>(arg11);
        0x2::table::drop<u64, u64>(arg12);
        0x2::table::drop<u64, u64>(arg13);
        0x2::table::drop<u64, u64>(arg14);
        0x2::table::drop<u64, u64>(arg15);
        0x2::table::drop<u64, u64>(arg16);
        let v10 = UserCetusPositionMigrated{
            user_addr                      : 0x2::tx_context::sender(arg18),
            username                       : arg0,
            profile_addr                   : arg1,
            total_user_cetus_positions     : v2,
            hive_earned_from_cetus_attack  : v0,
            dlp_claimable_for_cetus_attack : v1,
        };
        0x2::event::emit<UserCetusPositionMigrated>(v10);
        (arg5, arg6)
    }

    fun internal_migrate_user_flowx_position<T0, T1, T2>(arg0: 0x1::string::String, arg1: address, arg2: &mut LockdropForPool<T0, T1, T2>, arg3: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HiveVault, arg4: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveProfile, arg5: UserLockdropRewardsPosition, arg6: UserLockdropHivePosition, arg7: vector<u64>, arg8: 0x2::table::Table<u64, u64>, arg9: 0x2::table::Table<u64, u64>, arg10: 0x2::table::Table<u64, u128>, arg11: u128, arg12: u128, arg13: &mut 0x2::tx_context::TxContext) : (UserLockdropRewardsPosition, UserLockdropHivePosition) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::length<u64>(&arg7);
        let v3 = 0;
        while (v3 < v2) {
            let v4 = *0x1::vector::borrow<u64>(&arg7, v3);
            0x1::vector::push_back<u64>(&mut arg6.flowx_lockdrop.lockup_weeks, v4);
            let v5 = *0x2::table::borrow<u64, u64>(&arg8, v4);
            0x2::table::add<u64, u64>(&mut arg6.flowx_lockdrop.lp_tokens_locked, v4, v5);
            let v6 = *0x2::table::borrow<u64, u128>(&arg10, v4);
            0x2::table::add<u64, u128>(&mut arg6.flowx_lockdrop.lockup_weighted_units, v4, v6);
            let v7 = calculate_hive_rewards(v6, arg2.flowx_state.total_weighted_units, arg2.flowx_state.total_hive_incentives);
            v0 = v0 + v7;
            0x2::table::add<u64, u64>(&mut arg6.flowx_lockdrop.hive_rewards_per_lockup, v4, v7);
            0x2::table::add<u64, u64>(&mut arg6.flowx_lockdrop.unlock_timestamps, v4, *0x2::table::borrow<u64, u64>(&arg9, v4));
            let v8 = calculate_dlp_for_position((v5 as u128), (arg2.flowx_state.total_dlps_amount as u128), (arg2.flowx_state.total_lp_locked as u128));
            v1 = v1 + v8;
            0x2::table::add<u64, u64>(&mut arg6.flowx_lockdrop.dlp_per_lockup, v4, v8);
            0x2::table::add<u64, bool>(&mut arg6.flowx_lockdrop.dlp_claim_flag, v4, false);
            v3 = v3 + 1;
        };
        arg6.total_degenhive_lp_tokens = arg6.total_degenhive_lp_tokens + v1;
        arg5.total_hive_rewards = arg5.total_hive_rewards + v0;
        0x2::balance::join<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>(&mut arg5.available_hive_rewards, 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::deposit_gems_via_profile_and_return(arg3, &mut arg2.hive_profile, v0, arg13));
        0x2::table::drop<u64, u64>(arg8);
        0x2::table::drop<u64, u64>(arg9);
        0x2::table::drop<u64, u128>(arg10);
        let v9 = UserFlowxPositionMigrated{
            user_addr                      : 0x2::tx_context::sender(arg13),
            username                       : arg0,
            profile_addr                   : arg1,
            total_user_flowx_positions     : v2,
            hive_earned_from_flowx_attack  : v0,
            dlp_claimable_for_flowx_attack : v1,
        };
        0x2::event::emit<UserFlowxPositionMigrated>(v9);
        (arg5, arg6)
    }

    fun kraft_user_position(arg0: &mut 0x2::tx_context::TxContext) : UserLockdropHivePosition {
        let v0 = UserSuiLockdropState{
            lockup_weeks            : 0x1::vector::empty<u64>(),
            locked_per_position     : 0x2::table::new<u64, u64>(arg0),
            lockup_weighted_units   : 0x2::table::new<u64, u128>(arg0),
            unlock_timestamps       : 0x2::table::new<u64, u64>(arg0),
            dlp_per_lockup          : 0x2::table::new<u64, u64>(arg0),
            dlp_claim_flag          : 0x2::table::new<u64, bool>(arg0),
            hive_rewards_per_lockup : 0x2::table::new<u64, u64>(arg0),
        };
        let v1 = UserCetusLockdropState{
            lockup_weeks            : 0x1::vector::empty<u64>(),
            x_withdrawn             : 0x2::table::new<u64, u64>(arg0),
            y_withdrawn             : 0x2::table::new<u64, u64>(arg0),
            fee_earned_x            : 0x2::table::new<u64, u64>(arg0),
            fee_earned_y            : 0x2::table::new<u64, u64>(arg0),
            sui_earned              : 0x2::table::new<u64, u64>(arg0),
            earned                  : 0x2::table::new<u64, u64>(arg0),
            position_liquidity      : 0x2::table::new<u64, u128>(arg0),
            weighted_units          : 0x2::table::new<u64, u128>(arg0),
            hive_rewards_per_lockup : 0x2::table::new<u64, u64>(arg0),
            unlock_timestamps       : 0x2::table::new<u64, u64>(arg0),
            dlp_per_lockup          : 0x2::table::new<u64, u64>(arg0),
            dlp_claim_flag          : 0x2::table::new<u64, bool>(arg0),
        };
        let v2 = UserKriyaLockdropState{
            lockup_weeks            : 0x1::vector::empty<u64>(),
            lp_tokens_locked        : 0x2::table::new<u64, u64>(arg0),
            lockup_weighted_units   : 0x2::table::new<u64, u128>(arg0),
            hive_rewards_per_lockup : 0x2::table::new<u64, u64>(arg0),
            unlock_timestamps       : 0x2::table::new<u64, u64>(arg0),
            dlp_per_lockup          : 0x2::table::new<u64, u64>(arg0),
            dlp_claim_flag          : 0x2::table::new<u64, bool>(arg0),
        };
        let v3 = UserFlowxLockdropState{
            lockup_weeks            : 0x1::vector::empty<u64>(),
            lp_tokens_locked        : 0x2::table::new<u64, u64>(arg0),
            lockup_weighted_units   : 0x2::table::new<u64, u128>(arg0),
            hive_rewards_per_lockup : 0x2::table::new<u64, u64>(arg0),
            unlock_timestamps       : 0x2::table::new<u64, u64>(arg0),
            dlp_per_lockup          : 0x2::table::new<u64, u64>(arg0),
            dlp_claim_flag          : 0x2::table::new<u64, bool>(arg0),
        };
        UserLockdropHivePosition{
            id                           : 0x2::object::new(arg0),
            vesting_init_timestamp       : 0,
            sui_lockdrop                 : v0,
            cetus_lockdrop               : v1,
            kriya_lockdrop               : v2,
            flowx_lockdrop               : v3,
            total_degenhive_lp_tokens    : 0,
            unbonded_degenhive_lp_tokens : 0,
            lp_to_unlock                 : 0x2::linked_table::new<u64, u64>(arg0),
            claimed_lp_shares            : 0,
            hive_gems_per_share          : 0,
            gems_streamed_from_staking   : 0,
            bee_fruit_indexes            : 0x2::linked_table::new<0x1::ascii::String, u256>(arg0),
            total_bee_fruits_earned      : 0x2::linked_table::new<0x1::ascii::String, u128>(arg0),
        }
    }

    fun kraft_user_rewards_osition(arg0: &mut 0x2::tx_context::TxContext) : UserLockdropRewardsPosition {
        UserLockdropRewardsPosition{
            id                     : 0x2::object::new(arg0),
            available_hive_rewards : 0x2::balance::zero<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>(),
            total_hive_rewards     : 0,
            delegated_hive_rewards : 0,
            claimed_hive_rewards   : 0,
        }
    }

    public entry fun migrate_user_cetus_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg2: &LockdropRewardsCapabilityHolder, arg3: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HiveVault, arg4: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveProfile, arg5: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveManager, arg6: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveDisperser, arg7: &mut LockdropForPool<T0, T1, T2>, arg8: &0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::CetusAttackConfig, arg9: &mut 0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::LockdropForPool<T0, T1>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7.kriya_state.total_weighted_units > 0 && arg7.kriya_state.total_dlps_amount > 0, 1802);
        let (v0, v1, _, _) = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_meta_info(arg4);
        if (0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::exists_for_profile(arg4, 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_dof_capability_identifier(&arg2.capability))) {
            let v4 = kraft_user_rewards_osition(arg10);
            0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v4, arg10);
        };
        if (0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::exists_for_profile(arg4, 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_dof_capability_identifier(&arg7.user_profile_access_cap))) {
            let v5 = kraft_user_position(arg10);
            0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v5, arg10);
        };
        let (v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16) = 0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::destroy_user_position<T0, T1>(arg0, arg1, arg8, arg9, arg4, v0, arg10);
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::follow_profile(arg0, arg5, arg4, &mut arg7.hive_profile, arg6, 12, arg10);
        let v17 = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, arg10);
        let v18 = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, arg10);
        let (v19, v20) = internal_migrate_user_cetus_position<T0, T1, T2>(v1, v0, arg7, arg3, arg4, v17, v18, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, arg10);
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v19, arg10);
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v20, arg10);
    }

    public entry fun migrate_user_flowx_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg2: &LockdropRewardsCapabilityHolder, arg3: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HiveVault, arg4: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveProfile, arg5: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveManager, arg6: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveDisperser, arg7: &mut LockdropForPool<T0, T1, T2>, arg8: &0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::FlowxAttackConfig, arg9: &mut 0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::FlowxLockdropForPool<T0, T1>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7.kriya_state.total_weighted_units > 0 && arg7.kriya_state.total_dlps_amount > 0, 1802);
        let (v0, v1, _, _) = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_meta_info(arg4);
        if (0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::exists_for_profile(arg4, 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_dof_capability_identifier(&arg2.capability))) {
            let v4 = kraft_user_rewards_osition(arg10);
            0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v4, arg10);
        };
        if (0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::exists_for_profile(arg4, 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_dof_capability_identifier(&arg7.user_profile_access_cap))) {
            let v5 = kraft_user_position(arg10);
            0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v5, arg10);
        };
        let (v6, v7, v8, v9, v10, v11) = 0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::destroy_user_position<T0, T1>(arg0, arg1, arg8, arg9, arg4, arg10);
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::follow_profile(arg0, arg5, arg4, &mut arg7.hive_profile, arg6, 12, arg10);
        let v12 = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, arg10);
        let v13 = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, arg10);
        let (v14, v15) = internal_migrate_user_flowx_position<T0, T1, T2>(v1, v0, arg7, arg3, arg4, v12, v13, v6, v7, v8, v9, v10, v11, arg10);
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v14, arg10);
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v15, arg10);
    }

    public entry fun migrate_user_kriya_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg2: &LockdropRewardsCapabilityHolder, arg3: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HiveVault, arg4: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveProfile, arg5: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveManager, arg6: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveDisperser, arg7: &mut LockdropForPool<T0, T1, T2>, arg8: &0x87b123b22b31e4f373691e389a181f1e294695a834089bec9bad15bc875203d2::kriya_vampire_attack::KriyaAttackConfig, arg9: &mut 0x87b123b22b31e4f373691e389a181f1e294695a834089bec9bad15bc875203d2::kriya_vampire_attack::KriyaLockdropForPool<T0, T1>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7.kriya_state.total_weighted_units > 0 && arg7.kriya_state.total_dlps_amount > 0, 1802);
        let (v0, v1, _, _) = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_meta_info(arg4);
        if (0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::exists_for_profile(arg4, 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_dof_capability_identifier(&arg2.capability))) {
            let v4 = kraft_user_rewards_osition(arg10);
            0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v4, arg10);
        };
        if (0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::exists_for_profile(arg4, 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_dof_capability_identifier(&arg7.user_profile_access_cap))) {
            let v5 = kraft_user_position(arg10);
            0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v5, arg10);
        };
        let (v6, v7, v8, v9, _, _) = 0x87b123b22b31e4f373691e389a181f1e294695a834089bec9bad15bc875203d2::kriya_vampire_attack::destroy_user_position<T0, T1>(arg0, arg1, arg8, arg9, arg4, arg10);
        let v12 = v9;
        let v13 = v8;
        let v14 = v7;
        let v15 = v6;
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::follow_profile(arg0, arg5, arg4, &mut arg7.hive_profile, arg6, 12, arg10);
        let v16 = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, arg10);
        let v17 = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, arg10);
        let v18 = 0;
        let v19 = 0;
        let v20 = 0x1::vector::length<u64>(&v15);
        let v21 = 0;
        while (v21 < v20) {
            let v22 = *0x1::vector::borrow<u64>(&v15, v21);
            0x1::vector::push_back<u64>(&mut v17.kriya_lockdrop.lockup_weeks, v22);
            let v23 = *0x2::table::borrow<u64, u64>(&v14, v22);
            0x2::table::add<u64, u64>(&mut v17.kriya_lockdrop.lp_tokens_locked, v22, v23);
            let v24 = *0x2::table::borrow<u64, u128>(&v12, v22);
            0x2::table::add<u64, u128>(&mut v17.kriya_lockdrop.lockup_weighted_units, v22, v24);
            let v25 = calculate_hive_rewards(v24, arg7.kriya_state.total_weighted_units, arg7.kriya_state.total_hive_incentives);
            v18 = v18 + v25;
            0x2::table::add<u64, u64>(&mut v17.kriya_lockdrop.hive_rewards_per_lockup, v22, v25);
            0x2::table::add<u64, u64>(&mut v17.kriya_lockdrop.unlock_timestamps, v22, *0x2::table::borrow<u64, u64>(&v13, v22));
            let v26 = calculate_dlp_for_position((v23 as u128), (arg7.kriya_state.total_dlps_amount as u128), (arg7.kriya_state.total_lp_locked as u128));
            v19 = v19 + v26;
            0x2::table::add<u64, u64>(&mut v17.kriya_lockdrop.dlp_per_lockup, v22, v26);
            0x2::table::add<u64, bool>(&mut v17.kriya_lockdrop.dlp_claim_flag, v22, false);
            v21 = v21 + 1;
        };
        v17.total_degenhive_lp_tokens = v17.total_degenhive_lp_tokens + v19;
        v16.total_hive_rewards = v16.total_hive_rewards + v18;
        0x2::balance::join<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>(&mut v16.available_hive_rewards, 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::deposit_gems_via_profile_and_return(arg3, &mut arg7.hive_profile, v18, arg10));
        0x2::table::drop<u64, u64>(v14);
        0x2::table::drop<u64, u64>(v13);
        0x2::table::drop<u64, u128>(v12);
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v16, arg10);
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v17, arg10);
        let v27 = UserKriyaPositionMigrated{
            user_addr                      : 0x2::tx_context::sender(arg10),
            username                       : v1,
            profile_addr                   : v0,
            total_user_kriya_positions     : v20,
            hive_earned_from_kriya_attack  : v18,
            dlp_claimable_for_kriya_attack : v19,
        };
        0x2::event::emit<UserKriyaPositionMigrated>(v27);
    }

    public entry fun migrate_user_rev_cetus_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg2: &LockdropRewardsCapabilityHolder, arg3: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HiveVault, arg4: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveProfile, arg5: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveManager, arg6: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveDisperser, arg7: &mut LockdropForPool<T0, T1, T2>, arg8: &0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::CetusAttackConfig, arg9: &mut 0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::LockdropForPool<T1, T0>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7.kriya_state.total_weighted_units > 0 && arg7.kriya_state.total_dlps_amount > 0, 1802);
        let (v0, v1, _, _) = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_meta_info(arg4);
        if (0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::exists_for_profile(arg4, 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_dof_capability_identifier(&arg2.capability))) {
            let v4 = kraft_user_rewards_osition(arg10);
            0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v4, arg10);
        };
        if (0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::exists_for_profile(arg4, 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_dof_capability_identifier(&arg7.user_profile_access_cap))) {
            let v5 = kraft_user_position(arg10);
            0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v5, arg10);
        };
        let (v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16) = 0xf5ffd09efe7b87235ed5abba6a80acae116406f6c4f5f1ec82fb29921ef6f387::cetus_vampire_attack::destroy_user_position<T1, T0>(arg0, arg1, arg8, arg9, arg4, v0, arg10);
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::follow_profile(arg0, arg5, arg4, &mut arg7.hive_profile, arg6, 12, arg10);
        let v17 = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, arg10);
        let v18 = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, arg10);
        let (v19, v20) = internal_migrate_user_cetus_position<T0, T1, T2>(v1, v0, arg7, arg3, arg4, v17, v18, v6, v7, v8, v9, v11, v10, v13, v12, v14, v15, v16, arg10);
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v19, arg10);
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v20, arg10);
    }

    public entry fun migrate_user_rev_flowx_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg2: &LockdropRewardsCapabilityHolder, arg3: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HiveVault, arg4: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveProfile, arg5: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveManager, arg6: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveDisperser, arg7: &mut LockdropForPool<T0, T1, T2>, arg8: &0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::FlowxAttackConfig, arg9: &mut 0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::FlowxLockdropForPool<T1, T0>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7.kriya_state.total_weighted_units > 0 && arg7.kriya_state.total_dlps_amount > 0, 1802);
        let (v0, v1, _, _) = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_meta_info(arg4);
        if (0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::exists_for_profile(arg4, 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_dof_capability_identifier(&arg2.capability))) {
            let v4 = kraft_user_rewards_osition(arg10);
            0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v4, arg10);
        };
        if (0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::exists_for_profile(arg4, 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_dof_capability_identifier(&arg7.user_profile_access_cap))) {
            let v5 = kraft_user_position(arg10);
            0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v5, arg10);
        };
        let (v6, v7, v8, v9, v10, v11) = 0xd18b566784b6c2cbb9950b50dfdb7b55da389bd4751ccd3ab119656bd7ecde3a::flowx_vampire_attack::destroy_user_position<T1, T0>(arg0, arg1, arg8, arg9, arg4, arg10);
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::follow_profile(arg0, arg5, arg4, &mut arg7.hive_profile, arg6, 12, arg10);
        let v12 = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, arg10);
        let v13 = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, arg10);
        let (v14, v15) = internal_migrate_user_flowx_position<T0, T1, T2>(v1, v0, arg7, arg3, arg4, v12, v13, v6, v7, v8, v9, v10, v11, arg10);
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v14, arg10);
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v15, arg10);
    }

    public fun migrate_user_sui_lockup_position(arg0: &0x2::clock::Clock, arg1: &0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::config::HiveEntryCap, arg2: &LockdropRewardsCapabilityHolder, arg3: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HiveVault, arg4: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveProfile, arg5: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveManager, arg6: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveDisperser, arg7: &mut LockdropVault, arg8: &mut 0x30f1432c9b62a8f25f48d95751367a69539513fd06f23ed7b69cd5f4db90ad61::lsd_lockdrop::LsdLockdropVault, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg7.sui_total_locked > 0 && arg7.total_lp_krafted > 0, 1807);
        let (v0, v1, _, _) = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_meta_info(arg4);
        if (0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::exists_for_profile(arg4, 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_dof_capability_identifier(&arg2.capability))) {
            let v4 = kraft_user_rewards_osition(arg9);
            0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v4, arg9);
        };
        if (0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::exists_for_profile(arg4, 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::get_profile_dof_capability_identifier(&arg7.user_profile_access_cap))) {
            let v5 = kraft_user_position(arg9);
            0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v5, arg9);
        };
        let (v6, v7, v8, v9, v10, _) = 0x30f1432c9b62a8f25f48d95751367a69539513fd06f23ed7b69cd5f4db90ad61::lsd_lockdrop::destroy_user_position(arg0, arg1, arg8, arg4, arg9);
        let v12 = v9;
        let v13 = v8;
        let v14 = v7;
        let v15 = v6;
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::follow_profile(arg0, arg5, arg4, &mut arg7.hive_profile, arg6, 12, arg9);
        let v16 = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, arg9);
        let v17 = 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, arg9);
        let v18 = 0;
        let v19 = 0;
        let v20 = 0;
        while (v20 < 0x1::vector::length<u64>(&v15)) {
            let v21 = *0x1::vector::borrow<u64>(&v15, v20);
            0x1::vector::push_back<u64>(&mut v17.sui_lockdrop.lockup_weeks, v21);
            let v22 = *0x2::table::borrow<u64, u64>(&v14, v21);
            0x2::table::add<u64, u64>(&mut v17.sui_lockdrop.locked_per_position, v21, v22);
            let v23 = *0x2::table::borrow<u64, u128>(&v13, v21);
            0x2::table::add<u64, u128>(&mut v17.sui_lockdrop.lockup_weighted_units, v21, v23);
            let v24 = calculate_hive_rewards(v23, arg7.sui_total_weighted_units, arg7.total_hive_incentives);
            v18 = v18 + v24;
            0x2::table::add<u64, u64>(&mut v17.sui_lockdrop.hive_rewards_per_lockup, v21, v24);
            0x2::table::add<u64, u64>(&mut v17.sui_lockdrop.unlock_timestamps, v21, *0x2::table::borrow<u64, u64>(&v12, v21));
            let v25 = (0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::math::mul_div_u256((v22 as u256), (arg7.total_lp_krafted as u256), (arg7.sui_total_locked as u256)) as u64);
            v19 = v19 + v25;
            0x2::table::add<u64, u64>(&mut v17.sui_lockdrop.dlp_per_lockup, v21, v25);
            v20 = v20 + 1;
        };
        v17.total_degenhive_lp_tokens = v17.total_degenhive_lp_tokens + v19;
        v16.total_hive_rewards = v16.total_hive_rewards + v18;
        0x2::balance::join<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>(&mut v16.available_hive_rewards, 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::deposit_gems_via_profile_and_return(arg3, &mut arg7.hive_profile, v18, arg9));
        0x2::table::drop<u64, u64>(v12);
        0x2::table::drop<u64, u128>(v13);
        0x2::table::drop<u64, u64>(v14);
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v16, arg9);
        0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v17, arg9);
        let v26 = UserSuiLockupPositionMigrated{
            user_addr                      : 0x2::tx_context::sender(arg9),
            username                       : v1,
            profile_addr                   : v0,
            total_sui_locked               : v10,
            hive_earned_from_sui_lockdrop  : v18,
            dlp_claimable_for_sui_lockdrop : v19,
        };
        0x2::event::emit<UserSuiLockupPositionMigrated>(v26);
    }

    public entry fun stake_pooldrop_lp_tokens_no_fruits<T0, T1, T2>(arg0: &mut LockdropForPool<T0, T1, T2>, arg1: &mut 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::PoolsGovernor, arg2: &mut 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::PoolHive<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<T0, T1, T2>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_lps_from_pooldrop<T0, T1, T2>(arg0);
        0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::deposit_into_bee_box_no_fruits<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<T0, T1, T2>>(arg1, arg2, &mut arg0.hive_profile, v0, arg3);
    }

    public entry fun stake_pooldrop_lp_tokens_one_fruits<T0, T1, T2, T3>(arg0: &mut LockdropForPool<T0, T1, T2>, arg1: &mut 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::PoolsGovernor, arg2: &mut 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::PoolHive<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<T0, T1, T2>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_lps_from_pooldrop<T0, T1, T2>(arg0);
        0x2::balance::destroy_zero<T3>(0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::deposit_into_bee_box_1_fruits<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<T0, T1, T2>, T3>(arg1, arg2, &mut arg0.hive_profile, v0, arg3));
    }

    public entry fun stake_pooldrop_lp_tokens_three_fruits<T0, T1, T2, T3, T4, T5>(arg0: &mut LockdropForPool<T0, T1, T2>, arg1: &mut 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::PoolsGovernor, arg2: &mut 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::PoolHive<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<T0, T1, T2>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_lps_from_pooldrop<T0, T1, T2>(arg0);
        let (v1, v2, v3) = 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::deposit_into_bee_box_3_fruits<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<T0, T1, T2>, T3, T4, T5>(arg1, arg2, &mut arg0.hive_profile, v0, arg3);
        0x2::balance::destroy_zero<T3>(v1);
        0x2::balance::destroy_zero<T4>(v2);
        0x2::balance::destroy_zero<T5>(v3);
    }

    public entry fun stake_pooldrop_lp_tokens_two_fruits<T0, T1, T2, T3, T4>(arg0: &mut LockdropForPool<T0, T1, T2>, arg1: &mut 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::PoolsGovernor, arg2: &mut 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::PoolHive<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<T0, T1, T2>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_lps_from_pooldrop<T0, T1, T2>(arg0);
        let (v1, v2) = 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::deposit_into_bee_box_2_fruits<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<T0, T1, T2>, T3, T4>(arg1, arg2, &mut arg0.hive_profile, v0, arg3);
        0x2::balance::destroy_zero<T3>(v1);
        0x2::balance::destroy_zero<T4>(v2);
    }

    public entry fun stake_vault_lp_tokens_no_fruits(arg0: &mut LockdropVault, arg1: &mut 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::PoolsGovernor, arg2: &mut 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::PoolHive<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<0x2::sui::SUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::curves::Curved>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_lps_from_lockdrop_vault(arg0);
        0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::deposit_into_bee_box_no_fruits<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<0x2::sui::SUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::curves::Curved>>(arg1, arg2, &mut arg0.hive_profile, v0, arg3);
    }

    public entry fun stake_vault_lp_tokens_one_fruits<T0>(arg0: &mut LockdropVault, arg1: &mut 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::PoolsGovernor, arg2: &mut 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::PoolHive<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<0x2::sui::SUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::curves::Curved>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_lps_from_lockdrop_vault(arg0);
        0x2::balance::destroy_zero<T0>(0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::deposit_into_bee_box_1_fruits<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<0x2::sui::SUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::curves::Curved>, T0>(arg1, arg2, &mut arg0.hive_profile, v0, arg3));
    }

    public entry fun stake_vault_lp_tokens_three_fruits<T0, T1, T2>(arg0: &mut LockdropVault, arg1: &mut 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::PoolsGovernor, arg2: &mut 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::PoolHive<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<0x2::sui::SUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::curves::Curved>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_lps_from_lockdrop_vault(arg0);
        let (v1, v2, v3) = 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::deposit_into_bee_box_3_fruits<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<0x2::sui::SUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::curves::Curved>, T0, T1, T2>(arg1, arg2, &mut arg0.hive_profile, v0, arg3);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::balance::destroy_zero<T1>(v2);
        0x2::balance::destroy_zero<T2>(v3);
    }

    public entry fun stake_vault_lp_tokens_two_fruits<T0, T1>(arg0: &mut LockdropVault, arg1: &mut 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::PoolsGovernor, arg2: &mut 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::PoolHive<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<0x2::sui::SUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::curves::Curved>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_lps_from_lockdrop_vault(arg0);
        let (v1, v2) = 0x6ce17e05da8526ffaead75737f2419eb3336ac8d01b18025e9610a40e1f65205::dex_dao::deposit_into_bee_box_2_fruits<0x26b9cc6dc832e6c9470fce3e381ece2057858e55f20c6c53f7e23f85c9d09c7e::two_pool::LP<0x2::sui::SUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::hsui::HSUI, 0x89eb5b1ed4b543d99ec6724a590e76902c5b54be97c098c4c9968d9ced0296e6::curves::Curved>, T0, T1>(arg1, arg2, &mut arg0.hive_profile, v0, arg3);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::balance::destroy_zero<T1>(v2);
    }

    fun unbond_degenhive_lp_tokens(arg0: u64, arg1: &mut UserLockdropHivePosition) : (u64, vector<u64>, vector<u64>, vector<u64>, vector<u64>) {
        assert!(arg1.total_degenhive_lp_tokens > 0, 1803);
        let (v0, v1, v2, v3, v4) = calculate_withdrawable_lp_shares(arg0, arg1);
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = v1;
        let v9 = 0;
        while (v9 < 0x1::vector::length<u64>(&v8)) {
            *0x2::table::borrow_mut<u64, bool>(&mut arg1.sui_lockdrop.dlp_claim_flag, *0x1::vector::borrow<u64>(&v8, v9)) = true;
            v9 = v9 + 1;
        };
        let v10 = 0;
        while (v10 < 0x1::vector::length<u64>(&v7)) {
            *0x2::table::borrow_mut<u64, bool>(&mut arg1.cetus_lockdrop.dlp_claim_flag, *0x1::vector::borrow<u64>(&v7, v10)) = true;
            v10 = v10 + 1;
        };
        let v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&v6)) {
            *0x2::table::borrow_mut<u64, bool>(&mut arg1.kriya_lockdrop.dlp_claim_flag, *0x1::vector::borrow<u64>(&v6, v11)) = true;
            v11 = v11 + 1;
        };
        let v12 = 0;
        while (v12 < 0x1::vector::length<u64>(&v5)) {
            *0x2::table::borrow_mut<u64, bool>(&mut arg1.flowx_lockdrop.dlp_claim_flag, *0x1::vector::borrow<u64>(&v5, v12)) = true;
            v12 = v12 + 1;
        };
        (v0, v8, v7, v6, v5)
    }

    fun withdraw_hive_gems(arg0: u64, arg1: &mut UserLockdropRewardsPosition, arg2: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive_profile::HiveProfile, arg3: &mut 0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HiveVault, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = calculate_withdrawable_hive(arg0, arg1.total_hive_rewards - arg1.delegated_hive_rewards);
        arg1.claimed_hive_rewards = arg1.claimed_hive_rewards + v0;
        0x2::balance::destroy_zero<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>(0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::burn_hive_and_return(arg3, arg2, 0x2::balance::split<0x12e7d4e7cd69706ba9916126eae7d7d7fe370a7f6f70f569dbe53a09fe89ab5a::hive::HIVE>(&mut arg1.available_hive_rewards, v0), v0, arg4));
        v0
    }

    // decompiled from Move bytecode v6
}

