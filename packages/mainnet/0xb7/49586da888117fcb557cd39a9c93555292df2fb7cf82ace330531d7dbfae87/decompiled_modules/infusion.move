module 0xb749586da888117fcb557cd39a9c93555292df2fb7cf82ace330531d7dbfae87::infusion {
    struct InfusionVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        user_profile_access_cap: 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::ProfileDofOwnershipCapability,
        begin_timestamp: u64,
        deposit_window: u64,
        withdrawal_window: u64,
        lp_tokens_vesting_duration: u64,
        infusion_profile: 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveProfile,
        total_gems_rewards: u64,
        x_hive_pool_addr: 0x1::option::Option<address>,
        available_usdc_balance: 0x2::balance::Balance<T0>,
        available_hive_balance: 0x2::balance::Balance<0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE>,
        total_hive_delegated: u64,
        total_usdc_delegated: u64,
        pool_infusion_timestamp: u64,
        available_lp_shares: 0x2::balance::Balance<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>,
        total_lp_shares_krafted: u64,
        cur_lp_shares_staked: u64,
        is_lp_staked: bool,
        hive_gems_per_share: u256,
        bee_fruit_indexes: 0x2::linked_table::LinkedTable<0x1::ascii::String, u256>,
        last_pol_claim_timestamp: u64,
        available_pol_shares: 0x2::balance::Balance<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>,
        pol_tokens_per_usdc: u256,
        total_pol_lp_streamed: u64,
        pol_tokens_distributed: u64,
        igems_kraft_cap: 0x2::coin::TreasuryCap<0xb749586da888117fcb557cd39a9c93555292df2fb7cf82ace330531d7dbfae87::igems::IGEMS>,
        available_igems: 0x2::balance::Balance<0xb749586da888117fcb557cd39a9c93555292df2fb7cf82ace330531d7dbfae87::igems::IGEMS>,
        pol_tokens_flamed: u64,
        igems_per_share: u256,
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
        usdc_delegated: u64,
        usdc_withdrawn_flag: bool,
        gems_claimable_for_infusion: u64,
        gems_claimed_flag: bool,
        user_lp_shares: u64,
        unbonded_lp_shares: u64,
        lp_to_unlock: 0x2::linked_table::LinkedTable<u64, u64>,
        claimed_lp_shares: u64,
        hive_gems_per_share: u256,
        gems_streamed_from_staking: u64,
        bee_fruit_indexes: 0x2::linked_table::LinkedTable<0x1::ascii::String, u256>,
        total_bee_fruits_earned: 0x2::linked_table::LinkedTable<0x1::ascii::String, u128>,
        pol_tokens_per_usdc: u256,
        claimed_pol_tokens: u64,
        igems_per_share: u256,
        claimed_igems: u64,
    }

    struct InfusionVaultInitialized has copy, drop {
        vault_addr: address,
    }

    struct InfusedHiveForInfusionPhase has copy, drop {
        hive_gems_incentives: u64,
    }

    struct DepositUsdcForInfusion has copy, drop {
        user: address,
        username: 0x1::string::String,
        profile_addr: address,
        user_position_id: address,
        usdc_deposited: u64,
        total_usdc_deposited_by_user: u64,
    }

    struct WithdrawUsdcFromInfusion has copy, drop {
        user: address,
        username: 0x1::string::String,
        profile_addr: address,
        user_position_id: address,
        usdc_withdrawn: u64,
        total_usdc_deposited_by_user: u64,
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

    struct HiveUsdcPoolInitialized<phantom T0, phantom T1, phantom T2> has copy, drop {
        hive_usdc_lp_shares: u64,
        total_hive_usdc_lp_shares: u64,
    }

    struct HiveUsdcLpTokensStaked has copy, drop {
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
        pol_rewards_for_user: u64,
        igems_for_user: u64,
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

    public fun claim_pol_from_streamer_buzz<T0>(arg0: &0x2::clock::Clock, arg1: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::HiveEntryCap, arg2: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::AdminDofOwnershipCapability, arg3: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg4: &mut 0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::PoolRegistry, arg5: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HiveVault, arg6: &mut 0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LiquidityPool<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_manager_borrow_mut_from_profile<InfusionVault<T0>>(arg2, arg3);
        let v2 = 0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::claim_pol_from_streamer_buzz<T0, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>(arg0, arg1, arg4, arg5, arg6, arg7);
        let v3 = 0x2::balance::value<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&v2);
        v1.last_pol_claim_timestamp = v0;
        v1.total_pol_lp_streamed = v1.total_pol_lp_streamed + v3;
        let v4 = 0;
        let v5 = 0;
        if (v0 < v1.pool_infusion_timestamp + v1.lp_tokens_vesting_duration) {
            v1.pol_tokens_per_usdc = v1.pol_tokens_per_usdc + 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((v3 as u256), (10000000000 as u256), (v1.total_usdc_delegated as u256));
            0x2::balance::join<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&mut v1.available_pol_shares, v2);
            v1.pol_tokens_distributed = v1.pol_tokens_distributed + v3;
            v4 = v3;
        } else {
            let v6 = 0x2::coin::mint_balance<0xb749586da888117fcb557cd39a9c93555292df2fb7cf82ace330531d7dbfae87::igems::IGEMS>(&mut v1.igems_kraft_cap, 1000000 * v3);
            let v7 = 0x2::balance::value<0xb749586da888117fcb557cd39a9c93555292df2fb7cf82ace330531d7dbfae87::igems::IGEMS>(&v6);
            v5 = v7;
            v1.igems_per_share = v1.igems_per_share + 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((v7 as u256), (10000000000 as u256), ((v1.total_lp_shares_krafted + v1.pol_tokens_distributed) as u256));
            v1.pol_tokens_flamed = v1.pol_tokens_flamed + v3;
            0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::dangerous_burn_lp_coins<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>(arg6, v2);
            0x2::balance::join<0xb749586da888117fcb557cd39a9c93555292df2fb7cf82ace330531d7dbfae87::igems::IGEMS>(&mut v1.available_igems, v6);
        };
        (v3, v4, v5)
    }

    public fun lock_in_x_hive_pool_addr<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::HiveEntryCap, arg2: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::AdminDofOwnershipCapability, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg5: &mut 0x9b98e5056b3bdcc865dcbd194d38aabb5c6a2c8e5d7dbd12e8fc2e6719767a85::hsui_vault::HSuiVault, arg6: &mut 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::Config, arg7: &mut 0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::PoolRegistry, arg8: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HSuiDisperser<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg9: 0x2::balance::Balance<0x2::sui::SUI>, arg10: &0x2::coin::CoinMetadata<T0>, arg11: &0x2::coin::CoinMetadata<T1>, arg12: vector<u64>, arg13: 0x1::option::Option<vector<u256>>, arg14: 0x1::option::Option<vector<u64>>, arg15: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_manager_borrow_mut_from_profile<InfusionVault<T0>>(arg2, arg4);
        assert!(0x1::option::is_none<address>(&v0.x_hive_pool_addr), 5103);
        let v1 = 0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::lock_in_x_hive_pool_addr<T0, T1, T2>(arg0, arg1, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        v0.x_hive_pool_addr = 0x1::option::some<address>(v1);
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
            (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((arg2 as u256), ((v2 - arg1) as u256), ((v2 - v1) as u256)) as u64)
        } else {
            0
        }
    }

    fun calculate_igems_user_meme<T0>(arg0: &InfusionVault<T0>, arg1: &UserInfusionPosition) : u64 {
        if (arg0.igems_per_share <= arg1.igems_per_share) {
            return 0
        };
        (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256(((arg0.igems_per_share - arg1.igems_per_share) as u256), ((arg1.user_lp_shares + arg1.claimed_pol_tokens) as u256), (10000000000 as u256)) as u64)
    }

    fun calculate_pol_lp_rewards<T0>(arg0: &InfusionVault<T0>, arg1: &UserInfusionPosition) : u64 {
        if (arg0.pol_tokens_per_usdc <= arg1.pol_tokens_per_usdc) {
            return 0
        };
        (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256(((arg0.pol_tokens_per_usdc - arg1.pol_tokens_per_usdc) as u256), (arg1.usdc_delegated as u256), (10000000000 as u256)) as u64)
    }

    fun calculate_unbondable_lp_shares<T0>(arg0: u64, arg1: &InfusionVault<T0>, arg2: &UserInfusionPosition) : u64 {
        let v0 = arg0 - arg1.pool_infusion_timestamp;
        if (v0 >= arg1.lp_tokens_vesting_duration) {
            arg2.user_lp_shares - arg2.unbonded_lp_shares
        } else {
            let v2 = (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((arg2.user_lp_shares as u256), (v0 as u256), (arg1.lp_tokens_vesting_duration as u256)) as u64);
            assert!(v2 >= arg2.unbonded_lp_shares, 5113);
            v2 - arg2.unbonded_lp_shares
        }
    }

    fun calculate_user_hive_incentives<T0>(arg0: &InfusionVault<T0>, arg1: &UserInfusionPosition) : u64 {
        ((0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((arg1.usdc_delegated as u256), (10000000000 as u256), (arg0.total_usdc_delegated as u256)) as u256), ((arg0.total_gems_rewards / 2) as u256), (10000000000 as u256)) + 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((arg1.hive_delegated as u256), (10000000000 as u256), (arg0.total_hive_delegated as u256)) as u256), ((arg0.total_gems_rewards / 2) as u256), (10000000000 as u256))) as u64)
    }

    fun calculate_user_lp_shares<T0>(arg0: &InfusionVault<T0>, arg1: &UserInfusionPosition) : u64 {
        ((0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((arg1.hive_delegated as u256), (10000000000 as u256), (arg0.total_hive_delegated as u256)) as u256), ((arg0.total_lp_shares_krafted / 2) as u256), (10000000000 as u256)) + 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((arg1.usdc_delegated as u256), (10000000000 as u256), (arg0.total_usdc_delegated as u256)) as u256), ((arg0.total_lp_shares_krafted / 2) as u256), (10000000000 as u256))) as u64)
    }

    fun claim_gems_and_increment_states<T0>(arg0: &mut InfusionVault<T0>, arg1: &mut UserInfusionPosition, arg2: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveProfile, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        arg0.hive_gems_per_share = arg0.hive_gems_per_share + 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256(((arg4 - arg3) as u256), (10000000000 as u256), (arg0.cur_lp_shares_staked as u256));
        let v0 = (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256(arg0.hive_gems_per_share - arg1.hive_gems_per_share, ((arg1.user_lp_shares - arg1.unbonded_lp_shares) as u256), (10000000000 as u256)) as u64);
        0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::transfer_hive_gems(&mut arg0.infusion_profile, arg2, v0, arg5);
        arg1.hive_gems_per_share = arg0.hive_gems_per_share;
        arg1.gems_streamed_from_staking = arg1.gems_streamed_from_staking + v0;
        let v1 = 0;
        if (!arg1.gems_claimed_flag) {
            0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::transfer_hive_gems(&mut arg0.infusion_profile, arg2, arg1.gems_claimable_for_infusion, arg5);
            arg1.gems_claimed_flag = true;
            v1 = arg1.gems_claimable_for_infusion;
        };
        (v0, v1)
    }

    public fun claim_rewards_and_shares_0_fruits<T0>(arg0: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::AdminDofOwnershipCapability, arg1: &0x2::clock::Clock, arg2: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg3: &mut 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::PoolsGovernor, arg4: &mut 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::PoolHive<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>, arg5: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveProfile, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::tx_context::epoch(arg7);
        let (_, _, _, v4, _, _) = 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::get_pools_governor(arg3);
        let v7 = v0 + v4;
        let v8 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_manager_borrow_mut_from_profile<InfusionVault<T0>>(arg0, arg2);
        let v9 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_remove_from_profile<UserInfusionPosition>(&v8.user_profile_access_cap, arg5, arg7);
        let (v10, v11, _, v13) = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::get_profile_meta_info(arg5);
        assert!(v13 == 0x2::tx_context::sender(arg7), 5115);
        let v14 = &mut v9;
        let v15 = verification_and_update_states<T0>(0x2::clock::timestamp_ms(arg1), v8, v14, arg6);
        let v16 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::get_available_gems_in_profile(&v8.infusion_profile);
        0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::unbond_from_bee_box_no_fruit<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(arg3, arg4, &mut v8.infusion_profile, v15, arg7);
        let v17 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::get_available_gems_in_profile(&v8.infusion_profile);
        let v18 = &mut v9;
        let (v19, v20) = claim_gems_and_increment_states<T0>(v8, v18, arg5, v16, v17, arg7);
        let v21 = &mut v9;
        let (v22, v23, v24) = internal_claim_lps_igems<T0>(v8, arg4, v21, v15, v7, v0, arg7);
        let v25 = v24;
        let v26 = v23;
        let v27 = v22;
        let v28 = 0x2::balance::value<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&v27);
        let v29 = 0x2::balance::value<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&v26);
        let v30 = 0x2::balance::value<0xb749586da888117fcb557cd39a9c93555292df2fb7cf82ace330531d7dbfae87::igems::IGEMS>(&v25);
        0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_add_to_profile<UserInfusionPosition>(&v8.user_profile_access_cap, arg5, v9, arg7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(v27, 0x2::tx_context::sender(arg7), arg7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(v26, 0x2::tx_context::sender(arg7), arg7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<0xb749586da888117fcb557cd39a9c93555292df2fb7cf82ace330531d7dbfae87::igems::IGEMS>(v25, 0x2::tx_context::sender(arg7), arg7);
        let v31 = UserClaimedInfusionRewards{
            username                             : v11,
            profile_addr                         : v10,
            unbond_lp_shares_amt                 : v15,
            unlock_epoch                         : v7,
            gems_via_staking_yield               : v19,
            hive_incentives_for_infusion_claimed : v20,
            unlocked_lp_shares                   : v28,
            pol_rewards_for_user                 : v29,
            igems_for_user                       : v30,
        };
        0x2::event::emit<UserClaimedInfusionRewards>(v31);
        (v15, v19, v20, v28, v29, v30)
    }

    public fun claim_rewards_and_shares_1_fruits<T0, T1>(arg0: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::AdminDofOwnershipCapability, arg1: &0x2::clock::Clock, arg2: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg3: &mut 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::PoolsGovernor, arg4: &mut 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::PoolHive<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>, arg5: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveProfile, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::tx_context::epoch(arg7);
        let (_, _, _, v4, _, _) = 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::get_pools_governor(arg3);
        let v7 = v0 + v4;
        let v8 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_manager_borrow_mut_from_profile<InfusionVault<T0>>(arg0, arg2);
        let v9 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_remove_from_profile<UserInfusionPosition>(&v8.user_profile_access_cap, arg5, arg7);
        let (v10, v11, _, v13) = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::get_profile_meta_info(arg5);
        assert!(v13 == 0x2::tx_context::sender(arg7), 5115);
        let v14 = &mut v9;
        let v15 = verification_and_update_states<T0>(0x2::clock::timestamp_ms(arg1), v8, v14, arg6);
        let v16 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::get_available_gems_in_profile(&v8.infusion_profile);
        let v17 = 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::unbond_from_bee_box_1_fruit<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>, T1>(arg3, arg4, &mut v8.infusion_profile, v15, arg7);
        let v18 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::get_available_gems_in_profile(&v8.infusion_profile);
        let v19 = &mut v9;
        let (v20, v21) = claim_gems_and_increment_states<T0>(v8, v19, arg5, v16, v18, arg7);
        let v22 = &mut v9;
        let v23 = increment_bee_fruit_indexes<T0, T1>(v11, v8, v22, v17, arg7);
        let v24 = &mut v9;
        let (v25, v26, v27) = internal_claim_lps_igems<T0>(v8, arg4, v24, v15, v7, v0, arg7);
        let v28 = v27;
        let v29 = v26;
        let v30 = v25;
        let v31 = 0x2::balance::value<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&v30);
        let v32 = 0x2::balance::value<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&v29);
        let v33 = 0x2::balance::value<0xb749586da888117fcb557cd39a9c93555292df2fb7cf82ace330531d7dbfae87::igems::IGEMS>(&v28);
        0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_add_to_profile<UserInfusionPosition>(&v8.user_profile_access_cap, arg5, v9, arg7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(v30, 0x2::tx_context::sender(arg7), arg7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(v29, 0x2::tx_context::sender(arg7), arg7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<0xb749586da888117fcb557cd39a9c93555292df2fb7cf82ace330531d7dbfae87::igems::IGEMS>(v28, 0x2::tx_context::sender(arg7), arg7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<T1>(v23, 0x2::tx_context::sender(arg7), arg7);
        let v34 = UserClaimedInfusionRewards{
            username                             : v11,
            profile_addr                         : v10,
            unbond_lp_shares_amt                 : v15,
            unlock_epoch                         : v7,
            gems_via_staking_yield               : v20,
            hive_incentives_for_infusion_claimed : v21,
            unlocked_lp_shares                   : v31,
            pol_rewards_for_user                 : v32,
            igems_for_user                       : v33,
        };
        0x2::event::emit<UserClaimedInfusionRewards>(v34);
        (v15, v20, v21, v31, v32, v33, 0x2::balance::value<T1>(&v23))
    }

    public fun claim_rewards_and_shares_2_fruits<T0, T1, T2>(arg0: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::AdminDofOwnershipCapability, arg1: &0x2::clock::Clock, arg2: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg3: &mut 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::PoolsGovernor, arg4: &mut 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::PoolHive<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>, arg5: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveProfile, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::tx_context::epoch(arg7);
        let (_, _, _, v4, _, _) = 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::get_pools_governor(arg3);
        let v7 = v0 + v4;
        let v8 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_manager_borrow_mut_from_profile<InfusionVault<T0>>(arg0, arg2);
        let v9 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_remove_from_profile<UserInfusionPosition>(&v8.user_profile_access_cap, arg5, arg7);
        let (v10, v11, _, v13) = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::get_profile_meta_info(arg5);
        assert!(v13 == 0x2::tx_context::sender(arg7), 5115);
        let v14 = &mut v9;
        let v15 = verification_and_update_states<T0>(0x2::clock::timestamp_ms(arg1), v8, v14, arg6);
        let v16 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::get_available_gems_in_profile(&v8.infusion_profile);
        let (v17, v18) = 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::unbond_from_bee_box_2_fruits<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>, T1, T2>(arg3, arg4, &mut v8.infusion_profile, v15, arg7);
        let v19 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::get_available_gems_in_profile(&v8.infusion_profile);
        let v20 = &mut v9;
        let (v21, v22) = claim_gems_and_increment_states<T0>(v8, v20, arg5, v16, v19, arg7);
        let v23 = &mut v9;
        let v24 = increment_bee_fruit_indexes<T0, T1>(v11, v8, v23, v17, arg7);
        let v25 = &mut v9;
        let v26 = increment_bee_fruit_indexes<T0, T2>(v11, v8, v25, v18, arg7);
        let v27 = &mut v9;
        let (v28, v29, v30) = internal_claim_lps_igems<T0>(v8, arg4, v27, v15, v7, v0, arg7);
        let v31 = v30;
        let v32 = v29;
        let v33 = v28;
        let v34 = 0x2::balance::value<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&v33);
        let v35 = 0x2::balance::value<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&v32);
        let v36 = 0x2::balance::value<0xb749586da888117fcb557cd39a9c93555292df2fb7cf82ace330531d7dbfae87::igems::IGEMS>(&v31);
        0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_add_to_profile<UserInfusionPosition>(&v8.user_profile_access_cap, arg5, v9, arg7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(v33, 0x2::tx_context::sender(arg7), arg7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(v32, 0x2::tx_context::sender(arg7), arg7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<0xb749586da888117fcb557cd39a9c93555292df2fb7cf82ace330531d7dbfae87::igems::IGEMS>(v31, 0x2::tx_context::sender(arg7), arg7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<T1>(v24, 0x2::tx_context::sender(arg7), arg7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<T2>(v26, 0x2::tx_context::sender(arg7), arg7);
        let v37 = UserClaimedInfusionRewards{
            username                             : v11,
            profile_addr                         : v10,
            unbond_lp_shares_amt                 : v15,
            unlock_epoch                         : v7,
            gems_via_staking_yield               : v21,
            hive_incentives_for_infusion_claimed : v22,
            unlocked_lp_shares                   : v34,
            pol_rewards_for_user                 : v35,
            igems_for_user                       : v36,
        };
        0x2::event::emit<UserClaimedInfusionRewards>(v37);
        (v15, v21, v22, v34, v35, v36, 0x2::balance::value<T1>(&v24), 0x2::balance::value<T2>(&v26))
    }

    public fun claim_rewards_and_shares_3_fruits<T0, T1, T2, T3>(arg0: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::AdminDofOwnershipCapability, arg1: &0x2::clock::Clock, arg2: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg3: &mut 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::PoolsGovernor, arg4: &mut 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::PoolHive<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>, arg5: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveProfile, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64, u64, u64, u64, u64) {
        let v0 = 0x2::tx_context::epoch(arg7);
        let (_, _, _, v4, _, _) = 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::get_pools_governor(arg3);
        let v7 = v0 + v4;
        let v8 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_manager_borrow_mut_from_profile<InfusionVault<T0>>(arg0, arg2);
        let v9 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_remove_from_profile<UserInfusionPosition>(&v8.user_profile_access_cap, arg5, arg7);
        let (v10, v11, _, v13) = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::get_profile_meta_info(arg5);
        assert!(v13 == 0x2::tx_context::sender(arg7), 5115);
        let v14 = &mut v9;
        let v15 = verification_and_update_states<T0>(0x2::clock::timestamp_ms(arg1), v8, v14, arg6);
        let v16 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::get_available_gems_in_profile(&v8.infusion_profile);
        let (v17, v18, v19) = 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::unbond_from_bee_box_3_fruits<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>, T1, T2, T3>(arg3, arg4, &mut v8.infusion_profile, v15, arg7);
        let v20 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::get_available_gems_in_profile(&v8.infusion_profile);
        let v21 = &mut v9;
        let (v22, v23) = claim_gems_and_increment_states<T0>(v8, v21, arg5, v16, v20, arg7);
        let v24 = &mut v9;
        let v25 = increment_bee_fruit_indexes<T0, T1>(v11, v8, v24, v17, arg7);
        let v26 = &mut v9;
        let v27 = increment_bee_fruit_indexes<T0, T2>(v11, v8, v26, v18, arg7);
        let v28 = &mut v9;
        let v29 = increment_bee_fruit_indexes<T0, T3>(v11, v8, v28, v19, arg7);
        let v30 = &mut v9;
        let (v31, v32, v33) = internal_claim_lps_igems<T0>(v8, arg4, v30, v15, v7, v0, arg7);
        let v34 = v33;
        let v35 = v32;
        let v36 = v31;
        let v37 = 0x2::balance::value<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&v36);
        let v38 = 0x2::balance::value<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&v35);
        let v39 = 0x2::balance::value<0xb749586da888117fcb557cd39a9c93555292df2fb7cf82ace330531d7dbfae87::igems::IGEMS>(&v34);
        0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_add_to_profile<UserInfusionPosition>(&v8.user_profile_access_cap, arg5, v9, arg7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(v36, 0x2::tx_context::sender(arg7), arg7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(v35, 0x2::tx_context::sender(arg7), arg7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<0xb749586da888117fcb557cd39a9c93555292df2fb7cf82ace330531d7dbfae87::igems::IGEMS>(v34, 0x2::tx_context::sender(arg7), arg7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<T1>(v25, 0x2::tx_context::sender(arg7), arg7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<T2>(v27, 0x2::tx_context::sender(arg7), arg7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<T3>(v29, 0x2::tx_context::sender(arg7), arg7);
        let v40 = UserClaimedInfusionRewards{
            username                             : v11,
            profile_addr                         : v10,
            unbond_lp_shares_amt                 : v15,
            unlock_epoch                         : v7,
            gems_via_staking_yield               : v22,
            hive_incentives_for_infusion_claimed : v23,
            unlocked_lp_shares                   : v37,
            pol_rewards_for_user                 : v38,
            igems_for_user                       : v39,
        };
        0x2::event::emit<UserClaimedInfusionRewards>(v40);
        (v15, v22, v23, v37, v38, v39, 0x2::balance::value<T1>(&v25), 0x2::balance::value<T2>(&v27), 0x2::balance::value<T3>(&v29))
    }

    public fun delegate_hive_airdrop<T0>(arg0: &0x2::clock::Clock, arg1: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::AdminDofOwnershipCapability, arg2: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::AdminDofOwnershipCapability, arg3: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg4: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveProfile, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0xf0c3e78a5b1a84502a19e6c84eebe0f783e77a4dfa8b93a74b01040ef0084a07::airdrop::delegate_hive_for_infusion(arg2, arg3, arg4, arg5, arg6);
        let v1 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_manager_borrow_mut_from_profile<InfusionVault<T0>>(arg1, arg3);
        0x2::clock::timestamp_ms(arg0);
        let (v2, v3, _, _) = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::get_profile_meta_info(arg4);
        let v6 = if (0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::exists_for_profile(arg4, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::get_profile_dof_capability_identifier(&v1.user_profile_access_cap))) {
            0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_remove_from_profile<UserInfusionPosition>(&v1.user_profile_access_cap, arg4, arg6)
        } else {
            kraft_user_position(arg6)
        };
        v1.total_hive_delegated = v1.total_hive_delegated + arg5;
        v6.hive_delegated = v6.hive_delegated + arg5;
        0x2::balance::join<0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE>(&mut v1.available_hive_balance, v0);
        let v7 = HiveDelegatedFromAirdrop{
            user                         : 0x2::tx_context::sender(arg6),
            username                     : v3,
            profile_addr                 : v2,
            user_position_id             : 0x2::object::uid_to_address(&v6.id),
            hive_delegated               : arg5,
            total_hive_delegated_by_user : v6.hive_delegated,
        };
        0x2::event::emit<HiveDelegatedFromAirdrop>(v7);
        let v8 = calculate_user_hive_incentives<T0>(v1, &v6);
        0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_add_to_profile<UserInfusionPosition>(&v1.user_profile_access_cap, arg4, v6, arg6);
        (v8 - calculate_user_hive_incentives<T0>(v1, &v6), v8)
    }

    public entry fun delegate_hive_from_lockdrop<T0>(arg0: &0x2::clock::Clock, arg1: &0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::config::HiveEntryCap, arg2: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::AdminDofOwnershipCapability, arg3: &0xf1a306f0f19d715f0dcd04515dbb57104b3dd2ae2cec8c4d31d058d4efb7ea8b::lockdrop::LockdropRewardsCapabilityHolder, arg4: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg5: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveProfile, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0xf1a306f0f19d715f0dcd04515dbb57104b3dd2ae2cec8c4d31d058d4efb7ea8b::lockdrop::delegate_hive_for_infusion(arg1, arg3, arg5, arg6, arg7);
        let v1 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_manager_borrow_mut_from_profile<InfusionVault<T0>>(arg2, arg4);
        0x2::clock::timestamp_ms(arg0);
        let (v2, v3, _, _) = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::get_profile_meta_info(arg5);
        let v6 = if (0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::exists_for_profile(arg5, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::get_profile_dof_capability_identifier(&v1.user_profile_access_cap))) {
            0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_remove_from_profile<UserInfusionPosition>(&v1.user_profile_access_cap, arg5, arg7)
        } else {
            kraft_user_position(arg7)
        };
        v1.total_hive_delegated = v1.total_hive_delegated + arg6;
        v6.hive_delegated = v6.hive_delegated + arg6;
        0x2::balance::join<0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE>(&mut v1.available_hive_balance, v0);
        let v7 = HiveDelegatedFromLockdrop{
            user                         : 0x2::tx_context::sender(arg7),
            username                     : v3,
            profile_addr                 : v2,
            user_position_id             : 0x2::object::uid_to_address(&v6.id),
            hive_delegated               : arg6,
            total_hive_delegated_by_user : v6.hive_delegated,
        };
        0x2::event::emit<HiveDelegatedFromLockdrop>(v7);
        let v8 = calculate_user_hive_incentives<T0>(v1, &v6);
        0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_add_to_profile<UserInfusionPosition>(&v1.user_profile_access_cap, arg5, v6, arg7);
        (v8 - calculate_user_hive_incentives<T0>(v1, &v6), v8)
    }

    public entry fun deposit_usdc<T0>(arg0: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::AdminDofOwnershipCapability, arg1: &0x2::clock::Clock, arg2: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg3: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveProfile, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_manager_borrow_mut_from_profile<InfusionVault<T0>>(arg0, arg2);
        0x2::clock::timestamp_ms(arg1);
        let (v1, v2, _, v4) = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::get_profile_meta_info(arg3);
        assert!(v4 == 0x2::tx_context::sender(arg6), 5115);
        let v5 = if (0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::exists_for_profile(arg3, 0x1::string::to_ascii(0x1::string::utf8(b"HIVE_INFUSION_CAP")))) {
            0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_remove_from_profile<UserInfusionPosition>(&v0.user_profile_access_cap, arg3, arg6)
        } else {
            kraft_user_position(arg6)
        };
        v0.total_usdc_delegated = v0.total_usdc_delegated + arg5;
        v5.usdc_delegated = v5.usdc_delegated + arg5;
        let v6 = 0x2::coin::into_balance<T0>(arg4);
        0x2::balance::join<T0>(&mut v0.available_usdc_balance, 0x2::balance::split<T0>(&mut v6, arg5));
        let v7 = DepositUsdcForInfusion{
            user                         : 0x2::tx_context::sender(arg6),
            username                     : v2,
            profile_addr                 : v1,
            user_position_id             : 0x2::object::uid_to_address(&v5.id),
            usdc_deposited               : arg5,
            total_usdc_deposited_by_user : v5.usdc_delegated,
        };
        0x2::event::emit<DepositUsdcForInfusion>(v7);
        let v8 = calculate_user_hive_incentives<T0>(v0, &v5);
        0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_add_to_profile<UserInfusionPosition>(&v0.user_profile_access_cap, arg3, v5, arg6);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<T0>(v6, 0x2::tx_context::sender(arg6), arg6);
        (v8 - calculate_user_hive_incentives<T0>(v0, &v5), v8)
    }

    public entry fun handle_withdraw_usdc<T0>(arg0: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::AdminDofOwnershipCapability, arg1: &0x2::clock::Clock, arg2: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg3: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveProfile, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_manager_borrow_mut_from_profile<InfusionVault<T0>>(arg0, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let (v2, v3, _, v5) = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::get_profile_meta_info(arg3);
        let v6 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_remove_from_profile<UserInfusionPosition>(&v0.user_profile_access_cap, arg3, arg5);
        allowed_withdrawal_amount<T0>(v0, v1, v6.usdc_delegated);
        if (v1 >= v0.begin_timestamp + v0.deposit_window) {
            v6.usdc_withdrawn_flag = true;
        };
        v0.total_usdc_delegated = v0.total_usdc_delegated - arg4;
        v6.usdc_delegated = v6.usdc_delegated - arg4;
        let v7 = WithdrawUsdcFromInfusion{
            user                         : 0x2::tx_context::sender(arg5),
            username                     : v3,
            profile_addr                 : v2,
            user_position_id             : 0x2::object::uid_to_address(&v6.id),
            usdc_withdrawn               : arg4,
            total_usdc_deposited_by_user : v6.usdc_delegated,
        };
        0x2::event::emit<WithdrawUsdcFromInfusion>(v7);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<T0>(0x2::balance::split<T0>(&mut v0.available_usdc_balance, arg4), v5, arg5);
        let v8 = calculate_user_hive_incentives<T0>(v0, &v6);
        0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_add_to_profile<UserInfusionPosition>(&v0.user_profile_access_cap, arg3, v6, arg5);
        (calculate_user_hive_incentives<T0>(v0, &v6) - v8, v8)
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
        v3.claim_index = v3.claim_index + 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((v1 as u256), (10000000000 as u256), (arg1.cur_lp_shares_staked as u256));
        v3.total_bee_fruits_earned = v3.total_bee_fruits_earned + v1;
        let v4 = (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256(v3.claim_index - *0x2::linked_table::borrow<0x1::ascii::String, u256>(&arg2.bee_fruit_indexes, v0), ((arg2.user_lp_shares - arg2.unbonded_lp_shares) as u256), (10000000000 as u256)) as u128);
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

    public entry fun infuse_hive_incentives<T0>(arg0: &0x2::clock::Clock, arg1: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::AdminDofOwnershipCapability, arg2: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg3: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HiveVault, arg4: 0x2::coin::Coin<0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::clock::timestamp_ms(arg0);
        let v0 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_manager_borrow_mut_from_profile<InfusionVault<T0>>(arg1, arg2);
        v0.total_gems_rewards = v0.total_gems_rewards + arg5;
        let v1 = InfusedHiveForInfusionPhase{hive_gems_incentives: arg5};
        0x2::event::emit<InfusedHiveForInfusionPhase>(v1);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE>(0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::burn_hive_and_return(arg3, &mut v0.infusion_profile, 0x2::coin::into_balance<0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE>(arg4), arg5, arg6), 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun infuse_usdc_hive_pool<T0>(arg0: &0x2::clock::Clock, arg1: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::AdminDofOwnershipCapability, arg2: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::AdminDofOwnershipCapability, arg3: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg4: &mut 0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LiquidityPool<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>) : (u64, u64, u64) {
        let v0 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_manager_borrow_mut_from_profile<InfusionVault<T0>>(arg1, arg3);
        assert!(0x2::balance::value<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&v0.available_lp_shares) == 0, 5111);
        let v1 = 0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::add_liquidity<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>(arg0, arg4, 0x2::balance::withdraw_all<T0>(&mut v0.available_usdc_balance), 0x2::balance::withdraw_all<0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE>(&mut v0.available_hive_balance), 0);
        let v2 = 0x2::balance::value<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&v1);
        v0.total_lp_shares_krafted = v0.total_lp_shares_krafted + v2;
        0x2::balance::join<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&mut v0.available_lp_shares, v1);
        v0.pool_infusion_timestamp = 0x2::clock::timestamp_ms(arg0);
        let v3 = HiveUsdcPoolInitialized<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>{
            hive_usdc_lp_shares       : v2,
            total_hive_usdc_lp_shares : v0.total_lp_shares_krafted,
        };
        0x2::event::emit<HiveUsdcPoolInitialized<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(v3);
        0xf0c3e78a5b1a84502a19e6c84eebe0f783e77a4dfa8b93a74b01040ef0084a07::airdrop::enable_hive_withdrawals(arg2, arg3);
        (0x2::balance::value<T0>(&v0.available_usdc_balance), 0x2::balance::value<0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE>(&v0.available_hive_balance), v2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun initialize_infusion_vault<T0>(arg0: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::AdminDofOwnershipCapability, arg1: &0x2::clock::Clock, arg2: 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::ProfileDofOwnershipCapability, arg3: 0x2::coin::TreasuryCap<0xb749586da888117fcb557cd39a9c93555292df2fb7cf82ace330531d7dbfae87::igems::IGEMS>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x9b98e5056b3bdcc865dcbd194d38aabb5c6a2c8e5d7dbd12e8fc2e6719767a85::hsui_vault::HSuiVault, arg6: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveProfileMappingStore, arg7: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg8: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HSuiDisperser<0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::hsui::HSUI>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        0x2::clock::timestamp_ms(arg1);
        let (v0, v1) = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::kraft_owned_hive_profile(arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg16);
        let v2 = InfusionVault<T0>{
            id                         : 0x2::object::new(arg16),
            user_profile_access_cap    : arg2,
            begin_timestamp            : arg12,
            deposit_window             : arg13,
            withdrawal_window          : arg14,
            lp_tokens_vesting_duration : arg15,
            infusion_profile           : v0,
            total_gems_rewards         : 0,
            x_hive_pool_addr           : 0x1::option::none<address>(),
            available_usdc_balance     : 0x2::balance::zero<T0>(),
            available_hive_balance     : 0x2::balance::zero<0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE>(),
            total_hive_delegated       : 0,
            total_usdc_delegated       : 0,
            pool_infusion_timestamp    : 0,
            available_lp_shares        : 0x2::balance::zero<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(),
            total_lp_shares_krafted    : 0,
            cur_lp_shares_staked       : 0,
            is_lp_staked               : false,
            hive_gems_per_share        : 0,
            bee_fruit_indexes          : 0x2::linked_table::new<0x1::ascii::String, u256>(arg16),
            last_pol_claim_timestamp   : 0,
            available_pol_shares       : 0x2::balance::zero<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(),
            pol_tokens_per_usdc        : 0,
            total_pol_lp_streamed      : 0,
            pol_tokens_distributed     : 0,
            igems_kraft_cap            : arg3,
            available_igems            : 0x2::balance::zero<0xb749586da888117fcb557cd39a9c93555292df2fb7cf82ace330531d7dbfae87::igems::IGEMS>(),
            pol_tokens_flamed          : 0,
            igems_per_share            : 0,
        };
        let v3 = InfusionVaultInitialized{vault_addr: 0x2::object::uid_to_address(&v2.id)};
        0x2::event::emit<InfusionVaultInitialized>(v3);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg16), arg16);
        0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_manager_add_to_profile<InfusionVault<T0>>(arg0, arg7, v2);
    }

    fun internal_claim_lps_igems<T0>(arg0: &mut InfusionVault<T0>, arg1: &mut 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::PoolHive<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>, arg2: &mut UserInfusionPosition, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>, 0x2::balance::Balance<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>, 0x2::balance::Balance<0xb749586da888117fcb557cd39a9c93555292df2fb7cf82ace330531d7dbfae87::igems::IGEMS>) {
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
        let v2 = 0x2::balance::zero<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>();
        while (0x1::option::is_some<u64>(&v0)) {
            let v3 = *0x1::option::borrow<u64>(&v0);
            v0 = *0x2::linked_table::next<u64, u64>(&arg2.lp_to_unlock, v3);
            if (v3 <= arg5) {
                v1 = v1 + *0x2::linked_table::borrow<u64, u64>(&arg2.lp_to_unlock, v3);
                0x2::linked_table::remove<u64, u64>(&mut arg2.lp_to_unlock, v3);
            };
        };
        if (v1 > 0) {
            0x2::balance::join<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&mut arg0.available_lp_shares, 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::unlock_from_bee_box<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(arg1, &mut arg0.infusion_profile, arg6));
            0x2::balance::join<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&mut v2, 0x2::balance::split<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&mut arg0.available_lp_shares, v1));
            arg2.claimed_lp_shares = arg2.claimed_lp_shares + v1;
        };
        let v4 = calculate_pol_lp_rewards<T0>(arg0, arg2);
        arg2.pol_tokens_per_usdc = arg0.pol_tokens_per_usdc;
        arg2.claimed_pol_tokens = arg2.claimed_pol_tokens + v4;
        let v5 = calculate_igems_user_meme<T0>(arg0, arg2);
        arg2.igems_per_share = arg0.igems_per_share;
        arg2.claimed_igems = arg2.claimed_igems + v5;
        (v2, 0x2::balance::split<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&mut arg0.available_pol_shares, v4), 0x2::balance::split<0xb749586da888117fcb557cd39a9c93555292df2fb7cf82ace330531d7dbfae87::igems::IGEMS>(&mut arg0.available_igems, v5))
    }

    fun internal_extract_lps_for_staking<T0>(arg0: &mut InfusionVault<T0>) : 0x2::balance::Balance<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>> {
        assert!(0x2::balance::value<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&arg0.available_lp_shares) > 0, 5112);
        let v0 = 0x2::balance::withdraw_all<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&mut arg0.available_lp_shares);
        arg0.is_lp_staked = true;
        let v1 = HiveUsdcLpTokensStaked{shared_staked: 0x2::balance::value<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(&v0)};
        0x2::event::emit<HiveUsdcLpTokensStaked>(v1);
        v0
    }

    fun is_deposit_open<T0>(arg0: u64, arg1: &InfusionVault<T0>) : bool {
        arg0 >= arg1.begin_timestamp && arg0 < arg1.begin_timestamp + arg1.deposit_window
    }

    fun kraft_user_position(arg0: &mut 0x2::tx_context::TxContext) : UserInfusionPosition {
        UserInfusionPosition{
            id                          : 0x2::object::new(arg0),
            hive_delegated              : 0,
            usdc_delegated              : 0,
            usdc_withdrawn_flag         : false,
            gems_claimable_for_infusion : 0,
            gems_claimed_flag           : false,
            user_lp_shares              : 0,
            unbonded_lp_shares          : 0,
            lp_to_unlock                : 0x2::linked_table::new<u64, u64>(arg0),
            claimed_lp_shares           : 0,
            hive_gems_per_share         : 0,
            gems_streamed_from_staking  : 0,
            bee_fruit_indexes           : 0x2::linked_table::new<0x1::ascii::String, u256>(arg0),
            total_bee_fruits_earned     : 0x2::linked_table::new<0x1::ascii::String, u128>(arg0),
            pol_tokens_per_usdc         : 0,
            claimed_pol_tokens          : 0,
            igems_per_share             : 0,
            claimed_igems               : 0,
        }
    }

    public fun simulate_delegate_hive<T0>(arg0: &0x2::clock::Clock, arg1: 0x1::ascii::String, arg2: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg3: u64) : u64 {
        let v0 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::borrow_from_admin_profile<InfusionVault<T0>>(arg2, arg1);
        if (!is_deposit_open<T0>(0x2::clock::timestamp_ms(arg0), v0)) {
            return 0
        };
        (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((arg3 as u256), (10000000000 as u256), (v0.total_hive_delegated as u256)) as u256), ((v0.total_gems_rewards / 2) as u256), (10000000000 as u256)) as u64)
    }

    public fun simulate_deposit_usdc<T0>(arg0: 0x1::ascii::String, arg1: &0x2::clock::Clock, arg2: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg3: u64) : u64 {
        let v0 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::borrow_from_admin_profile<InfusionVault<T0>>(arg2, arg0);
        if (!is_deposit_open<T0>(0x2::clock::timestamp_ms(arg1), v0)) {
            return 0
        };
        (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((arg3 as u256), (10000000000 as u256), (v0.total_usdc_delegated as u256)) as u256), ((v0.total_gems_rewards / 2) as u256), (10000000000 as u256)) as u64)
    }

    public entry fun simulate_withdraw_usdc<T0>(arg0: 0x1::ascii::String, arg1: &0x2::clock::Clock, arg2: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg3: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveProfile, arg4: u64) : (u64, u64, bool) {
        let v0 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::borrow_from_admin_profile<InfusionVault<T0>>(arg2, arg0);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        if (v1 < v0.begin_timestamp || v1 > v0.begin_timestamp + v0.deposit_window + v0.withdrawal_window) {
            return (0, 0, false)
        };
        let v2 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::get_profile_dof_capability_identifier(&v0.user_profile_access_cap);
        if (!0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::exists_for_profile(arg3, v2)) {
            return (0, 0, false)
        };
        let v3 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::borrow_from_profile<UserInfusionPosition>(arg3, v2);
        allowed_withdrawal_amount<T0>(v0, v1, v3.usdc_delegated);
        (0, (0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::math::mul_div_u256((arg4 as u256), (10000000000 as u256), (v0.total_usdc_delegated as u256)) as u256), ((v0.total_gems_rewards / 2) as u256), (10000000000 as u256)) as u64), v3.usdc_withdrawn_flag)
    }

    public entry fun stake_lp_tokens_no_fruits<T0>(arg0: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::AdminDofOwnershipCapability, arg1: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg2: &mut 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::PoolsGovernor, arg3: &mut 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::PoolHive<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_manager_borrow_mut_from_profile<InfusionVault<T0>>(arg0, arg1);
        let v1 = internal_extract_lps_for_staking<T0>(v0);
        0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::deposit_into_bee_box_no_fruits<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>(arg2, arg3, &mut v0.infusion_profile, v1, arg4);
    }

    public entry fun stake_lp_tokens_one_fruits<T0, T1>(arg0: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::AdminDofOwnershipCapability, arg1: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg2: &mut 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::PoolsGovernor, arg3: &mut 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::PoolHive<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_manager_borrow_mut_from_profile<InfusionVault<T0>>(arg0, arg1);
        let v1 = internal_extract_lps_for_staking<T0>(v0);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<T1>(0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::deposit_into_bee_box_1_fruits<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>, T1>(arg2, arg3, &mut v0.infusion_profile, v1, arg4), 0x2::tx_context::sender(arg4), arg4);
    }

    public entry fun stake_lp_tokens_three_fruits<T0, T1, T2, T3>(arg0: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::AdminDofOwnershipCapability, arg1: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg2: &mut 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::PoolsGovernor, arg3: &mut 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::PoolHive<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_manager_borrow_mut_from_profile<InfusionVault<T0>>(arg0, arg1);
        let v1 = internal_extract_lps_for_staking<T0>(v0);
        let (v2, v3, v4) = 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::deposit_into_bee_box_3_fruits<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>, T1, T2, T3>(arg2, arg3, &mut v0.infusion_profile, v1, arg4);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<T1>(v2, 0x2::tx_context::sender(arg4), arg4);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<T2>(v3, 0x2::tx_context::sender(arg4), arg4);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<T3>(v4, 0x2::tx_context::sender(arg4), arg4);
    }

    public entry fun stake_lp_tokens_two_fruits<T0, T1, T2>(arg0: &0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::AdminDofOwnershipCapability, arg1: &mut 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::HiveManager, arg2: &mut 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::PoolsGovernor, arg3: &mut 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::PoolHive<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive_profile::entry_manager_borrow_mut_from_profile<InfusionVault<T0>>(arg0, arg1);
        let v1 = internal_extract_lps_for_staking<T0>(v0);
        let (v2, v3) = 0xa6a761ba05c1778d314ec425dbf822bf79579de7524a70605fcf836f9f4c49e9::dex_dao::deposit_into_bee_box_2_fruits<0xa3f16d76f2a5da550e32637b1fe1b90d38ef4356a8572b5279a5d3abe44fa06a::two_pool::LP<T0, 0xf34ede06db26611dc0fb8a110887d1c80f858ad5153be39a432828b9c8b447a6::hive::HIVE, 0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::curves::Curved>, T1, T2>(arg2, arg3, &mut v0.infusion_profile, v1, arg4);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<T1>(v2, 0x2::tx_context::sender(arg4), arg4);
        0xd890c9216210c776b5c6a43bdd3629bd6a71be3b5d58c3edd73803d8a1b88d7b::coin_helper::destroy_or_transfer_balance<T2>(v3, 0x2::tx_context::sender(arg4), arg4);
    }

    fun verification_and_update_states<T0>(arg0: u64, arg1: &mut InfusionVault<T0>, arg2: &mut UserInfusionPosition, arg3: bool) : u64 {
        assert!(arg2.hive_delegated > 0 || arg2.usdc_delegated > 0, 5114);
        assert!(arg1.total_lp_shares_krafted > 0, 5112);
        if (arg2.user_lp_shares == 0) {
            arg2.user_lp_shares = calculate_user_lp_shares<T0>(arg1, arg2);
            arg2.gems_claimable_for_infusion = calculate_user_hive_incentives<T0>(arg1, arg2);
        };
        let v0 = 0;
        if (arg3) {
            v0 = calculate_unbondable_lp_shares<T0>(arg0, arg1, arg2);
        };
        v0
    }

    // decompiled from Move bytecode v6
}

