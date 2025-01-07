module 0x86aa465fa3286f3ce965971bd017a3f03bfcf86b3f29404461bab1eefc3e977c::lockdrop {
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
        earned_bal: 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>,
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
            earned_bal                : 0x2::balance::zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(),
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

