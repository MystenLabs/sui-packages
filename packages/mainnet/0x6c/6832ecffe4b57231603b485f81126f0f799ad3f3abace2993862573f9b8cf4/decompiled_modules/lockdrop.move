module 0x6c6832ecffe4b57231603b485f81126f0f799ad3f3abace2993862573f9b8cf4::lockdrop {
    struct LockdropRewardsCapabilityHolder has key {
        id: 0x2::object::UID,
        capability: 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::ProfileDofOwnershipCapability,
    }

    struct LockdropVault has store, key {
        id: 0x2::object::UID,
        hive_profile: 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::HiveProfile,
        user_profile_access_cap: 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::ProfileDofOwnershipCapability,
        krafted_pools: 0x2::table::Table<0x1::string::String, address>,
        sui_total_locked: u64,
        sui_total_weighted_units: u128,
        hive_sui_total_received: u64,
        hive_available: 0x2::balance::Balance<0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HIVE>,
        total_hive_incentives: u64,
        degenhive_lps_krafted: 0x2::balance::Balance<0xb74d357f49f719ac5f71eb25afdf6a01fdb50c043ece13f6c9720e0027b7cd9d::two_pool::LP<0x2::sui::SUI, 0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::hsui::HSUI, 0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::curves::Curved>>,
        total_lp_krafted: u64,
        are_staked_with_pool_hive: bool,
        dlps_staked_amount: u64,
        hive_gems_per_share: u256,
        bee_fruit_indexes: 0x2::linked_table::LinkedTable<0x1::ascii::String, u256>,
    }

    struct BeeFruitDistributor<phantom T0> has store, key {
        id: 0x2::object::UID,
        claim_index: u256,
        available_bee_fruits: 0x2::balance::Balance<T0>,
        total_bee_fruits_earned: u64,
    }

    struct UserLockdropRewardsPosition has store, key {
        id: 0x2::object::UID,
        available_hive_rewards: 0x2::balance::Balance<0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HIVE>,
        total_hive_rewards: u64,
        delegated_hive_rewards: u64,
        claimed_hive_rewards: u64,
    }

    struct UserLockdropHivePosition has store, key {
        id: 0x2::object::UID,
        vesting_init_timestamp: u64,
        sui_lockup_weeks: vector<u64>,
        sui_locked_per_position: 0x2::table::Table<u64, u64>,
        sui_lockup_weighted_units: 0x2::table::Table<u64, u128>,
        sui_unlock_timestamps: 0x2::table::Table<u64, u64>,
        sui_dlp_per_lockup: 0x2::table::Table<u64, u64>,
        sui_dlp_claim_flag: 0x2::table::Table<u64, bool>,
        sui_hive_rewards_per_lockup: 0x2::table::Table<u64, u64>,
        cetus_lockup_weeks: vector<u64>,
        cetus_x_withdrawn: 0x2::table::Table<u64, u64>,
        cetus_y_withdrawn: 0x2::table::Table<u64, u64>,
        cetus_fee_earned_x: 0x2::table::Table<u64, u64>,
        cetus_fee_earned_y: 0x2::table::Table<u64, u64>,
        cetus_sui_earned: 0x2::table::Table<u64, u64>,
        cetus_earned: 0x2::table::Table<u64, u64>,
        cetus_position_liquidity: 0x2::table::Table<u64, u128>,
        cetus_weighted_units: 0x2::table::Table<u64, u128>,
        cetus_hive_rewards_per_lockup: 0x2::table::Table<u64, u64>,
        cetus_unlock_timestamps: 0x2::table::Table<u64, u64>,
        cetus_dlp_per_lockup: 0x2::table::Table<u64, u64>,
        cetus_dlp_claim_flag: 0x2::table::Table<u64, bool>,
        total_degenhive_lp_tokens: u64,
        unbonded_degenhive_lp_tokens: u64,
        lp_to_unlock: 0x2::linked_table::LinkedTable<u64, u64>,
        claimed_lp_shares: u64,
        hive_gems_per_share: u256,
        gems_streamed_from_staking: u64,
        bee_fruit_indexes: 0x2::linked_table::LinkedTable<0x1::ascii::String, u256>,
        total_bee_fruits_earned: 0x2::linked_table::LinkedTable<0x1::ascii::String, u128>,
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

