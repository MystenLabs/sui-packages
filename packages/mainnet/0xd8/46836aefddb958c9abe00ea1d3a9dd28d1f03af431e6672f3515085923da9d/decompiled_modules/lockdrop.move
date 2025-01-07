module 0xd846836aefddb958c9abe00ea1d3a9dd28d1f03af431e6672f3515085923da9d::lockdrop {
    struct LockdropRewardsCapabilityHolder has key {
        id: 0x2::object::UID,
        capability: 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::ProfileDofOwnershipCapability,
    }

    struct LockdropVault has store, key {
        id: 0x2::object::UID,
        hive_profile: 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile,
        user_profile_access_cap: 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::ProfileDofOwnershipCapability,
        krafted_pools: 0x2::table::Table<0x1::string::String, address>,
        sui_total_locked: u64,
        sui_total_weighted_units: u128,
        hive_sui_total_received: u64,
        hive_available: 0x2::balance::Balance<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>,
        total_hive_incentives: u64,
        degenhive_lps_krafted: 0x2::balance::Balance<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>,
        total_lp_krafted: u64,
        are_staked_with_pool_hive: bool,
        dlps_staked_amount: u64,
        hive_gems_per_share: u256,
        bee_fruit_indexes: 0x2::linked_table::LinkedTable<0x1::ascii::String, u256>,
    }

    struct LockdropForPool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        hive_profile: 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile,
        user_profile_access_cap: 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::ProfileDofOwnershipCapability,
        cetus_state: LockdropCetusState<T0, T1>,
        kriya_state: LockdropKriyaState,
        flowx_state: LockdropFlowxState,
        total_withdrawn_x_balance: 0x2::balance::Balance<T0>,
        total_withdrawn_y_balance: 0x2::balance::Balance<T1>,
        degenhive_lps_krafted: 0x2::balance::Balance<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>,
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
        available_hive_rewards: 0x2::balance::Balance<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>,
        total_hive_rewards: u64,
        delegated_hive_rewards: u64,
        claimed_hive_rewards: u64,
    }

    struct UserLockdropHivePosition has store, key {
        id: 0x2::object::UID,
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
        fee_earned_x: u64,
        fee_earned_y: u64,
        sui_earned: u64,
        cetus_earned: u64,
        fee_and_rewards_claimed: bool,
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

    struct CetusFeeAndRewardsClaimed has copy, drop {
        user_addr: address,
        cetus_earned: u64,
        sui_earned: u64,
        x_fee_earned: u64,
        y_fee_earned: u64,
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

    public entry fun extract_liquidity_from_kriya<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg2: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg3: &mut LockdropForPool<T0, T1, T2>, arg4: &0xaba0e8b2a90b73a392c8c47a0e32c89bca4cc98df050ff8cac4e715df993b6e2::kriya_vampire_attack::KriyaAttackConfig, arg5: &mut 0xaba0e8b2a90b73a392c8c47a0e32c89bca4cc98df050ff8cac4e715df993b6e2::kriya_vampire_attack::KriyaLockdropForPool<T0, T1>, arg6: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg7: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, u64, u64) {
        let (v0, v1, v2, v3, v4, v5) = 0xaba0e8b2a90b73a392c8c47a0e32c89bca4cc98df050ff8cac4e715df993b6e2::kriya_vampire_attack::extract_liquidity_from_kriya<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7);
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
        0x2::balance::destroy_zero<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>(0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::burn_hive_and_return(arg2, &mut arg3.hive_profile, v5, v2, arg7));
        (v0, v1, v2, v8, v9)
    }

    public entry fun extract_liquidity_from_flowx<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg2: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg3: &mut LockdropForPool<T0, T1, T2>, arg4: &0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::FlowxAttackConfig, arg5: &mut 0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::FlowxLockdropForPool<T0, T1>, arg6: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg7: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, u64, u64) {
        let (v0, v1, v2, v3, v4, v5) = 0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::extract_liquidity_from_flowx<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7);
        internal_extract_flowx_liquidity<T0, T1, T2>(arg3, arg2, v0, v1, v2, v3, v4, v5, arg7)
    }

    public entry fun infuse_sui_hsui_pool(arg0: &0x2::clock::Clock, arg1: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg2: &mut LockdropVault, arg3: &mut 0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LiquidityPool<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x13e000cdb1fffaf1a925bdd173461846afc30b5fe396ded44e8100d085f7358a::hsui_vault::HSuiVault, arg6: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg7: &mut 0xc989ec7508bcfb8d98ca8f9f7b16a07a4f2a6d4a7c69d6b4a730d7a76cdd51f4::lsd_lockdrop::LsdLockdropVault, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        let (v0, v1, v2, v3, v4) = 0xc989ec7508bcfb8d98ca8f9f7b16a07a4f2a6d4a7c69d6b4a730d7a76cdd51f4::lsd_lockdrop::infuse_sui_hsui_pool(arg0, arg1, arg7, arg4, arg5, arg8);
        let v5 = v2;
        let v6 = v1;
        let v7 = v0;
        let v8 = 0x2::balance::value<0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI>(&v7);
        let v9 = 0x2::balance::value<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>(&v5);
        arg2.sui_total_locked = arg2.sui_total_locked + v3;
        arg2.sui_total_weighted_units = arg2.sui_total_weighted_units + v4;
        arg2.hive_sui_total_received = arg2.hive_sui_total_received + v8;
        arg2.total_hive_incentives = arg2.total_hive_incentives + v9;
        0x2::balance::destroy_zero<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>(0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::burn_hive_and_return(arg6, &mut arg2.hive_profile, v5, v9, arg8));
        let v10 = 0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::add_liquidity<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>(arg0, arg3, v6, v7, 0);
        arg2.total_lp_krafted = arg2.total_lp_krafted + 0x2::balance::value<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>(&v10);
        0x2::balance::join<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>(&mut arg2.degenhive_lps_krafted, v10);
        (v8, 0x2::balance::value<0x2::sui::SUI>(&v6), 0x2::balance::value<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>(&v10), v9)
    }

    public fun add_incentives_for_cetus_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::LockdropForPool<T0, T1>, arg2: &0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::CetusAttackConfig, arg3: 0x2::coin::Coin<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x1::string::String) {
        0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::add_incentives_for_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun add_incentives_for_flowx_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::FlowxLockdropForPool<T0, T1>, arg2: &0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::FlowxAttackConfig, arg3: 0x2::coin::Coin<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x1::string::String) {
        0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::add_incentives_for_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun add_incentives_for_kriya_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0xaba0e8b2a90b73a392c8c47a0e32c89bca4cc98df050ff8cac4e715df993b6e2::kriya_vampire_attack::KriyaLockdropForPool<T0, T1>, arg2: &0xaba0e8b2a90b73a392c8c47a0e32c89bca4cc98df050ff8cac4e715df993b6e2::kriya_vampire_attack::KriyaAttackConfig, arg3: 0x2::coin::Coin<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x1::string::String) {
        0xaba0e8b2a90b73a392c8c47a0e32c89bca4cc98df050ff8cac4e715df993b6e2::kriya_vampire_attack::add_incentives_for_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun add_incentives_for_lsd_lockdrop(arg0: &0x2::clock::Clock, arg1: &mut 0xc989ec7508bcfb8d98ca8f9f7b16a07a4f2a6d4a7c69d6b4a730d7a76cdd51f4::lsd_lockdrop::LsdLockdropVault, arg2: 0x2::coin::Coin<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0xc989ec7508bcfb8d98ca8f9f7b16a07a4f2a6d4a7c69d6b4a730d7a76cdd51f4::lsd_lockdrop::add_hive_incentives(arg0, arg1, arg2, arg3, arg4)
    }

    public entry fun add_liquidity_to_degenhive<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg2: &mut LockdropForPool<T0, T1, T2>, arg3: &mut 0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LiquidityPool<T0, T1, T2>, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        assert!(0x2::balance::value<T0>(&arg2.total_withdrawn_x_balance) > 0 && 0x2::balance::value<T1>(&arg2.total_withdrawn_y_balance) > 0, 1800);
        let v0 = 0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::add_liquidity<T0, T1, T2>(arg0, arg3, 0x2::balance::withdraw_all<T0>(&mut arg2.total_withdrawn_x_balance), 0x2::balance::withdraw_all<T1>(&mut arg2.total_withdrawn_y_balance), 0);
        arg2.total_lp_krafted = arg2.total_lp_krafted + (0x2::balance::value<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>(&v0) as u128);
        0x2::balance::join<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>(&mut arg2.degenhive_lps_krafted, v0);
        let v1 = ((arg2.cetus_state.total_x_withdrawn + arg2.kriya_state.total_x_withdrawn + arg2.flowx_state.total_x_withdrawn) as u256);
        let v2 = ((arg2.cetus_state.total_y_withdrawn + arg2.kriya_state.total_y_withdrawn + arg2.flowx_state.total_y_withdrawn) as u256);
        let v3 = ((0x2::balance::value<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>(&v0) / 2) as u256);
        arg2.cetus_state.total_dlps_amount = (0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256((arg2.cetus_state.total_x_withdrawn as u256), v3, v1) as u64);
        arg2.cetus_state.total_dlps_amount = arg2.cetus_state.total_dlps_amount + (0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256((arg2.cetus_state.total_y_withdrawn as u256), v3, v2) as u64);
        arg2.kriya_state.total_dlps_amount = (0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256((arg2.kriya_state.total_x_withdrawn as u256), v3, v1) as u64);
        arg2.kriya_state.total_dlps_amount = arg2.kriya_state.total_dlps_amount + (0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256((arg2.flowx_state.total_y_withdrawn as u256), v3, v2) as u64);
        arg2.flowx_state.total_dlps_amount = (0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256((arg2.flowx_state.total_x_withdrawn as u256), v3, v1) as u64);
        arg2.flowx_state.total_dlps_amount = arg2.flowx_state.total_dlps_amount + (0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256((arg2.flowx_state.total_y_withdrawn as u256), v3, v2) as u64);
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
        (0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256((arg0 as u256), ((arg4 / 2) as u256), (arg1 as u256)) as u64) + (0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256((arg2 as u256), ((arg4 / 2) as u256), (arg3 as u256)) as u64)
    }

    fun calculate_dlp_for_position(arg0: u128, arg1: u128, arg2: u128) : u64 {
        if (arg2 == 0) {
            0
        } else {
            (0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256((arg0 as u256), (arg1 as u256), (arg2 as u256)) as u64)
        }
    }

    fun calculate_hive_rewards(arg0: u128, arg1: u128, arg2: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            (0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256((arg2 as u256), (arg0 as u256), (arg1 as u256)) as u64)
        }
    }

    fun calculate_withdrawable_hive(arg0: u64, arg1: u64) : u64 {
        if (arg0 > 1700161652000 + 15552000000) {
            arg1
        } else {
            (0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256((arg1 as u256), ((arg0 - 1700161652000) as u256), (15552000000 as u256)) as u64)
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

    fun claim_cetus_fee_and_rewards<T0, T1, T2>(arg0: address, arg1: &mut LockdropForPool<T0, T1, T2>, arg2: &mut UserLockdropHivePosition, arg3: &mut 0x2::tx_context::TxContext) {
        if (!arg2.cetus_lockdrop.fee_and_rewards_claimed && 0x1::vector::length<u64>(&arg2.cetus_lockdrop.lockup_weeks) > 0) {
            let v0 = 0x2::balance::split<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg1.cetus_state.cetus_earned_bal, arg2.cetus_lockdrop.cetus_earned);
            let v1 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.cetus_state.sui_earned_bal, arg2.cetus_lockdrop.sui_earned);
            let v2 = 0x2::balance::split<T0>(&mut arg1.cetus_state.x_fee_withdrawn, arg2.cetus_lockdrop.fee_earned_x);
            let v3 = 0x2::balance::split<T1>(&mut arg1.cetus_state.y_fee_withdrawn, arg2.cetus_lockdrop.fee_earned_y);
            arg2.cetus_lockdrop.fee_and_rewards_claimed = true;
            let v4 = CetusFeeAndRewardsClaimed{
                user_addr    : arg0,
                cetus_earned : 0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v0),
                sui_earned   : 0x2::balance::value<0x2::sui::SUI>(&v1),
                x_fee_earned : 0x2::balance::value<T0>(&v2),
                y_fee_earned : 0x2::balance::value<T1>(&v3),
            };
            0x2::event::emit<CetusFeeAndRewardsClaimed>(v4);
            0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(v0, arg0, arg3);
            0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, arg0, arg3);
            0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<T0>(v2, arg0, arg3);
            0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<T1>(v3, arg0, arg3);
        };
    }

    fun claim_gems_and_increment_lsd_states(arg0: &mut LockdropVault, arg1: &mut UserLockdropHivePosition, arg2: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        arg0.hive_gems_per_share = arg0.hive_gems_per_share + 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256(((arg4 - arg3) as u256), (1000000000 as u256), (arg0.dlps_staked_amount as u256));
        let v0 = (0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256(arg0.hive_gems_per_share - arg1.hive_gems_per_share, ((arg1.total_degenhive_lp_tokens - arg1.unbonded_degenhive_lp_tokens) as u256), (1000000000 as u256)) as u64);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::transfer_hive_gems(&mut arg0.hive_profile, arg2, v0, arg5);
        arg1.hive_gems_per_share = arg0.hive_gems_per_share;
        arg1.gems_streamed_from_staking = arg1.gems_streamed_from_staking + v0;
        v0
    }

    fun claim_gems_and_increment_states<T0, T1, T2>(arg0: &mut LockdropForPool<T0, T1, T2>, arg1: &mut UserLockdropHivePosition, arg2: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        arg0.hive_gems_per_share = arg0.hive_gems_per_share + 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256(((arg4 - arg3) as u256), (1000000000 as u256), (arg0.dlps_staked_amount as u256));
        let v0 = (0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256(arg0.hive_gems_per_share - arg1.hive_gems_per_share, ((arg1.total_degenhive_lp_tokens - arg1.unbonded_degenhive_lp_tokens) as u256), (1000000000 as u256)) as u64);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::transfer_hive_gems(&mut arg0.hive_profile, arg2, v0, arg5);
        arg1.hive_gems_per_share = arg0.hive_gems_per_share;
        arg1.gems_streamed_from_staking = arg1.gems_streamed_from_staking + v0;
        v0
    }

    public fun claim_hive_and_unlock_degenhive_lps_0_fruit<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &LockdropRewardsCapabilityHolder, arg2: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg3: &mut LockdropForPool<T0, T1, T2>, arg4: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg5: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolsGovernor, arg6: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolHive<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, v3) = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_meta_info(arg2);
        assert!(0x2::tx_context::sender(arg7) == v3, 1810);
        let v4 = 0x2::clock::timestamp_ms(arg0);
        let v5 = 0x2::tx_context::epoch(arg7);
        let v6 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, arg7);
        let v7 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg3.user_profile_access_cap, arg2, arg7);
        let v8 = &mut v7;
        claim_cetus_fee_and_rewards<T0, T1, T2>(v3, arg3, v8, arg7);
        let v9 = &mut v7;
        let (v10, v11, v12, v13, v14) = unbond_degenhive_lp_tokens(v4, v9);
        let v15 = &mut v6;
        let v16 = withdraw_hive_gems(v4, v15, arg2, arg4, arg7);
        let v17 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_available_gems_in_profile(&arg3.hive_profile);
        0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::unbond_from_bee_box_0_fruit<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>(arg5, arg6, &mut arg3.hive_profile, v10, arg7);
        let v18 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_available_gems_in_profile(&arg3.hive_profile);
        let v19 = &mut v7;
        let v20 = claim_gems_and_increment_states<T0, T1, T2>(arg3, v19, arg2, v17, v18, arg7);
        let v21 = &mut v7;
        let v22 = internal_claim_lps<T0, T1, T2>(arg3, arg6, v21, v10, v5 + 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::get_unbonding_duration(arg5), v5, arg7);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg3.user_profile_access_cap, arg2, v7, arg7);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, v6, arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>(v22, 0x2::tx_context::sender(arg7), arg7);
        let v23 = PositionsUnlockedAndRewardsClaimed{
            user_addr                   : 0x2::tx_context::sender(arg7),
            username                    : v1,
            profile_addr                : v0,
            unbondable_sui_lp_positions : v11,
            unbondable_cetus_positions  : v12,
            unbondable_kriya_positions  : v13,
            unbondable_flowx_positions  : v14,
            unbond_lp_shares_amt        : v10,
            claimable_hive              : v16,
            gems_via_staking_yield      : v20,
        };
        0x2::event::emit<PositionsUnlockedAndRewardsClaimed>(v23);
    }

    public fun claim_hive_and_unlock_degenhive_lps_1_fruit<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &LockdropRewardsCapabilityHolder, arg2: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg3: &mut LockdropForPool<T0, T1, T2>, arg4: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg5: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolsGovernor, arg6: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolHive<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, v3) = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_meta_info(arg2);
        assert!(0x2::tx_context::sender(arg7) == v3, 1810);
        let v4 = 0x2::clock::timestamp_ms(arg0);
        let v5 = 0x2::tx_context::epoch(arg7);
        let v6 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, arg7);
        let v7 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg3.user_profile_access_cap, arg2, arg7);
        let v8 = &mut v7;
        claim_cetus_fee_and_rewards<T0, T1, T2>(v3, arg3, v8, arg7);
        let v9 = &mut v7;
        let (v10, v11, v12, v13, v14) = unbond_degenhive_lp_tokens(v4, v9);
        let v15 = &mut v6;
        let v16 = withdraw_hive_gems(v4, v15, arg2, arg4, arg7);
        let v17 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_available_gems_in_profile(&arg3.hive_profile);
        let v18 = 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::unbond_from_bee_box_1_fruit<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>, T3>(arg5, arg6, &mut arg3.hive_profile, v10, arg7);
        let v19 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_available_gems_in_profile(&arg3.hive_profile);
        let v20 = &mut v7;
        let v21 = claim_gems_and_increment_states<T0, T1, T2>(arg3, v20, arg2, v17, v19, arg7);
        let v22 = &mut v7;
        let v23 = increment_bee_fruit_indexes<T0, T1, T2, T3>(v1, arg3, v22, v18, arg7);
        let v24 = &mut v7;
        let v25 = internal_claim_lps<T0, T1, T2>(arg3, arg6, v24, v10, v5 + 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::get_unbonding_duration(arg5), v5, arg7);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg3.user_profile_access_cap, arg2, v7, arg7);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, v6, arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>(v25, 0x2::tx_context::sender(arg7), arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<T3>(v23, 0x2::tx_context::sender(arg7), arg7);
        let v26 = PositionsUnlockedAndRewardsClaimed{
            user_addr                   : 0x2::tx_context::sender(arg7),
            username                    : v1,
            profile_addr                : v0,
            unbondable_sui_lp_positions : v11,
            unbondable_cetus_positions  : v12,
            unbondable_kriya_positions  : v13,
            unbondable_flowx_positions  : v14,
            unbond_lp_shares_amt        : v10,
            claimable_hive              : v16,
            gems_via_staking_yield      : v21,
        };
        0x2::event::emit<PositionsUnlockedAndRewardsClaimed>(v26);
    }

    public fun claim_hive_and_unlock_degenhive_lps_2_fruit<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &LockdropRewardsCapabilityHolder, arg2: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg3: &mut LockdropForPool<T0, T1, T2>, arg4: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg5: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolsGovernor, arg6: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolHive<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, v3) = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_meta_info(arg2);
        assert!(0x2::tx_context::sender(arg7) == v3, 1810);
        let v4 = 0x2::clock::timestamp_ms(arg0);
        let v5 = 0x2::tx_context::epoch(arg7);
        let v6 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, arg7);
        let v7 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg3.user_profile_access_cap, arg2, arg7);
        let v8 = &mut v7;
        claim_cetus_fee_and_rewards<T0, T1, T2>(v3, arg3, v8, arg7);
        let v9 = &mut v7;
        let (v10, v11, v12, v13, v14) = unbond_degenhive_lp_tokens(v4, v9);
        let v15 = &mut v6;
        let v16 = withdraw_hive_gems(v4, v15, arg2, arg4, arg7);
        let v17 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_available_gems_in_profile(&arg3.hive_profile);
        let (v18, v19) = 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::unbond_from_bee_box_2_fruits<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>, T3, T4>(arg5, arg6, &mut arg3.hive_profile, v10, arg7);
        let v20 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_available_gems_in_profile(&arg3.hive_profile);
        let v21 = &mut v7;
        let v22 = claim_gems_and_increment_states<T0, T1, T2>(arg3, v21, arg2, v17, v20, arg7);
        let v23 = &mut v7;
        let v24 = increment_bee_fruit_indexes<T0, T1, T2, T3>(v1, arg3, v23, v18, arg7);
        let v25 = &mut v7;
        let v26 = increment_bee_fruit_indexes<T0, T1, T2, T4>(v1, arg3, v25, v19, arg7);
        let v27 = &mut v7;
        let v28 = internal_claim_lps<T0, T1, T2>(arg3, arg6, v27, v10, v5 + 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::get_unbonding_duration(arg5), v5, arg7);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg3.user_profile_access_cap, arg2, v7, arg7);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, v6, arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>(v28, 0x2::tx_context::sender(arg7), arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<T3>(v24, 0x2::tx_context::sender(arg7), arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<T4>(v26, 0x2::tx_context::sender(arg7), arg7);
        let v29 = PositionsUnlockedAndRewardsClaimed{
            user_addr                   : 0x2::tx_context::sender(arg7),
            username                    : v1,
            profile_addr                : v0,
            unbondable_sui_lp_positions : v11,
            unbondable_cetus_positions  : v12,
            unbondable_kriya_positions  : v13,
            unbondable_flowx_positions  : v14,
            unbond_lp_shares_amt        : v10,
            claimable_hive              : v16,
            gems_via_staking_yield      : v22,
        };
        0x2::event::emit<PositionsUnlockedAndRewardsClaimed>(v29);
    }

    public fun claim_hive_and_unlock_degenhive_lps_3_fruit<T0, T1, T2, T3, T4, T5>(arg0: &0x2::clock::Clock, arg1: &LockdropRewardsCapabilityHolder, arg2: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg3: &mut LockdropForPool<T0, T1, T2>, arg4: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg5: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolsGovernor, arg6: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolHive<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, v3) = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_meta_info(arg2);
        assert!(0x2::tx_context::sender(arg7) == v3, 1810);
        let v4 = 0x2::clock::timestamp_ms(arg0);
        let v5 = 0x2::tx_context::epoch(arg7);
        let v6 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, arg7);
        let v7 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg3.user_profile_access_cap, arg2, arg7);
        let v8 = &mut v7;
        claim_cetus_fee_and_rewards<T0, T1, T2>(v3, arg3, v8, arg7);
        let v9 = &mut v7;
        let (v10, v11, v12, v13, v14) = unbond_degenhive_lp_tokens(v4, v9);
        let v15 = &mut v6;
        let v16 = withdraw_hive_gems(v4, v15, arg2, arg4, arg7);
        let v17 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_available_gems_in_profile(&arg3.hive_profile);
        let (v18, v19, v20) = 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::unbond_from_bee_box_3_fruits<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>, T3, T4, T5>(arg5, arg6, &mut arg3.hive_profile, v10, arg7);
        let v21 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_available_gems_in_profile(&arg3.hive_profile);
        let v22 = &mut v7;
        let v23 = claim_gems_and_increment_states<T0, T1, T2>(arg3, v22, arg2, v17, v21, arg7);
        let v24 = &mut v7;
        let v25 = increment_bee_fruit_indexes<T0, T1, T2, T3>(v1, arg3, v24, v18, arg7);
        let v26 = &mut v7;
        let v27 = increment_bee_fruit_indexes<T0, T1, T2, T4>(v1, arg3, v26, v19, arg7);
        let v28 = &mut v7;
        let v29 = increment_bee_fruit_indexes<T0, T1, T2, T5>(v1, arg3, v28, v20, arg7);
        let v30 = &mut v7;
        let v31 = internal_claim_lps<T0, T1, T2>(arg3, arg6, v30, v10, v5 + 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::get_unbonding_duration(arg5), v5, arg7);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg3.user_profile_access_cap, arg2, v7, arg7);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, v6, arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>(v31, 0x2::tx_context::sender(arg7), arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<T3>(v25, 0x2::tx_context::sender(arg7), arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<T4>(v27, 0x2::tx_context::sender(arg7), arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<T5>(v29, 0x2::tx_context::sender(arg7), arg7);
        let v32 = PositionsUnlockedAndRewardsClaimed{
            user_addr                   : 0x2::tx_context::sender(arg7),
            username                    : v1,
            profile_addr                : v0,
            unbondable_sui_lp_positions : v11,
            unbondable_cetus_positions  : v12,
            unbondable_kriya_positions  : v13,
            unbondable_flowx_positions  : v14,
            unbond_lp_shares_amt        : v10,
            claimable_hive              : v16,
            gems_via_staking_yield      : v23,
        };
        0x2::event::emit<PositionsUnlockedAndRewardsClaimed>(v32);
    }

    public fun claim_hive_and_unlock_degenhive_lsd_lps_0_fruit(arg0: &0x2::clock::Clock, arg1: &LockdropRewardsCapabilityHolder, arg2: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg3: &mut LockdropVault, arg4: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg5: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolsGovernor, arg6: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolHive<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, v3) = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_meta_info(arg2);
        assert!(0x2::tx_context::sender(arg7) == v3, 1810);
        let v4 = 0x2::clock::timestamp_ms(arg0);
        let v5 = 0x2::tx_context::epoch(arg7);
        let v6 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, arg7);
        let v7 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg3.user_profile_access_cap, arg2, arg7);
        let v8 = &mut v7;
        let (v9, v10, v11, v12, v13) = unbond_degenhive_lp_tokens(v4, v8);
        let v14 = &mut v6;
        let v15 = withdraw_hive_gems(v4, v14, arg2, arg4, arg7);
        let v16 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_available_gems_in_profile(&arg3.hive_profile);
        0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::unbond_from_bee_box_0_fruit<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>(arg5, arg6, &mut arg3.hive_profile, v9, arg7);
        let v17 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_available_gems_in_profile(&arg3.hive_profile);
        let v18 = &mut v7;
        let v19 = claim_gems_and_increment_lsd_states(arg3, v18, arg2, v16, v17, arg7);
        let v20 = &mut v7;
        let v21 = internal_claim_lsd_lps(arg3, arg6, v20, v9, v5 + 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::get_unbonding_duration(arg5), v5, arg7);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg3.user_profile_access_cap, arg2, v7, arg7);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, v6, arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>(v21, 0x2::tx_context::sender(arg7), arg7);
        let v22 = PositionsUnlockedAndRewardsClaimed{
            user_addr                   : 0x2::tx_context::sender(arg7),
            username                    : v1,
            profile_addr                : v0,
            unbondable_sui_lp_positions : v10,
            unbondable_cetus_positions  : v11,
            unbondable_kriya_positions  : v12,
            unbondable_flowx_positions  : v13,
            unbond_lp_shares_amt        : v9,
            claimable_hive              : v15,
            gems_via_staking_yield      : v19,
        };
        0x2::event::emit<PositionsUnlockedAndRewardsClaimed>(v22);
    }

    public fun claim_hive_and_unlock_degenhive_lsd_lps_1_fruit<T0>(arg0: &0x2::clock::Clock, arg1: &LockdropRewardsCapabilityHolder, arg2: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg3: &mut LockdropVault, arg4: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg5: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolsGovernor, arg6: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolHive<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, v3) = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_meta_info(arg2);
        assert!(0x2::tx_context::sender(arg7) == v3, 1810);
        let v4 = 0x2::clock::timestamp_ms(arg0);
        let v5 = 0x2::tx_context::epoch(arg7);
        let v6 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, arg7);
        let v7 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg3.user_profile_access_cap, arg2, arg7);
        let v8 = &mut v7;
        let (v9, v10, v11, v12, v13) = unbond_degenhive_lp_tokens(v4, v8);
        let v14 = &mut v6;
        let v15 = withdraw_hive_gems(v4, v14, arg2, arg4, arg7);
        let v16 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_available_gems_in_profile(&arg3.hive_profile);
        let v17 = 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::unbond_from_bee_box_1_fruit<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>, T0>(arg5, arg6, &mut arg3.hive_profile, v9, arg7);
        let v18 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_available_gems_in_profile(&arg3.hive_profile);
        let v19 = &mut v7;
        let v20 = claim_gems_and_increment_lsd_states(arg3, v19, arg2, v16, v18, arg7);
        let v21 = &mut v7;
        let v22 = lsd_increment_bee_fruit_indexes<T0>(v1, arg3, v21, v17, arg7);
        let v23 = &mut v7;
        let v24 = internal_claim_lsd_lps(arg3, arg6, v23, v9, v5 + 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::get_unbonding_duration(arg5), v5, arg7);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg3.user_profile_access_cap, arg2, v7, arg7);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, v6, arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>(v24, 0x2::tx_context::sender(arg7), arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<T0>(v22, 0x2::tx_context::sender(arg7), arg7);
        let v25 = PositionsUnlockedAndRewardsClaimed{
            user_addr                   : 0x2::tx_context::sender(arg7),
            username                    : v1,
            profile_addr                : v0,
            unbondable_sui_lp_positions : v10,
            unbondable_cetus_positions  : v11,
            unbondable_kriya_positions  : v12,
            unbondable_flowx_positions  : v13,
            unbond_lp_shares_amt        : v9,
            claimable_hive              : v15,
            gems_via_staking_yield      : v20,
        };
        0x2::event::emit<PositionsUnlockedAndRewardsClaimed>(v25);
    }

    public fun claim_hive_and_unlock_degenhive_lsd_lps_2_fruit<T0, T1>(arg0: &0x2::clock::Clock, arg1: &LockdropRewardsCapabilityHolder, arg2: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg3: &mut LockdropVault, arg4: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg5: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolsGovernor, arg6: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolHive<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, v3) = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_meta_info(arg2);
        assert!(0x2::tx_context::sender(arg7) == v3, 1810);
        let v4 = 0x2::clock::timestamp_ms(arg0);
        let v5 = 0x2::tx_context::epoch(arg7);
        let v6 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, arg7);
        let v7 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg3.user_profile_access_cap, arg2, arg7);
        let v8 = &mut v7;
        let (v9, v10, v11, v12, v13) = unbond_degenhive_lp_tokens(v4, v8);
        let v14 = &mut v6;
        let v15 = withdraw_hive_gems(v4, v14, arg2, arg4, arg7);
        let v16 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_available_gems_in_profile(&arg3.hive_profile);
        let (v17, v18) = 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::unbond_from_bee_box_2_fruits<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>, T0, T1>(arg5, arg6, &mut arg3.hive_profile, v9, arg7);
        let v19 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_available_gems_in_profile(&arg3.hive_profile);
        let v20 = &mut v7;
        let v21 = claim_gems_and_increment_lsd_states(arg3, v20, arg2, v16, v19, arg7);
        let v22 = &mut v7;
        let v23 = lsd_increment_bee_fruit_indexes<T0>(v1, arg3, v22, v17, arg7);
        let v24 = &mut v7;
        let v25 = lsd_increment_bee_fruit_indexes<T1>(v1, arg3, v24, v18, arg7);
        let v26 = &mut v7;
        let v27 = internal_claim_lsd_lps(arg3, arg6, v26, v9, v5 + 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::get_unbonding_duration(arg5), v5, arg7);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg3.user_profile_access_cap, arg2, v7, arg7);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, v6, arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>(v27, 0x2::tx_context::sender(arg7), arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<T0>(v23, 0x2::tx_context::sender(arg7), arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<T1>(v25, 0x2::tx_context::sender(arg7), arg7);
        let v28 = PositionsUnlockedAndRewardsClaimed{
            user_addr                   : 0x2::tx_context::sender(arg7),
            username                    : v1,
            profile_addr                : v0,
            unbondable_sui_lp_positions : v10,
            unbondable_cetus_positions  : v11,
            unbondable_kriya_positions  : v12,
            unbondable_flowx_positions  : v13,
            unbond_lp_shares_amt        : v9,
            claimable_hive              : v15,
            gems_via_staking_yield      : v21,
        };
        0x2::event::emit<PositionsUnlockedAndRewardsClaimed>(v28);
    }

    public fun claim_hive_and_unlock_degenhive_lsd_lps_3_fruit<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &LockdropRewardsCapabilityHolder, arg2: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg3: &mut LockdropVault, arg4: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg5: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolsGovernor, arg6: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolHive<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _, v3) = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_meta_info(arg2);
        assert!(0x2::tx_context::sender(arg7) == v3, 1810);
        let v4 = 0x2::clock::timestamp_ms(arg0);
        let v5 = 0x2::tx_context::epoch(arg7);
        let v6 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, arg7);
        let v7 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg3.user_profile_access_cap, arg2, arg7);
        let v8 = &mut v7;
        let (v9, v10, v11, v12, v13) = unbond_degenhive_lp_tokens(v4, v8);
        let v14 = &mut v6;
        let v15 = withdraw_hive_gems(v4, v14, arg2, arg4, arg7);
        let v16 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_available_gems_in_profile(&arg3.hive_profile);
        let (v17, v18, v19) = 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::unbond_from_bee_box_3_fruits<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>, T0, T1, T2>(arg5, arg6, &mut arg3.hive_profile, v9, arg7);
        let v20 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_available_gems_in_profile(&arg3.hive_profile);
        let v21 = &mut v7;
        let v22 = claim_gems_and_increment_lsd_states(arg3, v21, arg2, v16, v20, arg7);
        let v23 = &mut v7;
        let v24 = lsd_increment_bee_fruit_indexes<T0>(v1, arg3, v23, v17, arg7);
        let v25 = &mut v7;
        let v26 = lsd_increment_bee_fruit_indexes<T1>(v1, arg3, v25, v18, arg7);
        let v27 = &mut v7;
        let v28 = lsd_increment_bee_fruit_indexes<T2>(v1, arg3, v27, v19, arg7);
        let v29 = &mut v7;
        let v30 = internal_claim_lsd_lps(arg3, arg6, v29, v9, v5 + 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::get_unbonding_duration(arg5), v5, arg7);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg3.user_profile_access_cap, arg2, v7, arg7);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, v6, arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>(v30, 0x2::tx_context::sender(arg7), arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<T0>(v24, 0x2::tx_context::sender(arg7), arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<T1>(v26, 0x2::tx_context::sender(arg7), arg7);
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<T2>(v28, 0x2::tx_context::sender(arg7), arg7);
        let v31 = PositionsUnlockedAndRewardsClaimed{
            user_addr                   : 0x2::tx_context::sender(arg7),
            username                    : v1,
            profile_addr                : v0,
            unbondable_sui_lp_positions : v10,
            unbondable_cetus_positions  : v11,
            unbondable_kriya_positions  : v12,
            unbondable_flowx_positions  : v13,
            unbond_lp_shares_amt        : v9,
            claimable_hive              : v15,
            gems_via_staking_yield      : v22,
        };
        0x2::event::emit<PositionsUnlockedAndRewardsClaimed>(v31);
    }

    public fun claim_liquidity_from_cetus<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg2: &0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::CetusAttackConfig, arg3: &mut 0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::LockdropForPool<T0, T1>, arg4: &mut LockdropForPool<T0, T1, T2>, arg5: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg6: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, u64, u64, u64, u64, u64, u64) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8) = 0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::transfer_liquidity_from_cetus<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        internal_claim_cetus_liquidity<T0, T1, T2>(arg4, arg5, v0, v1, v2, v3, v4, v5, v6, v7, v8, arg6)
    }

    public fun claim_liquidity_from_rev_cetus<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg2: &0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::CetusAttackConfig, arg3: &mut 0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::LockdropForPool<T1, T0>, arg4: &mut LockdropForPool<T0, T1, T2>, arg5: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg6: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, u64, u64, u64, u64, u64, u64) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8) = 0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::transfer_liquidity_from_cetus<T1, T0>(arg0, arg1, arg2, arg3, arg6);
        internal_claim_cetus_liquidity<T0, T1, T2>(arg4, arg5, v0, v1, v3, v2, v5, v4, v6, v7, v8, arg6)
    }

    public fun delegate_hive_for_infusion(arg0: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg1: &LockdropRewardsCapabilityHolder, arg2: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE> {
        let v0 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, arg4);
        assert!(v0.total_hive_rewards - v0.delegated_hive_rewards >= arg3, 1811);
        v0.delegated_hive_rewards = v0.delegated_hive_rewards + arg3;
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg1.capability, arg2, v0, arg4);
        0x2::balance::split<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>(&mut v0.available_hive_rewards, arg3)
    }

    public entry fun extract_liquidity_from_rev_flowx<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg2: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg3: &mut LockdropForPool<T0, T1, T2>, arg4: &0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::FlowxAttackConfig, arg5: &mut 0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::FlowxLockdropForPool<T1, T0>, arg6: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg7: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, u64, u64) {
        let (v0, v1, v2, v3, v4, v5) = 0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::extract_liquidity_from_flowx<T1, T0>(arg0, arg1, arg4, arg5, arg6, arg7);
        internal_extract_flowx_liquidity<T0, T1, T2>(arg3, arg2, v0, v1, v2, v4, v3, v5, arg7)
    }

    public fun get_user_attack_positions<T0, T1, T2>(arg0: &0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg1: &LockdropForPool<T0, T1, T2>) : (vector<u64>, vector<u64>, vector<u64>, vector<u128>, u64, u64, u64, u64, bool, vector<u64>, vector<bool>, vector<u64>, vector<u64>, u64, u64, vector<u64>, vector<u64>, vector<u64>, vector<bool>, vector<u64>, vector<u64>, u64, u64, vector<u64>, vector<u64>, vector<u64>, vector<bool>, vector<u64>, vector<u64>, u64, u64, vector<u64>, vector<u64>, u256, u64, vector<0x1::ascii::String>, vector<u256>, vector<u128>) {
        let v0 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_dof_capability_identifier(&arg1.user_profile_access_cap);
        if (!0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::exists_for_profile(arg0, v0)) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u128>(), 0, 0, 0, 0, false, 0x1::vector::empty<u64>(), 0x1::vector::empty<bool>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0, 0, 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<bool>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0, 0, 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<bool>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0, 0, 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0, 0, 0x1::vector::empty<0x1::ascii::String>(), 0x1::vector::empty<u256>(), 0x1::vector::empty<u128>())
        };
        let v1 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::borrow_from_profile<UserLockdropHivePosition>(arg0, v0);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u128>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<bool>();
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0x1::vector::empty<u64>();
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        while (v11 < 0x1::vector::length<u64>(&v1.cetus_lockdrop.lockup_weeks)) {
            let v12 = *0x1::vector::borrow<u64>(&v1.cetus_lockdrop.lockup_weeks, v11);
            0x1::vector::push_back<u64>(&mut v2, *0x2::table::borrow<u64, u64>(&v1.cetus_lockdrop.x_withdrawn, v12));
            0x1::vector::push_back<u64>(&mut v3, *0x2::table::borrow<u64, u64>(&v1.cetus_lockdrop.y_withdrawn, v12));
            0x1::vector::push_back<u128>(&mut v4, *0x2::table::borrow<u64, u128>(&v1.cetus_lockdrop.position_liquidity, v12));
            let v13 = *0x2::table::borrow<u64, u64>(&v1.cetus_lockdrop.hive_rewards_per_lockup, v12);
            0x1::vector::push_back<u64>(&mut v5, v13);
            v9 = v9 + v13;
            0x1::vector::push_back<bool>(&mut v6, *0x2::table::borrow<u64, bool>(&v1.cetus_lockdrop.dlp_claim_flag, v12));
            0x1::vector::push_back<u64>(&mut v7, *0x2::table::borrow<u64, u64>(&v1.cetus_lockdrop.unlock_timestamps, v12));
            let v14 = *0x2::table::borrow<u64, u64>(&v1.cetus_lockdrop.dlp_per_lockup, v12);
            0x1::vector::push_back<u64>(&mut v8, v14);
            v10 = v10 + v14;
            v11 = v11 + 1;
        };
        let v15 = 0x1::vector::empty<u64>();
        let v16 = 0x1::vector::empty<u64>();
        let v17 = 0x1::vector::empty<bool>();
        let v18 = 0x1::vector::empty<u64>();
        let v19 = 0x1::vector::empty<u64>();
        let v20 = 0;
        let v21 = 0;
        let v22 = 0;
        while (v22 < 0x1::vector::length<u64>(&v1.kriya_lockdrop.lockup_weeks)) {
            let v23 = *0x1::vector::borrow<u64>(&v1.kriya_lockdrop.lockup_weeks, v22);
            0x1::vector::push_back<u64>(&mut v15, *0x2::table::borrow<u64, u64>(&v1.kriya_lockdrop.lp_tokens_locked, v23));
            0x1::vector::push_back<bool>(&mut v17, *0x2::table::borrow<u64, bool>(&v1.kriya_lockdrop.dlp_claim_flag, v23));
            0x1::vector::push_back<u64>(&mut v18, *0x2::table::borrow<u64, u64>(&v1.kriya_lockdrop.unlock_timestamps, v23));
            let v24 = *0x2::table::borrow<u64, u64>(&v1.kriya_lockdrop.hive_rewards_per_lockup, v23);
            0x1::vector::push_back<u64>(&mut v16, v24);
            v20 = v20 + v24;
            let v25 = *0x2::table::borrow<u64, u64>(&v1.kriya_lockdrop.dlp_per_lockup, v23);
            0x1::vector::push_back<u64>(&mut v19, v25);
            v21 = v21 + v25;
            v22 = v22 + 1;
        };
        let v26 = 0x1::vector::empty<u64>();
        let v27 = 0x1::vector::empty<u64>();
        let v28 = 0x1::vector::empty<bool>();
        let v29 = 0x1::vector::empty<u64>();
        let v30 = 0x1::vector::empty<u64>();
        let v31 = 0;
        let v32 = 0;
        let v33 = 0;
        while (v33 < 0x1::vector::length<u64>(&v1.flowx_lockdrop.lockup_weeks)) {
            let v34 = *0x1::vector::borrow<u64>(&v1.flowx_lockdrop.lockup_weeks, v33);
            0x1::vector::push_back<u64>(&mut v26, *0x2::table::borrow<u64, u64>(&v1.flowx_lockdrop.lp_tokens_locked, v34));
            0x1::vector::push_back<bool>(&mut v28, *0x2::table::borrow<u64, bool>(&v1.flowx_lockdrop.dlp_claim_flag, v34));
            0x1::vector::push_back<u64>(&mut v29, *0x2::table::borrow<u64, u64>(&v1.flowx_lockdrop.unlock_timestamps, v34));
            let v35 = *0x2::table::borrow<u64, u64>(&v1.flowx_lockdrop.hive_rewards_per_lockup, v34);
            0x1::vector::push_back<u64>(&mut v27, v35);
            v31 = v31 + v35;
            let v36 = *0x2::table::borrow<u64, u64>(&v1.flowx_lockdrop.dlp_per_lockup, v34);
            0x1::vector::push_back<u64>(&mut v30, v36);
            v32 = v32 + v36;
            v33 = v33 + 1;
        };
        let v37 = 0x1::vector::empty<u64>();
        let v38 = 0x1::vector::empty<u64>();
        let v39 = *0x2::linked_table::front<u64, u64>(&v1.lp_to_unlock);
        while (0x1::option::is_some<u64>(&v39)) {
            let v40 = *0x1::option::borrow<u64>(&v39);
            0x1::vector::push_back<u64>(&mut v37, v40);
            0x1::vector::push_back<u64>(&mut v38, *0x2::linked_table::borrow<u64, u64>(&v1.lp_to_unlock, v40));
            v39 = *0x2::linked_table::next<u64, u64>(&v1.lp_to_unlock, v40);
        };
        let v41 = 0x1::vector::empty<0x1::ascii::String>();
        let v42 = 0x1::vector::empty<u256>();
        let v43 = 0x1::vector::empty<u128>();
        let v44 = *0x2::linked_table::front<0x1::ascii::String, u256>(&v1.bee_fruit_indexes);
        while (0x1::option::is_some<0x1::ascii::String>(&v44)) {
            let v45 = *0x1::option::borrow<0x1::ascii::String>(&v44);
            0x1::vector::push_back<0x1::ascii::String>(&mut v41, v45);
            0x1::vector::push_back<u256>(&mut v42, *0x2::linked_table::borrow<0x1::ascii::String, u256>(&v1.bee_fruit_indexes, v45));
            0x1::vector::push_back<u128>(&mut v43, *0x2::linked_table::borrow<0x1::ascii::String, u128>(&v1.total_bee_fruits_earned, v45));
            v44 = *0x2::linked_table::next<0x1::ascii::String, u256>(&v1.bee_fruit_indexes, v45);
        };
        (v1.cetus_lockdrop.lockup_weeks, v2, v3, v4, v1.cetus_lockdrop.fee_earned_x, v1.cetus_lockdrop.fee_earned_y, v1.cetus_lockdrop.sui_earned, v1.cetus_lockdrop.cetus_earned, v1.cetus_lockdrop.fee_and_rewards_claimed, v5, v6, v7, v8, v9, v10, v1.kriya_lockdrop.lockup_weeks, v15, v16, v17, v18, v19, v20, v21, v1.flowx_lockdrop.lockup_weeks, v26, v27, v28, v29, v30, v31, v32, v37, v38, v1.hive_gems_per_share, v1.gems_streamed_from_staking, v41, v42, v43)
    }

    public fun get_user_lsd_positions(arg0: &0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg1: &LockdropVault) : (vector<u64>, vector<u64>, vector<u64>, vector<u64>, vector<bool>, vector<u64>, u64, u64, u64, u64, vector<u64>, vector<u64>, u256, u64, vector<0x1::ascii::String>, vector<u256>, vector<u128>) {
        let v0 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_dof_capability_identifier(&arg1.user_profile_access_cap);
        if (!0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::exists_for_profile(arg0, v0)) {
            return (0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0x1::vector::empty<bool>(), 0x1::vector::empty<u64>(), 0, 0, 0, 0, 0x1::vector::empty<u64>(), 0x1::vector::empty<u64>(), 0, 0, 0x1::vector::empty<0x1::ascii::String>(), 0x1::vector::empty<u256>(), 0x1::vector::empty<u128>())
        };
        let v1 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::borrow_from_profile<UserLockdropHivePosition>(arg0, v0);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<bool>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = 0;
        let v8 = 0;
        while (v8 < 0x1::vector::length<u64>(&v1.sui_lockdrop.lockup_weeks)) {
            let v9 = *0x1::vector::borrow<u64>(&v1.sui_lockdrop.lockup_weeks, v8);
            0x1::vector::push_back<u64>(&mut v2, *0x2::table::borrow<u64, u64>(&v1.sui_lockdrop.locked_per_position, v9));
            0x1::vector::push_back<u64>(&mut v3, *0x2::table::borrow<u64, u64>(&v1.sui_lockdrop.unlock_timestamps, v9));
            0x1::vector::push_back<u64>(&mut v4, *0x2::table::borrow<u64, u64>(&v1.sui_lockdrop.dlp_per_lockup, v9));
            0x1::vector::push_back<bool>(&mut v5, *0x2::table::borrow<u64, bool>(&v1.sui_lockdrop.dlp_claim_flag, v9));
            let v10 = *0x2::table::borrow<u64, u64>(&v1.sui_lockdrop.hive_rewards_per_lockup, v9);
            0x1::vector::push_back<u64>(&mut v6, v10);
            v7 = v7 + v10;
            v8 = v8 + 1;
        };
        let v11 = 0x1::vector::empty<u64>();
        let v12 = 0x1::vector::empty<u64>();
        let v13 = *0x2::linked_table::front<u64, u64>(&v1.lp_to_unlock);
        while (0x1::option::is_some<u64>(&v13)) {
            let v14 = *0x1::option::borrow<u64>(&v13);
            0x1::vector::push_back<u64>(&mut v11, v14);
            0x1::vector::push_back<u64>(&mut v12, *0x2::linked_table::borrow<u64, u64>(&v1.lp_to_unlock, v14));
            v13 = *0x2::linked_table::next<u64, u64>(&v1.lp_to_unlock, v14);
        };
        let v15 = 0x1::vector::empty<0x1::ascii::String>();
        let v16 = 0x1::vector::empty<u256>();
        let v17 = 0x1::vector::empty<u128>();
        let v18 = *0x2::linked_table::front<0x1::ascii::String, u256>(&v1.bee_fruit_indexes);
        while (0x1::option::is_some<0x1::ascii::String>(&v18)) {
            let v19 = *0x1::option::borrow<0x1::ascii::String>(&v18);
            0x1::vector::push_back<0x1::ascii::String>(&mut v15, v19);
            0x1::vector::push_back<u256>(&mut v16, *0x2::linked_table::borrow<0x1::ascii::String, u256>(&v1.bee_fruit_indexes, v19));
            0x1::vector::push_back<u128>(&mut v17, *0x2::linked_table::borrow<0x1::ascii::String, u128>(&v1.total_bee_fruits_earned, v19));
            v18 = *0x2::linked_table::next<0x1::ascii::String, u256>(&v1.bee_fruit_indexes, v19);
        };
        (v1.sui_lockdrop.lockup_weeks, v2, v3, v4, v5, v6, v7, v1.total_degenhive_lp_tokens, v1.unbonded_degenhive_lp_tokens, v1.claimed_lp_shares, v11, v12, v1.hive_gems_per_share, v1.gems_streamed_from_staking, v15, v16, v17)
    }

    public fun get_user_rewards_info(arg0: &0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg1: &LockdropRewardsCapabilityHolder, arg2: &0x2::clock::Clock) : (u64, u64, u64, u64, u64) {
        let v0 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_dof_capability_identifier(&arg1.capability);
        if (!0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::exists_for_profile(arg0, v0)) {
            return (0, 0, 0, 0, 0)
        };
        let v1 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::borrow_from_profile<UserLockdropRewardsPosition>(arg0, v0);
        (0x2::balance::value<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>(&v1.available_hive_rewards), v1.total_hive_rewards, v1.delegated_hive_rewards, v1.claimed_hive_rewards, calculate_withdrawable_hive(0x2::clock::timestamp_ms(arg2), v1.total_hive_rewards - v1.delegated_hive_rewards))
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
        v3.claim_index = v3.claim_index + 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256((v1 as u256), (1000000000 as u256), (arg1.dlps_staked_amount as u256));
        v3.total_bee_fruits_earned = v3.total_bee_fruits_earned + v1;
        let v4 = (0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256(v3.claim_index - *0x2::linked_table::borrow<0x1::ascii::String, u256>(&arg2.bee_fruit_indexes, v0), ((arg2.total_degenhive_lp_tokens - arg2.unbonded_degenhive_lp_tokens) as u256), (1000000000 as u256)) as u128);
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

    public fun initialize_attack_on_cetus_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg2: 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::ProfileDofOwnershipCapability, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &LockdropForPool<T0, T1, T2>, arg5: &0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::CetusAttackConfig, arg6: 0x1::string::String, arg7: 0x2::coin::Coin<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : address {
        0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::initialize_attack_on_pool<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8, arg9)
    }

    public fun initialize_attack_on_flowx_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg2: 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::ProfileDofOwnershipCapability, arg3: &LockdropForPool<T0, T1, T2>, arg4: &mut 0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::FlowxAttackConfig, arg5: 0x1::string::String, arg6: 0x2::coin::Coin<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : address {
        0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::initialize_attack_on_pool<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8)
    }

    public fun initialize_attack_on_kriya_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg2: 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::ProfileDofOwnershipCapability, arg3: &LockdropForPool<T0, T1, T2>, arg4: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>, arg5: &mut 0xaba0e8b2a90b73a392c8c47a0e32c89bca4cc98df050ff8cac4e715df993b6e2::kriya_vampire_attack::KriyaAttackConfig, arg6: 0x1::string::String, arg7: 0x2::coin::Coin<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : address {
        0xaba0e8b2a90b73a392c8c47a0e32c89bca4cc98df050ff8cac4e715df993b6e2::kriya_vampire_attack::initialize_attack_on_pool<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun initialize_attack_on_rev_flowx_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg2: 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::ProfileDofOwnershipCapability, arg3: &LockdropForPool<T0, T1, T2>, arg4: &mut 0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::FlowxAttackConfig, arg5: 0x1::string::String, arg6: 0x2::coin::Coin<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : address {
        0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::initialize_attack_on_pool<T1, T0>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8)
    }

    public fun initialize_attack_on_reverse_cetus_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg2: 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::ProfileDofOwnershipCapability, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &LockdropForPool<T0, T1, T2>, arg5: &0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::CetusAttackConfig, arg6: 0x1::string::String, arg7: 0x2::coin::Coin<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : address {
        0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::initialize_attack_on_pool<T1, T0>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8, arg9)
    }

    public entry fun initialize_lockdrop_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg2: 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::ProfileDofOwnershipCapability, arg3: &mut LockdropVault, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x13e000cdb1fffaf1a925bdd173461846afc30b5fe396ded44e8100d085f7358a::hsui_vault::HSuiVault, arg6: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfileMappingStore, arg7: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveManager, arg8: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HSuiDisperser<0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) : address {
        let (v0, v1) = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::kraft_owned_hive_profile(arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v2 = v0;
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg12), arg12);
        let (v3, v4, _, _) = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_meta_info(&v2);
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
            degenhive_lps_krafted     : 0x2::balance::zero<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>(),
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

    public entry fun initialize_lockdrops(arg0: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg1: 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::ProfileDofOwnershipCapability, arg2: 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::ProfileDofOwnershipCapability, arg3: 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::ProfileDofOwnershipCapability, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x13e000cdb1fffaf1a925bdd173461846afc30b5fe396ded44e8100d085f7358a::hsui_vault::HSuiVault, arg6: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfileMappingStore, arg7: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveManager, arg8: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HSuiDisperser<0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::clock::Clock, arg11: 0x1::string::String, arg12: 0x1::string::String, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: &mut 0x2::tx_context::TxContext) : (address, address, address, address, address) {
        let (v0, v1) = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::kraft_owned_hive_profile(arg10, arg4, arg5, arg6, arg7, arg8, arg9, arg11, arg12, arg21);
        let v2 = v0;
        0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg21), arg21);
        let (v3, v4, _, _) = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_meta_info(&v2);
        let v7 = LockdropVault{
            id                        : 0x2::object::new(arg21),
            hive_profile              : v2,
            user_profile_access_cap   : arg3,
            krafted_pools             : 0x2::table::new<0x1::string::String, address>(arg21),
            sui_total_locked          : 0,
            sui_total_weighted_units  : 0,
            hive_sui_total_received   : 0,
            hive_available            : 0x2::balance::zero<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>(),
            total_hive_incentives     : 0,
            degenhive_lps_krafted     : 0x2::balance::zero<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>(),
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
        (0x2::object::uid_to_address(&v7.id), 0xc989ec7508bcfb8d98ca8f9f7b16a07a4f2a6d4a7c69d6b4a730d7a76cdd51f4::lsd_lockdrop::initialize_global_lsd_lockdrop(arg0, arg2, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21), 0xaba0e8b2a90b73a392c8c47a0e32c89bca4cc98df050ff8cac4e715df993b6e2::kriya_vampire_attack::initialize_kriya_attack_config(arg10, arg0, arg14, arg15, arg16, arg17, arg18, arg19, arg20, (arg13 as u8), arg21), 0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::initialize_flowx_attack_config(arg10, arg0, arg14, arg15, arg16, arg17, arg18, arg19, arg20, (arg13 as u8), arg21), 0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::initialize_cetus_attack(arg10, arg0, arg14, arg15, arg16, arg17, arg18, arg19, arg20, (arg13 as u8), arg21))
    }

    fun internal_claim_cetus_liquidity<T0, T1, T2>(arg0: &mut LockdropForPool<T0, T1, T2>, arg1: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg2: u128, arg3: u128, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: 0x2::balance::Balance<0x2::sui::SUI>, arg9: 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg10: 0x2::balance::Balance<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>, arg11: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg4);
        let v1 = 0x2::balance::value<T1>(&arg5);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg8);
        let v3 = 0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&arg9);
        let v4 = 0x2::balance::value<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>(&arg10);
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
        0x2::balance::destroy_zero<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>(0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::burn_hive_and_return(arg1, &mut arg0.hive_profile, arg10, v4, arg11));
        (arg2, arg3, v0, v1, 0x2::balance::value<T0>(&arg6), 0x2::balance::value<T1>(&arg7), v2, v3, v4)
    }

    fun internal_claim_lps<T0, T1, T2>(arg0: &mut LockdropForPool<T0, T1, T2>, arg1: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolHive<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>, arg2: &mut UserLockdropHivePosition, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>> {
        if (arg3 > 0) {
            arg2.unbonded_degenhive_lp_tokens = arg2.unbonded_degenhive_lp_tokens + arg3;
            if (0x2::linked_table::contains<u64, u64>(&arg2.lp_to_unlock, arg4)) {
                *0x2::linked_table::borrow_mut<u64, u64>(&mut arg2.lp_to_unlock, arg4) = *0x2::linked_table::borrow<u64, u64>(&arg2.lp_to_unlock, arg4) + arg3;
            } else {
                0x2::linked_table::push_back<u64, u64>(&mut arg2.lp_to_unlock, arg4, arg3);
            };
            arg0.dlps_staked_amount = arg0.dlps_staked_amount - arg3;
        };
        let v0 = *0x2::linked_table::front<u64, u64>(&arg2.lp_to_unlock);
        let v1 = 0;
        let v2 = 0x2::balance::zero<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>();
        while (0x1::option::is_some<u64>(&v0)) {
            let v3 = *0x1::option::borrow<u64>(&v0);
            v0 = *0x2::linked_table::next<u64, u64>(&arg2.lp_to_unlock, v3);
            if (v3 <= arg5) {
                v1 = v1 + *0x2::linked_table::borrow<u64, u64>(&arg2.lp_to_unlock, v3);
                0x2::linked_table::remove<u64, u64>(&mut arg2.lp_to_unlock, v3);
            };
        };
        if (v1 > 0) {
            0x2::balance::join<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>(&mut arg0.degenhive_lps_krafted, 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::unlock_from_bee_box<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>(arg1, &mut arg0.hive_profile, arg6));
            0x2::balance::join<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>(&mut v2, 0x2::balance::split<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>(&mut arg0.degenhive_lps_krafted, v1));
            arg2.claimed_lp_shares = arg2.claimed_lp_shares + v1;
        };
        v2
    }

    fun internal_claim_lsd_lps(arg0: &mut LockdropVault, arg1: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolHive<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>, arg2: &mut UserLockdropHivePosition, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>> {
        if (arg3 > 0) {
            arg2.unbonded_degenhive_lp_tokens = arg2.unbonded_degenhive_lp_tokens + arg3;
            if (0x2::linked_table::contains<u64, u64>(&arg2.lp_to_unlock, arg4)) {
                *0x2::linked_table::borrow_mut<u64, u64>(&mut arg2.lp_to_unlock, arg4) = *0x2::linked_table::borrow<u64, u64>(&arg2.lp_to_unlock, arg4) + arg3;
            } else {
                0x2::linked_table::push_back<u64, u64>(&mut arg2.lp_to_unlock, arg4, arg3);
            };
            arg0.dlps_staked_amount = arg0.dlps_staked_amount - arg3;
        };
        let v0 = *0x2::linked_table::front<u64, u64>(&arg2.lp_to_unlock);
        let v1 = 0;
        let v2 = 0x2::balance::zero<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>();
        while (0x1::option::is_some<u64>(&v0)) {
            let v3 = *0x1::option::borrow<u64>(&v0);
            v0 = *0x2::linked_table::next<u64, u64>(&arg2.lp_to_unlock, v3);
            if (v3 <= arg5) {
                v1 = v1 + *0x2::linked_table::borrow<u64, u64>(&arg2.lp_to_unlock, v3);
                0x2::linked_table::remove<u64, u64>(&mut arg2.lp_to_unlock, v3);
            };
        };
        if (v1 > 0) {
            0x2::balance::join<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>(&mut arg0.degenhive_lps_krafted, 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::unlock_from_bee_box<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>(arg1, &mut arg0.hive_profile, arg6));
            0x2::balance::join<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>(&mut v2, 0x2::balance::split<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>(&mut arg0.degenhive_lps_krafted, v1));
            arg2.claimed_lp_shares = arg2.claimed_lp_shares + v1;
        };
        v2
    }

    fun internal_extract_flowx_liquidity<T0, T1, T2>(arg0: &mut LockdropForPool<T0, T1, T2>, arg1: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg2: u128, arg3: u128, arg4: u64, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: 0x2::balance::Balance<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>, arg8: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg5);
        let v1 = 0x2::balance::value<T1>(&arg6);
        arg0.flowx_state.total_lp_locked = arg0.flowx_state.total_lp_locked + arg2;
        arg0.flowx_state.total_weighted_units = arg0.flowx_state.total_weighted_units + arg3;
        arg0.flowx_state.total_hive_incentives = arg0.flowx_state.total_hive_incentives + arg4;
        arg0.flowx_state.total_x_withdrawn = arg0.flowx_state.total_x_withdrawn + v0;
        arg0.flowx_state.total_y_withdrawn = arg0.flowx_state.total_y_withdrawn + v1;
        0x2::balance::join<T0>(&mut arg0.total_withdrawn_x_balance, arg5);
        0x2::balance::join<T1>(&mut arg0.total_withdrawn_y_balance, arg6);
        0x2::balance::destroy_zero<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>(0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::burn_hive_and_return(arg1, &mut arg0.hive_profile, arg7, arg4, arg8));
        (arg2, arg3, arg4, v0, v1)
    }

    fun internal_lps_from_lockdrop_vault(arg0: &mut LockdropVault) : 0x2::balance::Balance<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>> {
        assert!(0x2::balance::value<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>(&arg0.degenhive_lps_krafted) > 0, 1802);
        let v0 = 0x2::balance::withdraw_all<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>(&mut arg0.degenhive_lps_krafted);
        arg0.are_staked_with_pool_hive = true;
        arg0.dlps_staked_amount = arg0.dlps_staked_amount + 0x2::balance::value<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>(&v0);
        v0
    }

    fun internal_lps_from_pooldrop<T0, T1, T2>(arg0: &mut LockdropForPool<T0, T1, T2>) : 0x2::balance::Balance<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>> {
        assert!(0x2::balance::value<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>(&arg0.degenhive_lps_krafted) > 0, 1802);
        let v0 = 0x2::balance::withdraw_all<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>(&mut arg0.degenhive_lps_krafted);
        arg0.are_staked_with_pool_hive = true;
        arg0.dlps_staked_amount = arg0.dlps_staked_amount + 0x2::balance::value<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>(&v0);
        v0
    }

    fun internal_migrate_user_cetus_position<T0, T1, T2>(arg0: 0x1::string::String, arg1: address, arg2: &mut LockdropForPool<T0, T1, T2>, arg3: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg4: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg5: UserLockdropRewardsPosition, arg6: UserLockdropHivePosition, arg7: vector<u64>, arg8: 0x2::table::Table<u64, u64>, arg9: 0x2::table::Table<u64, u128>, arg10: 0x2::table::Table<u64, u128>, arg11: 0x2::table::Table<u64, u64>, arg12: 0x2::table::Table<u64, u64>, arg13: 0x2::table::Table<u64, u64>, arg14: 0x2::table::Table<u64, u64>, arg15: 0x2::table::Table<u64, u64>, arg16: 0x2::table::Table<u64, u64>, arg17: u128, arg18: &mut 0x2::tx_context::TxContext) : (UserLockdropRewardsPosition, UserLockdropHivePosition) {
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
            arg6.cetus_lockdrop.fee_earned_x = arg6.cetus_lockdrop.fee_earned_x + *0x2::table::borrow<u64, u64>(&arg13, v4);
            arg6.cetus_lockdrop.fee_earned_y = arg6.cetus_lockdrop.fee_earned_y + *0x2::table::borrow<u64, u64>(&arg14, v4);
            arg6.cetus_lockdrop.sui_earned = arg6.cetus_lockdrop.sui_earned + *0x2::table::borrow<u64, u64>(&arg16, v4);
            arg6.cetus_lockdrop.cetus_earned = arg6.cetus_lockdrop.cetus_earned + *0x2::table::borrow<u64, u64>(&arg15, v4);
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
        0x2::balance::join<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>(&mut arg5.available_hive_rewards, 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::deposit_gems_via_profile_and_return(arg3, &mut arg2.hive_profile, v0, arg18));
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

    fun internal_migrate_user_flowx_position<T0, T1, T2>(arg0: 0x1::string::String, arg1: address, arg2: &mut LockdropForPool<T0, T1, T2>, arg3: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg4: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg5: UserLockdropRewardsPosition, arg6: UserLockdropHivePosition, arg7: vector<u64>, arg8: 0x2::table::Table<u64, u64>, arg9: 0x2::table::Table<u64, u64>, arg10: 0x2::table::Table<u64, u128>, arg11: u128, arg12: u128, arg13: &mut 0x2::tx_context::TxContext) : (UserLockdropRewardsPosition, UserLockdropHivePosition) {
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
        0x2::balance::join<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>(&mut arg5.available_hive_rewards, 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::deposit_gems_via_profile_and_return(arg3, &mut arg2.hive_profile, v0, arg13));
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
            fee_earned_x            : 0,
            fee_earned_y            : 0,
            sui_earned              : 0,
            cetus_earned            : 0,
            fee_and_rewards_claimed : false,
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

    fun kraft_user_rewards_position(arg0: &mut 0x2::tx_context::TxContext) : UserLockdropRewardsPosition {
        UserLockdropRewardsPosition{
            id                     : 0x2::object::new(arg0),
            available_hive_rewards : 0x2::balance::zero<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>(),
            total_hive_rewards     : 0,
            delegated_hive_rewards : 0,
            claimed_hive_rewards   : 0,
        }
    }

    fun lsd_increment_bee_fruit_indexes<T0>(arg0: 0x1::string::String, arg1: &mut LockdropVault, arg2: &mut UserLockdropHivePosition, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x2::balance::value<T0>(&arg3);
        if (!0x2::linked_table::contains<0x1::ascii::String, u256>(&arg1.bee_fruit_indexes, v0)) {
            0x2::linked_table::push_back<0x1::ascii::String, u256>(&mut arg1.bee_fruit_indexes, v0, 0);
            let v2 = BeeFruitDistributor<T0>{
                id                      : 0x2::object::new(arg4),
                claim_index             : 0,
                available_bee_fruits    : 0x2::balance::zero<T0>(),
                total_bee_fruits_earned : 0,
            };
            0x2::dynamic_object_field::add<0x1::ascii::String, BeeFruitDistributor<T0>>(&mut arg1.id, v0, v2);
        };
        let v3 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruitDistributor<T0>>(&mut arg1.id, v0);
        v3.claim_index = v3.claim_index + 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256((v1 as u256), (1000000000 as u256), (arg1.dlps_staked_amount as u256));
        v3.total_bee_fruits_earned = v3.total_bee_fruits_earned + v1;
        let v4 = (0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256(v3.claim_index - *0x2::linked_table::borrow<0x1::ascii::String, u256>(&arg2.bee_fruit_indexes, v0), ((arg2.total_degenhive_lp_tokens - arg2.unbonded_degenhive_lp_tokens) as u256), (1000000000 as u256)) as u128);
        *0x2::linked_table::borrow_mut<0x1::ascii::String, u256>(&mut arg2.bee_fruit_indexes, v0) = v3.claim_index;
        *0x2::linked_table::borrow_mut<0x1::ascii::String, u128>(&mut arg2.total_bee_fruits_earned, v0) = *0x2::linked_table::borrow<0x1::ascii::String, u128>(&arg2.total_bee_fruits_earned, v0) + v4;
        0x2::balance::join<T0>(&mut v3.available_bee_fruits, arg3);
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
        0x2::balance::split<T0>(&mut v3.available_bee_fruits, (v4 as u64))
    }

    public entry fun migrate_user_cetus_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg2: &LockdropRewardsCapabilityHolder, arg3: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg4: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg5: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveManager, arg6: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveDisperser, arg7: &mut LockdropForPool<T0, T1, T2>, arg8: &0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::CetusAttackConfig, arg9: &mut 0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::LockdropForPool<T0, T1>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7.kriya_state.total_weighted_units > 0 && arg7.kriya_state.total_dlps_amount > 0, 1802);
        let (v0, v1, _, _) = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_meta_info(arg4);
        if (!0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::exists_for_profile(arg4, 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_dof_capability_identifier(&arg2.capability))) {
            let v4 = kraft_user_rewards_position(arg10);
            0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v4, arg10);
        };
        if (!0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::exists_for_profile(arg4, 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_dof_capability_identifier(&arg7.user_profile_access_cap))) {
            let v5 = kraft_user_position(arg10);
            0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v5, arg10);
        };
        let (v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16) = 0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::destroy_user_position<T0, T1>(arg0, arg1, arg8, arg9, arg4, v0, arg10);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::follow_profile(arg0, arg5, arg4, &mut arg7.hive_profile, arg6, 12, arg10);
        let v17 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, arg10);
        let v18 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, arg10);
        let (v19, v20) = internal_migrate_user_cetus_position<T0, T1, T2>(v1, v0, arg7, arg3, arg4, v17, v18, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, arg10);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v19, arg10);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v20, arg10);
    }

    public entry fun migrate_user_flowx_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg2: &LockdropRewardsCapabilityHolder, arg3: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg4: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg5: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveManager, arg6: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveDisperser, arg7: &mut LockdropForPool<T0, T1, T2>, arg8: &0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::FlowxAttackConfig, arg9: &mut 0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::FlowxLockdropForPool<T0, T1>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7.kriya_state.total_weighted_units > 0 && arg7.kriya_state.total_dlps_amount > 0, 1802);
        let (v0, v1, _, _) = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_meta_info(arg4);
        if (!0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::exists_for_profile(arg4, 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_dof_capability_identifier(&arg2.capability))) {
            let v4 = kraft_user_rewards_position(arg10);
            0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v4, arg10);
        };
        if (!0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::exists_for_profile(arg4, 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_dof_capability_identifier(&arg7.user_profile_access_cap))) {
            let v5 = kraft_user_position(arg10);
            0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v5, arg10);
        };
        let (v6, v7, v8, v9, v10, v11) = 0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::destroy_user_position<T0, T1>(arg0, arg1, arg8, arg9, arg4, arg10);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::follow_profile(arg0, arg5, arg4, &mut arg7.hive_profile, arg6, 12, arg10);
        let v12 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, arg10);
        let v13 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, arg10);
        let (v14, v15) = internal_migrate_user_flowx_position<T0, T1, T2>(v1, v0, arg7, arg3, arg4, v12, v13, v6, v7, v8, v9, v10, v11, arg10);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v14, arg10);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v15, arg10);
    }

    public entry fun migrate_user_kriya_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg2: &LockdropRewardsCapabilityHolder, arg3: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg4: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg5: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveManager, arg6: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveDisperser, arg7: &mut LockdropForPool<T0, T1, T2>, arg8: &0xaba0e8b2a90b73a392c8c47a0e32c89bca4cc98df050ff8cac4e715df993b6e2::kriya_vampire_attack::KriyaAttackConfig, arg9: &mut 0xaba0e8b2a90b73a392c8c47a0e32c89bca4cc98df050ff8cac4e715df993b6e2::kriya_vampire_attack::KriyaLockdropForPool<T0, T1>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7.kriya_state.total_weighted_units > 0 && arg7.kriya_state.total_dlps_amount > 0, 1802);
        let (v0, v1, _, _) = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_meta_info(arg4);
        if (!0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::exists_for_profile(arg4, 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_dof_capability_identifier(&arg2.capability))) {
            let v4 = kraft_user_rewards_position(arg10);
            0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v4, arg10);
        };
        if (!0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::exists_for_profile(arg4, 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_dof_capability_identifier(&arg7.user_profile_access_cap))) {
            let v5 = kraft_user_position(arg10);
            0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v5, arg10);
        };
        let (v6, v7, v8, v9, _, _) = 0xaba0e8b2a90b73a392c8c47a0e32c89bca4cc98df050ff8cac4e715df993b6e2::kriya_vampire_attack::destroy_user_position<T0, T1>(arg0, arg1, arg8, arg9, arg4, arg10);
        let v12 = v9;
        let v13 = v8;
        let v14 = v7;
        let v15 = v6;
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::follow_profile(arg0, arg5, arg4, &mut arg7.hive_profile, arg6, 12, arg10);
        let v16 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, arg10);
        let v17 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, arg10);
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
        0x2::balance::join<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>(&mut v16.available_hive_rewards, 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::deposit_gems_via_profile_and_return(arg3, &mut arg7.hive_profile, v18, arg10));
        0x2::table::drop<u64, u64>(v14);
        0x2::table::drop<u64, u64>(v13);
        0x2::table::drop<u64, u128>(v12);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v16, arg10);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v17, arg10);
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

    public entry fun migrate_user_rev_cetus_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg2: &LockdropRewardsCapabilityHolder, arg3: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg4: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg5: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveManager, arg6: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveDisperser, arg7: &mut LockdropForPool<T0, T1, T2>, arg8: &0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::CetusAttackConfig, arg9: &mut 0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::LockdropForPool<T1, T0>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7.kriya_state.total_weighted_units > 0 && arg7.kriya_state.total_dlps_amount > 0, 1802);
        let (v0, v1, _, _) = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_meta_info(arg4);
        if (!0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::exists_for_profile(arg4, 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_dof_capability_identifier(&arg2.capability))) {
            let v4 = kraft_user_rewards_position(arg10);
            0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v4, arg10);
        };
        if (!0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::exists_for_profile(arg4, 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_dof_capability_identifier(&arg7.user_profile_access_cap))) {
            let v5 = kraft_user_position(arg10);
            0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v5, arg10);
        };
        let (v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16) = 0x3236ac306ececf4dd66f8c7173d0890d443995b2a6bfa62e2920d2a7174b1e30::cetus_vampire_attack::destroy_user_position<T1, T0>(arg0, arg1, arg8, arg9, arg4, v0, arg10);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::follow_profile(arg0, arg5, arg4, &mut arg7.hive_profile, arg6, 12, arg10);
        let v17 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, arg10);
        let v18 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, arg10);
        let (v19, v20) = internal_migrate_user_cetus_position<T0, T1, T2>(v1, v0, arg7, arg3, arg4, v17, v18, v6, v7, v8, v9, v11, v10, v13, v12, v14, v15, v16, arg10);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v19, arg10);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v20, arg10);
    }

    public entry fun migrate_user_rev_flowx_position<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg2: &LockdropRewardsCapabilityHolder, arg3: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg4: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg5: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveManager, arg6: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveDisperser, arg7: &mut LockdropForPool<T0, T1, T2>, arg8: &0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::FlowxAttackConfig, arg9: &mut 0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::FlowxLockdropForPool<T1, T0>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg7.kriya_state.total_weighted_units > 0 && arg7.kriya_state.total_dlps_amount > 0, 1802);
        let (v0, v1, _, _) = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_meta_info(arg4);
        if (!0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::exists_for_profile(arg4, 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_dof_capability_identifier(&arg2.capability))) {
            let v4 = kraft_user_rewards_position(arg10);
            0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v4, arg10);
        };
        if (!0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::exists_for_profile(arg4, 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_dof_capability_identifier(&arg7.user_profile_access_cap))) {
            let v5 = kraft_user_position(arg10);
            0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v5, arg10);
        };
        let (v6, v7, v8, v9, v10, v11) = 0xbee9ae00c2af20ea0f39c9953f32e734d6cc07bae2a32a195de0c6e58cc1da86::flowx_vampire_attack::destroy_user_position<T1, T0>(arg0, arg1, arg8, arg9, arg4, arg10);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::follow_profile(arg0, arg5, arg4, &mut arg7.hive_profile, arg6, 12, arg10);
        let v12 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, arg10);
        let v13 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, arg10);
        let (v14, v15) = internal_migrate_user_flowx_position<T0, T1, T2>(v1, v0, arg7, arg3, arg4, v12, v13, v6, v7, v8, v9, v10, v11, arg10);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v14, arg10);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v15, arg10);
    }

    public fun migrate_user_sui_lockup_position(arg0: &0x2::clock::Clock, arg1: &0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::config::HiveEntryCap, arg2: &LockdropRewardsCapabilityHolder, arg3: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg4: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg5: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveManager, arg6: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveDisperser, arg7: &mut LockdropVault, arg8: &mut 0xc989ec7508bcfb8d98ca8f9f7b16a07a4f2a6d4a7c69d6b4a730d7a76cdd51f4::lsd_lockdrop::LsdLockdropVault, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg7.sui_total_locked > 0 && arg7.total_lp_krafted > 0, 1807);
        let (v0, v1, _, _) = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_meta_info(arg4);
        if (!0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::exists_for_profile(arg4, 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_dof_capability_identifier(&arg2.capability))) {
            let v4 = kraft_user_rewards_position(arg9);
            0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v4, arg9);
        };
        if (!0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::exists_for_profile(arg4, 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::get_profile_dof_capability_identifier(&arg7.user_profile_access_cap))) {
            let v5 = kraft_user_position(arg9);
            0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v5, arg9);
        };
        let (v6, v7, v8, v9, v10, _) = 0xc989ec7508bcfb8d98ca8f9f7b16a07a4f2a6d4a7c69d6b4a730d7a76cdd51f4::lsd_lockdrop::destroy_user_position(arg0, arg1, arg8, arg4, arg9);
        let v12 = v9;
        let v13 = v8;
        let v14 = v7;
        let v15 = v6;
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::follow_profile(arg0, arg5, arg4, &mut arg7.hive_profile, arg6, 12, arg9);
        let v16 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, arg9);
        let v17 = 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_remove_from_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, arg9);
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
            let v25 = (0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::math::mul_div_u256((v22 as u256), (arg7.total_lp_krafted as u256), (arg7.sui_total_locked as u256)) as u64);
            v19 = v19 + v25;
            0x2::table::add<u64, u64>(&mut v17.sui_lockdrop.dlp_per_lockup, v21, v25);
            0x2::table::add<u64, bool>(&mut v17.sui_lockdrop.dlp_claim_flag, v21, false);
            v20 = v20 + 1;
        };
        v17.total_degenhive_lp_tokens = v17.total_degenhive_lp_tokens + v19;
        v16.total_hive_rewards = v16.total_hive_rewards + v18;
        0x2::balance::join<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>(&mut v16.available_hive_rewards, 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::deposit_gems_via_profile_and_return(arg3, &mut arg7.hive_profile, v18, arg9));
        0x2::table::drop<u64, u64>(v12);
        0x2::table::drop<u64, u128>(v13);
        0x2::table::drop<u64, u64>(v14);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropRewardsPosition>(&arg2.capability, arg4, v16, arg9);
        0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::entry_add_to_profile<UserLockdropHivePosition>(&arg7.user_profile_access_cap, arg4, v17, arg9);
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

    public entry fun stake_pooldrop_lp_tokens_0_fruits<T0, T1, T2>(arg0: &mut LockdropForPool<T0, T1, T2>, arg1: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolsGovernor, arg2: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolHive<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_lps_from_pooldrop<T0, T1, T2>(arg0);
        0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::deposit_into_bee_box_0_fruits<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>(arg1, arg2, &mut arg0.hive_profile, v0, arg3);
    }

    public entry fun stake_pooldrop_lp_tokens_one_fruits<T0, T1, T2, T3>(arg0: &mut LockdropForPool<T0, T1, T2>, arg1: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolsGovernor, arg2: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolHive<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_lps_from_pooldrop<T0, T1, T2>(arg0);
        0x2::balance::destroy_zero<T3>(0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::deposit_into_bee_box_1_fruits<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>, T3>(arg1, arg2, &mut arg0.hive_profile, v0, arg3));
    }

    public entry fun stake_pooldrop_lp_tokens_three_fruits<T0, T1, T2, T3, T4, T5>(arg0: &mut LockdropForPool<T0, T1, T2>, arg1: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolsGovernor, arg2: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolHive<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_lps_from_pooldrop<T0, T1, T2>(arg0);
        let (v1, v2, v3) = 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::deposit_into_bee_box_3_fruits<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>, T3, T4, T5>(arg1, arg2, &mut arg0.hive_profile, v0, arg3);
        0x2::balance::destroy_zero<T3>(v1);
        0x2::balance::destroy_zero<T4>(v2);
        0x2::balance::destroy_zero<T5>(v3);
    }

    public entry fun stake_pooldrop_lp_tokens_two_fruits<T0, T1, T2, T3, T4>(arg0: &mut LockdropForPool<T0, T1, T2>, arg1: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolsGovernor, arg2: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolHive<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_lps_from_pooldrop<T0, T1, T2>(arg0);
        let (v1, v2) = 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::deposit_into_bee_box_2_fruits<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<T0, T1, T2>, T3, T4>(arg1, arg2, &mut arg0.hive_profile, v0, arg3);
        0x2::balance::destroy_zero<T3>(v1);
        0x2::balance::destroy_zero<T4>(v2);
    }

    public entry fun stake_vault_lp_tokens_0_fruits(arg0: &mut LockdropVault, arg1: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolsGovernor, arg2: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolHive<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_lps_from_lockdrop_vault(arg0);
        0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::deposit_into_bee_box_0_fruits<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>(arg1, arg2, &mut arg0.hive_profile, v0, arg3);
    }

    public entry fun stake_vault_lp_tokens_one_fruits<T0>(arg0: &mut LockdropVault, arg1: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolsGovernor, arg2: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolHive<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_lps_from_lockdrop_vault(arg0);
        0x2::balance::destroy_zero<T0>(0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::deposit_into_bee_box_1_fruits<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>, T0>(arg1, arg2, &mut arg0.hive_profile, v0, arg3));
    }

    public entry fun stake_vault_lp_tokens_three_fruits<T0, T1, T2>(arg0: &mut LockdropVault, arg1: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolsGovernor, arg2: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolHive<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_lps_from_lockdrop_vault(arg0);
        let (v1, v2, v3) = 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::deposit_into_bee_box_3_fruits<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>, T0, T1, T2>(arg1, arg2, &mut arg0.hive_profile, v0, arg3);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::balance::destroy_zero<T1>(v2);
        0x2::balance::destroy_zero<T2>(v3);
    }

    public entry fun stake_vault_lp_tokens_two_fruits<T0, T1>(arg0: &mut LockdropVault, arg1: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolsGovernor, arg2: &mut 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::PoolHive<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = internal_lps_from_lockdrop_vault(arg0);
        let (v1, v2) = 0x8efcb647d54f639be110db57727a85ab2e2ccdd3b2a834a72b83f1b90c302538::dex_dao::deposit_into_bee_box_2_fruits<0x346948d65480bcf09a06ac4e95b35f23b66f643929230e86df2bea438eb6c68e::two_pool::LP<0x2::sui::SUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::hsui::HSUI, 0x5e544104aec78ee52d7c2349e8ff4a766ca07c892fbab0f6e85c2ae4a4f05858::curves::Curved>, T0, T1>(arg1, arg2, &mut arg0.hive_profile, v0, arg3);
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

    fun withdraw_hive_gems(arg0: u64, arg1: &mut UserLockdropRewardsPosition, arg2: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive_profile::HiveProfile, arg3: &mut 0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HiveVault, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = calculate_withdrawable_hive(arg0, arg1.total_hive_rewards - arg1.delegated_hive_rewards);
        arg1.claimed_hive_rewards = arg1.claimed_hive_rewards + v0;
        0x2::balance::destroy_zero<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>(0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::burn_hive_and_return(arg3, arg2, 0x2::balance::split<0x986254f489ad47a97b84106a666f9054ad30d429b342ccf00f97ccae827a4573::hive::HIVE>(&mut arg1.available_hive_rewards, v0), v0, arg4));
        v0
    }

    // decompiled from Move bytecode v6
}

