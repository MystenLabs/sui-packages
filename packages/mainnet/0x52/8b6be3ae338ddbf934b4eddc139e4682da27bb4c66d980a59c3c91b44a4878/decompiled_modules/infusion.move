module 0x528b6be3ae338ddbf934b4eddc139e4682da27bb4c66d980a59c3c91b44a4878::infusion {
    struct InfusionVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        user_profile_access_cap: 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveAppAccessCapability,
        begin_timestamp: u64,
        deposit_window: u64,
        withdrawal_window: u64,
        lp_tokens_vesting_duration: u64,
        infusion_profile: 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveProfile,
        total_hive_rewards: u64,
        sui_hive_pool_addr: 0x1::option::Option<address>,
        available_sui_balance: 0x2::balance::Balance<T0>,
        available_hive_balance: 0x2::balance::Balance<0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE>,
        total_hive_delegated: u64,
        total_sui_delegated: u64,
        pool_infusion_timestamp: u64,
        available_lp_shares: 0x2::balance::Balance<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>,
        total_lp_shares_krafted: u64,
        cur_lp_shares_staked: u64,
        is_lp_staked: bool,
        lp_to_burn_for_tax: 0x2::balance::Balance<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>,
        hive_per_share: u256,
        bee_fruit_indexes: 0x2::linked_table::LinkedTable<0x1::ascii::String, u256>,
        sui_hive_lp_tokens_flamed: u64,
        sui_dsui_lp_tokens_flamed: u64,
        bees_manager: BeeManager,
        module_version: u64,
    }

    struct BeeManager has store {
        bee_infusion_incentives: 0x2::balance::Balance<0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE>,
        bee_per_lp_share: u256,
        sui_bee_pool_addr: 0x1::option::Option<address>,
        sui_bee_lp_tokens_flamed: u64,
    }

    struct BeeFruitDistributor<phantom T0> has store, key {
        id: 0x2::object::UID,
        claim_index: u256,
        available_bee_fruits: 0x2::balance::Balance<T0>,
        total_bee_fruits_earned: u64,
    }

    struct UserInfusionPosition has store, key {
        id: 0x2::object::UID,
        hive_delegated: u64,
        sui_delegated: u64,
        sui_withdrawn_flag: bool,
        gems_claimable_for_infusion: u64,
        bees_claimable_for_infusion: u64,
        gems_claimed_flag: bool,
        user_lp_shares: u64,
        unbonded_lp_shares: u64,
        lp_to_unlock: 0x2::linked_table::LinkedTable<u64, u64>,
        claimed_lp_shares: u64,
        burnt_for_tax: u64,
        hive_per_share: u256,
        gems_streamed_from_staking: u64,
        bee_fruit_indexes: 0x2::linked_table::LinkedTable<0x1::ascii::String, u256>,
        total_bee_fruits_earned: 0x2::linked_table::LinkedTable<0x1::ascii::String, u128>,
        claimed_bees: u64,
    }

    struct InfusionVaultInitialized has copy, drop {
        vault_addr: address,
    }

    struct InfusedHiveForInfusionPhase has copy, drop {
        hive_gems_incentives: u64,
    }

    struct DepositSuiForInfusion has copy, drop {
        user: address,
        username: 0x1::string::String,
        profile_addr: address,
        user_position_id: address,
        sui_deposited: u64,
        total_sui_deposited_by_user: u64,
    }

    struct WithdrawSuiFromInfusion has copy, drop {
        user: address,
        username: 0x1::string::String,
        profile_addr: address,
        user_position_id: address,
        sui_withdrawn: u64,
        total_sui_deposited_by_user: u64,
    }

    struct HiveDelegatedFromAirdrop has copy, drop {
        user: address,
        username: 0x1::string::String,
        profile_addr: address,
        user_position_id: address,
        hive_delegated: u64,
        total_hive_delegated_by_user: u64,
    }

    struct HiveDelegatedFromLockdrop has copy, drop {
        user: address,
        username: 0x1::string::String,
        profile_addr: address,
        user_position_id: address,
        hive_delegated: u64,
        total_hive_delegated_by_user: u64,
    }

    struct InfusionPhaseOver<phantom T0, phantom T1, phantom T2> has copy, drop {
        hive_sui_lp_shares: u64,
        total_hive_sui_lp_shares: u64,
        krafted_sui_bee_lp_balance: u64,
        bee_for_infusion_incentives: u64,
        bee_per_lp_share: u256,
    }

    struct DegenSuiLpTokensStaked has copy, drop {
        shared_staked: u64,
    }

    struct UserClaimedInfusionRewards has copy, drop {
        username: 0x1::string::String,
        profile_addr: address,
        unbond_lp_shares_amt: u64,
        unlock_epoch: u64,
        gems_via_staking_yield: u64,
        hive_incentives_for_infusion_claimed: u64,
        unlocked_lp_shares: u64,
        bees_incentives_for_infusion_claimed: u64,
        lp_shares_to_burn: u64,
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

    public fun claim_pol_from_streamer_buzz<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::config::HiveEntryCap, arg2: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::ManagerAppAccessCapability, arg3: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg4: &mut 0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::PoolRegistry, arg5: &mut 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HiveVault, arg6: &mut 0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LiquidityPool<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>, arg7: &mut 0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LiquidityPool<T0, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>, arg8: &mut 0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LiquidityPool<T0, T1, T2>, arg9: &mut 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::config::FeeCollector<T0>, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_mut_from_manager_profile<InfusionVault<T0>>(arg2, arg3);
        assert!(v0.module_version == 0, 5118);
        if (v0.pool_infusion_timestamp == 0) {
            return (0, 0, 0)
        };
        let (v1, v2, v3) = 0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::claim_pol_from_streamer_buzz<T0, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE, T1, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved, T2>(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        v0.sui_hive_lp_tokens_flamed = v0.sui_hive_lp_tokens_flamed + v1;
        v0.sui_dsui_lp_tokens_flamed = v0.sui_dsui_lp_tokens_flamed + v3;
        v0.bees_manager.sui_bee_lp_tokens_flamed = v0.bees_manager.sui_bee_lp_tokens_flamed + v2;
        (v1, v2, v3)
    }

    public fun lock_in_sui_bee_pool_addr<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::config::HiveEntryCap, arg2: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::ManagerAppAccessCapability, arg3: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg4: &mut 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::config::Config, arg5: &mut 0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::PoolRegistry, arg6: &0x2::coin::CoinMetadata<T1>, arg7: 0x2::balance::Balance<0x2::sui::SUI>, arg8: &mut 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::config::FeeCollector<0x2::sui::SUI>, arg9: vector<u64>, arg10: 0x1::option::Option<vector<u256>>, arg11: 0x1::option::Option<vector<u64>>, arg12: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_mut_from_manager_profile<InfusionVault<T0>>(arg2, arg3);
        assert!(0x1::option::is_none<address>(&v0.bees_manager.sui_bee_pool_addr), 5116);
        assert!(v0.module_version == 0, 5118);
        let (v1, v2) = 0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::lock_in_sui_bee_pool_addr<T0, T1, T2>(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        v0.bees_manager.sui_bee_pool_addr = 0x1::option::some<address>(v1);
        0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg12), arg12);
        v1
    }

    public fun lock_in_sui_hive_pool_addr<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::config::HiveEntryCap, arg2: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::ManagerAppAccessCapability, arg3: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg4: &mut 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::config::Config, arg5: &mut 0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::PoolRegistry, arg6: &0x2::coin::CoinMetadata<T1>, arg7: 0x2::balance::Balance<0x2::sui::SUI>, arg8: &mut 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::config::FeeCollector<0x2::sui::SUI>, arg9: vector<u64>, arg10: 0x1::option::Option<vector<u256>>, arg11: 0x1::option::Option<vector<u64>>, arg12: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_mut_from_manager_profile<InfusionVault<T0>>(arg2, arg3);
        assert!(0x1::option::is_none<address>(&v0.sui_hive_pool_addr), 5103);
        assert!(v0.module_version == 0, 5118);
        let (v1, v2) = 0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::lock_in_sui_hive_pool_addr<T0, T1, T2>(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        v0.sui_hive_pool_addr = 0x1::option::some<address>(v1);
        0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg12), arg12);
        v1
    }

    fun allowed_withdrawal_amount<T0>(arg0: &InfusionVault<T0>, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0.begin_timestamp + arg0.deposit_window;
        if (arg1 < v0) {
            return arg2
        };
        let v1 = v0 + arg0.withdrawal_window / 2;
        if (arg1 <= v1) {
            return arg2 / 2
        };
        let v2 = v0 + arg0.withdrawal_window;
        if (arg1 < v2) {
            (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(((arg2 / 2) as u256), ((v2 - arg1) as u256), ((v2 - v1) as u256)) as u64)
        } else {
            0
        }
    }

    fun calculate_unbondable_lp_shares<T0>(arg0: u64, arg1: &InfusionVault<T0>, arg2: &UserInfusionPosition, arg3: bool) : u64 {
        let v0 = arg0 - arg1.pool_infusion_timestamp;
        if (v0 >= arg1.lp_tokens_vesting_duration || arg3) {
            arg2.user_lp_shares - arg2.unbonded_lp_shares
        } else {
            let v2 = (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256((arg2.user_lp_shares as u256), (v0 as u256), (arg1.lp_tokens_vesting_duration as u256)) as u64);
            assert!(v2 >= arg2.unbonded_lp_shares, 5113);
            v2 - arg2.unbonded_lp_shares
        }
    }

    fun calculate_user_hive_incentives<T0>(arg0: &InfusionVault<T0>, arg1: &UserInfusionPosition) : (u64, u64) {
        let v0 = (10000000000 as u256);
        let v1 = (10000000000 as u256);
        if (arg0.total_hive_delegated > 0) {
            v0 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256((arg1.hive_delegated as u256), (10000000000 as u256), (arg0.total_hive_delegated as u256));
        };
        if (arg0.total_sui_delegated > 0) {
            v1 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256((arg1.sui_delegated as u256), (10000000000 as u256), (arg0.total_sui_delegated as u256));
        };
        let v2 = ((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256((v1 as u256), ((arg0.total_hive_rewards / 2) as u256), (10000000000 as u256)) + 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256((v0 as u256), ((arg0.total_hive_rewards / 2) as u256), (10000000000 as u256))) as u64);
        (v2, (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u128((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::total_bee_supply() as u128), ((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::percent_precision() - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::bees_for_streambuzz_profile_pct() - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::bees_for_treasury_pct() - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::genesis_bee_for_lp_pct()) as u128), (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::percent_precision() as u128)) as u64) as u256), (v2 as u256), (arg0.total_hive_rewards as u256)) as u64))
    }

    fun calculate_user_lp_shares<T0>(arg0: &InfusionVault<T0>, arg1: &UserInfusionPosition) : u64 {
        ((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256((arg1.hive_delegated as u256), (10000000000 as u256), (arg0.total_hive_delegated as u256)) as u256), ((arg0.total_lp_shares_krafted / 2) as u256), (10000000000 as u256)) + 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256((arg1.sui_delegated as u256), (10000000000 as u256), (arg0.total_sui_delegated as u256)) as u256), ((arg0.total_lp_shares_krafted / 2) as u256), (10000000000 as u256))) as u64)
    }

    fun claim_gems_and_increment_states<T0>(arg0: &mut InfusionVault<T0>, arg1: &mut UserInfusionPosition, arg2: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveProfile, arg3: &mut 0x2::token::TokenPolicy<0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE>, arg4: &0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::bee_trade::BeesManager<0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        arg0.hive_per_share = arg0.hive_per_share + 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(((arg6 - arg5) as u256), (10000000000 as u256), (arg0.cur_lp_shares_staked as u256));
        let v0 = (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(arg0.hive_per_share - arg1.hive_per_share, ((arg1.user_lp_shares - arg1.unbonded_lp_shares) as u256), (10000000000 as u256)) as u64);
        0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::transfer_hive_gems_via_comp_profile(&mut arg0.infusion_profile, arg2, v0, arg7);
        arg1.hive_per_share = arg0.hive_per_share;
        arg1.gems_streamed_from_staking = arg1.gems_streamed_from_staking + v0;
        let v1 = 0;
        let v2 = 0;
        if (!arg1.gems_claimed_flag) {
            0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::transfer_hive_gems_via_comp_profile(&mut arg0.infusion_profile, arg2, arg1.gems_claimable_for_infusion, arg7);
            arg1.gems_claimed_flag = true;
            v1 = arg1.gems_claimable_for_infusion;
            v2 = arg1.bees_claimable_for_infusion;
            0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::bee_trade::transfer_bees_balance(arg3, arg4, 0x2::balance::split<0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE>(&mut arg0.bees_manager.bee_infusion_incentives, arg1.bees_claimable_for_infusion), 0x2::tx_context::sender(arg7), arg7);
        };
        (v0, v1, v2)
    }

    public fun claim_rewards_and_shares_0_fruits<T0>(arg0: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::ManagerAppAccessCapability, arg1: &0x2::clock::Clock, arg2: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg3: &mut 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::PoolsGovernor, arg4: &mut 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::PoolHive<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>, arg5: &mut 0x2::token::TokenPolicy<0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE>, arg6: &0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::bee_trade::BeesManager<0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE>, arg7: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveProfile, arg8: bool, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::tx_context::epoch(arg10);
        let (_, _, v3, _, _) = 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::get_pools_governor(arg3);
        let v6 = v0 + v3;
        let v7 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_mut_from_manager_profile<InfusionVault<T0>>(arg0, arg2);
        let v8 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::remove_app_from_profile<UserInfusionPosition>(&v7.user_profile_access_cap, arg7, arg10);
        let (v9, v10, _, v12) = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::get_profile_meta_info(arg7);
        assert!(v12 == 0x2::tx_context::sender(arg10), 5115);
        let v13 = &mut v8;
        let v14 = verification_and_update_states<T0>(0x2::clock::timestamp_ms(arg1), v7, v13, arg8, arg9);
        let v15 = 0;
        let v16 = 0;
        let v17 = 0;
        let v18 = 0;
        let v19 = if (arg9) {
            let v20 = 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::unlock_from_bee_box<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(arg4, &mut v7.infusion_profile, v14, arg10);
            v7.cur_lp_shares_staked = v7.cur_lp_shares_staked - v14;
            v8.claimed_lp_shares = v8.claimed_lp_shares + v14;
            let v21 = v14 * 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::lockdrop_emergency_unlock_tax() / 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::percent_precision();
            v18 = v21;
            0x2::balance::join<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&mut v7.lp_to_burn_for_tax, 0x2::balance::split<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&mut v20, v21));
            0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(v20, 0x2::tx_context::sender(arg10), arg10);
            0x2::balance::value<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&v20)
        } else {
            let v22 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::get_available_gems_in_profile(&v7.infusion_profile);
            0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::unbond_from_bee_box_0_fruits<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(arg3, arg4, &mut v7.infusion_profile, v14, arg10);
            let v23 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::get_available_gems_in_profile(&v7.infusion_profile);
            let v24 = &mut v8;
            let (v25, v26, v27) = claim_gems_and_increment_states<T0>(v7, v24, arg7, arg5, arg6, v22, v23, arg10);
            v17 = v27;
            v16 = v26;
            v15 = v25;
            let v28 = &mut v8;
            let v29 = internal_claim_unlocked_lps<T0>(v7, arg4, v28, v14, v6, v0, arg10);
            0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(v29, 0x2::tx_context::sender(arg10), arg10);
            0x2::balance::value<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&v29)
        };
        0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::add_app_to_profile<UserInfusionPosition>(&v7.user_profile_access_cap, arg7, v8, arg10);
        let v30 = UserClaimedInfusionRewards{
            username                             : v10,
            profile_addr                         : v9,
            unbond_lp_shares_amt                 : v14,
            unlock_epoch                         : v6,
            gems_via_staking_yield               : v15,
            hive_incentives_for_infusion_claimed : v16,
            unlocked_lp_shares                   : v19,
            bees_incentives_for_infusion_claimed : v17,
            lp_shares_to_burn                    : v18,
        };
        0x2::event::emit<UserClaimedInfusionRewards>(v30);
        (v14, v15, v16, v17, v19, v18)
    }

    public fun claim_rewards_and_shares_1_fruits<T0, T1>(arg0: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::ManagerAppAccessCapability, arg1: &0x2::clock::Clock, arg2: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg3: &mut 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::PoolsGovernor, arg4: &mut 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::PoolHive<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>, arg5: &mut 0x2::token::TokenPolicy<0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE>, arg6: &0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::bee_trade::BeesManager<0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE>, arg7: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveProfile, arg8: bool, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::tx_context::epoch(arg10);
        let (_, _, v3, _, _) = 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::get_pools_governor(arg3);
        let v6 = v0 + v3;
        let v7 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_mut_from_manager_profile<InfusionVault<T0>>(arg0, arg2);
        let v8 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::remove_app_from_profile<UserInfusionPosition>(&v7.user_profile_access_cap, arg7, arg10);
        let (v9, v10, _, v12) = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::get_profile_meta_info(arg7);
        assert!(v12 == 0x2::tx_context::sender(arg10), 5115);
        let v13 = &mut v8;
        let v14 = verification_and_update_states<T0>(0x2::clock::timestamp_ms(arg1), v7, v13, arg8, arg9);
        let v15 = 0;
        let v16 = 0;
        let v17 = 0;
        let v18 = 0;
        let v19 = if (arg9) {
            let v20 = 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::unlock_from_bee_box<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(arg4, &mut v7.infusion_profile, v14, arg10);
            v7.cur_lp_shares_staked = v7.cur_lp_shares_staked - v14;
            v8.claimed_lp_shares = v8.claimed_lp_shares + v14;
            let v21 = v14 * 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::lockdrop_emergency_unlock_tax() / 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::percent_precision();
            v18 = v21;
            0x2::balance::join<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&mut v7.lp_to_burn_for_tax, 0x2::balance::split<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&mut v20, v21));
            0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(v20, 0x2::tx_context::sender(arg10), arg10);
            0x2::balance::value<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&v20)
        } else {
            let v22 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::get_available_gems_in_profile(&v7.infusion_profile);
            let v23 = 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::unbond_from_bee_box_1_fruits<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>, T1>(arg3, arg4, &mut v7.infusion_profile, v14, arg10);
            let v24 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::get_available_gems_in_profile(&v7.infusion_profile);
            let v25 = &mut v8;
            let (v26, v27, v28) = claim_gems_and_increment_states<T0>(v7, v25, arg7, arg5, arg6, v22, v24, arg10);
            v17 = v28;
            v16 = v27;
            v15 = v26;
            let v29 = &mut v8;
            let v30 = increment_bee_fruit_indexes<T0, T1>(v10, v7, v29, v23, arg10);
            let v31 = &mut v8;
            let v32 = internal_claim_unlocked_lps<T0>(v7, arg4, v31, v14, v6, v0, arg10);
            0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(v32, 0x2::tx_context::sender(arg10), arg10);
            0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<T1>(v30, 0x2::tx_context::sender(arg10), arg10);
            0x2::balance::value<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&v32)
        };
        0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::add_app_to_profile<UserInfusionPosition>(&v7.user_profile_access_cap, arg7, v8, arg10);
        let v33 = UserClaimedInfusionRewards{
            username                             : v10,
            profile_addr                         : v9,
            unbond_lp_shares_amt                 : v14,
            unlock_epoch                         : v6,
            gems_via_staking_yield               : v15,
            hive_incentives_for_infusion_claimed : v16,
            unlocked_lp_shares                   : v19,
            bees_incentives_for_infusion_claimed : v17,
            lp_shares_to_burn                    : v18,
        };
        0x2::event::emit<UserClaimedInfusionRewards>(v33);
        (v14, v15, v16, v17, v19, v18)
    }

    public fun claim_rewards_and_shares_2_fruits<T0, T1, T2>(arg0: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::ManagerAppAccessCapability, arg1: &0x2::clock::Clock, arg2: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg3: &mut 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::PoolsGovernor, arg4: &mut 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::PoolHive<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>, arg5: &mut 0x2::token::TokenPolicy<0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE>, arg6: &0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::bee_trade::BeesManager<0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE>, arg7: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveProfile, arg8: bool, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::tx_context::epoch(arg10);
        let (_, _, v3, _, _) = 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::get_pools_governor(arg3);
        let v6 = v0 + v3;
        let v7 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_mut_from_manager_profile<InfusionVault<T0>>(arg0, arg2);
        let v8 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::remove_app_from_profile<UserInfusionPosition>(&v7.user_profile_access_cap, arg7, arg10);
        let (v9, v10, _, v12) = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::get_profile_meta_info(arg7);
        assert!(v12 == 0x2::tx_context::sender(arg10), 5115);
        let v13 = &mut v8;
        let v14 = verification_and_update_states<T0>(0x2::clock::timestamp_ms(arg1), v7, v13, arg8, arg9);
        let v15 = 0;
        let v16 = 0;
        let v17 = 0;
        let v18 = 0;
        let v19 = if (arg9) {
            let v20 = 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::unlock_from_bee_box<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(arg4, &mut v7.infusion_profile, v14, arg10);
            v7.cur_lp_shares_staked = v7.cur_lp_shares_staked - v14;
            v8.claimed_lp_shares = v8.claimed_lp_shares + v14;
            let v21 = v14 * 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::lockdrop_emergency_unlock_tax() / 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::percent_precision();
            v18 = v21;
            0x2::balance::join<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&mut v7.lp_to_burn_for_tax, 0x2::balance::split<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&mut v20, v21));
            0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(v20, 0x2::tx_context::sender(arg10), arg10);
            0x2::balance::value<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&v20)
        } else {
            let v22 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::get_available_gems_in_profile(&v7.infusion_profile);
            let (v23, v24) = 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::unbond_from_bee_box_2_fruits<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>, T1, T2>(arg3, arg4, &mut v7.infusion_profile, v14, arg10);
            let v25 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::get_available_gems_in_profile(&v7.infusion_profile);
            let v26 = &mut v8;
            let (v27, v28, v29) = claim_gems_and_increment_states<T0>(v7, v26, arg7, arg5, arg6, v22, v25, arg10);
            v17 = v29;
            v16 = v28;
            v15 = v27;
            let v30 = &mut v8;
            let v31 = increment_bee_fruit_indexes<T0, T1>(v10, v7, v30, v23, arg10);
            let v32 = &mut v8;
            let v33 = increment_bee_fruit_indexes<T0, T2>(v10, v7, v32, v24, arg10);
            let v34 = &mut v8;
            let v35 = internal_claim_unlocked_lps<T0>(v7, arg4, v34, v14, v6, v0, arg10);
            0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(v35, 0x2::tx_context::sender(arg10), arg10);
            0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<T1>(v31, 0x2::tx_context::sender(arg10), arg10);
            0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<T2>(v33, 0x2::tx_context::sender(arg10), arg10);
            0x2::balance::value<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&v35)
        };
        0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::add_app_to_profile<UserInfusionPosition>(&v7.user_profile_access_cap, arg7, v8, arg10);
        let v36 = UserClaimedInfusionRewards{
            username                             : v10,
            profile_addr                         : v9,
            unbond_lp_shares_amt                 : v14,
            unlock_epoch                         : v6,
            gems_via_staking_yield               : v15,
            hive_incentives_for_infusion_claimed : v16,
            unlocked_lp_shares                   : v19,
            bees_incentives_for_infusion_claimed : v17,
            lp_shares_to_burn                    : v18,
        };
        0x2::event::emit<UserClaimedInfusionRewards>(v36);
        (v14, v15, v16, v17, v19, v18)
    }

    public fun claim_rewards_and_shares_3_fruits<T0, T1, T2, T3>(arg0: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::ManagerAppAccessCapability, arg1: &0x2::clock::Clock, arg2: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg3: &mut 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::PoolsGovernor, arg4: &mut 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::PoolHive<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>, arg5: &mut 0x2::token::TokenPolicy<0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE>, arg6: &0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::bee_trade::BeesManager<0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE>, arg7: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveProfile, arg8: bool, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::tx_context::epoch(arg10);
        let (_, _, v3, _, _) = 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::get_pools_governor(arg3);
        let v6 = v0 + v3;
        let v7 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_mut_from_manager_profile<InfusionVault<T0>>(arg0, arg2);
        let v8 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::remove_app_from_profile<UserInfusionPosition>(&v7.user_profile_access_cap, arg7, arg10);
        let (v9, v10, _, v12) = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::get_profile_meta_info(arg7);
        assert!(v12 == 0x2::tx_context::sender(arg10), 5115);
        let v13 = &mut v8;
        let v14 = verification_and_update_states<T0>(0x2::clock::timestamp_ms(arg1), v7, v13, arg8, arg9);
        let v15 = 0;
        let v16 = 0;
        let v17 = 0;
        let v18 = 0;
        let v19 = if (arg9) {
            let v20 = 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::unlock_from_bee_box<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(arg4, &mut v7.infusion_profile, v14, arg10);
            v7.cur_lp_shares_staked = v7.cur_lp_shares_staked - v14;
            v8.claimed_lp_shares = v8.claimed_lp_shares + v14;
            let v21 = v14 * 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::lockdrop_emergency_unlock_tax() / 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::percent_precision();
            v18 = v21;
            0x2::balance::join<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&mut v7.lp_to_burn_for_tax, 0x2::balance::split<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&mut v20, v21));
            0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(v20, 0x2::tx_context::sender(arg10), arg10);
            0x2::balance::value<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&v20)
        } else {
            let v22 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::get_available_gems_in_profile(&v7.infusion_profile);
            let (v23, v24, v25) = 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::unbond_from_bee_box_3_fruits<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>, T1, T2, T3>(arg3, arg4, &mut v7.infusion_profile, v14, arg10);
            let v26 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::get_available_gems_in_profile(&v7.infusion_profile);
            let v27 = &mut v8;
            let (v28, v29, v30) = claim_gems_and_increment_states<T0>(v7, v27, arg7, arg5, arg6, v22, v26, arg10);
            v17 = v30;
            v16 = v29;
            v15 = v28;
            let v31 = &mut v8;
            let v32 = increment_bee_fruit_indexes<T0, T1>(v10, v7, v31, v23, arg10);
            let v33 = &mut v8;
            let v34 = increment_bee_fruit_indexes<T0, T2>(v10, v7, v33, v24, arg10);
            let v35 = &mut v8;
            let v36 = increment_bee_fruit_indexes<T0, T3>(v10, v7, v35, v25, arg10);
            let v37 = &mut v8;
            let v38 = internal_claim_unlocked_lps<T0>(v7, arg4, v37, v14, v6, v0, arg10);
            0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(v38, 0x2::tx_context::sender(arg10), arg10);
            0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<T1>(v32, 0x2::tx_context::sender(arg10), arg10);
            0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<T2>(v34, 0x2::tx_context::sender(arg10), arg10);
            0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<T3>(v36, 0x2::tx_context::sender(arg10), arg10);
            0x2::balance::value<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&v38)
        };
        0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::add_app_to_profile<UserInfusionPosition>(&v7.user_profile_access_cap, arg7, v8, arg10);
        let v39 = UserClaimedInfusionRewards{
            username                             : v10,
            profile_addr                         : v9,
            unbond_lp_shares_amt                 : v14,
            unlock_epoch                         : v6,
            gems_via_staking_yield               : v15,
            hive_incentives_for_infusion_claimed : v16,
            unlocked_lp_shares                   : v19,
            bees_incentives_for_infusion_claimed : v17,
            lp_shares_to_burn                    : v18,
        };
        0x2::event::emit<UserClaimedInfusionRewards>(v39);
        (v14, v15, v16, v17, v19, v18)
    }

    public fun delegate_hive_airdrop<T0>(arg0: &0x2::clock::Clock, arg1: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::ManagerAppAccessCapability, arg2: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::ManagerAppAccessCapability, arg3: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg4: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveProfile, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        let v0 = 0xae391fde6a6ccb353a534fbb9c146034a11d292a39ff5804905d0c3f6db067e::airdrop::delegate_hive_for_infusion(arg2, arg3, arg4, arg5, arg6);
        let v1 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_mut_from_manager_profile<InfusionVault<T0>>(arg1, arg3);
        assert!(is_deposit_open<T0>(0x2::clock::timestamp_ms(arg0), v1), 5107);
        let (v2, v3, _, _) = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::get_profile_meta_info(arg4);
        let v6 = if (0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::exists_for_profile(arg4, 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::get_hive_app_name(&v1.user_profile_access_cap))) {
            0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::remove_app_from_profile<UserInfusionPosition>(&v1.user_profile_access_cap, arg4, arg6)
        } else {
            kraft_user_position(arg6)
        };
        let (v7, v8) = calculate_user_hive_incentives<T0>(v1, &v6);
        v1.total_hive_delegated = v1.total_hive_delegated + arg5;
        v6.hive_delegated = v6.hive_delegated + arg5;
        0x2::balance::join<0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE>(&mut v1.available_hive_balance, v0);
        let v9 = HiveDelegatedFromAirdrop{
            user                         : 0x2::tx_context::sender(arg6),
            username                     : v3,
            profile_addr                 : v2,
            user_position_id             : 0x2::object::uid_to_address(&v6.id),
            hive_delegated               : arg5,
            total_hive_delegated_by_user : v6.hive_delegated,
        };
        0x2::event::emit<HiveDelegatedFromAirdrop>(v9);
        let (v10, v11) = calculate_user_hive_incentives<T0>(v1, &v6);
        0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::add_app_to_profile<UserInfusionPosition>(&v1.user_profile_access_cap, arg4, v6, arg6);
        (v10 - v7, v10, v11 - v8, v11)
    }

    public entry fun deposit_sui<T0>(arg0: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::ManagerAppAccessCapability, arg1: &0x2::clock::Clock, arg2: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg3: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveProfile, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_mut_from_manager_profile<InfusionVault<T0>>(arg0, arg2);
        assert!(is_deposit_open<T0>(0x2::clock::timestamp_ms(arg1), v0), 5107);
        let (v1, v2, _, v4) = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::get_profile_meta_info(arg3);
        assert!(v4 == 0x2::tx_context::sender(arg6), 5115);
        let v5 = if (0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::exists_for_profile(arg3, 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::get_hive_app_name(&v0.user_profile_access_cap))) {
            0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::remove_app_from_profile<UserInfusionPosition>(&v0.user_profile_access_cap, arg3, arg6)
        } else {
            kraft_user_position(arg6)
        };
        let (v6, v7) = calculate_user_hive_incentives<T0>(v0, &v5);
        v0.total_sui_delegated = v0.total_sui_delegated + arg5;
        v5.sui_delegated = v5.sui_delegated + arg5;
        let v8 = 0x2::coin::into_balance<T0>(arg4);
        0x2::balance::join<T0>(&mut v0.available_sui_balance, 0x2::balance::split<T0>(&mut v8, arg5));
        let v9 = DepositSuiForInfusion{
            user                        : 0x2::tx_context::sender(arg6),
            username                    : v2,
            profile_addr                : v1,
            user_position_id            : 0x2::object::uid_to_address(&v5.id),
            sui_deposited               : arg5,
            total_sui_deposited_by_user : v5.sui_delegated,
        };
        0x2::event::emit<DepositSuiForInfusion>(v9);
        let (v10, v11) = calculate_user_hive_incentives<T0>(v0, &v5);
        0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::add_app_to_profile<UserInfusionPosition>(&v0.user_profile_access_cap, arg3, v5, arg6);
        0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<T0>(v8, 0x2::tx_context::sender(arg6), arg6);
        (v10 - v6, v11 - v7)
    }

    public fun get_user_participation_position<T0>(arg0: 0x1::ascii::String, arg1: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg2: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveProfile) : (u64, u64, bool, u64, u64, bool, u64) {
        let v0 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_from_admin_profile<InfusionVault<T0>>(arg1, arg0);
        let v1 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::get_hive_app_name(&v0.user_profile_access_cap);
        if (!0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::exists_for_profile(arg2, v1)) {
            return (0, 0, false, 0, 0, false, 0)
        };
        let v2 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_from_profile<UserInfusionPosition>(arg2, v1);
        let v3 = v2.gems_claimable_for_infusion;
        let v4 = v3;
        let v5 = v2.bees_claimable_for_infusion;
        if (v3 == 0) {
            let (v6, v7) = calculate_user_hive_incentives<T0>(v0, v2);
            v5 = v7;
            v4 = v6;
        };
        (v2.hive_delegated, v2.sui_delegated, v2.sui_withdrawn_flag, v4, v5, v2.gems_claimed_flag, v2.user_lp_shares)
    }

    public entry fun handle_withdraw_sui<T0>(arg0: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::ManagerAppAccessCapability, arg1: &0x2::clock::Clock, arg2: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg3: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveProfile, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64) {
        let v0 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_mut_from_manager_profile<InfusionVault<T0>>(arg0, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let (v2, v3, _, v5) = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::get_profile_meta_info(arg3);
        let v6 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::remove_app_from_profile<UserInfusionPosition>(&v0.user_profile_access_cap, arg3, arg5);
        assert!(!v6.sui_withdrawn_flag, 5108);
        assert!(arg4 <= allowed_withdrawal_amount<T0>(v0, v1, v6.sui_delegated), 5109);
        if (v1 >= v0.begin_timestamp + v0.deposit_window) {
            v6.sui_withdrawn_flag = true;
        };
        let (v7, v8) = calculate_user_hive_incentives<T0>(v0, &v6);
        v0.total_sui_delegated = v0.total_sui_delegated - arg4;
        v6.sui_delegated = v6.sui_delegated - arg4;
        let v9 = WithdrawSuiFromInfusion{
            user                        : 0x2::tx_context::sender(arg5),
            username                    : v3,
            profile_addr                : v2,
            user_position_id            : 0x2::object::uid_to_address(&v6.id),
            sui_withdrawn               : arg4,
            total_sui_deposited_by_user : v6.sui_delegated,
        };
        0x2::event::emit<WithdrawSuiFromInfusion>(v9);
        0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<T0>(0x2::balance::split<T0>(&mut v0.available_sui_balance, arg4), v5, arg5);
        let (v10, v11) = calculate_user_hive_incentives<T0>(v0, &v6);
        0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::add_app_to_profile<UserInfusionPosition>(&v0.user_profile_access_cap, arg3, v6, arg5);
        (v7 - v10, v10, v8 - v11, v11)
    }

    fun increment_bee_fruit_indexes<T0, T1>(arg0: 0x1::string::String, arg1: &mut InfusionVault<T0>, arg2: &mut UserInfusionPosition, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v1 = 0x2::balance::value<T1>(&arg3);
        if (!0x2::linked_table::contains<0x1::ascii::String, u256>(&arg1.bee_fruit_indexes, v0)) {
            0x2::linked_table::push_back<0x1::ascii::String, u256>(&mut arg1.bee_fruit_indexes, v0, 0);
            let v2 = BeeFruitDistributor<T1>{
                id                      : 0x2::object::new(arg4),
                claim_index             : 0,
                available_bee_fruits    : 0x2::balance::zero<T1>(),
                total_bee_fruits_earned : 0,
            };
            0x2::dynamic_object_field::add<0x1::ascii::String, BeeFruitDistributor<T1>>(&mut arg1.id, v0, v2);
        };
        let v3 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, BeeFruitDistributor<T1>>(&mut arg1.id, v0);
        v3.claim_index = v3.claim_index + 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256((v1 as u256), (10000000000 as u256), (arg1.cur_lp_shares_staked as u256));
        v3.total_bee_fruits_earned = v3.total_bee_fruits_earned + v1;
        if (!0x2::linked_table::contains<0x1::ascii::String, u256>(&arg2.bee_fruit_indexes, v0)) {
            0x2::linked_table::push_back<0x1::ascii::String, u256>(&mut arg2.bee_fruit_indexes, v0, 0);
            0x2::linked_table::push_back<0x1::ascii::String, u128>(&mut arg2.total_bee_fruits_earned, v0, 0);
        };
        let v4 = (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(v3.claim_index - *0x2::linked_table::borrow<0x1::ascii::String, u256>(&arg2.bee_fruit_indexes, v0), ((arg2.user_lp_shares - arg2.unbonded_lp_shares) as u256), (10000000000 as u256)) as u128);
        *0x2::linked_table::borrow_mut<0x1::ascii::String, u256>(&mut arg2.bee_fruit_indexes, v0) = v3.claim_index;
        *0x2::linked_table::borrow_mut<0x1::ascii::String, u128>(&mut arg2.total_bee_fruits_earned, v0) = *0x2::linked_table::borrow<0x1::ascii::String, u128>(&arg2.total_bee_fruits_earned, v0) + v4;
        0x2::balance::join<T1>(&mut v3.available_bee_fruits, arg3);
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
        0x2::balance::split<T1>(&mut v3.available_bee_fruits, (v4 as u64))
    }

    public entry fun infuse_hive_incentives<T0>(arg0: &0x2::clock::Clock, arg1: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::ManagerAppAccessCapability, arg2: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg3: &mut 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HiveVault, arg4: 0x2::coin::Coin<0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_mut_from_manager_profile<InfusionVault<T0>>(arg1, arg2);
        assert!(v0.module_version == 0, 5118);
        assert!(v0.begin_timestamp + v0.deposit_window + v0.withdrawal_window > 0x2::clock::timestamp_ms(arg0), 5101);
        0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::burn_hive_for_gems(arg3, &mut v0.infusion_profile, arg4, arg5, arg6);
        v0.total_hive_rewards = v0.total_hive_rewards + arg5;
        let v1 = InfusedHiveForInfusionPhase{hive_gems_incentives: arg5};
        0x2::event::emit<InfusedHiveForInfusionPhase>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_infusion_vault<T0>(arg0: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::ManagerAppAccessCapability, arg1: &0x2::clock::Clock, arg2: 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveAppAccessCapability, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x4bdc27c50617222bea0c6420cadfc0859a1422b442def2c604a634e0f8c6af9a::dsui_vault::DSuiVault, arg5: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveProfileMappingStore, arg6: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg7: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::DSuiDisperser<0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::dsui::DSUI>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg12 > 0 && arg13 > 0 && arg14 > 0 && arg11 > 0x2::clock::timestamp_ms(arg1), 5102);
        let (v0, v1) = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::kraft_owned_hive_profile(arg1, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg15);
        let v2 = BeeManager{
            bee_infusion_incentives  : 0x2::balance::zero<0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE>(),
            bee_per_lp_share         : 0,
            sui_bee_pool_addr        : 0x1::option::none<address>(),
            sui_bee_lp_tokens_flamed : 0,
        };
        let v3 = InfusionVault<T0>{
            id                         : 0x2::object::new(arg15),
            user_profile_access_cap    : arg2,
            begin_timestamp            : arg11,
            deposit_window             : arg12,
            withdrawal_window          : arg13,
            lp_tokens_vesting_duration : arg14,
            infusion_profile           : v0,
            total_hive_rewards         : 0,
            sui_hive_pool_addr         : 0x1::option::none<address>(),
            available_sui_balance      : 0x2::balance::zero<T0>(),
            available_hive_balance     : 0x2::balance::zero<0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE>(),
            total_hive_delegated       : 0,
            total_sui_delegated        : 0,
            pool_infusion_timestamp    : 0,
            available_lp_shares        : 0x2::balance::zero<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(),
            total_lp_shares_krafted    : 0,
            cur_lp_shares_staked       : 0,
            is_lp_staked               : false,
            lp_to_burn_for_tax         : 0x2::balance::zero<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(),
            hive_per_share             : 0,
            bee_fruit_indexes          : 0x2::linked_table::new<0x1::ascii::String, u256>(arg15),
            sui_hive_lp_tokens_flamed  : 0,
            sui_dsui_lp_tokens_flamed  : 0,
            bees_manager               : v2,
            module_version             : 0,
        };
        let v4 = InfusionVaultInitialized{vault_addr: 0x2::object::uid_to_address(&v3.id)};
        0x2::event::emit<InfusionVaultInitialized>(v4);
        0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg15), arg15);
        0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::add_app_to_manager_profile<InfusionVault<T0>>(arg0, arg6, v3);
    }

    fun internal_claim_unlocked_lps<T0>(arg0: &mut InfusionVault<T0>, arg1: &mut 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::PoolHive<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>, arg2: &mut UserInfusionPosition, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>> {
        if (arg3 > 0) {
            arg2.unbonded_lp_shares = arg2.unbonded_lp_shares + arg3;
            if (0x2::linked_table::contains<u64, u64>(&arg2.lp_to_unlock, arg4)) {
                *0x2::linked_table::borrow_mut<u64, u64>(&mut arg2.lp_to_unlock, arg4) = *0x2::linked_table::borrow<u64, u64>(&arg2.lp_to_unlock, arg4) + arg3;
            } else {
                0x2::linked_table::push_back<u64, u64>(&mut arg2.lp_to_unlock, arg4, arg3);
            };
            arg0.cur_lp_shares_staked = arg0.cur_lp_shares_staked - arg3;
        };
        let v0 = *0x2::linked_table::front<u64, u64>(&arg2.lp_to_unlock);
        let v1 = 0;
        let v2 = 0x2::balance::zero<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>();
        while (0x1::option::is_some<u64>(&v0)) {
            let v3 = *0x1::option::borrow<u64>(&v0);
            v0 = *0x2::linked_table::next<u64, u64>(&arg2.lp_to_unlock, v3);
            if (v3 <= arg5) {
                v1 = v1 + *0x2::linked_table::borrow<u64, u64>(&arg2.lp_to_unlock, v3);
                0x2::linked_table::remove<u64, u64>(&mut arg2.lp_to_unlock, v3);
            };
        };
        if (v1 > 0) {
            0x2::balance::join<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&mut arg0.available_lp_shares, 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::unlock_from_bee_box<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(arg1, &mut arg0.infusion_profile, 0, arg6));
            0x2::balance::join<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&mut v2, 0x2::balance::split<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&mut arg0.available_lp_shares, v1));
            arg2.claimed_lp_shares = arg2.claimed_lp_shares + v1;
        };
        v2
    }

    fun internal_extract_lps_for_staking<T0>(arg0: &mut InfusionVault<T0>) : 0x2::balance::Balance<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>> {
        assert!(0x2::balance::value<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&arg0.available_lp_shares) > 0, 5112);
        let v0 = 0x2::balance::withdraw_all<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&mut arg0.available_lp_shares);
        let v1 = 0x2::balance::value<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&v0);
        arg0.is_lp_staked = true;
        arg0.cur_lp_shares_staked = v1;
        let v2 = DegenSuiLpTokensStaked{shared_staked: v1};
        0x2::event::emit<DegenSuiLpTokensStaked>(v2);
        v0
    }

    fun is_deposit_open<T0>(arg0: u64, arg1: &InfusionVault<T0>) : bool {
        arg0 >= arg1.begin_timestamp && arg0 < arg1.begin_timestamp + arg1.deposit_window
    }

    fun kraft_user_position(arg0: &mut 0x2::tx_context::TxContext) : UserInfusionPosition {
        UserInfusionPosition{
            id                          : 0x2::object::new(arg0),
            hive_delegated              : 0,
            sui_delegated               : 0,
            sui_withdrawn_flag          : false,
            gems_claimable_for_infusion : 0,
            bees_claimable_for_infusion : 0,
            gems_claimed_flag           : false,
            user_lp_shares              : 0,
            unbonded_lp_shares          : 0,
            lp_to_unlock                : 0x2::linked_table::new<u64, u64>(arg0),
            claimed_lp_shares           : 0,
            burnt_for_tax               : 0,
            hive_per_share              : 0,
            gems_streamed_from_staking  : 0,
            bee_fruit_indexes           : 0x2::linked_table::new<0x1::ascii::String, u256>(arg0),
            total_bee_fruits_earned     : 0x2::linked_table::new<0x1::ascii::String, u128>(arg0),
            claimed_bees                : 0,
        }
    }

    public fun make_vote_on_proposal<T0, T1>(arg0: &0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::config::DegenHiveDeployerCap, arg1: &mut 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::PoolHive<T1>, arg2: &InfusionVault<T0>, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::castVote<T1>(arg1, &arg2.infusion_profile, arg3, arg4, arg5);
    }

    public fun query_infusion_vault_bees_metrics<T0>(arg0: 0x1::ascii::String, arg1: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager) : (u64, u256, 0x1::option::Option<address>, u64) {
        let v0 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_from_admin_profile<InfusionVault<T0>>(arg1, arg0);
        (0x2::balance::value<0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE>(&v0.bees_manager.bee_infusion_incentives), v0.bees_manager.bee_per_lp_share, v0.bees_manager.sui_bee_pool_addr, v0.bees_manager.sui_bee_lp_tokens_flamed)
    }

    public fun query_infusion_vault_pol_metrics<T0>(arg0: 0x1::ascii::String, arg1: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager) : (u64, u64, u64) {
        let v0 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_from_admin_profile<InfusionVault<T0>>(arg1, arg0);
        (v0.sui_hive_lp_tokens_flamed, v0.sui_dsui_lp_tokens_flamed, v0.bees_manager.sui_bee_lp_tokens_flamed)
    }

    public fun query_infusion_vault_state<T0>(arg0: 0x1::ascii::String, arg1: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager) : (u64, u64, u64, u64, u64, 0x1::option::Option<address>, u64, u64, u64, u64, u64, u64, u64, u64, bool, u256, u256) {
        let v0 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_from_admin_profile<InfusionVault<T0>>(arg1, arg0);
        (v0.begin_timestamp, v0.deposit_window, v0.withdrawal_window, v0.lp_tokens_vesting_duration, v0.total_hive_rewards, v0.sui_hive_pool_addr, 0x2::balance::value<T0>(&v0.available_sui_balance), 0x2::balance::value<0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE>(&v0.available_hive_balance), v0.total_hive_delegated, v0.total_sui_delegated, v0.pool_infusion_timestamp, 0x2::balance::value<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&v0.available_lp_shares), v0.total_lp_shares_krafted, v0.cur_lp_shares_staked, v0.is_lp_staked, v0.hive_per_share, v0.bees_manager.bee_per_lp_share)
    }

    public fun simulate_delegate_hive<T0>(arg0: &0x2::clock::Clock, arg1: 0x1::ascii::String, arg2: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg3: u64) : (u64, u64) {
        let v0 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_from_admin_profile<InfusionVault<T0>>(arg2, arg1);
        if (!is_deposit_open<T0>(0x2::clock::timestamp_ms(arg0), v0)) {
            return (0, 0)
        };
        let v1 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256((arg3 as u256), (10000000000 as u256), ((v0.total_hive_delegated + arg3) as u256)) as u256), ((v0.total_hive_rewards / 2) as u256), (10000000000 as u256));
        ((v1 as u64), ((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u128((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::total_bee_supply() as u128), ((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::percent_precision() - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::bees_for_streambuzz_profile_pct() - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::bees_for_treasury_pct() - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::genesis_bee_for_lp_pct()) as u128), (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::percent_precision() as u128)) as u64) as u256), (v1 as u256), (v0.total_hive_rewards as u256)) as u64) as u64))
    }

    public fun simulate_deposit_sui<T0>(arg0: 0x1::ascii::String, arg1: &0x2::clock::Clock, arg2: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg3: u64) : (u64, u64) {
        let v0 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_from_admin_profile<InfusionVault<T0>>(arg2, arg0);
        if (!is_deposit_open<T0>(0x2::clock::timestamp_ms(arg1), v0)) {
            return (0, 0)
        };
        let v1 = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256((arg3 as u256), (10000000000 as u256), ((arg3 + v0.total_sui_delegated) as u256)) as u256), ((v0.total_hive_rewards / 2) as u256), (10000000000 as u256));
        ((v1 as u64), ((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u128((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::total_bee_supply() as u128), ((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::percent_precision() - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::bees_for_streambuzz_profile_pct() - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::bees_for_treasury_pct() - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::genesis_bee_for_lp_pct()) as u128), (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::percent_precision() as u128)) as u64) as u256), (v1 as u256), (v0.total_hive_rewards as u256)) as u64) as u64))
    }

    public entry fun simulate_withdraw_sui<T0>(arg0: 0x1::ascii::String, arg1: &0x2::clock::Clock, arg2: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg3: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveProfile, arg4: u64) : (u64, u64, u64, bool) {
        let v0 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_from_admin_profile<InfusionVault<T0>>(arg2, arg0);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        if (v1 < v0.begin_timestamp || v1 > v0.begin_timestamp + v0.deposit_window + v0.withdrawal_window) {
            return (0, 0, 0, false)
        };
        let v2 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::get_hive_app_name(&v0.user_profile_access_cap);
        if (!0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::exists_for_profile(arg3, v2)) {
            return (0, 0, 0, false)
        };
        let v3 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_from_profile<UserInfusionPosition>(arg3, v2);
        let v4 = (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256((arg4 as u256), (10000000000 as u256), ((v0.total_sui_delegated - arg4) as u256)) as u256), ((v0.total_hive_rewards / 2) as u256), (10000000000 as u256)) as u64);
        (allowed_withdrawal_amount<T0>(v0, v1, v3.sui_delegated), v4, (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256(((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u128((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::total_bee_supply() as u128), ((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::percent_precision() - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::bees_for_streambuzz_profile_pct() - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::bees_for_treasury_pct() - 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::genesis_bee_for_lp_pct()) as u128), (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::percent_precision() as u128)) as u64) as u256), (v4 as u256), (v0.total_hive_rewards as u256)) as u64), v3.sui_withdrawn_flag)
    }

    public entry fun stake_lp_tokens_0_fruits<T0>(arg0: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::ManagerAppAccessCapability, arg1: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg2: &mut 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::PoolsGovernor, arg3: &mut 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::PoolHive<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_mut_from_manager_profile<InfusionVault<T0>>(arg0, arg1);
        let v1 = internal_extract_lps_for_staking<T0>(v0);
        0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::deposit_into_bee_box_0_fruits<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(arg2, arg3, &mut v0.infusion_profile, v1, arg4);
    }

    public entry fun stake_lp_tokens_one_fruits<T0, T1>(arg0: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::ManagerAppAccessCapability, arg1: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg2: &mut 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::PoolsGovernor, arg3: &mut 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::PoolHive<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_mut_from_manager_profile<InfusionVault<T0>>(arg0, arg1);
        let v1 = internal_extract_lps_for_staking<T0>(v0);
        0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<T1>(0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::deposit_into_bee_box_1_fruits<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>, T1>(arg2, arg3, &mut v0.infusion_profile, v1, arg4), 0x2::tx_context::sender(arg4), arg4);
    }

    public entry fun stake_lp_tokens_three_fruits<T0, T1, T2, T3>(arg0: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::ManagerAppAccessCapability, arg1: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg2: &mut 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::PoolsGovernor, arg3: &mut 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::PoolHive<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_mut_from_manager_profile<InfusionVault<T0>>(arg0, arg1);
        let v1 = internal_extract_lps_for_staking<T0>(v0);
        let (v2, v3, v4) = 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::deposit_into_bee_box_3_fruits<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>, T1, T2, T3>(arg2, arg3, &mut v0.infusion_profile, v1, arg4);
        0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<T1>(v2, 0x2::tx_context::sender(arg4), arg4);
        0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<T2>(v3, 0x2::tx_context::sender(arg4), arg4);
        0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<T3>(v4, 0x2::tx_context::sender(arg4), arg4);
    }

    public entry fun stake_lp_tokens_two_fruits<T0, T1, T2>(arg0: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::ManagerAppAccessCapability, arg1: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg2: &mut 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::PoolsGovernor, arg3: &mut 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::PoolHive<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_mut_from_manager_profile<InfusionVault<T0>>(arg0, arg1);
        let v1 = internal_extract_lps_for_staking<T0>(v0);
        let (v2, v3) = 0x66bb60cbd5b08382010f2059134fd5bc0090b302191b76603cf80d4bc20031da::dex_dao::deposit_into_bee_box_2_fruits<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>, T1, T2>(arg2, arg3, &mut v0.infusion_profile, v1, arg4);
        0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<T1>(v2, 0x2::tx_context::sender(arg4), arg4);
        0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<T2>(v3, 0x2::tx_context::sender(arg4), arg4);
    }

    public entry fun testnet_infuse_sui_hive_pool<T0>(arg0: &0x2::clock::Clock, arg1: &0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::config::HiveEntryCap, arg2: &mut 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HiveVault, arg3: &mut 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::HiveManager, arg4: 0x2::coin::TreasuryCap<0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE>, arg5: &mut 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut 0x2::coin::Coin<0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE>, arg8: u64, arg9: &0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::ManagerAppAccessCapability, arg10: &mut 0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LiquidityPool<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>, arg11: &mut 0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LiquidityPool<T0, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>, arg12: &mut 0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::PoolRegistry, arg13: &mut 0x2039d95404fdbee97e6694b70dbddc99dfd168285b0c4c466efd4440f61800a8::three_pool::PoolRegistry, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xda71a87cdda0159bebb56d2f79eb2806468ad0a57dd0be70f64b2c020514a7a2::hive_profile::borrow_mut_from_manager_profile<InfusionVault<T0>>(arg9, arg3);
        let v1 = 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg5, arg6, arg14));
        let v2 = 0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::add_liquidity<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>(arg0, arg10, 0x2::balance::split<T0>(&mut v1, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u128((0x2::balance::value<T0>(&v1) as u128), (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::sui_for_hive_pool() as u128), (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::percent_precision() as u128))), 0x2::coin::into_balance<0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE>(0x2::coin::split<0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE>(arg7, arg8, arg14)), 0);
        let v3 = 0x2::balance::value<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&v2);
        0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(v2, 0x2::tx_context::sender(arg14), arg14);
        let v4 = 0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::bee_trade::kraft_genesis_bees<T0>(arg2, arg4, arg14);
        let v5 = 0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::add_liquidity<T0, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>(arg0, arg11, v1, 0x2::balance::split<0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE>(&mut v4, (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u128((0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::get_total_bee_Supply() as u128), (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::genesis_bee_for_lp_pct() as u128), (0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::constants::percent_precision() as u128)) as u64)), 0);
        0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::coin_helper::destroy_or_transfer_balance<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(v5, 0x2::tx_context::sender(arg14), arg14);
        0x2::balance::join<0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE>(&mut v0.bees_manager.bee_infusion_incentives, v4);
        v0.bees_manager.bee_per_lp_share = 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::math::mul_div_u256((0x2::balance::value<0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE>(&v4) as u256), (10000000000 as u256), (v3 as u256));
        v0.pool_infusion_timestamp = 0x2::clock::timestamp_ms(arg0);
        let v6 = InfusionPhaseOver<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>{
            hive_sui_lp_shares          : v3,
            total_hive_sui_lp_shares    : v3,
            krafted_sui_bee_lp_balance  : 0x2::balance::value<0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::LP<T0, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::bee::BEE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(&v5),
            bee_for_infusion_incentives : 0,
            bee_per_lp_share            : 0,
        };
        0x2::event::emit<InfusionPhaseOver<T0, 0x8f6211b71fa5136769e20f943a620bf92d05adb9f9ad1fe88e07e9ba69ff4e4d::hive::HIVE, 0x6464d2aac437e111ca64daad649b7407de6c8901a84e641a8a0c2e95d5c89a7a::curves::Curved>>(v6);
        0x12ed84ba987fd665126517bbd3eeff2f33361f8bad0722f315c1c6939cfbfd44::two_pool::enable_public_pools(arg1, arg12);
        0x2039d95404fdbee97e6694b70dbddc99dfd168285b0c4c466efd4440f61800a8::three_pool::enable_public_pools(arg1, arg13);
    }

    fun verification_and_update_states<T0>(arg0: u64, arg1: &InfusionVault<T0>, arg2: &mut UserInfusionPosition, arg3: bool, arg4: bool) : u64 {
        assert!(arg2.hive_delegated > 0 || arg2.sui_delegated > 0, 5114);
        assert!(arg1.total_lp_shares_krafted > 0, 5112);
        if (arg2.user_lp_shares == 0) {
            arg2.user_lp_shares = calculate_user_lp_shares<T0>(arg1, arg2);
            let (v0, v1) = calculate_user_hive_incentives<T0>(arg1, arg2);
            arg2.gems_claimable_for_infusion = v0;
            arg2.bees_claimable_for_infusion = v1;
        };
        let v2 = 0;
        if (arg3) {
            v2 = calculate_unbondable_lp_shares<T0>(arg0, arg1, arg2, arg4);
        };
        v2
    }

    // decompiled from Move bytecode v6
}

