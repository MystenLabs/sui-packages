module 0x5d829a29b88abbff19eee8afd42da32007ea11ff74e87cfbcd0f11f3b1ae130c::dsui_vault {
    struct DSuiVault has key {
        id: 0x2::object::UID,
        config_params: ConfigParams,
        dsui_kraft_cap: 0x2::coin::TreasuryCap<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::dsui::DSUI>,
        whitelisted_validators: vector<address>,
        validator_pools: 0x2::linked_table::LinkedTable<address, ValidatorPool>,
        selected_validator_mapping: 0x2::linked_table::LinkedTable<address, 0x2::balance::Balance<0x2::sui::SUI>>,
        sui_to_stake: 0x2::balance::Balance<0x2::sui::SUI>,
        hive_fee_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        unstaked_sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        unstake_epochs: 0x2::linked_table::LinkedTable<u64, RequestsForEpoch>,
        total_principal_staked: u64,
        total_accrued_rewards: u64,
        sui_to_unstake: u64,
        uncollected_protocol_fees: u64,
        dsui_supply: u64,
        rewards_last_updated_epoch: u64,
        sui_claimable_per_dsui: u128,
        version: u64,
    }

    struct UnstakeRequest has store, key {
        id: 0x2::object::UID,
        dsui_amount: u64,
        sui_amount: u64,
        requested_at_epoch: u64,
    }

    struct ConfigParams has store {
        pause_stake: bool,
        protocol_fee_percent: u64,
        service_fee_percent: u64,
        unstake_delay_epoches: u64,
        treasury_percent: u64,
    }

    struct ValidatorPool has store {
        staked_sui_objects: 0x2::linked_table::LinkedTable<u64, 0x3::staking_pool::StakedSui>,
        total_principal_staked: u64,
        accrued_rewards: u64,
    }

    struct RequestsForEpoch has store {
        amount: u64,
        approved: bool,
    }

    struct ValidatorListUpdated has copy, drop {
        validator_list: vector<address>,
        to_add: bool,
    }

    struct DegenSUIFeeStructureUpdated has copy, drop {
        protocol_fee_percent: u64,
        service_fee_percent: u64,
        treasury_percent: u64,
    }

    struct EmergencyPauseUpdate has copy, drop {
        pause_stake: bool,
    }

    struct StakeSuiRequest has copy, drop {
        staker: address,
        sui_to_stake: u64,
        dsui_krafted: u64,
        sui_claimable_per_dsui: u128,
        cur_epoch: u64,
    }

    struct UserUnstakedInstantly has copy, drop {
        owner: address,
        sui_withdrawn: u64,
        service_fee_charged: u64,
        protocol_fee_charged: u64,
        dsui_burnt: u64,
        sui_claimable_per_dsui: u128,
        cur_epoch: u64,
    }

    struct UserUnstakeRequest has copy, drop {
        owner: address,
        unstake_epoch: u64,
        sui_to_claim: u64,
        dsui_burnt: u64,
        sui_claimable_per_dsui: u128,
        cur_epoch: u64,
    }

    struct UserClaimedSui has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        sui_withdrawn: u64,
        sui_claimable_per_dsui: u128,
        cur_epoch: u64,
    }

    struct RequestsForEpochDestroyed has copy, drop {
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
        sui_claimable_per_dsui: u128,
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
        prev_sui_claimable_per_dsui: u128,
        new_sui_claimable_per_dsui: u128,
        exchange_rate_increase: u128,
    }

    struct ValidatorPoolDestroyed has copy, drop {
        validator_address: address,
        cur_epoch: u64,
    }

    struct UnstakingRequestsProcessed has copy, drop {
        cur_epoch: u64,
        total_sui_unstaked: u64,
        sui_claimable_per_dsui: u128,
    }

    struct LsdFeeCollected has copy, drop {
        collected_fees_amt: u64,
        treasury_fees: u64,
        sui_for_buyback: u64,
    }

    public fun admin_emergency_pause_update(arg0: &0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::yield_flow::DeployerCap, arg1: &mut DSuiVault, arg2: bool) {
        assert!(arg1.version == 0, 9002);
        arg1.config_params.pause_stake = arg2;
        let v0 = EmergencyPauseUpdate{pause_stake: arg1.config_params.pause_stake};
        0x2::event::emit<EmergencyPauseUpdate>(v0);
    }

    fun calculate_staked_sui_rewards(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x3::staking_pool::StakedSui, arg2: u64) : u64 {
        0x5d829a29b88abbff19eee8afd42da32007ea11ff74e87cfbcd0f11f3b1ae130c::helper::calculate_rewards(arg0, 0x3::staking_pool::pool_id(arg1), 0x3::staking_pool::staked_sui_amount(arg1), 0x3::staking_pool::stake_activation_epoch(arg1), arg2)
    }

    fun calculate_validator_pool_rewards_increase(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: address, arg2: &mut ValidatorPool, arg3: u64) : u64 {
        let v0 = 0;
        let v1 = *0x2::linked_table::front<u64, 0x3::staking_pool::StakedSui>(&arg2.staked_sui_objects);
        while (0x1::option::is_some<u64>(&v1)) {
            let v2 = *0x1::option::borrow<u64>(&v1);
            v0 = v0 + calculate_staked_sui_rewards(arg0, 0x2::linked_table::borrow<u64, 0x3::staking_pool::StakedSui>(&arg2.staked_sui_objects, v2), arg3);
            v1 = *0x2::linked_table::next<u64, 0x3::staking_pool::StakedSui>(&arg2.staked_sui_objects, v2);
        };
        let v3 = arg2.accrued_rewards;
        arg2.accrued_rewards = v0;
        let v4 = if (v3 > v0) {
            0
        } else {
            v0 - v3
        };
        let v5 = ValidatorPoolRewardsUpdated{
            validator_addr         : arg1,
            total_staked_sui_objs  : 0x2::linked_table::length<u64, 0x3::staking_pool::StakedSui>(&arg2.staked_sui_objects),
            prev_rewards           : v3,
            new_rewards            : v4,
            total_principal_staked : arg2.total_principal_staked,
            cur_epoch              : arg3,
        };
        0x2::event::emit<ValidatorPoolRewardsUpdated>(v5);
        v0 - v3
    }

    public entry fun claim_collected_lsd_fee(arg0: &mut DSuiVault, arg1: &mut 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::yield_flow::YieldFlow, arg2: &mut 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::yield_flow::FeeCollector<0x2::sui::SUI>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 9002);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.hive_fee_vault);
        let v1 = 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u128((v0 as u128), (arg0.config_params.treasury_percent as u128), (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::percent_precision() as u128));
        if (v1 > 0) {
            0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::yield_flow::add_to_treasury(arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.hive_fee_vault, v1));
        };
        0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::yield_flow::collect_fee_for_coin<0x2::sui::SUI>(arg2, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.hive_fee_vault));
        let v2 = LsdFeeCollected{
            collected_fees_amt : v0,
            treasury_fees      : v1,
            sui_for_buyback    : 0x2::balance::value<0x2::sui::SUI>(&arg0.hive_fee_vault),
        };
        0x2::event::emit<LsdFeeCollected>(v2);
    }

    fun claim_unstake_epoch(arg0: &mut DSuiVault, arg1: u64, arg2: u64) {
        let v0 = 0x2::linked_table::borrow_mut<u64, RequestsForEpoch>(&mut arg0.unstake_epochs, arg1);
        assert!(v0.approved, 9007);
        v0.amount = v0.amount - arg2;
        if (v0.amount == 0) {
            let (_, _) = destroy_unstake_epoch(arg1, 0x2::linked_table::remove<u64, RequestsForEpoch>(&mut arg0.unstake_epochs, arg1));
        };
    }

    public fun claim_unstaked_sui(arg0: &mut DSuiVault, arg1: UnstakeRequest, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg0.version == 0, 9002);
        let (v0, _, v2, v3) = destroy_ticket(arg1);
        assert!(v3 + arg0.config_params.unstake_delay_epoches <= 0x2::tx_context::epoch(arg2), 9008);
        claim_unstake_epoch(arg0, v3, v2);
        let v4 = UserClaimedSui{
            id                     : v0,
            owner                  : 0x2::tx_context::sender(arg2),
            sui_withdrawn          : v2,
            sui_claimable_per_dsui : get_sui_claimable_per_dsui(arg0),
            cur_epoch              : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<UserClaimedSui>(v4);
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.unstaked_sui_reserve, v2)
    }

    fun destroy_ticket(arg0: UnstakeRequest) : (0x2::object::ID, u64, u64, u64) {
        let UnstakeRequest {
            id                 : v0,
            dsui_amount        : v1,
            sui_amount         : v2,
            requested_at_epoch : v3,
        } = arg0;
        let v4 = v0;
        0x2::object::delete(v4);
        (0x2::object::uid_to_inner(&v4), v1, v2, v3)
    }

    fun destroy_unstake_epoch(arg0: u64, arg1: RequestsForEpoch) : (u64, bool) {
        let RequestsForEpoch {
            amount   : v0,
            approved : v1,
        } = arg1;
        let v2 = RequestsForEpochDestroyed{epoch: arg0};
        0x2::event::emit<RequestsForEpochDestroyed>(v2);
        (v0, v1)
    }

    fun destroy_validator_pool(arg0: &mut DSuiVault, arg1: address, arg2: u64) : (u64, u64) {
        let ValidatorPool {
            staked_sui_objects     : v0,
            total_principal_staked : v1,
            accrued_rewards        : v2,
        } = 0x2::linked_table::remove<address, ValidatorPool>(&mut arg0.validator_pools, arg1);
        0x2::linked_table::destroy_empty<u64, 0x3::staking_pool::StakedSui>(v0);
        let v3 = ValidatorPoolDestroyed{
            validator_address : arg1,
            cur_epoch         : arg2,
        };
        0x2::event::emit<ValidatorPoolDestroyed>(v3);
        (v1, v2)
    }

    fun do_before_unstake(arg0: &mut DSuiVault, arg1: &0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 0;
        let v1 = *0x2::linked_table::front<u64, RequestsForEpoch>(&arg0.unstake_epochs);
        while (0x1::option::is_some<u64>(&v1)) {
            let v2 = 0x1::option::extract<u64>(&mut v1);
            let v3 = 0x2::linked_table::borrow_mut<u64, RequestsForEpoch>(&mut arg0.unstake_epochs, v2);
            if (0x2::tx_context::epoch(arg1) >= v2 + arg0.config_params.unstake_delay_epoches && !v3.approved) {
                v0 = v0 + v3.amount;
                v3.approved = true;
            };
            v1 = *0x2::linked_table::next<u64, RequestsForEpoch>(&arg0.unstake_epochs, v2);
        };
        let v4 = arg0.uncollected_protocol_fees + v0;
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_to_stake);
        if (v4 < v5) {
            return (v5 - v4, v0, arg0.uncollected_protocol_fees)
        };
        (0, v4, arg0.uncollected_protocol_fees)
    }

    public fun emergency_pause_update(arg0: &0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::yield_flow::DragonDaoCapability, arg1: &mut DSuiVault, arg2: bool) {
        assert!(arg1.version == 0, 9002);
        arg1.config_params.pause_stake = arg2;
        let v0 = EmergencyPauseUpdate{pause_stake: arg1.config_params.pause_stake};
        0x2::event::emit<EmergencyPauseUpdate>(v0);
    }

    fun execute_validator_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg3: address, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (u64, bool) {
        let v0 = false;
        let v1 = v0;
        if (!0x2::linked_table::contains<address, ValidatorPool>(&arg1.validator_pools, arg3)) {
            return (0, v0)
        };
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x2::linked_table::borrow_mut<address, ValidatorPool>(&mut arg1.validator_pools, arg3);
        while (arg4 > 0 && 0x2::linked_table::length<u64, 0x3::staking_pool::StakedSui>(&v4.staked_sui_objects) > 0) {
            let v5 = *0x2::linked_table::back<u64, 0x3::staking_pool::StakedSui>(&v4.staked_sui_objects);
            let v6 = *0x1::option::borrow<u64>(&v5);
            let (_, _, v9, v10) = get_split_amount(arg0, 0x2::linked_table::borrow<u64, 0x3::staking_pool::StakedSui>(&v4.staked_sui_objects, v6), arg4, arg5);
            if (v10 > 0) {
                let v11 = if (v9 > 0) {
                    0x3::staking_pool::split(0x2::linked_table::borrow_mut<u64, 0x3::staking_pool::StakedSui>(&mut v4.staked_sui_objects, v6), v10, arg6)
                } else {
                    let (_, v13) = 0x2::linked_table::pop_back<u64, 0x3::staking_pool::StakedSui>(&mut v4.staked_sui_objects);
                    v13
                };
                let (v14, v15, v16) = withdraw_staked_sui(arg0, v11, arg2, arg5, arg6);
                v2 = v2 + v15;
                v3 = v3 + v16;
                if (v14 <= arg4) {
                    arg4 = arg4 - v14;
                } else {
                    arg4 = 0;
                };
                arg1.total_principal_staked = arg1.total_principal_staked - v15;
                arg1.total_accrued_rewards = arg1.total_accrued_rewards - v16;
                v4.total_principal_staked = v4.total_principal_staked - v15;
                v4.accrued_rewards = v4.accrued_rewards - v16;
            };
        };
        if (0x2::linked_table::is_empty<u64, 0x3::staking_pool::StakedSui>(&v4.staked_sui_objects)) {
            let (_, _) = destroy_validator_pool(arg1, arg3, arg5);
            v1 = true;
        };
        (arg4, v1)
    }

    public fun get_dsui_by_sui(arg0: &DSuiVault, arg1: u64) : u64 {
        let v0 = get_total_sui(arg0);
        if (v0 == 0 || arg0.dsui_supply == 0) {
            return arg1
        };
        (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u256((arg1 as u256), (arg0.dsui_supply as u256), (v0 as u256)) as u64)
    }

    fun get_split_amount(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &0x3::staking_pool::StakedSui, arg2: u64, arg3: u64) : (u64, u64, u64, u64) {
        let v0 = 0x3::staking_pool::staked_sui_amount(arg1);
        let v1 = 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::lsd_exchange_rate_precision();
        if (0x3::staking_pool::stake_activation_epoch(arg1) > arg3) {
            return (v0, 0, 0, 0)
        };
        let v2 = calculate_staked_sui_rewards(arg0, arg1, arg3);
        let v3 = v0 + v2;
        if (v3 < arg2) {
            return (v0, v2, 0, v3)
        };
        let v4 = ((0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u256((v1 as u256) * (arg2 as u256), (v0 as u256), (v3 as u256)) / (v1 as u256)) as u64) + 1;
        let v5 = v0 - v4;
        if (v4 < 1000000000) {
            if (v0 - 1000000000 < 1000000000) {
                return (v0, v2, 0, v3)
            };
            return (v0, v2, v0 - 1000000000, 1000000000)
        };
        if (v5 >= 1000000000) {
            return (v0, v2, v5, v4)
        };
        (v0, v2, 0, v3)
    }

    public fun get_sui_by_dsui(arg0: &DSuiVault, arg1: u64) : u64 {
        let v0 = get_total_sui(arg0);
        if (v0 == 0 || arg0.dsui_supply == 0) {
            return arg1
        };
        (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u256((v0 as u256), (arg1 as u256), (arg0.dsui_supply as u256)) as u64)
    }

    public fun get_sui_claimable_per_dsui(arg0: &DSuiVault) : u128 {
        let v0 = get_total_sui(arg0);
        let v1 = arg0.dsui_supply;
        if (v0 == 0 || v1 == 0) {
            return (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::lsd_exchange_rate_precision() as u128)
        };
        (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u256((v0 as u256), (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::lsd_exchange_rate_precision() as u256), (v1 as u256)) as u128)
    }

    public fun get_total_sui(arg0: &DSuiVault) : u64 {
        let v0 = *0x2::linked_table::front<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping);
        let v1 = 0;
        while (0x1::option::is_some<address>(&v0)) {
            let v2 = *0x1::option::borrow<address>(&v0);
            v1 = v1 + 0x2::balance::value<0x2::sui::SUI>(0x2::linked_table::borrow<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping, v2));
            v0 = *0x2::linked_table::next<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping, v2);
        };
        arg0.total_principal_staked + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_to_stake) + v1 + arg0.total_accrued_rewards - arg0.uncollected_protocol_fees - arg0.sui_to_unstake
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun init_dsui_vault(arg0: 0x2::coin::TreasuryCap<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::dsui::DSUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ConfigParams{
            pause_stake           : false,
            protocol_fee_percent  : 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::lsd_init_protocol_fee_percent(),
            service_fee_percent   : 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::lsd_init_service_fee_percent(),
            unstake_delay_epoches : 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::lsd_init_delay_epoches(),
            treasury_percent      : 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::lsd_init_treasury_fee_percent(),
        };
        let v1 = DSuiVault{
            id                         : 0x2::object::new(arg1),
            config_params              : v0,
            dsui_kraft_cap             : arg0,
            whitelisted_validators     : 0x1::vector::empty<address>(),
            validator_pools            : 0x2::linked_table::new<address, ValidatorPool>(arg1),
            selected_validator_mapping : 0x2::linked_table::new<address, 0x2::balance::Balance<0x2::sui::SUI>>(arg1),
            sui_to_stake               : 0x2::balance::zero<0x2::sui::SUI>(),
            hive_fee_vault             : 0x2::balance::zero<0x2::sui::SUI>(),
            unstaked_sui_reserve       : 0x2::balance::zero<0x2::sui::SUI>(),
            unstake_epochs             : 0x2::linked_table::new<u64, RequestsForEpoch>(arg1),
            total_principal_staked     : 0,
            total_accrued_rewards      : 0,
            sui_to_unstake             : 0,
            uncollected_protocol_fees  : 0,
            dsui_supply                : 0,
            rewards_last_updated_epoch : 0x2::tx_context::epoch(arg1),
            sui_claimable_per_dsui     : (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::lsd_exchange_rate_precision() as u128),
            version                    : 0,
        };
        0x2::transfer::share_object<DSuiVault>(v1);
    }

    public fun migrate(arg0: &mut DSuiVault) {
        assert!(arg0.version < 0, 9002);
        arg0.version = 0;
    }

    public fun process_stake_sui_requests(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        let v1 = 0x3::sui_system::active_validator_addresses(arg0);
        assert!(arg1.version == 0, 9002);
        if (arg1.rewards_last_updated_epoch < 0x2::tx_context::epoch(arg2)) {
            update_calculated_accrued_rewards(arg0, arg1, arg2);
        };
        let (v2, v3) = stake_user_selected_validators(arg0, arg1, v1, arg2);
        let v4 = v2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_to_stake, v3);
        let v5 = 0;
        let v6 = arg1.uncollected_protocol_fees;
        let v7 = *0x2::linked_table::front<u64, RequestsForEpoch>(&arg1.unstake_epochs);
        while (0x1::option::is_some<u64>(&v7)) {
            let v8 = 0x1::option::extract<u64>(&mut v7);
            let v9 = 0x2::linked_table::borrow_mut<u64, RequestsForEpoch>(&mut arg1.unstake_epochs, v8);
            if (v0 >= v8 + arg1.config_params.unstake_delay_epoches && !v9.approved) {
                v9.approved = true;
                if (v9.amount <= 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_to_stake)) {
                    0x2::balance::join<0x2::sui::SUI>(&mut arg1.unstaked_sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_to_stake, v9.amount));
                    arg1.sui_to_unstake = arg1.sui_to_unstake - v9.amount;
                    v5 = v5 + v9.amount;
                } else {
                    let v10 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_to_stake);
                    let v11 = v6 + v9.amount;
                    v6 = v11 - v10;
                    arg1.sui_to_unstake = arg1.sui_to_unstake - v10;
                    0x2::balance::join<0x2::sui::SUI>(&mut arg1.unstaked_sui_reserve, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.sui_to_stake));
                    v5 = v5 + v10;
                };
            };
            v7 = *0x2::linked_table::next<u64, RequestsForEpoch>(&arg1.unstake_epochs, v8);
        };
        let v12 = 0;
        if (v6 > 0) {
            let (_, v14) = unstake_from_validator_pools(arg0, arg1, v6, arg2);
            let v15 = v14;
            let v16 = 0x2::balance::value<0x2::sui::SUI>(&v15);
            v12 = v16;
            if (arg1.sui_to_unstake >= v16) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg1.unstaked_sui_reserve, v15);
                arg1.sui_to_unstake = arg1.sui_to_unstake - v16;
            } else {
                0x2::balance::join<0x2::sui::SUI>(&mut arg1.unstaked_sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut v15, arg1.sui_to_unstake));
                arg1.sui_to_unstake = 0;
                0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_to_stake, v15);
            };
        };
        if (0x2::balance::value<0x2::sui::SUI>(&arg1.sui_to_stake) > 0x1::vector::length<address>(&arg1.whitelisted_validators) * 1000000000) {
            let v17 = 0;
            let v18 = 0;
            while (v18 < 0x1::vector::length<address>(&arg1.whitelisted_validators)) {
                let v19 = *0x1::vector::borrow<address>(&arg1.whitelisted_validators, v18);
                if (0x1::vector::contains<address>(&v1, &v19)) {
                    v17 = v17 + 1;
                };
                v18 = v18 + 1;
            };
            assert!(v17 > 0, 9009);
            let v20 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_to_stake) / v17;
            if (v20 > 1000000000) {
                let v21 = 0;
                while (v21 < 0x1::vector::length<address>(&arg1.whitelisted_validators) - 1) {
                    let v22 = *0x1::vector::borrow<address>(&arg1.whitelisted_validators, v21);
                    if (0x1::vector::contains<address>(&v1, &v22)) {
                        let v23 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_to_stake, v20);
                        v4 = v4 + v20;
                        stake_with_validator(arg0, arg1, v22, v23, arg2);
                    };
                    v21 = v21 + 1;
                };
                let v24 = *0x1::vector::borrow<address>(&arg1.whitelisted_validators, v21);
                if (0x1::vector::contains<address>(&v1, &v24)) {
                    let v25 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.sui_to_stake);
                    v4 = v4 + 0x2::balance::value<0x2::sui::SUI>(&v25);
                    stake_with_validator(arg0, arg1, v24, v25, arg2);
                };
            };
        };
        let v26 = StakeSuiRequestsProcessed{
            cur_epoch                               : v0,
            total_sui_staked                        : v4,
            unstaked_sui_added_to_reserve_after_fee : v12,
            protocol_fee_collected                  : 0,
            sui_claimable_per_dsui                  : get_sui_claimable_per_dsui(arg1),
        };
        0x2::event::emit<StakeSuiRequestsProcessed>(v26);
    }

    public fun process_unstake_sui_requests(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 9002);
        unstake_inactive_validators(arg0, arg1, arg2);
        update_calculated_accrued_rewards(arg0, arg1, arg2);
        let (_, v1, _) = do_before_unstake(arg1, arg2);
        let (_, v4) = unstake_from_validator_pools(arg0, arg1, v1, arg2);
        let v5 = v4;
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&v5);
        if (v6 >= arg1.sui_to_unstake) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.unstaked_sui_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut v5, arg1.sui_to_unstake));
            arg1.sui_to_unstake = 0;
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_to_stake, v5);
        } else {
            arg1.sui_to_unstake = arg1.sui_to_unstake - v6;
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.unstaked_sui_reserve, v5);
        };
        let v7 = UnstakingRequestsProcessed{
            cur_epoch              : 0x2::tx_context::epoch(arg2),
            total_sui_unstaked     : v6,
            sui_claimable_per_dsui : get_sui_claimable_per_dsui(arg1),
        };
        0x2::event::emit<UnstakingRequestsProcessed>(v7);
    }

    public fun query_all_selected_validator_mapping(arg0: &DSuiVault, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping)
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<address>(&v3) && v4 < arg2) {
            let v5 = 0x1::option::borrow<address>(&v3);
            0x1::vector::push_back<address>(&mut v0, *v5);
            0x1::vector::push_back<u64>(&mut v1, 0x2::balance::value<0x2::sui::SUI>(0x2::linked_table::borrow<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping, *v5)));
            v3 = *0x2::linked_table::next<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping, *v5);
            v4 = v4 + 1;
        };
        (v0, v1, 0x2::linked_table::length<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping))
    }

    public fun query_all_staked_sui_objs_for_pool(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &DSuiVault, arg2: address, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: &0x2::tx_context::TxContext) : (vector<u64>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x2::linked_table::borrow<address, ValidatorPool>(&arg1.validator_pools, arg2);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = if (0x1::option::is_some<u64>(&arg3)) {
            arg3
        } else {
            *0x2::linked_table::front<u64, 0x3::staking_pool::StakedSui>(&v0.staked_sui_objects)
        };
        let v6 = v5;
        let v7 = 0;
        while (0x1::option::is_some<u64>(&v6) && v7 < arg4) {
            let v8 = 0x1::option::borrow<u64>(&v6);
            let v9 = 0x2::linked_table::borrow<u64, 0x3::staking_pool::StakedSui>(&v0.staked_sui_objects, *v8);
            let v10 = 0x3::staking_pool::stake_activation_epoch(v9);
            let v11 = 0x3::staking_pool::staked_sui_amount(v9);
            0x1::vector::push_back<u64>(&mut v1, *v8);
            0x1::vector::push_back<u64>(&mut v2, v10);
            0x1::vector::push_back<u64>(&mut v3, v11);
            0x1::vector::push_back<u64>(&mut v4, 0x5d829a29b88abbff19eee8afd42da32007ea11ff74e87cfbcd0f11f3b1ae130c::helper::calculate_rewards(arg0, 0x3::staking_pool::pool_id(v9), v11, v10, 0x2::tx_context::epoch(arg5)));
            v6 = *0x2::linked_table::next<u64, 0x3::staking_pool::StakedSui>(&v0.staked_sui_objects, *v8);
            v7 = v7 + 1;
        };
        (v1, v2, v3, v4, 0x2::linked_table::length<u64, 0x3::staking_pool::StakedSui>(&v0.staked_sui_objects))
    }

    public fun query_dsui_vault_config(arg0: &DSuiVault) : (bool, u64, u64, u64, u64) {
        (arg0.config_params.pause_stake, arg0.config_params.protocol_fee_percent, arg0.config_params.service_fee_percent, arg0.config_params.unstake_delay_epoches, arg0.config_params.treasury_percent)
    }

    public fun query_request_delayed_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg1.version == 0, 9002);
        update_calculated_accrued_rewards(arg0, arg1, arg3);
        let v0 = get_sui_by_dsui(arg1, arg2);
        if (v0 > get_total_sui(arg1)) {
            return 0
        };
        v0
    }

    public fun query_request_instant_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        assert!(arg1.version == 0, 9002);
        update_calculated_accrued_rewards(arg0, arg1, arg3);
        let v0 = get_sui_by_dsui(arg1, arg2);
        if (0x2::balance::value<0x2::sui::SUI>(&arg1.sui_to_stake) < v0) {
            return (0, 0, 0)
        };
        let v1 = 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::percent_precision();
        let v2 = 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u128((v0 as u128), (arg1.config_params.service_fee_percent as u128), (v1 as u128));
        (v0 - v2, v2, 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div(v2, arg1.config_params.protocol_fee_percent, v1))
    }

    public fun query_selected_validator_mapping(arg0: &DSuiVault, arg1: address) : u64 {
        0x2::balance::value<0x2::sui::SUI>(0x2::linked_table::borrow<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.selected_validator_mapping, arg1))
    }

    public fun query_stake_sui_request(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg1.version == 0, 9002);
        assert!(arg1.config_params.pause_stake == false, 9003);
        update_calculated_accrued_rewards(arg0, arg1, arg3);
        get_dsui_by_sui(arg1, arg2)
    }

    public fun query_staked_sui_obj_for_pool(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &DSuiVault, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = 0x2::linked_table::borrow<u64, 0x3::staking_pool::StakedSui>(&0x2::linked_table::borrow<address, ValidatorPool>(&arg1.validator_pools, arg2).staked_sui_objects, arg3);
        let v1 = 0x3::staking_pool::stake_activation_epoch(v0);
        let v2 = 0x3::staking_pool::staked_sui_amount(v0);
        (v1, v2, 0x5d829a29b88abbff19eee8afd42da32007ea11ff74e87cfbcd0f11f3b1ae130c::helper::calculate_rewards(arg0, 0x3::staking_pool::pool_id(v0), v2, v1, 0x2::tx_context::epoch(arg4)))
    }

    public fun query_sui_available_with_vault_overview(arg0: &DSuiVault) : (u64, u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_to_stake), 0x2::balance::value<0x2::sui::SUI>(&arg0.hive_fee_vault), 0x2::balance::value<0x2::sui::SUI>(&arg0.unstaked_sui_reserve))
    }

    public fun query_unstake_request(arg0: &UnstakeRequest) : (u64, u64, u64) {
        (arg0.dsui_amount, arg0.sui_amount, arg0.requested_at_epoch)
    }

    public fun query_unstake_request_claim_epoch(arg0: &DSuiVault, arg1: &UnstakeRequest) : u64 {
        arg1.requested_at_epoch + arg0.config_params.unstake_delay_epoches
    }

    public fun query_unstake_request_for_epoch(arg0: &DSuiVault, arg1: u64) : (u64, bool) {
        let v0 = 0x2::linked_table::borrow<u64, RequestsForEpoch>(&arg0.unstake_epochs, arg1);
        (v0.amount, v0.approved)
    }

    public fun query_unstake_request_for_epochs(arg0: &DSuiVault, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<u64>, vector<u64>, vector<bool>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<bool>();
        let v3 = if (0x1::option::is_some<u64>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<u64, RequestsForEpoch>(&arg0.unstake_epochs)
        };
        let v4 = v3;
        let v5 = 0;
        while (0x1::option::is_some<u64>(&v4) && v5 < arg2) {
            let v6 = 0x1::option::borrow<u64>(&v4);
            let v7 = 0x2::linked_table::borrow<u64, RequestsForEpoch>(&arg0.unstake_epochs, *v6);
            0x1::vector::push_back<u64>(&mut v0, *v6);
            0x1::vector::push_back<u64>(&mut v1, v7.amount);
            0x1::vector::push_back<bool>(&mut v2, v7.approved);
            v4 = *0x2::linked_table::next<u64, RequestsForEpoch>(&arg0.unstake_epochs, *v6);
            v5 = v5 + 1;
        };
        (v0, v1, v2, 0x2::linked_table::length<u64, RequestsForEpoch>(&arg0.unstake_epochs))
    }

    public fun query_validator_pool(arg0: &DSuiVault, arg1: address) : (u64, u64, u64) {
        let v0 = 0x2::linked_table::borrow<address, ValidatorPool>(&arg0.validator_pools, arg1);
        (0x2::linked_table::length<u64, 0x3::staking_pool::StakedSui>(&v0.staked_sui_objects), v0.total_principal_staked, v0.accrued_rewards)
    }

    public fun query_validator_pools(arg0: &DSuiVault, arg1: 0x1::option::Option<address>, arg2: u64) : (vector<address>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = if (0x1::option::is_some<address>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<address, ValidatorPool>(&arg0.validator_pools)
        };
        let v5 = v4;
        let v6 = 0;
        while (0x1::option::is_some<address>(&v5) && v6 < arg2) {
            let v7 = 0x1::option::borrow<address>(&v5);
            let v8 = 0x2::linked_table::borrow<address, ValidatorPool>(&arg0.validator_pools, *v7);
            0x1::vector::push_back<address>(&mut v0, *v7);
            0x1::vector::push_back<u64>(&mut v1, 0x2::linked_table::length<u64, 0x3::staking_pool::StakedSui>(&v8.staked_sui_objects));
            0x1::vector::push_back<u64>(&mut v2, v8.total_principal_staked);
            0x1::vector::push_back<u64>(&mut v3, v8.accrued_rewards);
            v5 = *0x2::linked_table::next<address, ValidatorPool>(&arg0.validator_pools, *v7);
            v6 = v6 + 1;
        };
        (v0, v1, v2, v3, 0x2::linked_table::length<address, ValidatorPool>(&arg0.validator_pools))
    }

    public fun query_vault_overview(arg0: &DSuiVault) : (u64, u64, u64, u64, u64, u64, u128) {
        (arg0.total_principal_staked, arg0.total_accrued_rewards, arg0.sui_to_unstake, arg0.uncollected_protocol_fees, arg0.dsui_supply, arg0.rewards_last_updated_epoch, arg0.sui_claimable_per_dsui)
    }

    public fun query_whitelisted_validators(arg0: &DSuiVault) : vector<address> {
        arg0.whitelisted_validators
    }

    public fun request_delayed_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: 0x2::balance::Balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::dsui::DSUI>, arg3: &mut 0x2::tx_context::TxContext) : UnstakeRequest {
        assert!(arg1.version == 0, 9002);
        let v0 = 0x2::tx_context::epoch(arg3);
        update_calculated_accrued_rewards(arg0, arg1, arg3);
        let v1 = get_sui_by_dsui(arg1, 0x2::balance::value<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::dsui::DSUI>(&arg2));
        assert!(v1 > 0 && v1 <= get_total_sui(arg1), 9006);
        if (0x2::linked_table::contains<u64, RequestsForEpoch>(&arg1.unstake_epochs, v0)) {
            let v2 = 0x2::linked_table::borrow_mut<u64, RequestsForEpoch>(&mut arg1.unstake_epochs, v0);
            v2.amount = v2.amount + v1;
        } else {
            let v3 = RequestsForEpoch{
                amount   : v1,
                approved : false,
            };
            0x2::linked_table::push_back<u64, RequestsForEpoch>(&mut arg1.unstake_epochs, v0, v3);
        };
        let v4 = UnstakeRequest{
            id                 : 0x2::object::new(arg3),
            dsui_amount        : 0x2::balance::value<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::dsui::DSUI>(&arg2),
            sui_amount         : v1,
            requested_at_epoch : v0,
        };
        0x2::coin::burn<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::dsui::DSUI>(&mut arg1.dsui_kraft_cap, 0x2::coin::from_balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::dsui::DSUI>(arg2, arg3));
        arg1.dsui_supply = 0x2::coin::total_supply<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::dsui::DSUI>(&arg1.dsui_kraft_cap);
        arg1.sui_to_unstake = arg1.sui_to_unstake + v1;
        let v5 = UserUnstakeRequest{
            owner                  : 0x2::tx_context::sender(arg3),
            unstake_epoch          : v4.requested_at_epoch + arg1.config_params.unstake_delay_epoches,
            sui_to_claim           : v1,
            dsui_burnt             : v4.dsui_amount,
            sui_claimable_per_dsui : get_sui_claimable_per_dsui(arg1),
            cur_epoch              : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<UserUnstakeRequest>(v5);
        v4
    }

    public fun request_instant_unstake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: 0x2::balance::Balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::dsui::DSUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg1.version == 0, 9002);
        update_calculated_accrued_rewards(arg0, arg1, arg3);
        let v0 = get_sui_by_dsui(arg1, 0x2::balance::value<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::dsui::DSUI>(&arg2));
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_to_stake) >= v0, 9004);
        let v1 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_to_stake, v0);
        let v2 = 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::percent_precision();
        let v3 = 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u128((v0 as u128), (arg1.config_params.service_fee_percent as u128), (v2 as u128));
        let v4 = 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div(v3, arg1.config_params.protocol_fee_percent, v2);
        let v5 = 0x2::balance::split<0x2::sui::SUI>(&mut v1, v3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.hive_fee_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v4));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_to_stake, v5);
        0x2::coin::burn<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::dsui::DSUI>(&mut arg1.dsui_kraft_cap, 0x2::coin::from_balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::dsui::DSUI>(arg2, arg3));
        arg1.dsui_supply = 0x2::coin::total_supply<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::dsui::DSUI>(&arg1.dsui_kraft_cap);
        let v6 = get_sui_claimable_per_dsui(arg1);
        arg1.sui_claimable_per_dsui = v6;
        let v7 = UserUnstakedInstantly{
            owner                  : 0x2::tx_context::sender(arg3),
            sui_withdrawn          : v0,
            service_fee_charged    : v3,
            protocol_fee_charged   : v4,
            dsui_burnt             : 0x2::balance::value<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::dsui::DSUI>(&arg2),
            sui_claimable_per_dsui : v6,
            cur_epoch              : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<UserUnstakedInstantly>(v7);
        v1
    }

    fun sort_vals_in_decreasing_order(arg0: &DSuiVault) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = *0x2::linked_table::front<address, ValidatorPool>(&arg0.validator_pools);
        while (0x1::option::is_some<address>(&v2)) {
            let v3 = *0x1::option::borrow<address>(&v2);
            0x1::vector::push_back<address>(&mut v0, v3);
            0x1::vector::push_back<u64>(&mut v1, 0x2::linked_table::borrow<address, ValidatorPool>(&arg0.validator_pools, v3).total_principal_staked);
            v2 = *0x2::linked_table::next<address, ValidatorPool>(&arg0.validator_pools, v3);
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

    public fun stake_sui_request(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::dsui::DSUI> {
        assert!(arg1.version == 0, 9002);
        assert!(!arg1.config_params.pause_stake, 9003);
        update_calculated_accrued_rewards(arg0, arg1, arg4);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        let v1 = get_dsui_by_sui(arg1, v0);
        let v2 = 0x3::sui_system::active_validator_addresses(arg0);
        if (0x1::option::is_some<address>(&arg3)) {
            assert!(0x1::vector::contains<address>(&v2, 0x1::option::borrow<address>(&arg3)), 9012);
            let v3 = *0x1::option::borrow<address>(&arg3);
            if (0x2::linked_table::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg1.selected_validator_mapping, v3)) {
                0x2::balance::join<0x2::sui::SUI>(0x2::linked_table::borrow_mut<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.selected_validator_mapping, v3), arg2);
            } else {
                0x2::linked_table::push_back<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.selected_validator_mapping, v3, arg2);
            };
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_to_stake, arg2);
        };
        arg1.dsui_supply = 0x2::coin::total_supply<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::dsui::DSUI>(&arg1.dsui_kraft_cap);
        let v4 = StakeSuiRequest{
            staker                 : 0x2::tx_context::sender(arg4),
            sui_to_stake           : v0,
            dsui_krafted           : v1,
            sui_claimable_per_dsui : get_sui_claimable_per_dsui(arg1),
            cur_epoch              : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<StakeSuiRequest>(v4);
        0x2::coin::mint_balance<0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::dsui::DSUI>(&mut arg1.dsui_kraft_cap, v1)
    }

    fun stake_user_selected_validators(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) : (u64, 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0;
        let v2 = *0x2::linked_table::front<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg1.selected_validator_mapping);
        while (0x1::option::is_some<address>(&v2)) {
            let v3 = *0x1::option::borrow<address>(&v2);
            let v4 = 0x2::linked_table::remove<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.selected_validator_mapping, v3);
            let v5 = 0x2::balance::value<0x2::sui::SUI>(&v4);
            v2 = *0x2::linked_table::front<address, 0x2::balance::Balance<0x2::sui::SUI>>(&arg1.selected_validator_mapping);
            if (v5 >= 1000000000 && 0x1::vector::contains<address>(&arg2, &v3)) {
                v1 = v1 + v5;
                stake_with_validator(arg0, arg1, v3, v4, arg3);
                let v6 = StakeWithSelectedValidatorRequestProcessed{
                    validator_addr   : v3,
                    sui_to_stake_amt : v5,
                    cur_epoch        : 0x2::tx_context::epoch(arg3),
                };
                0x2::event::emit<StakeWithSelectedValidatorRequestProcessed>(v6);
                continue
            };
            0x2::balance::join<0x2::sui::SUI>(&mut v0, v4);
        };
        (v1, v0)
    }

    fun stake_with_validator(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: address, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg3);
        if (!0x2::linked_table::contains<address, ValidatorPool>(&arg1.validator_pools, arg2)) {
            let v1 = ValidatorPool{
                staked_sui_objects     : 0x2::linked_table::new<u64, 0x3::staking_pool::StakedSui>(arg4),
                total_principal_staked : 0,
                accrued_rewards        : 0,
            };
            0x2::linked_table::push_back<address, ValidatorPool>(&mut arg1.validator_pools, arg2, v1);
        };
        let v2 = 0x2::linked_table::borrow_mut<address, ValidatorPool>(&mut arg1.validator_pools, arg2);
        v2.total_principal_staked = v2.total_principal_staked + v0;
        let v3 = 0x3::sui_system::request_add_stake_non_entry(arg0, 0x2::coin::from_balance<0x2::sui::SUI>(arg3, arg4), arg2, arg4);
        let v4 = 0x3::staking_pool::stake_activation_epoch(&v3);
        if (0x2::linked_table::contains<u64, 0x3::staking_pool::StakedSui>(&v2.staked_sui_objects, v4)) {
            0x3::staking_pool::join_staked_sui(0x2::linked_table::borrow_mut<u64, 0x3::staking_pool::StakedSui>(&mut v2.staked_sui_objects, v4), v3);
        } else {
            0x2::linked_table::push_back<u64, 0x3::staking_pool::StakedSui>(&mut v2.staked_sui_objects, v4, v3);
        };
        let v5 = StakeOperationProcessed{
            validator_addr   : arg2,
            sui_to_stake_amt : v0,
            cur_epoch        : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<StakeOperationProcessed>(v5);
        arg1.total_principal_staked = arg1.total_principal_staked + v0;
    }

    fun unstake_from_validator_pools(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (u64, 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = sort_vals_in_decreasing_order(arg1);
        let v2 = 0x2::linked_table::length<address, ValidatorPool>(&arg1.validator_pools);
        let v3 = 0;
        loop {
            let v4 = if (arg2 > 0) {
                if (v3 < v2) {
                    v3 < 0x1::vector::length<address>(&v1)
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                let v5 = &mut v0;
                let v6 = 0x2::tx_context::epoch(arg3);
                let (v7, v8) = execute_validator_unstake(arg0, arg1, v5, *0x1::vector::borrow<address>(&v1, v3), arg2, v6, arg3);
                arg2 = v7;
                if (v8) {
                    0x1::vector::remove<address>(&mut v1, v3);
                    v2 = v2 - 1;
                    continue
                };
                v3 = v3 + 1;
            } else {
                break
            };
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v0) >= arg1.uncollected_protocol_fees) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.hive_fee_vault, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg1.uncollected_protocol_fees));
            arg1.uncollected_protocol_fees = 0;
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.hive_fee_vault, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v0));
            arg1.uncollected_protocol_fees = arg1.uncollected_protocol_fees - 0x2::balance::value<0x2::sui::SUI>(&v0);
        };
        (arg2, v0)
    }

    fun unstake_inactive_validators(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3::sui_system::active_validator_addresses(arg0);
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x2::tx_context::epoch(arg2);
        let v3 = *0x2::linked_table::front<address, ValidatorPool>(&arg1.validator_pools);
        while (0x1::option::is_some<address>(&v3)) {
            let v4 = *0x1::option::borrow<address>(&v3);
            if (!0x1::vector::contains<address>(&v0, &v4)) {
                0x1::vector::push_back<address>(&mut v1, v4);
            };
            v3 = *0x2::linked_table::next<address, ValidatorPool>(&arg1.validator_pools, v4);
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

    public fun update_calculated_accrued_rewards(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: &mut DSuiVault, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 9002);
        let v0 = 0x2::tx_context::epoch(arg2);
        if (v0 == arg1.rewards_last_updated_epoch) {
            return
        };
        let v1 = get_sui_claimable_per_dsui(arg1);
        let v2 = 0;
        let v3 = *0x2::linked_table::front<address, ValidatorPool>(&arg1.validator_pools);
        while (0x1::option::is_some<address>(&v3)) {
            let v4 = *0x1::option::borrow<address>(&v3);
            let v5 = 0x2::linked_table::borrow_mut<address, ValidatorPool>(&mut arg1.validator_pools, v4);
            v2 = v2 + calculate_validator_pool_rewards_increase(arg0, v4, v5, v0);
            v3 = *0x2::linked_table::next<address, ValidatorPool>(&arg1.validator_pools, v4);
        };
        let v6 = (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::math::mul_div_u256((v2 as u256), (arg1.config_params.protocol_fee_percent as u256), (0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::percent_precision() as u256)) as u64);
        arg1.total_accrued_rewards = arg1.total_accrued_rewards + v2;
        arg1.uncollected_protocol_fees = arg1.uncollected_protocol_fees + v6;
        arg1.rewards_last_updated_epoch = v0;
        let v7 = get_sui_claimable_per_dsui(arg1);
        arg1.sui_claimable_per_dsui = v7;
        let v8 = TotalRewardsUpdated{
            cur_epoch                   : v0,
            total_principal_staked      : arg1.total_principal_staked,
            sui_to_unstake              : arg1.sui_to_unstake,
            total_accrued_rewards       : arg1.total_accrued_rewards,
            new_rewards                 : v2,
            uncollected_protocol_fees   : arg1.uncollected_protocol_fees,
            protocol_fee_on_new_rewards : v6,
            prev_sui_claimable_per_dsui : v1,
            new_sui_claimable_per_dsui  : v7,
            exchange_rate_increase      : v7 - v1,
        };
        0x2::event::emit<TotalRewardsUpdated>(v8);
    }

    public fun update_dsui_fee_config(arg0: &0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::yield_flow::DragonDaoCapability, arg1: &mut DSuiVault, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg1.version == 0, 9002);
        let v0 = if (arg2 < 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::lsd_max_protocol_fee_percent()) {
            if (arg3 < 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::lsd_max_service_fee_percent()) {
                arg4 < 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::lsd_max_treasury_fee_percent()
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 9001);
        if (arg2 > 0) {
            arg1.config_params.protocol_fee_percent = arg2;
        };
        if (arg3 > 0) {
            arg1.config_params.service_fee_percent = arg3;
        };
        if (arg4 > 0) {
            arg1.config_params.treasury_percent = arg4;
        };
        let v1 = DegenSUIFeeStructureUpdated{
            protocol_fee_percent : arg1.config_params.protocol_fee_percent,
            service_fee_percent  : arg1.config_params.service_fee_percent,
            treasury_percent     : arg1.config_params.treasury_percent,
        };
        0x2::event::emit<DegenSUIFeeStructureUpdated>(v1);
    }

    public fun update_validator_list(arg0: &0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::yield_flow::DragonDaoCapability, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut DSuiVault, arg3: vector<address>, arg4: bool) {
        assert!(arg2.version == 0, 9002);
        let v0 = 0x3::sui_system::active_validator_addresses(arg1);
        if (arg4) {
            let v1 = 0;
            while (v1 < 0x1::vector::length<address>(&arg3)) {
                let v2 = *0x1::vector::borrow<address>(&arg3, v1);
                if (0x1::vector::contains<address>(&v0, &v2) && !0x1::vector::contains<address>(&arg2.whitelisted_validators, &v2)) {
                    0x1::vector::push_back<address>(&mut arg2.whitelisted_validators, v2);
                };
                v1 = v1 + 1;
            };
        };
        if (!arg4) {
            let v3 = 0;
            while (v3 < 0x1::vector::length<address>(&arg3)) {
                let v4 = *0x1::vector::borrow<address>(&arg3, v3);
                let (v5, v6) = 0x1::vector::index_of<address>(&arg2.whitelisted_validators, &v4);
                if (v5) {
                    0x1::vector::remove<address>(&mut arg2.whitelisted_validators, v6);
                };
                v3 = v3 + 1;
            };
        };
        assert!(0x1::vector::length<address>(&arg2.whitelisted_validators) < 0x8446967d96588cab8efedac020cc83a4a8ae1332c8da67ce69f44677b9bbb173::constants::max_whitelisted_validators_allowed(), 9009);
        let v7 = ValidatorListUpdated{
            validator_list : arg3,
            to_add         : arg4,
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

