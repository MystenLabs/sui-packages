module 0x7c21f7a9a3ae4992d11e937c03c572d41849879ea64333a78dc1211e034246c9::lockdrop {
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

    struct LockdropForPool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        hive_profile: 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::HiveProfile,
        user_profile_access_cap: 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::ProfileDofOwnershipCapability,
        cetus_state: LockdropCetusState<T0, T1>,
        kriya_state: LockdropKriyaState,
        flowx_state: LockdropFlowxState,
        total_withdrawn_x_balance: 0x2::balance::Balance<T0>,
        total_withdrawn_y_balance: 0x2::balance::Balance<T1>,
        degenhive_lps_krafted: 0x2::balance::Balance<0xb74d357f49f719ac5f71eb25afdf6a01fdb50c043ece13f6c9720e0027b7cd9d::two_pool::LP<T0, T1, T2>>,
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
        available_hive_rewards: 0x2::balance::Balance<0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HIVE>,
        total_hive_rewards: u64,
        delegated_hive_rewards: u64,
        claimed_hive_rewards: u64,
    }

    struct UserLockdropHivePosition has store, key {
        id: 0x2::object::UID,
        vesting_init_timestamp: u64,
        user_sui_lockdrop_state: UserSuiLockdropState,
        user_cetus_lockdrop_state: UserCetusLockdropState,
        user_kriya_lockdrop_state: UserKriyaLockdropState,
        user_flowx_lockdrop_state: UserFlowxLockdropState,
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
        sui_lockup_weeks: vector<u64>,
        sui_locked_per_position: 0x2::table::Table<u64, u64>,
        sui_lockup_weighted_units: 0x2::table::Table<u64, u128>,
        sui_unlock_timestamps: 0x2::table::Table<u64, u64>,
        sui_dlp_per_lockup: 0x2::table::Table<u64, u64>,
        sui_dlp_claim_flag: 0x2::table::Table<u64, bool>,
        sui_hive_rewards_per_lockup: 0x2::table::Table<u64, u64>,
    }

    struct UserCetusLockdropState has store {
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

    public entry fun infuse_sui_hsui_pool(arg0: &0x2::clock::Clock, arg1: &0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::config::HiveEntryCap, arg2: &mut LockdropVault, arg3: &mut 0xb74d357f49f719ac5f71eb25afdf6a01fdb50c043ece13f6c9720e0027b7cd9d::two_pool::LiquidityPool<0x2::sui::SUI, 0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::hsui::HSUI, 0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::curves::Curved>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x24bc76f3e97e7299b0e91432c3cdcdb7080bb5f976a45d9fb2fb6431b3173a8::hsui_vault::HSuiVault, arg6: &mut 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HiveVault, arg7: &mut 0x52608683dc67e9b66497cf84d979615c0ea2bf1cecbf643050c6009e7c2da4fc::lsd_lockdrop::LsdLockdropVault, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        let (v0, v1, v2, v3, v4) = 0x52608683dc67e9b66497cf84d979615c0ea2bf1cecbf643050c6009e7c2da4fc::lsd_lockdrop::infuse_sui_hsui_pool(arg0, arg1, arg7, arg4, arg5, arg8);
        let v5 = v2;
        let v6 = v1;
        let v7 = v0;
        let v8 = 0x2::balance::value<0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::hsui::HSUI>(&v7);
        let v9 = 0x2::balance::value<0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HIVE>(&v5);
        arg2.sui_total_locked = arg2.sui_total_locked + v3;
        arg2.sui_total_weighted_units = arg2.sui_total_weighted_units + v4;
        arg2.hive_sui_total_received = arg2.hive_sui_total_received + v8;
        arg2.total_hive_incentives = arg2.total_hive_incentives + v9;
        0x2::balance::destroy_zero<0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HIVE>(0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::burn_hive_and_return(arg6, &mut arg2.hive_profile, v5, v9, arg8));
        let v10 = 0xb74d357f49f719ac5f71eb25afdf6a01fdb50c043ece13f6c9720e0027b7cd9d::two_pool::add_liquidity<0x2::sui::SUI, 0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::hsui::HSUI, 0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::curves::Curved>(arg0, arg3, v6, v7, 0);
        arg2.total_lp_krafted = arg2.total_lp_krafted + 0x2::balance::value<0xb74d357f49f719ac5f71eb25afdf6a01fdb50c043ece13f6c9720e0027b7cd9d::two_pool::LP<0x2::sui::SUI, 0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::hsui::HSUI, 0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::curves::Curved>>(&v10);
        0x2::balance::join<0xb74d357f49f719ac5f71eb25afdf6a01fdb50c043ece13f6c9720e0027b7cd9d::two_pool::LP<0x2::sui::SUI, 0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::hsui::HSUI, 0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::curves::Curved>>(&mut arg2.degenhive_lps_krafted, v10);
        (v8, 0x2::balance::value<0x2::sui::SUI>(&v6), 0x2::balance::value<0xb74d357f49f719ac5f71eb25afdf6a01fdb50c043ece13f6c9720e0027b7cd9d::two_pool::LP<0x2::sui::SUI, 0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::hsui::HSUI, 0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::curves::Curved>>(&v10), v9)
    }

    public entry fun extract_liquidity_from_flowx<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::config::HiveEntryCap, arg2: &mut 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HiveVault, arg3: &mut LockdropForPool<T0, T1, T2>, arg4: &0x7457dd0fceeb3307637f978e0d20f34cd0b862f5bcc1ca50ac677f025f122d7b::flowx_vampire_attack::FlowxAttackConfig, arg5: &mut 0x7457dd0fceeb3307637f978e0d20f34cd0b862f5bcc1ca50ac677f025f122d7b::flowx_vampire_attack::FlowxLockdropForPool<T0, T1>, arg6: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg7: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, u64, u64) {
        let (v0, v1, v2, v3, v4, v5) = 0x7457dd0fceeb3307637f978e0d20f34cd0b862f5bcc1ca50ac677f025f122d7b::flowx_vampire_attack::extract_liquidity_from_flowx<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7);
        let v6 = v4;
        let v7 = v3;
        let v8 = 0x2::balance::value<T0>(&v7);
        let v9 = 0x2::balance::value<T1>(&v6);
        arg3.flowx_state.total_lp_locked = arg3.flowx_state.total_lp_locked + v0;
        arg3.flowx_state.total_weighted_units = arg3.flowx_state.total_weighted_units + v1;
        arg3.flowx_state.total_hive_incentives = arg3.flowx_state.total_hive_incentives + v2;
        arg3.flowx_state.total_x_withdrawn = arg3.flowx_state.total_x_withdrawn + v8;
        arg3.flowx_state.total_y_withdrawn = arg3.flowx_state.total_y_withdrawn + v9;
        0x2::balance::join<T0>(&mut arg3.total_withdrawn_x_balance, v7);
        0x2::balance::join<T1>(&mut arg3.total_withdrawn_y_balance, v6);
        0x2::balance::destroy_zero<0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HIVE>(0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::burn_hive_and_return(arg2, &mut arg3.hive_profile, v5, v2, arg7));
        (v0, v1, v2, v8, v9)
    }

    public fun add_incentives_for_cetus_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x4343eef50640ce42e4b5b82942d815f88ce529d79d72eb250a26ab09df1c2c2f::cetus_vampire_attack::LockdropForPool<T0, T1>, arg2: &0x4343eef50640ce42e4b5b82942d815f88ce529d79d72eb250a26ab09df1c2c2f::cetus_vampire_attack::CetusAttackConfig, arg3: 0x2::coin::Coin<0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HIVE>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x1::string::String) {
        0x4343eef50640ce42e4b5b82942d815f88ce529d79d72eb250a26ab09df1c2c2f::cetus_vampire_attack::add_incentives_for_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun add_incentives_for_flowx_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x7457dd0fceeb3307637f978e0d20f34cd0b862f5bcc1ca50ac677f025f122d7b::flowx_vampire_attack::FlowxLockdropForPool<T0, T1>, arg2: &0x7457dd0fceeb3307637f978e0d20f34cd0b862f5bcc1ca50ac677f025f122d7b::flowx_vampire_attack::FlowxAttackConfig, arg3: 0x2::coin::Coin<0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HIVE>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x1::string::String) {
        0x7457dd0fceeb3307637f978e0d20f34cd0b862f5bcc1ca50ac677f025f122d7b::flowx_vampire_attack::add_incentives_for_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun add_incentives_for_kriya_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut 0x87b12507bf324e3ca3c9ec13264f99c8382bdd05e3ea07969bcff00124ad7b31::kriya_vampire_attack::KriyaLockdropForPool<T0, T1>, arg2: &0x87b12507bf324e3ca3c9ec13264f99c8382bdd05e3ea07969bcff00124ad7b31::kriya_vampire_attack::KriyaAttackConfig, arg3: 0x2::coin::Coin<0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HIVE>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, 0x1::string::String) {
        0x87b12507bf324e3ca3c9ec13264f99c8382bdd05e3ea07969bcff00124ad7b31::kriya_vampire_attack::add_incentives_for_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun add_incentives_for_lsd_lockdrop(arg0: &0x2::clock::Clock, arg1: &mut 0x52608683dc67e9b66497cf84d979615c0ea2bf1cecbf643050c6009e7c2da4fc::lsd_lockdrop::LsdLockdropVault, arg2: 0x2::coin::Coin<0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HIVE>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0x52608683dc67e9b66497cf84d979615c0ea2bf1cecbf643050c6009e7c2da4fc::lsd_lockdrop::add_hive_incentives(arg0, arg1, arg2, arg3, arg4)
    }

    public entry fun add_liquidity_to_degenhive<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::config::HiveEntryCap, arg2: &mut LockdropForPool<T0, T1, T2>, arg3: &mut 0xb74d357f49f719ac5f71eb25afdf6a01fdb50c043ece13f6c9720e0027b7cd9d::two_pool::LiquidityPool<T0, T1, T2>, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        assert!(0x2::balance::value<T0>(&arg2.total_withdrawn_x_balance) > 0 && 0x2::balance::value<T1>(&arg2.total_withdrawn_y_balance) > 0, 1800);
        let v0 = 0xb74d357f49f719ac5f71eb25afdf6a01fdb50c043ece13f6c9720e0027b7cd9d::two_pool::add_liquidity<T0, T1, T2>(arg0, arg3, 0x2::balance::withdraw_all<T0>(&mut arg2.total_withdrawn_x_balance), 0x2::balance::withdraw_all<T1>(&mut arg2.total_withdrawn_y_balance), 0);
        arg2.total_lp_krafted = arg2.total_lp_krafted + (0x2::balance::value<0xb74d357f49f719ac5f71eb25afdf6a01fdb50c043ece13f6c9720e0027b7cd9d::two_pool::LP<T0, T1, T2>>(&v0) as u128);
        0x2::balance::join<0xb74d357f49f719ac5f71eb25afdf6a01fdb50c043ece13f6c9720e0027b7cd9d::two_pool::LP<T0, T1, T2>>(&mut arg2.degenhive_lps_krafted, v0);
        let v1 = ((arg2.cetus_state.total_x_withdrawn + arg2.kriya_state.total_x_withdrawn + arg2.flowx_state.total_x_withdrawn) as u256);
        let v2 = ((arg2.cetus_state.total_y_withdrawn + arg2.kriya_state.total_y_withdrawn + arg2.flowx_state.total_y_withdrawn) as u256);
        let v3 = ((0x2::balance::value<0xb74d357f49f719ac5f71eb25afdf6a01fdb50c043ece13f6c9720e0027b7cd9d::two_pool::LP<T0, T1, T2>>(&v0) / 2) as u256);
        arg2.cetus_state.total_dlps_amount = (0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::math::mul_div_u256((arg2.cetus_state.total_x_withdrawn as u256), v3, v1) as u64);
        arg2.cetus_state.total_dlps_amount = arg2.cetus_state.total_dlps_amount + (0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::math::mul_div_u256((arg2.cetus_state.total_y_withdrawn as u256), v3, v2) as u64);
        arg2.kriya_state.total_dlps_amount = (0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::math::mul_div_u256((arg2.kriya_state.total_x_withdrawn as u256), v3, v1) as u64);
        arg2.kriya_state.total_dlps_amount = arg2.kriya_state.total_dlps_amount + (0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::math::mul_div_u256((arg2.flowx_state.total_y_withdrawn as u256), v3, v2) as u64);
        arg2.flowx_state.total_dlps_amount = (0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::math::mul_div_u256((arg2.flowx_state.total_x_withdrawn as u256), v3, v1) as u64);
        arg2.flowx_state.total_dlps_amount = arg2.flowx_state.total_dlps_amount + (0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::math::mul_div_u256((arg2.flowx_state.total_y_withdrawn as u256), v3, v2) as u64);
        let v4 = DegenHiveLpTokensKrafted<T0, T1, T2>{
            dlp_shares_krafted      : (arg2.total_lp_krafted as u64),
            cetus_total_dlps_amount : arg2.cetus_state.total_dlps_amount,
            kriya_total_dlps_amount : arg2.kriya_state.total_dlps_amount,
            flowx_total_dlps_amount : arg2.flowx_state.total_dlps_amount,
        };
        0x2::event::emit<DegenHiveLpTokensKrafted<T0, T1, T2>>(v4);
        ((arg2.total_lp_krafted as u64), arg2.cetus_state.total_dlps_amount, arg2.kriya_state.total_dlps_amount, arg2.flowx_state.total_dlps_amount)
    }

    public fun claim_liquidity_from_cetus<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::config::HiveEntryCap, arg2: &0x4343eef50640ce42e4b5b82942d815f88ce529d79d72eb250a26ab09df1c2c2f::cetus_vampire_attack::CetusAttackConfig, arg3: &mut 0x4343eef50640ce42e4b5b82942d815f88ce529d79d72eb250a26ab09df1c2c2f::cetus_vampire_attack::LockdropForPool<T0, T1>, arg4: &mut LockdropForPool<T0, T1, T2>, arg5: &mut 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HiveVault, arg6: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, u64, u64, u64, u64, u64, u64) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8) = 0x4343eef50640ce42e4b5b82942d815f88ce529d79d72eb250a26ab09df1c2c2f::cetus_vampire_attack::transfer_liquidity_from_cetus<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        let v9 = v8;
        let v10 = v7;
        let v11 = v6;
        let v12 = v5;
        let v13 = v4;
        let v14 = v3;
        let v15 = v2;
        let v16 = 0x2::balance::value<T0>(&v15);
        let v17 = 0x2::balance::value<T1>(&v14);
        let v18 = 0x2::balance::value<0x2::sui::SUI>(&v11);
        let v19 = 0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&v10);
        let v20 = 0x2::balance::value<0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HIVE>(&v9);
        arg4.cetus_state.total_positions_liquidity = arg4.cetus_state.total_positions_liquidity + v0;
        arg4.cetus_state.total_weighted_units = arg4.cetus_state.total_weighted_units + v1;
        arg4.cetus_state.total_x_withdrawn = arg4.cetus_state.total_x_withdrawn + v16;
        arg4.cetus_state.total_y_withdrawn = arg4.cetus_state.total_y_withdrawn + v17;
        arg4.cetus_state.total_sui_earned = arg4.cetus_state.total_sui_earned + v18;
        arg4.cetus_state.total_cetus_earned = arg4.cetus_state.total_cetus_earned + v19;
        arg4.cetus_state.total_hive_incentives = arg4.cetus_state.total_hive_incentives + v20;
        0x2::balance::join<T0>(&mut arg4.total_withdrawn_x_balance, v15);
        0x2::balance::join<T1>(&mut arg4.total_withdrawn_y_balance, v14);
        0x2::balance::join<T0>(&mut arg4.cetus_state.x_fee_withdrawn, v13);
        0x2::balance::join<T1>(&mut arg4.cetus_state.y_fee_withdrawn, v12);
        0x2::balance::join<0x2::sui::SUI>(&mut arg4.cetus_state.sui_earned_bal, v11);
        0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg4.cetus_state.cetus_earned_bal, v10);
        0x2::balance::destroy_zero<0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HIVE>(0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::burn_hive_and_return(arg5, &mut arg4.hive_profile, v9, v20, arg6));
        (v0, v1, v16, v17, 0x2::balance::value<T0>(&v13), 0x2::balance::value<T1>(&v12), v18, v19, v20)
    }

    public entry fun extract_liquidity_from_kriya<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::config::HiveEntryCap, arg2: &mut 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HiveVault, arg3: &mut LockdropForPool<T0, T1, T2>, arg4: &0x87b12507bf324e3ca3c9ec13264f99c8382bdd05e3ea07969bcff00124ad7b31::kriya_vampire_attack::KriyaAttackConfig, arg5: &mut 0x87b12507bf324e3ca3c9ec13264f99c8382bdd05e3ea07969bcff00124ad7b31::kriya_vampire_attack::KriyaLockdropForPool<T0, T1>, arg6: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg7: &mut 0x2::tx_context::TxContext) : (u128, u128, u64, u64, u64) {
        let (v0, v1, v2, v3, v4, v5) = 0x87b12507bf324e3ca3c9ec13264f99c8382bdd05e3ea07969bcff00124ad7b31::kriya_vampire_attack::extract_liquidity_from_kriya<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7);
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
        0x2::balance::destroy_zero<0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HIVE>(0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::burn_hive_and_return(arg2, &mut arg3.hive_profile, v5, v2, arg7));
        (v0, v1, v2, v8, v9)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun initialize_attack_on_cetus_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::config::HiveEntryCap, arg2: 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::ProfileDofOwnershipCapability, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &LockdropForPool<T0, T1, T2>, arg5: &0x4343eef50640ce42e4b5b82942d815f88ce529d79d72eb250a26ab09df1c2c2f::cetus_vampire_attack::CetusAttackConfig, arg6: 0x1::string::String, arg7: 0x2::coin::Coin<0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HIVE>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : address {
        0x4343eef50640ce42e4b5b82942d815f88ce529d79d72eb250a26ab09df1c2c2f::cetus_vampire_attack::initialize_attack_on_pool<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8, arg9)
    }

    public fun initialize_attack_on_flowx_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::config::HiveEntryCap, arg2: 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::ProfileDofOwnershipCapability, arg3: &LockdropForPool<T0, T1, T2>, arg4: &mut 0x7457dd0fceeb3307637f978e0d20f34cd0b862f5bcc1ca50ac677f025f122d7b::flowx_vampire_attack::FlowxAttackConfig, arg5: 0x1::string::String, arg6: 0x2::coin::Coin<0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HIVE>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : address {
        0x7457dd0fceeb3307637f978e0d20f34cd0b862f5bcc1ca50ac677f025f122d7b::flowx_vampire_attack::initialize_attack_on_pool<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8)
    }

    public fun initialize_attack_on_kriya_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::config::HiveEntryCap, arg2: 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::ProfileDofOwnershipCapability, arg3: &LockdropForPool<T0, T1, T2>, arg4: 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::KriyaLPToken<T0, T1>, arg5: &mut 0x87b12507bf324e3ca3c9ec13264f99c8382bdd05e3ea07969bcff00124ad7b31::kriya_vampire_attack::KriyaAttackConfig, arg6: 0x1::string::String, arg7: 0x2::coin::Coin<0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HIVE>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : address {
        0x87b12507bf324e3ca3c9ec13264f99c8382bdd05e3ea07969bcff00124ad7b31::kriya_vampire_attack::initialize_attack_on_pool<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public entry fun initialize_lockdrop_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::config::HiveEntryCap, arg2: 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::ProfileDofOwnershipCapability, arg3: &mut LockdropVault, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x24bc76f3e97e7299b0e91432c3cdcdb7080bb5f976a45d9fb2fb6431b3173a8::hsui_vault::HSuiVault, arg6: &mut 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::HiveProfileMappingStore, arg7: &mut 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::HiveManager, arg8: &mut 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::HSuiDisperser<0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::hsui::HSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) : address {
        0x1::string::append(&mut arg10, 0x1::string::utf8(b" POOL-LOCKDROP"));
        let (v0, v1) = 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::kraft_owned_hive_profile(arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, 0x1::string::utf8(b"Participate in HIVE LOCKDROP!"), arg11);
        let v2 = v0;
        0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg11), arg11);
        let (v3, v4, _, _) = 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::get_profile_meta_info(&v2);
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
            id                        : 0x2::object::new(arg11),
            hive_profile              : v2,
            user_profile_access_cap   : arg2,
            cetus_state               : v7,
            kriya_state               : v8,
            flowx_state               : v9,
            total_withdrawn_x_balance : 0x2::balance::zero<T0>(),
            total_withdrawn_y_balance : 0x2::balance::zero<T1>(),
            degenhive_lps_krafted     : 0x2::balance::zero<0xb74d357f49f719ac5f71eb25afdf6a01fdb50c043ece13f6c9720e0027b7cd9d::two_pool::LP<T0, T1, T2>>(),
            total_lp_krafted          : 0,
            are_staked_with_pool_hive : false,
            dlps_staked_amount        : 0,
            hive_gems_per_share       : 0,
            bee_fruit_indexes         : 0x2::linked_table::new<0x1::ascii::String, u256>(arg11),
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

    public entry fun initialize_lockdrops(arg0: &0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::config::HiveEntryCap, arg1: 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::ProfileDofOwnershipCapability, arg2: 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::ProfileDofOwnershipCapability, arg3: 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::ProfileDofOwnershipCapability, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x24bc76f3e97e7299b0e91432c3cdcdb7080bb5f976a45d9fb2fb6431b3173a8::hsui_vault::HSuiVault, arg6: &mut 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::HiveProfileMappingStore, arg7: &mut 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::HiveManager, arg8: &mut 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::HSuiDisperser<0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::hsui::HSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::clock::Clock, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &mut 0x2::tx_context::TxContext) : (address, address, address, address, address) {
        let (v0, v1) = 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::kraft_owned_hive_profile(arg10, arg4, arg5, arg6, arg7, arg8, arg9, 0x1::string::utf8(b"LockdropLsdManager"), 0x1::string::utf8(b"Participate in HIVE LOCKDROP!"), arg19);
        let v2 = v0;
        0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg19), arg19);
        let (v3, v4, _, _) = 0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive_profile::get_profile_meta_info(&v2);
        let v7 = LockdropVault{
            id                        : 0x2::object::new(arg19),
            hive_profile              : v2,
            user_profile_access_cap   : arg3,
            krafted_pools             : 0x2::table::new<0x1::string::String, address>(arg19),
            sui_total_locked          : 0,
            sui_total_weighted_units  : 0,
            hive_sui_total_received   : 0,
            hive_available            : 0x2::balance::zero<0xdb900dc1968ceaa3e1e3a93579682a83fbf4b9d382e2205abf4ab086c925d50c::hive::HIVE>(),
            total_hive_incentives     : 0,
            degenhive_lps_krafted     : 0x2::balance::zero<0xb74d357f49f719ac5f71eb25afdf6a01fdb50c043ece13f6c9720e0027b7cd9d::two_pool::LP<0x2::sui::SUI, 0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::hsui::HSUI, 0x9006b6a9074a409702a34ab92502dd985cebdf5fc5bea62f56e10bc03388b7b3::curves::Curved>>(),
            total_lp_krafted          : 0,
            are_staked_with_pool_hive : false,
            dlps_staked_amount        : 0,
            hive_gems_per_share       : 0,
            bee_fruit_indexes         : 0x2::linked_table::new<0x1::ascii::String, u256>(arg19),
        };
        let v8 = LockdropVaultInitialized{
            vault_addr       : 0x2::object::uid_to_address(&v7.id),
            profile_addr     : v3,
            profile_username : v4,
        };
        0x2::event::emit<LockdropVaultInitialized>(v8);
        0x2::transfer::share_object<LockdropVault>(v7);
        let v9 = 0x2::object::new(arg19);
        let v10 = LockdropRewardsCapabilityHolderInitialized{addr: 0x2::object::uid_to_address(&v9)};
        0x2::event::emit<LockdropRewardsCapabilityHolderInitialized>(v10);
        let v11 = LockdropRewardsCapabilityHolder{
            id         : v9,
            capability : arg1,
        };
        0x2::transfer::share_object<LockdropRewardsCapabilityHolder>(v11);
        (0x2::object::uid_to_address(&v7.id), 0x52608683dc67e9b66497cf84d979615c0ea2bf1cecbf643050c6009e7c2da4fc::lsd_lockdrop::initialize_global_lsd_lockdrop(arg0, arg2, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19), 0x87b12507bf324e3ca3c9ec13264f99c8382bdd05e3ea07969bcff00124ad7b31::kriya_vampire_attack::initialize_kriya_attack_config(arg10, arg0, arg12, arg13, arg14, arg15, arg16, arg17, arg18, (arg11 as u8), arg19), 0x7457dd0fceeb3307637f978e0d20f34cd0b862f5bcc1ca50ac677f025f122d7b::flowx_vampire_attack::initialize_flowx_attack_config(arg10, arg0, arg12, arg13, arg14, arg15, arg16, arg17, arg18, (arg11 as u8), arg19), 0x4343eef50640ce42e4b5b82942d815f88ce529d79d72eb250a26ab09df1c2c2f::cetus_vampire_attack::initialize_cetus_attack(arg10, arg0, arg12, arg13, arg14, arg15, arg16, arg17, arg18, (arg11 as u8), arg19))
    }

    // decompiled from Move bytecode v6
}

