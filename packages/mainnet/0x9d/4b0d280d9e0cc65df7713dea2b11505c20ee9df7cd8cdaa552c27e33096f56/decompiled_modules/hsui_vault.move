module 0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::hsui_vault {
    struct HSuiVault has key {
        id: 0x2::object::UID,
        version: u64,
        hsui_treasury_cap: 0x2::coin::TreasuryCap<0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::hsui::HSUI>,
        pause_stake: bool,
        pause_unstake: bool,
        whitelisted_validators: vector<address>,
        validator_pools: 0x2::table::Table<address, ValidatorPool>,
        validators_with_active_pools: vector<address>,
        protocol_fee_percent: u64,
        service_fee_percent: u64,
        unstake_delay_epoches: u64,
        fee_distribution: FeeInfo,
        selected_validator_mapping: 0x2::vec_map::VecMap<address, 0x2::balance::Balance<0x2::sui::SUI>>,
        sui_to_stake: 0x2::balance::Balance<0x2::sui::SUI>,
        hive_fee_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        unstaked_sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        unstake_epochs: vector<UnstakedInEpoch>,
        total_principal_staked: u64,
        total_accrued_rewards: u64,
        sui_to_unstake: u64,
        uncollected_protocol_fees: u64,
        hsui_supply: u64,
        rewards_last_updated_epoch: u64,
        sui_claimable_per_hsui: u128,
    }

    struct ValidatorPool has store {
        staked_sui_objects: 0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::table_queue::TableQueue<0x3::staking_pool::StakedSui>,
        total_principal_staked: u64,
        accrued_rewards: u64,
    }

    struct FeeInfo has store {
        treasury_percent: u64,
    }

    struct UnstakedInEpoch has store {
        epoch: u64,
        amount: u64,
        approved: bool,
    }

    struct UnstakeRequest has store, key {
        id: 0x2::object::UID,
        hsui_amount: u64,
        sui_amount: u64,
        claim_epoch: u64,
        requested_at_epoch: u64,
    }

    struct ValidatorListUpdated has copy, drop {
        validator_list: vector<address>,
        to_add: bool,
    }

    struct StakeSuiRequest has copy, drop {
        staker: address,
        sui_to_stake: u64,
        hsui_krafted: u64,
        sui_claimable_per_hsui: u128,
        cur_epoch: u64,
    }

    struct UserUnstakedInstantly has copy, drop {
        owner: address,
        sui_withdrawn: u64,
        service_fee_charged: u64,
        protocol_fee_charged: u64,
        hsui_burnt: u64,
        sui_claimable_per_hsui: u128,
        cur_epoch: u64,
    }

    struct UserUnstakeRequest has copy, drop {
        owner: address,
        epoch: u64,
        unstake_epoch: u64,
        sui_to_claim: u64,
        hsui_burnt: u64,
        sui_claimable_per_hsui: u128,
        cur_epoch: u64,
    }

    struct UserClaimedSui has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        sui_withdrawn: u64,
        sui_claimable_per_hsui: u128,
        cur_epoch: u64,
    }

    struct UnstakedInEpochDestroyed has copy, drop {
        epoch: u64,
    }

    struct StakeWithSelectedValidatorRequestProcessed has copy, drop {
        validator_addr: address,
        sui_to_stake_amt: u64,
        cur_epoch: u64,
    }

    struct StakeOperationProcessed has copy, drop {
        validator_addr: address,
        sui_to_stake_amt: u64,
        cur_epoch: u64,
    }

    struct StakeSuiRequestsProcessed has copy, drop {
        cur_epoch: u64,
        total_sui_staked: u64,
        unstaked_sui_added_to_reserve_after_fee: u64,
        protocol_fee_collected: u64,
        sui_claimable_per_hsui: u128,
    }

    struct ValidatorPoolRewardsUpdated has copy, drop {
        validator_addr: address,
        total_staked_sui_objs: u64,
        prev_rewards: u64,
        new_rewards: u64,
        total_principal_staked: u64,
        cur_epoch: u64,
    }

    struct TotalRewardsUpdated has copy, drop {
        cur_epoch: u64,
        total_principal_staked: u64,
        sui_to_unstake: u64,
        total_accrued_rewards: u64,
        new_rewards: u64,
        uncollected_protocol_fees: u64,
        protocol_fee_on_new_rewards: u64,
        prev_sui_claimable_per_hsui: u128,
        new_sui_claimable_per_hsui: u128,
        exchange_rate_increase: u128,
    }

    struct ValidatorPoolDestroyed has copy, drop {
        validator_address: address,
        cur_epoch: u64,
    }

    struct UnstakingRequestsProcessed has copy, drop {
        cur_epoch: u64,
        total_sui_unstaked: u64,
        sui_claimable_per_hsui: u128,
    }

    fun calculate_staked_sui_rewards(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x3::staking_pool::StakedSui, arg2: u64) : u64 {
        let v0 = 0x1::string::utf8(b"calculate_staked_sui_rewards:: staked_sui_start_epoch");
        0x1::debug::print<0x1::string::String>(&v0);
        0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::helper::calculate_rewards(arg0, 0x3::staking_pool::pool_id(arg1), 0x3::staking_pool::staked_sui_amount(arg1), 0x3::staking_pool::stake_activation_epoch(arg1), arg2)
    }

    fun calculate_validator_pool_rewards_increase(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: address, arg2: &mut ValidatorPool, arg3: u64) : u64 {
        let v0 = 0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::table_queue::length<0x3::staking_pool::StakedSui>(&arg2.staked_sui_objects);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0;
        let v2 = 0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::table_queue::head<0x3::staking_pool::StakedSui>(&arg2.staked_sui_objects);
        while (v2 < 0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::table_queue::tail<0x3::staking_pool::StakedSui>(&arg2.staked_sui_objects)) {
            let v3 = 0x1::string::utf8(b"i");
            0x1::debug::print<0x1::string::String>(&v3);
            let v4 = 0x1::string::utf8(b"staked_sui_obj");
            0x1::debug::print<0x1::string::String>(&v4);
            let v5 = 0x1::string::utf8(b"rewards");
            0x1::debug::print<0x1::string::String>(&v5);
            v1 = v1 + calculate_staked_sui_rewards(arg0, 0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::table_queue::borrow<0x3::staking_pool::StakedSui>(&arg2.staked_sui_objects, v2), arg3);
            v2 = v2 + 1;
        };
        let v6 = arg2.accrued_rewards;
        arg2.accrued_rewards = v1;
        let v7 = if (v6 > v1) {
            0
        } else {
            v1 - v6
        };
        let v8 = ValidatorPoolRewardsUpdated{
            validator_addr         : arg1,
            total_staked_sui_objs  : v0,
            prev_rewards           : v6,
            new_rewards            : v7,
            total_principal_staked : arg2.total_principal_staked,
            cur_epoch              : arg3,
        };
        0x2::event::emit<ValidatorPoolRewardsUpdated>(v8);
        v1 - v6
    }

    public fun claim_collected_fees(arg0: &0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::config::HiveDaoCapability, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut HSuiVault, arg3: &mut 0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::config::Treasury<0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::hsui::HSUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::math::mul_div_u128((0x2::balance::value<0x2::sui::SUI>(&arg2.hive_fee_vault) as u128), (arg2.fee_distribution.treasury_percent as u128), (100000 as u128));
        if (v0 > 0) {
            let v1 = 0x2::balance::split<0x2::sui::SUI>(&mut arg2.hive_fee_vault, v0);
            let v2 = stake_sui_request(arg1, arg2, v1, 0x1::option::none<address>(), arg4);
            0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::config::deposit_to_treasury<0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::hsui::HSUI>(arg3, v2);
        };
        0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg2.hive_fee_vault)
    }

    fun claim_unstake_epoch(arg0: &mut HSuiVault, arg1: u64) {
        let v0 = 0x1::vector::length<UnstakedInEpoch>(&arg0.unstake_epochs);
        let v1 = 0;
        while (v1 < v0 && arg1 > 0) {
            let v2 = 0x1::vector::borrow_mut<UnstakedInEpoch>(&mut arg0.unstake_epochs, v1);
            assert!(v2.approved, 9007);
            if (arg1 > v2.amount) {
                arg1 = arg1 - v2.amount;
                v2.amount = 0;
            } else {
                v2.amount = v2.amount - arg1;
                arg1 = 0;
            };
            if (v2.amount == 0) {
                v0 = v0 - 1;
                let (_, _, _) = destroy_unstake_epoch(0x1::vector::remove<UnstakedInEpoch>(&mut arg0.unstake_epochs, v1));
                continue
            };
            v1 = v1 + 1;
        };
    }

    public fun claim_unstaked_sui(arg0: &mut HSuiVault, arg1: UnstakeRequest, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg0.version == 0, 9002);
        assert!(arg0.pause_unstake == false, 9005);
        let (v0, _, v2, v3, _) = destroy_ticket(arg1);
        let v5 = v3;
        let v6 = v2;
        assert!(v5 <= 0x2::tx_context::epoch(arg2), 9008);
        let v7 = 0x1::string::utf8(b"claim_epoch");
        0x1::debug::print<0x1::string::String>(&v7);
        0x1::debug::print<u64>(&v5);
        let v8 = 0x1::string::utf8(b"sui_to_return_amt");
        0x1::debug::print<0x1::string::String>(&v8);
        0x1::debug::print<u64>(&v6);
        claim_unstake_epoch(arg0, v6);
        let v9 = UserClaimedSui{
            id                     : v0,
            owner                  : 0x2::tx_context::sender(arg2),
            sui_withdrawn          : v6,
            sui_claimable_per_hsui : get_sui_claimable_per_hsui(arg0),
            cur_epoch              : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<UserClaimedSui>(v9);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.unstaked_sui_reserve, v6)
    }

    fun destroy_staking_pool(arg0: &mut HSuiVault, arg1: address, arg2: u64) : (u64, u64) {
        let ValidatorPool {
            staked_sui_objects     : v0,
            total_principal_staked : v1,
            accrued_rewards        : v2,
        } = 0x2::table::remove<address, ValidatorPool>(&mut arg0.validator_pools, arg1);
        let (_, _) = 0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::table_queue::destroy_empty<0x3::staking_pool::StakedSui>(v0);
        let (_, v6) = 0x1::vector::index_of<address>(&arg0.validators_with_active_pools, &arg1);
        0x1::vector::remove<address>(&mut arg0.validators_with_active_pools, v6);
        let v7 = ValidatorPoolDestroyed{
            validator_address : arg1,
            cur_epoch         : arg2,
        };
        0x2::event::emit<ValidatorPoolDestroyed>(v7);
        (v1, v2)
    }

    fun destroy_ticket(arg0: UnstakeRequest) : (0x2::object::ID, u64, u64, u64, u64) {
        let UnstakeRequest {
            id                 : v0,
            hsui_amount        : v1,
            sui_amount         : v2,
            claim_epoch        : v3,
            requested_at_epoch : v4,
        } = arg0;
        let v5 = v0;
        0x2::object::delete(v5);
        (0x2::object::uid_to_inner(&v5), v1, v2, v3, v4)
    }

    fun destroy_unstake_epoch(arg0: UnstakedInEpoch) : (u64, u64, bool) {
        let UnstakedInEpoch {
            epoch    : v0,
            amount   : v1,
            approved : v2,
        } = arg0;
        let v3 = UnstakedInEpochDestroyed{epoch: v0};
        0x2::event::emit<UnstakedInEpochDestroyed>(v3);
        (v0, v1, v2)
    }

    fun do_before_unstake(arg0: &mut HSuiVault, arg1: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<UnstakedInEpoch>(&arg0.unstake_epochs)) {
            let v2 = 0x1::vector::borrow_mut<UnstakedInEpoch>(&mut arg0.unstake_epochs, v1);
            if (0x2::tx_context::epoch(arg1) > v2.epoch && !v2.approved) {
                v0 = v0 + v2.amount;
                v2.approved = true;
            };
            v1 = v1 + 1;
        };
        let v3 = arg0.uncollected_protocol_fees + v0;
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_to_stake);
        if (v3 < v4) {
            return (v4 - v3, v0, arg0.uncollected_protocol_fees)
        };
        (0, v3, arg0.uncollected_protocol_fees)
    }

    public fun emergency_pause_update(arg0: &0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::config::HiveDaoCapability, arg1: &mut HSuiVault, arg2: bool) {
        assert!(arg1.version == 0, 9002);
        let v0 = 0x1::string::utf8(b"STAKING VAULT ::emergency_pause_update() FUNCTION -::- ");
        0x1::debug::print<0x1::string::String>(&v0);
        arg1.pause_stake = arg2;
    }

    fun execute_validator_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut HSuiVault, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg3: address, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (u64, bool) {
        let v0 = 0x1::string::utf8(b"Internal -::- execute_validator_unstake(), sui_to_unstake = ");
        0x1::debug::print<0x1::string::String>(&v0);
        0x1::debug::print<u64>(&arg4);
        let v1 = false;
        let v2 = v1;
        if (!0x2::table::contains<address, ValidatorPool>(&arg1.validator_pools, arg3)) {
            return (0, v1)
        };
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x2::table::borrow_mut<address, ValidatorPool>(&mut arg1.validator_pools, arg3);
        while (arg4 > 0 && 0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::table_queue::length<0x3::staking_pool::StakedSui>(&v5.staked_sui_objects) > 0) {
            let v6 = 0x1::string::utf8(b"staked_sui_obj borrowed");
            0x1::debug::print<0x1::string::String>(&v6);
            let (_, _, v9, v10) = get_split_amount(arg0, 0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::table_queue::borrow_tail<0x3::staking_pool::StakedSui>(&v5.staked_sui_objects), arg4, arg5);
            let v11 = v10;
            let v12 = v9;
            let v13 = 0x1::string::utf8(b"Result from get_split_amount()");
            0x1::debug::print<0x1::string::String>(&v13);
            let v14 = 0x1::string::utf8(b"sui_unstaked_from_obj = ");
            0x1::debug::print<0x1::string::String>(&v14);
            0x1::debug::print<u64>(&v11);
            let v15 = 0x1::string::utf8(b"remaining_principal = ");
            0x1::debug::print<0x1::string::String>(&v15);
            0x1::debug::print<u64>(&v12);
            if (v11 > 0) {
                let v16 = if (v12 > 0) {
                    0x3::staking_pool::split(0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::table_queue::borrow_tail_mut<0x3::staking_pool::StakedSui>(&mut v5.staked_sui_objects), v11, arg6)
                } else {
                    0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::table_queue::pop_from_tail<0x3::staking_pool::StakedSui>(&mut v5.staked_sui_objects)
                };
                let v17 = 0x1::string::utf8(b"Got the StakedSui object which is to be unstaked");
                0x1::debug::print<0x1::string::String>(&v17);
                let (v18, v19, v20) = withdraw_staked_sui(arg0, v16, arg2, arg5, arg6);
                let v21 = v20;
                let v22 = v19;
                let v23 = v18;
                let v24 = 0x1::string::utf8(b"Result from withdraw_staked_sui() internal Function");
                0x1::debug::print<0x1::string::String>(&v24);
                let v25 = 0x1::string::utf8(b"sui_withdrawn = ");
                0x1::debug::print<0x1::string::String>(&v25);
                0x1::debug::print<u64>(&v23);
                let v26 = 0x1::string::utf8(b"unstaked_principal = ");
                0x1::debug::print<0x1::string::String>(&v26);
                0x1::debug::print<u64>(&v22);
                let v27 = 0x1::string::utf8(b"withdrawn_rewards = ");
                0x1::debug::print<0x1::string::String>(&v27);
                0x1::debug::print<u64>(&v21);
                let v28 = 0x1::string::utf8(b"vault.sui_to_unstake = ");
                0x1::debug::print<0x1::string::String>(&v28);
                0x1::debug::print<u64>(&arg1.sui_to_unstake);
                let v29 = v3;
                v3 = v29 + v22;
                let v30 = v4;
                v4 = v30 + v21;
                let v31 = 0x1::string::utf8(b"sui_unstaked (Total) = ");
                0x1::debug::print<0x1::string::String>(&v31);
                0x1::debug::print<u64>(&v3);
                let v32 = 0x1::string::utf8(b"unstaked_rewards_total (Total) = ");
                0x1::debug::print<0x1::string::String>(&v32);
                0x1::debug::print<u64>(&v4);
                if (v23 <= arg4) {
                    let v33 = arg4;
                    arg4 = v33 - v23;
                } else {
                    arg4 = 0;
                };
                arg1.total_principal_staked = arg1.total_principal_staked - v22;
                arg1.total_accrued_rewards = arg1.total_accrued_rewards - v21;
                let v34 = 0x1::string::utf8(b"vault.total_principal_staked ");
                0x1::debug::print<0x1::string::String>(&v34);
                0x1::debug::print<u64>(&arg1.total_principal_staked);
                let v35 = 0x1::string::utf8(b"vault.total_accrued_rewards");
                0x1::debug::print<0x1::string::String>(&v35);
                0x1::debug::print<u64>(&arg1.total_accrued_rewards);
                v5.total_principal_staked = v5.total_principal_staked - v22;
                v5.accrued_rewards = v5.accrued_rewards - v21;
                let v36 = 0x1::string::utf8(b"validator_pool.total_principal_staked");
                0x1::debug::print<0x1::string::String>(&v36);
                0x1::debug::print<u64>(&v5.total_principal_staked);
                let v37 = 0x1::string::utf8(b"validator_pool.accrued_rewards");
                0x1::debug::print<0x1::string::String>(&v37);
                0x1::debug::print<u64>(&v5.accrued_rewards);
            };
        };
        if (0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::table_queue::is_empty<0x3::staking_pool::StakedSui>(&v5.staked_sui_objects)) {
            let (_, _) = destroy_staking_pool(arg1, arg3, arg5);
            v2 = true;
        };
        (arg4, v2)
    }

    public fun get_hsui_by_sui(arg0: &HSuiVault, arg1: u64) : u64 {
        let v0 = get_total_sui(arg0);
        if (v0 == 0 || arg0.hsui_supply == 0) {
            return arg1
        };
        0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::math::mul_div_u128((arg1 as u128), (arg0.hsui_supply as u128), (v0 as u128))
    }

    fun get_split_amount(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x3::staking_pool::StakedSui, arg2: u64, arg3: u64) : (u64, u64, u64, u64) {
        let v0 = 0x1::string::utf8(b"Internal -::- get_split_amount(), sui_to_unstake = ");
        0x1::debug::print<0x1::string::String>(&v0);
        0x1::debug::print<u64>(&arg2);
        let v1 = 0x3::staking_pool::staked_sui_amount(arg1);
        let v2 = 0x1::string::utf8(b"principal_sui_staked = ");
        0x1::debug::print<0x1::string::String>(&v2);
        0x1::debug::print<u64>(&v1);
        if (0x3::staking_pool::stake_activation_epoch(arg1) > arg3) {
            return (v1, 0, 0, 0)
        };
        let v3 = calculate_staked_sui_rewards(arg0, arg1, arg3);
        let v4 = v1 + v3;
        let v5 = 0x1::string::utf8(b"accrued_rewards = ");
        0x1::debug::print<0x1::string::String>(&v5);
        0x1::debug::print<u64>(&v3);
        let v6 = 0x1::string::utf8(b"total_sui_available = ");
        0x1::debug::print<0x1::string::String>(&v6);
        0x1::debug::print<u64>(&v4);
        if (v4 < arg2) {
            return (v1, v3, 0, v4)
        };
        let v7 = ((0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::math::mul_div_u256((1000000000 as u256) * (arg2 as u256), (v1 as u256), (v4 as u256)) / (1000000000 as u256)) as u64) + 1;
        let v8 = v1 - v7;
        let v9 = 0x1::string::utf8(b"calc_sui_to_unstake = ");
        0x1::debug::print<0x1::string::String>(&v9);
        0x1::debug::print<u64>(&v7);
        if (v7 < 1000000000) {
            if (v1 - 1000000000 < 1000000000) {
                return (v1, v3, 0, v4)
            };
            return (v1, v3, v1 - 1000000000, 1000000000)
        };
        if (v8 >= 1000000000) {
            return (v1, v3, v8, v7)
        };
        (v1, v3, 0, v4)
    }

    public fun get_sui_by_hsui(arg0: &HSuiVault, arg1: u64) : u64 {
        let v0 = get_total_sui(arg0);
        if (v0 == 0 || arg0.hsui_supply == 0) {
            return arg1
        };
        0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::math::mul_div_u128((v0 as u128), (arg1 as u128), (arg0.hsui_supply as u128))
    }

    public fun get_sui_claimable_per_hsui(arg0: &HSuiVault) : u128 {
        let v0 = get_total_sui(arg0);
        let v1 = arg0.hsui_supply;
        if (v0 == 0 || v1 == 0) {
            return (1000000000 as u128)
        };
        (0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::math::mul_div_u128((v0 as u128), (1000000000 as u128), (v1 as u128)) as u128)
    }

    public fun get_total_sui(arg0: &HSuiVault) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x2::vec_map::size<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping, v0);
            v1 = v1 + 0x2::balance::value<0x2::sui::SUI>(v3);
            v0 = v0 + 1;
        };
        arg0.total_principal_staked + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_to_stake) + v1 + arg0.total_accrued_rewards - arg0.uncollected_protocol_fees - arg0.sui_to_unstake
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun init_hsui_vault(arg0: 0x2::coin::TreasuryCap<0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::hsui::HSUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"STAKING VAULT ::init_hsui_vault() FUNCTION -::- ");
        0x1::debug::print<0x1::string::String>(&v0);
        let v1 = FeeInfo{treasury_percent: 32000};
        let v2 = HSuiVault{
            id                           : 0x2::object::new(arg1),
            version                      : 0,
            hsui_treasury_cap            : arg0,
            pause_stake                  : false,
            pause_unstake                : false,
            whitelisted_validators       : 0x1::vector::empty<address>(),
            validator_pools              : 0x2::table::new<address, ValidatorPool>(arg1),
            validators_with_active_pools : 0x1::vector::empty<address>(),
            protocol_fee_percent         : 5000,
            service_fee_percent          : 2000,
            unstake_delay_epoches        : 1,
            fee_distribution             : v1,
            selected_validator_mapping   : 0x2::vec_map::empty<address, 0x2::balance::Balance<0x2::sui::SUI>>(),
            sui_to_stake                 : 0x2::balance::zero<0x2::sui::SUI>(),
            hive_fee_vault               : 0x2::balance::zero<0x2::sui::SUI>(),
            unstaked_sui_reserve         : 0x2::balance::zero<0x2::sui::SUI>(),
            unstake_epochs               : 0x1::vector::empty<UnstakedInEpoch>(),
            total_principal_staked       : 0,
            total_accrued_rewards        : 0,
            sui_to_unstake               : 0,
            uncollected_protocol_fees    : 0,
            hsui_supply                  : 0,
            rewards_last_updated_epoch   : 0x2::tx_context::epoch(arg1),
            sui_claimable_per_hsui       : (1000000000 as u128),
        };
        0x2::transfer::share_object<HSuiVault>(v2);
    }

    public fun migrate(arg0: &mut HSuiVault) {
        let v0 = 0x1::string::utf8(b"STAKING VAULT ::migrate() FUNCTION -::- ");
        0x1::debug::print<0x1::string::String>(&v0);
        assert!(arg0.version < 0, 9002);
        arg0.version = 0;
    }

    public fun process_stake_sui_requests(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut HSuiVault, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"STAKING VAULT OPERATIONS ::process_stake_sui_requests() FUNCTION -::- ");
        0x1::debug::print<0x1::string::String>(&v0);
        let v1 = 0x2::tx_context::epoch(arg2);
        let v2 = 0x3::sui_system::active_validator_addresses(arg0);
        assert!(arg1.version == 0, 9002);
        assert!(arg1.pause_stake == false, 9003);
        if (arg1.rewards_last_updated_epoch < 0x2::tx_context::epoch(arg2)) {
            update_calculated_accrued_rewards(arg0, arg1, arg2);
        };
        let (v3, v4) = stake_user_selected_validators(arg0, arg1, v2, arg2);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x1::string::utf8(b"total_sui_staked to selected_validators");
        0x1::debug::print<0x1::string::String>(&v7);
        0x1::debug::print<u64>(&v6);
        let v8 = 0x1::string::utf8(b"remaining_sui from selected_validators");
        0x1::debug::print<0x1::string::String>(&v8);
        let v9 = 0x2::balance::value<0x2::sui::SUI>(&v5);
        0x1::debug::print<u64>(&v9);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_to_stake, v5);
        let v10 = 0x1::string::utf8(b"cur_epoch");
        0x1::debug::print<0x1::string::String>(&v10);
        0x1::debug::print<u64>(&v1);
        let v11 = 0;
        let v12 = arg1.uncollected_protocol_fees;
        let v13 = 0;
        while (v13 < 0x1::vector::length<UnstakedInEpoch>(&arg1.unstake_epochs)) {
            let v14 = 0x1::string::utf8(b"Getting epoch claim");
            0x1::debug::print<0x1::string::String>(&v14);
            let v15 = 0x1::vector::borrow_mut<UnstakedInEpoch>(&mut arg1.unstake_epochs, v13);
            0x1::debug::print<u64>(&v15.epoch);
            0x1::debug::print<u64>(&v15.amount);
            if (v1 > v15.epoch && !v15.approved) {
                v15.approved = true;
                if (v15.amount <= 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_to_stake)) {
                    0x2::balance::join<0x2::sui::SUI>(&mut arg1.unstaked_sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_to_stake, v15.amount));
                    arg1.sui_to_unstake = arg1.sui_to_unstake - v15.amount;
                    let v16 = v11;
                    v11 = v16 + v15.amount;
                } else {
                    let v17 = 0x1::string::utf8(b"rem_sui_to_stake Section");
                    0x1::debug::print<0x1::string::String>(&v17);
                    let v18 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_to_stake);
                    let v19 = v12 + v15.amount;
                    v12 = v19 - v18;
                    arg1.sui_to_unstake = arg1.sui_to_unstake - v18;
                    0x2::balance::join<0x2::sui::SUI>(&mut arg1.unstaked_sui_reserve, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.sui_to_stake));
                    let v20 = v11;
                    v11 = v20 + v18;
                };
            };
            v13 = v13 + 1;
        };
        let v21 = 0x1::string::utf8(b"switched_from_stake_to_unstake_reserve selected_validators");
        0x1::debug::print<0x1::string::String>(&v21);
        0x1::debug::print<u64>(&v11);
        let v22 = 0x1::string::utf8(b"total_sui_to_unstake");
        0x1::debug::print<0x1::string::String>(&v22);
        0x1::debug::print<u64>(&v12);
        let v23 = 0;
        if (v12 > 0) {
            let (_, v25) = unstake_from_validator_pools(arg0, arg1, v12, arg2);
            let v26 = v25;
            v23 = 0x2::balance::value<0x2::sui::SUI>(&v26);
            let v27 = 0x1::string::utf8(b"vault.sui_to_unstake");
            0x1::debug::print<0x1::string::String>(&v27);
            0x1::debug::print<u64>(&arg1.sui_to_unstake);
            let v28 = 0x1::string::utf8(b"Response from unstake_from_validator_pools() function");
            0x1::debug::print<0x1::string::String>(&v28);
            0x1::debug::print<u64>(&v23);
            if (arg1.sui_to_unstake >= v23) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg1.unstaked_sui_reserve, v26);
                arg1.sui_to_unstake = arg1.sui_to_unstake - v23;
                let v29 = 0x1::string::utf8(b"^ added to vault.unstaked_sui_reserve, which is =");
                0x1::debug::print<0x1::string::String>(&v29);
                let v30 = 0x2::balance::value<0x2::sui::SUI>(&arg1.unstaked_sui_reserve);
                0x1::debug::print<u64>(&v30);
            } else {
                0x2::balance::join<0x2::sui::SUI>(&mut arg1.unstaked_sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut v26, arg1.sui_to_unstake));
                arg1.sui_to_unstake = 0;
                let v31 = 0x1::string::utf8(b"^ vault.sui_to_unstake added to vault.unstaked_sui_reserve, which is =");
                0x1::debug::print<0x1::string::String>(&v31);
                let v32 = 0x2::balance::value<0x2::sui::SUI>(&arg1.unstaked_sui_reserve);
                0x1::debug::print<u64>(&v32);
                let v33 = 0x1::string::utf8(b"Added to vault.sui_to_stake =");
                0x1::debug::print<0x1::string::String>(&v33);
                let v34 = 0x2::balance::value<0x2::sui::SUI>(&v26);
                0x1::debug::print<u64>(&v34);
                0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_to_stake, v26);
            };
        };
        if (0x2::balance::value<0x2::sui::SUI>(&arg1.sui_to_stake) > 0x1::vector::length<address>(&arg1.whitelisted_validators) * 1000000000) {
            let v35 = 0x1::string::utf8(b"stake SUI now");
            0x1::debug::print<0x1::string::String>(&v35);
            let v36 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_to_stake);
            0x1::debug::print<u64>(&v36);
            let v37 = 0;
            let v38 = 0;
            while (v38 < 0x1::vector::length<address>(&arg1.whitelisted_validators)) {
                let v39 = *0x1::vector::borrow<address>(&arg1.whitelisted_validators, v38);
                if (0x1::vector::contains<address>(&v2, &v39)) {
                    let v40 = v37;
                    v37 = v40 + 1;
                };
                v38 = v38 + 1;
            };
            assert!(v37 > 0, 9009);
            let v41 = 0x1::string::utf8(b"supported_active_validators_count");
            0x1::debug::print<0x1::string::String>(&v41);
            0x1::debug::print<u64>(&v37);
            let v42 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_to_stake) / v37;
            let v43 = 0x1::string::utf8(b"sui_to_stake_per_val_amt");
            0x1::debug::print<0x1::string::String>(&v43);
            0x1::debug::print<u64>(&v42);
            if (v42 > 1000000000) {
                let v44 = 0;
                while (v44 < 0x1::vector::length<address>(&arg1.whitelisted_validators)) {
                    let v45 = *0x1::vector::borrow<address>(&arg1.whitelisted_validators, v44);
                    if (0x1::vector::contains<address>(&v2, &v45)) {
                        let v46 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_to_stake, v42);
                        let v47 = v6;
                        v6 = v47 + v42;
                        stake_with_validator(arg0, arg1, v45, v46, arg2);
                    };
                    v44 = v44 + 1;
                };
            };
        };
        let v48 = 0x1::string::utf8(b"total_sui_staked");
        0x1::debug::print<0x1::string::String>(&v48);
        0x1::debug::print<u64>(&v6);
        let v49 = StakeSuiRequestsProcessed{
            cur_epoch                               : v1,
            total_sui_staked                        : v6,
            unstaked_sui_added_to_reserve_after_fee : v23,
            protocol_fee_collected                  : 0,
            sui_claimable_per_hsui                  : get_sui_claimable_per_hsui(arg1),
        };
        0x2::event::emit<StakeSuiRequestsProcessed>(v49);
    }

    public fun process_unstake_sui_requests(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut HSuiVault, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"=== STAKING VAULT OPERATIONS === process_unstake_sui_requests() FUNCTION -::- ");
        0x1::debug::print<0x1::string::String>(&v0);
        unstake_inactive_validators(arg0, arg1, arg2);
        update_calculated_accrued_rewards(arg0, arg1, arg2);
        let (_, v2, _) = do_before_unstake(arg1, arg2);
        let v4 = v2;
        let v5 = 0x1::string::utf8(b"Result from do_before_unstake() internal Function, total_sui_to_unstake = ");
        0x1::debug::print<0x1::string::String>(&v5);
        0x1::debug::print<u64>(&v4);
        let (_, v7) = unstake_from_validator_pools(arg0, arg1, v4, arg2);
        let v8 = v7;
        let v9 = 0x1::string::utf8(b"Result from unstake_from_validator_pools() internal Function, sui_unstaked_balance = ");
        0x1::debug::print<0x1::string::String>(&v9);
        let v10 = 0x2::balance::value<0x2::sui::SUI>(&v8);
        0x1::debug::print<u64>(&v10);
        let v11 = 0x2::balance::value<0x2::sui::SUI>(&v8);
        if (v11 >= arg1.sui_to_unstake) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.unstaked_sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut v8, arg1.sui_to_unstake));
            arg1.sui_to_unstake = 0;
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_to_stake, v8);
        } else {
            arg1.sui_to_unstake = arg1.sui_to_unstake - v11;
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.unstaked_sui_reserve, v8);
        };
        let v12 = get_sui_claimable_per_hsui(arg1);
        let v13 = 0x1::string::utf8(b"cur_exchange_rate");
        0x1::debug::print<0x1::string::String>(&v13);
        0x1::debug::print<u128>(&v12);
        let v14 = UnstakingRequestsProcessed{
            cur_epoch              : 0x2::tx_context::epoch(arg2),
            total_sui_unstaked     : v11,
            sui_claimable_per_hsui : v12,
        };
        0x2::event::emit<UnstakingRequestsProcessed>(v14);
    }

    public fun query_request_delayed_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut HSuiVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::string::utf8(b"STAKING VAULT ::query_request_delayed_unstake() FUNCTION -::- ");
        0x1::debug::print<0x1::string::String>(&v0);
        assert!(arg1.version == 0, 9002);
        assert!(arg1.pause_unstake == false, 9005);
        update_calculated_accrued_rewards(arg0, arg1, arg3);
        let v1 = get_sui_by_hsui(arg1, arg2);
        let v2 = 0x1::string::utf8(b"underlying_sui_value");
        0x1::debug::print<0x1::string::String>(&v2);
        0x1::debug::print<u64>(&v1);
        if (v1 > get_total_sui(arg1)) {
            return 0
        };
        v1
    }

    public fun query_request_instant_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut HSuiVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x1::string::utf8(b"STAKING VAULT ::query_request_instant_unstake() FUNCTION -::- ");
        0x1::debug::print<0x1::string::String>(&v0);
        assert!(arg1.version == 0, 9002);
        assert!(arg1.pause_unstake == false, 9005);
        update_calculated_accrued_rewards(arg0, arg1, arg3);
        let v1 = get_sui_by_hsui(arg1, arg2);
        if (0x2::balance::value<0x2::sui::SUI>(&arg1.sui_to_stake) < v1) {
            return (0, 0)
        };
        let v2 = 0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::math::mul_div_u128((v1 as u128), (arg1.service_fee_percent as u128), (100000 as u128));
        (v1 - v2, v2)
    }

    public fun query_stake_sui_request(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut HSuiVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::string::utf8(b"STAKING VAULT ::query_stake_sui_request() FUNCTION -::- ");
        0x1::debug::print<0x1::string::String>(&v0);
        assert!(arg1.version == 0, 9002);
        assert!(arg1.pause_stake == false, 9003);
        update_calculated_accrued_rewards(arg0, arg1, arg3);
        get_hsui_by_sui(arg1, arg2)
    }

    public fun query_staked_objs_for_validator(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &HSuiVault, arg2: address, arg3: u64) : (vector<u64>, vector<u64>, vector<u64>) {
        let v0 = 0x2::table::borrow<address, ValidatorPool>(&arg1.validator_pools, arg2);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::table_queue::length<0x3::staking_pool::StakedSui>(&v0.staked_sui_objects);
        while (v4 > 0) {
            let v5 = 0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::table_queue::borrow<0x3::staking_pool::StakedSui>(&v0.staked_sui_objects, v4 - 1);
            let v6 = 0x3::staking_pool::stake_activation_epoch(v5);
            let v7 = 0x3::staking_pool::staked_sui_amount(v5);
            0x1::vector::push_back<u64>(&mut v1, v6);
            0x1::vector::push_back<u64>(&mut v2, v7);
            0x1::vector::push_back<u64>(&mut v3, 0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::helper::calculate_rewards(arg0, 0x3::staking_pool::pool_id(v5), v7, v6, arg3));
            v4 = v4 - 1;
        };
        (v1, v2, v3)
    }

    public fun query_unstaked_epoch(arg0: &HSuiVault, arg1: u64) : (u64, u64, bool) {
        let v0 = 0x1::vector::borrow<UnstakedInEpoch>(&arg0.unstake_epochs, arg1);
        (v0.epoch, v0.amount, v0.approved)
    }

    public fun query_unstaked_in_epochs(arg0: &HSuiVault) : (vector<u64>, vector<u64>, vector<bool>) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<bool>();
        let v3 = 0x1::vector::length<UnstakedInEpoch>(&arg0.unstake_epochs);
        while (v3 > 0) {
            let v4 = 0x1::vector::borrow<UnstakedInEpoch>(&arg0.unstake_epochs, v3 - 1);
            0x1::vector::push_back<u64>(&mut v0, v4.epoch);
            0x1::vector::push_back<u64>(&mut v1, v4.amount);
            0x1::vector::push_back<bool>(&mut v2, v4.approved);
            v3 = v3 - 1;
        };
        (v0, v1, v2)
    }

    public fun query_validator_pool(arg0: &HSuiVault, arg1: address) : (u64, u64) {
        let v0 = 0x2::table::borrow<address, ValidatorPool>(&arg0.validator_pools, arg1);
        (v0.total_principal_staked, v0.accrued_rewards)
    }

    public fun request_delayed_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut HSuiVault, arg2: 0x2::balance::Balance<0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::hsui::HSUI>, arg3: &mut 0x2::tx_context::TxContext) : UnstakeRequest {
        let v0 = 0x1::string::utf8(b"STAKING VAULT ::request_delayed_unstake() FUNCTION -::- ");
        0x1::debug::print<0x1::string::String>(&v0);
        assert!(arg1.version == 0, 9002);
        assert!(arg1.pause_unstake == false, 9005);
        update_calculated_accrued_rewards(arg0, arg1, arg3);
        let v1 = 0x2::tx_context::epoch(arg3);
        let v2 = get_sui_by_hsui(arg1, 0x2::balance::value<0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::hsui::HSUI>(&arg2));
        let v3 = 0x1::string::utf8(b"underlying_sui_value");
        0x1::debug::print<0x1::string::String>(&v3);
        0x1::debug::print<u64>(&v2);
        let v4 = get_total_sui(arg1);
        let v5 = 0x1::string::utf8(b"total_sui");
        0x1::debug::print<0x1::string::String>(&v5);
        0x1::debug::print<u64>(&v4);
        assert!(v2 <= v4, 9006);
        let v6 = 0;
        let v7 = false;
        while (v6 < 0x1::vector::length<UnstakedInEpoch>(&arg1.unstake_epochs)) {
            let v8 = 0x1::vector::borrow_mut<UnstakedInEpoch>(&mut arg1.unstake_epochs, v6);
            if (v8.epoch == v1) {
                v8.amount = v8.amount + v2;
                v7 = true;
                break
            };
            v6 = v6 + 1;
        };
        if (!v7) {
            let v9 = UnstakedInEpoch{
                epoch    : v1,
                amount   : v2,
                approved : false,
            };
            0x1::vector::push_back<UnstakedInEpoch>(&mut arg1.unstake_epochs, v9);
        };
        let v10 = UnstakeRequest{
            id                 : 0x2::object::new(arg3),
            hsui_amount        : 0x2::balance::value<0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::hsui::HSUI>(&arg2),
            sui_amount         : v2,
            claim_epoch        : v1 + arg1.unstake_delay_epoches,
            requested_at_epoch : v1,
        };
        0x2::coin::burn<0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::hsui::HSUI>(&mut arg1.hsui_treasury_cap, 0x2::coin::from_balance<0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::hsui::HSUI>(arg2, arg3));
        arg1.hsui_supply = 0x2::coin::total_supply<0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::hsui::HSUI>(&arg1.hsui_treasury_cap);
        arg1.sui_to_unstake = arg1.sui_to_unstake + v2;
        let v11 = UserUnstakeRequest{
            owner                  : 0x2::tx_context::sender(arg3),
            epoch                  : v1,
            unstake_epoch          : v10.claim_epoch,
            sui_to_claim           : v2,
            hsui_burnt             : v10.hsui_amount,
            sui_claimable_per_hsui : get_sui_claimable_per_hsui(arg1),
            cur_epoch              : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<UserUnstakeRequest>(v11);
        v10
    }

    public fun request_instant_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut HSuiVault, arg2: 0x2::balance::Balance<0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::hsui::HSUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x1::string::utf8(b"STAKING VAULT ::request_instant_unstake() FUNCTION -::- ");
        0x1::debug::print<0x1::string::String>(&v0);
        assert!(arg1.version == 0, 9002);
        assert!(arg1.pause_unstake == false, 9005);
        update_calculated_accrued_rewards(arg0, arg1, arg3);
        let v1 = get_sui_by_hsui(arg1, 0x2::balance::value<0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::hsui::HSUI>(&arg2));
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_to_stake) > v1, 9004);
        let v2 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_to_stake, v1);
        let v3 = 0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::math::mul_div_u128((v1 as u128), (arg1.service_fee_percent as u128), (100000 as u128));
        let v4 = 0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::math::mul_div(v3, arg1.protocol_fee_percent, 100000);
        let v5 = 0x2::balance::split<0x2::sui::SUI>(&mut v2, v3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.hive_fee_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v4));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_to_stake, v5);
        0x2::coin::burn<0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::hsui::HSUI>(&mut arg1.hsui_treasury_cap, 0x2::coin::from_balance<0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::hsui::HSUI>(arg2, arg3));
        arg1.hsui_supply = 0x2::coin::total_supply<0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::hsui::HSUI>(&arg1.hsui_treasury_cap);
        let v6 = get_sui_claimable_per_hsui(arg1);
        arg1.sui_claimable_per_hsui = v6;
        let v7 = UserUnstakedInstantly{
            owner                  : 0x2::tx_context::sender(arg3),
            sui_withdrawn          : v1,
            service_fee_charged    : v3,
            protocol_fee_charged   : v4,
            hsui_burnt             : 0x2::balance::value<0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::hsui::HSUI>(&arg2),
            sui_claimable_per_hsui : v6,
            cur_epoch              : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<UserUnstakedInstantly>(v7);
        v2
    }

    fun sort_vals_in_decreasing_order(arg0: &mut HSuiVault) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg0.validators_with_active_pools)) {
            let v3 = *0x1::vector::borrow<address>(&arg0.validators_with_active_pools, v2);
            0x1::vector::push_back<address>(&mut v0, v3);
            0x1::vector::push_back<u64>(&mut v1, 0x2::table::borrow<address, ValidatorPool>(&mut arg0.validator_pools, v3).total_principal_staked);
            v2 = v2 + 1;
        };
        let v4 = 0x1::vector::length<address>(&v0);
        let v5 = 0;
        while (v5 < v4) {
            let v6 = v5 + 1;
            while (v6 < v4) {
                if (*0x1::vector::borrow<u64>(&v1, v6) > *0x1::vector::borrow<u64>(&v1, v5)) {
                    0x1::vector::swap<u64>(&mut v1, v5, v6);
                    0x1::vector::swap<address>(&mut v0, v5, v6);
                };
                v6 = v6 + 1;
            };
            v5 = v5 + 1;
        };
        v0
    }

    public fun stake_sui_request(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut HSuiVault, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::hsui::HSUI> {
        assert!(arg1.version == 0, 9002);
        assert!(arg1.pause_stake == false, 9003);
        update_calculated_accrued_rewards(arg0, arg1, arg4);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        let v1 = get_hsui_by_sui(arg1, v0);
        let v2 = 0x3::sui_system::active_validator_addresses(arg0);
        if (0x1::option::is_some<address>(&arg3)) {
            assert!(0x1::vector::contains<address>(&v2, 0x1::option::borrow<address>(&arg3)), 9012);
            let v3 = 0x1::option::extract<address>(&mut arg3);
            if (0x2::vec_map::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg1.selected_validator_mapping, &v3)) {
                0x2::balance::join<0x2::sui::SUI>(0x2::vec_map::get_mut<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.selected_validator_mapping, &v3), arg2);
            } else {
                0x2::vec_map::insert<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.selected_validator_mapping, v3, arg2);
            };
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_to_stake, arg2);
        };
        arg1.hsui_supply = 0x2::coin::total_supply<0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::hsui::HSUI>(&arg1.hsui_treasury_cap);
        let v4 = StakeSuiRequest{
            staker                 : 0x2::tx_context::sender(arg4),
            sui_to_stake           : v0,
            hsui_krafted           : v1,
            sui_claimable_per_hsui : get_sui_claimable_per_hsui(arg1),
            cur_epoch              : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<StakeSuiRequest>(v4);
        0x2::coin::mint_balance<0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::hsui::HSUI>(&mut arg1.hsui_treasury_cap, v1)
    }

    fun stake_user_selected_validators(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut HSuiVault, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) : (u64, 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0;
        let v2 = 0x2::vec_map::size<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg1.selected_validator_mapping);
        while (v2 > 0) {
            v2 = v2 - 1;
            let (v3, v4) = 0x2::vec_map::remove_entry_by_idx<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.selected_validator_mapping, v2);
            let v5 = v4;
            let v6 = v3;
            let v7 = 0x2::balance::value<0x2::sui::SUI>(&v5);
            if (v7 >= 1000000000 && 0x1::vector::contains<address>(&arg2, &v6)) {
                v1 = v1 + v7;
                stake_with_validator(arg0, arg1, v6, v5, arg3);
                let v8 = StakeWithSelectedValidatorRequestProcessed{
                    validator_addr   : v6,
                    sui_to_stake_amt : v7,
                    cur_epoch        : 0x2::tx_context::epoch(arg3),
                };
                0x2::event::emit<StakeWithSelectedValidatorRequestProcessed>(v8);
                continue
            };
            0x2::balance::join<0x2::sui::SUI>(&mut v0, v5);
        };
        (v1, v0)
    }

    fun stake_with_validator(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut HSuiVault, arg2: address, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg3);
        if (!0x2::table::contains<address, ValidatorPool>(&arg1.validator_pools, arg2)) {
            let v1 = ValidatorPool{
                staked_sui_objects     : 0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::table_queue::new<0x3::staking_pool::StakedSui>(arg4),
                total_principal_staked : 0,
                accrued_rewards        : 0,
            };
            0x2::table::add<address, ValidatorPool>(&mut arg1.validator_pools, arg2, v1);
            0x1::vector::push_back<address>(&mut arg1.validators_with_active_pools, arg2);
        };
        let v2 = 0x2::table::borrow_mut<address, ValidatorPool>(&mut arg1.validator_pools, arg2);
        v2.total_principal_staked = v2.total_principal_staked + v0;
        let v3 = 0x3::sui_system::request_add_stake_non_entry(arg0, 0x2::coin::from_balance<0x2::sui::SUI>(arg3, arg4), arg2, arg4);
        if (0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::table_queue::length<0x3::staking_pool::StakedSui>(&v2.staked_sui_objects) == 0) {
            0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::table_queue::push_back<0x3::staking_pool::StakedSui>(&mut v2.staked_sui_objects, v3);
        } else if (0x3::staking_pool::stake_activation_epoch(&v3) == 0x3::staking_pool::stake_activation_epoch(0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::table_queue::borrow_tail<0x3::staking_pool::StakedSui>(&v2.staked_sui_objects))) {
            0x3::staking_pool::join_staked_sui(0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::table_queue::borrow_tail_mut<0x3::staking_pool::StakedSui>(&mut v2.staked_sui_objects), v3);
        } else {
            0x9d4b0d280d9e0cc65df7713dea2b11505c20ee9df7cd8cdaa552c27e33096f56::table_queue::push_back<0x3::staking_pool::StakedSui>(&mut v2.staked_sui_objects, v3);
        };
        let v4 = StakeOperationProcessed{
            validator_addr   : arg2,
            sui_to_stake_amt : v0,
            cur_epoch        : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<StakeOperationProcessed>(v4);
        arg1.total_principal_staked = arg1.total_principal_staked + v0;
    }

    public fun to_be_staked_with_validators_list(arg0: &HSuiVault) : (vector<address>, vector<u64>) {
        let v0 = 0x2::vec_map::keys<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping);
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&v0)) {
            let v4 = *0x1::vector::borrow<address>(&v0, v3);
            0x1::vector::push_back<address>(&mut v1, v4);
            0x1::vector::push_back<u64>(&mut v2, 0x2::balance::value<0x2::sui::SUI>(0x2::vec_map::get<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping, &v4)));
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    fun unstake_from_validator_pools(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut HSuiVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (u64, 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = 0x1::string::utf8(b"Internal -::- unstake_from_validator_pools(), total_sui_to_unstake = ");
        0x1::debug::print<0x1::string::String>(&v0);
        0x1::debug::print<u64>(&arg2);
        let v1 = 0x2::balance::zero<0x2::sui::SUI>();
        let v2 = sort_vals_in_decreasing_order(arg1);
        let v3 = 0x1::vector::length<address>(&arg1.validators_with_active_pools);
        let v4 = 0;
        while (arg2 > 0 && v4 < v3) {
            let v5 = &mut v1;
            let v6 = 0x2::tx_context::epoch(arg3);
            let (v7, v8) = execute_validator_unstake(arg0, arg1, v5, *0x1::vector::borrow<address>(&v2, v4), arg2, v6, arg3);
            arg2 = v7;
            let v9 = 0x1::string::utf8(b"Result from execute_validator_unstake() internal Function, total_sui_to_unstake = ");
            0x1::debug::print<0x1::string::String>(&v9);
            0x1::debug::print<u64>(&arg2);
            if (v8) {
                0x1::vector::remove<address>(&mut v2, v4);
                v3 = v3 - 1;
                continue
            };
            v4 = v4 + 1;
        };
        let v10 = 0x1::string::utf8(b"Internal -::- total_sui_unstaked from all Validator Pools balance = ");
        0x1::debug::print<0x1::string::String>(&v10);
        let v11 = 0x2::balance::value<0x2::sui::SUI>(&v1);
        0x1::debug::print<u64>(&v11);
        if (0x2::balance::value<0x2::sui::SUI>(&v1) >= arg1.uncollected_protocol_fees) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.hive_fee_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v1, arg1.uncollected_protocol_fees));
            arg1.uncollected_protocol_fees = 0;
            let v12 = 0x1::string::utf8(b"vault.uncollected_protocol_fees is 0 now  ");
            0x1::debug::print<0x1::string::String>(&v12);
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.hive_fee_vault, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v1));
            arg1.uncollected_protocol_fees = arg1.uncollected_protocol_fees - 0x2::balance::value<0x2::sui::SUI>(&v1);
            let v13 = 0x1::string::utf8(b"vault.uncollected_protocol_fees   ");
            0x1::debug::print<0x1::string::String>(&v13);
            0x1::debug::print<u64>(&arg1.uncollected_protocol_fees);
        };
        (arg2, v1)
    }

    fun unstake_inactive_validators(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut HSuiVault, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3::sui_system::active_validator_addresses(arg0);
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x2::tx_context::epoch(arg2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg1.validators_with_active_pools)) {
            let v4 = *0x1::vector::borrow<address>(&arg1.validators_with_active_pools, v3);
            if (!0x1::vector::contains<address>(&v0, &v4)) {
                0x1::vector::push_back<address>(&mut v1, v4);
            };
            v3 = v3 + 1;
        };
        let v5 = 0x2::balance::zero<0x2::sui::SUI>();
        let v6 = 0;
        while (v6 < 0x1::vector::length<address>(&v1)) {
            let v7 = &mut v5;
            let (_, _) = execute_validator_unstake(arg0, arg1, v7, *0x1::vector::borrow<address>(&v1, v6), 18446744073709551615, v2, arg2);
            v6 = v6 + 1;
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v5) >= arg1.uncollected_protocol_fees) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.hive_fee_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v5, arg1.uncollected_protocol_fees));
            arg1.uncollected_protocol_fees = 0;
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.hive_fee_vault, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v5));
            arg1.uncollected_protocol_fees = arg1.uncollected_protocol_fees - 0x2::balance::value<0x2::sui::SUI>(&v5);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_to_stake, v5);
    }

    public fun update_calculated_accrued_rewards(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut HSuiVault, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 9002);
        let v0 = 0x2::tx_context::epoch(arg2);
        if (v0 == arg1.rewards_last_updated_epoch) {
            return
        };
        let v1 = get_sui_claimable_per_hsui(arg1);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg1.validators_with_active_pools)) {
            let v4 = *0x1::vector::borrow<address>(&arg1.validators_with_active_pools, v3);
            let v5 = 0x2::table::borrow_mut<address, ValidatorPool>(&mut arg1.validator_pools, v4);
            v2 = v2 + calculate_validator_pool_rewards_increase(arg0, v4, v5, v0);
            v3 = v3 + 1;
        };
        let v6 = 0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::math::mul_div_u128((v2 as u128), (arg1.protocol_fee_percent as u128), (100000 as u128));
        arg1.total_accrued_rewards = arg1.total_accrued_rewards + v2;
        arg1.uncollected_protocol_fees = arg1.uncollected_protocol_fees + v6;
        arg1.rewards_last_updated_epoch = v0;
        let v7 = get_sui_claimable_per_hsui(arg1);
        arg1.sui_claimable_per_hsui = v7;
        let v8 = TotalRewardsUpdated{
            cur_epoch                   : v0,
            total_principal_staked      : arg1.total_principal_staked,
            sui_to_unstake              : arg1.sui_to_unstake,
            total_accrued_rewards       : arg1.total_accrued_rewards,
            new_rewards                 : v2,
            uncollected_protocol_fees   : arg1.uncollected_protocol_fees,
            protocol_fee_on_new_rewards : v6,
            prev_sui_claimable_per_hsui : v1,
            new_sui_claimable_per_hsui  : v7,
            exchange_rate_increase      : v7 - v1,
        };
        0x2::event::emit<TotalRewardsUpdated>(v8);
    }

    public fun update_global_fee_config(arg0: &0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::config::HiveDaoCapability, arg1: &mut HSuiVault, arg2: u64, arg3: u64) {
        assert!(arg1.version == 0, 9002);
        let v0 = 0x1::string::utf8(b"STAKING VAULT ::update_global_fee_config() FUNCTION -::- ");
        0x1::debug::print<0x1::string::String>(&v0);
        assert!(arg2 < 10000 && arg3 < 5000, 9001);
        if (arg2 > 0) {
            arg1.protocol_fee_percent = arg2;
        };
        if (arg3 > 0) {
            arg1.service_fee_percent = arg3;
        };
    }

    public fun update_protocol_fee_distribution(arg0: &0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::config::HiveDaoCapability, arg1: &mut HSuiVault, arg2: u64) {
        assert!(arg1.version == 0, 9002);
        let v0 = 0x1::string::utf8(b"STAKING VAULT ::update_protocol_fee_distribution() FUNCTION -::- ");
        0x1::debug::print<0x1::string::String>(&v0);
        assert!(arg2 < 50000, 9001);
        if (arg2 > 0) {
            arg1.fee_distribution.treasury_percent = arg2;
        };
    }

    public fun update_validator_list(arg0: &0x30afa04998585173ebfad211e890a1faac453adc7cf0928294d96a73abb65820::config::HiveDaoCapability, arg1: &mut HSuiVault, arg2: vector<address>, arg3: bool) {
        assert!(arg1.version == 0, 9002);
        let v0 = 0x1::string::utf8(b"STAKING VAULT ::update_validator_list() FUNCTION -::- ");
        0x1::debug::print<0x1::string::String>(&v0);
        if (arg3) {
            let v1 = 0;
            while (v1 < 0x1::vector::length<address>(&arg2)) {
                let v2 = *0x1::vector::borrow<address>(&arg2, v1);
                if (!0x1::vector::contains<address>(&arg1.whitelisted_validators, &v2)) {
                    0x1::vector::push_back<address>(&mut arg1.whitelisted_validators, v2);
                };
                v1 = v1 + 1;
            };
        };
        if (!arg3) {
            let v3 = 0;
            while (v3 < 0x1::vector::length<address>(&arg2)) {
                let v4 = *0x1::vector::borrow<address>(&arg2, v3);
                let (v5, v6) = 0x1::vector::index_of<address>(&arg1.whitelisted_validators, &v4);
                if (v5) {
                    0x1::vector::remove<address>(&mut arg1.whitelisted_validators, v6);
                };
                v3 = v3 + 1;
            };
        };
        let v7 = ValidatorListUpdated{
            validator_list : arg2,
            to_add         : arg3,
        };
        0x2::event::emit<ValidatorListUpdated>(v7);
    }

    fun withdraw_staked_sui(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x3::staking_pool::StakedSui, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = calculate_staked_sui_rewards(arg0, &arg1, arg3);
        let v1 = 0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg1, arg4);
        0x2::balance::join<0x2::sui::SUI>(arg2, v1);
        (0x2::balance::value<0x2::sui::SUI>(&v1), 0x3::staking_pool::staked_sui_amount(&arg1), v0)
    }

    // decompiled from Move bytecode v6
}

