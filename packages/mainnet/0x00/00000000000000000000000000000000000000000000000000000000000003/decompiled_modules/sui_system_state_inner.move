module 0x3::sui_system_state_inner {
    struct SystemParameters has store {
        epoch_duration_ms: u64,
        stake_subsidy_start_epoch: u64,
        max_validator_count: u64,
        min_validator_joining_stake: u64,
        validator_low_stake_threshold: u64,
        validator_very_low_stake_threshold: u64,
        validator_low_stake_grace_period: u64,
        extra_fields: 0x2::bag::Bag,
    }

    struct SystemParametersV2 has store {
        epoch_duration_ms: u64,
        stake_subsidy_start_epoch: u64,
        min_validator_count: u64,
        max_validator_count: u64,
        min_validator_joining_stake: u64,
        validator_low_stake_threshold: u64,
        validator_very_low_stake_threshold: u64,
        validator_low_stake_grace_period: u64,
        extra_fields: 0x2::bag::Bag,
    }

    struct SuiSystemStateInner has store {
        epoch: u64,
        protocol_version: u64,
        system_state_version: u64,
        validators: 0x3::validator_set::ValidatorSet,
        storage_fund: 0x3::storage_fund::StorageFund,
        parameters: SystemParameters,
        reference_gas_price: u64,
        validator_report_records: 0x2::vec_map::VecMap<address, 0x2::vec_set::VecSet<address>>,
        stake_subsidy: 0x3::stake_subsidy::StakeSubsidy,
        safe_mode: bool,
        safe_mode_storage_rewards: 0x2::balance::Balance<0x2::sui::SUI>,
        safe_mode_computation_rewards: 0x2::balance::Balance<0x2::sui::SUI>,
        safe_mode_storage_rebates: u64,
        safe_mode_non_refundable_storage_fee: u64,
        epoch_start_timestamp_ms: u64,
        extra_fields: 0x2::bag::Bag,
    }

    struct SuiSystemStateInnerV2 has store {
        epoch: u64,
        protocol_version: u64,
        system_state_version: u64,
        validators: 0x3::validator_set::ValidatorSet,
        storage_fund: 0x3::storage_fund::StorageFund,
        parameters: SystemParametersV2,
        reference_gas_price: u64,
        validator_report_records: 0x2::vec_map::VecMap<address, 0x2::vec_set::VecSet<address>>,
        stake_subsidy: 0x3::stake_subsidy::StakeSubsidy,
        safe_mode: bool,
        safe_mode_storage_rewards: 0x2::balance::Balance<0x2::sui::SUI>,
        safe_mode_computation_rewards: 0x2::balance::Balance<0x2::sui::SUI>,
        safe_mode_storage_rebates: u64,
        safe_mode_non_refundable_storage_fee: u64,
        epoch_start_timestamp_ms: u64,
        extra_fields: 0x2::bag::Bag,
    }

    struct SystemEpochInfoEvent has copy, drop {
        epoch: u64,
        protocol_version: u64,
        reference_gas_price: u64,
        total_stake: u64,
        storage_fund_reinvestment: u64,
        storage_charge: u64,
        storage_rebate: u64,
        storage_fund_balance: u64,
        stake_subsidy_amount: u64,
        total_gas_fees: u64,
        total_stake_rewards_distributed: u64,
        leftover_storage_fund_inflow: u64,
    }

    public(friend) fun epoch(arg0: &SuiSystemStateInnerV2) : u64 {
        arg0.epoch
    }

    public(friend) fun advance_epoch(arg0: &mut SuiSystemStateInnerV2, arg1: u64, arg2: u64, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: 0x2::balance::Balance<0x2::sui::SUI>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        arg0.epoch_start_timestamp_ms = arg9;
        let v0 = 10000;
        assert!(arg7 <= v0 && arg8 <= v0, 5);
        if (arg0.parameters.stake_subsidy_start_epoch > 0) {
            arg0.parameters.stake_subsidy_start_epoch = 20;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg3, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.safe_mode_storage_rewards));
        0x2::balance::join<0x2::sui::SUI>(&mut arg4, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.safe_mode_computation_rewards));
        let v1 = arg5 + arg0.safe_mode_storage_rebates;
        arg0.safe_mode_storage_rebates = 0;
        arg0.safe_mode_non_refundable_storage_fee = 0;
        let v2 = 0x3::storage_fund::total_balance(&arg0.storage_fund);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg4);
        let v4 = 0x2::balance::zero<0x2::sui::SUI>();
        let v5 = 0x2::tx_context::epoch(arg10);
        if (v5 >= arg0.parameters.stake_subsidy_start_epoch && arg9 >= arg0.epoch_start_timestamp_ms + arg0.parameters.epoch_duration_ms) {
            if (0x3::stake_subsidy::get_distribution_counter(&arg0.stake_subsidy) == 540 && v5 > 560) {
                let v6 = 0;
                while (v6 < v5 - 560) {
                    0x2::balance::join<0x2::sui::SUI>(&mut v4, 0x3::stake_subsidy::advance_epoch(&mut arg0.stake_subsidy));
                    v6 = v6 + 1;
                };
            };
            0x2::balance::join<0x2::sui::SUI>(&mut v4, 0x3::stake_subsidy::advance_epoch(&mut arg0.stake_subsidy));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg4, v4);
        let v7 = (((v2 as u128) * (v3 as u128) / ((v2 + 0x3::validator_set::total_stake(&arg0.validators)) as u128)) as u64);
        let v8 = 0x2::balance::split<0x2::sui::SUI>(&mut arg4, (v7 as u64));
        let v9 = (((v7 as u128) * (arg7 as u128) / (10000 as u128)) as u64);
        arg0.epoch = arg0.epoch + 1;
        assert!(arg1 == arg0.epoch, 8);
        0x3::validator_set::advance_epoch(&mut arg0.validators, &mut arg4, &mut v8, &mut arg0.validator_report_records, arg8, arg0.parameters.validator_low_stake_grace_period, arg10);
        arg0.protocol_version = arg2;
        arg0.reference_gas_price = 0x3::validator_set::derive_reference_gas_price(&arg0.validators);
        0x2::balance::join<0x2::sui::SUI>(&mut v8, arg4);
        let v10 = SystemEpochInfoEvent{
            epoch                           : arg0.epoch,
            protocol_version                : arg0.protocol_version,
            reference_gas_price             : arg0.reference_gas_price,
            total_stake                     : 0x3::validator_set::total_stake(&arg0.validators),
            storage_fund_reinvestment       : (v9 as u64),
            storage_charge                  : 0x2::balance::value<0x2::sui::SUI>(&arg3),
            storage_rebate                  : v1,
            storage_fund_balance            : 0x3::storage_fund::total_balance(&arg0.storage_fund),
            stake_subsidy_amount            : 0x2::balance::value<0x2::sui::SUI>(&v4),
            total_gas_fees                  : v3,
            total_stake_rewards_distributed : 0x2::balance::value<0x2::sui::SUI>(&arg4) - 0x2::balance::value<0x2::sui::SUI>(&arg4) + 0x2::balance::value<0x2::sui::SUI>(&v8) - 0x2::balance::value<0x2::sui::SUI>(&v8),
            leftover_storage_fund_inflow    : 0x2::balance::value<0x2::sui::SUI>(&v8),
        };
        0x2::event::emit<SystemEpochInfoEvent>(v10);
        arg0.safe_mode = false;
        let v11 = if (arg0.safe_mode_storage_rebates == 0) {
            if (0x2::balance::value<0x2::sui::SUI>(&arg0.safe_mode_storage_rewards) == 0) {
                0x2::balance::value<0x2::sui::SUI>(&arg0.safe_mode_computation_rewards) == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v11, 7);
        0x3::storage_fund::advance_epoch(&mut arg0.storage_fund, arg3, 0x2::balance::split<0x2::sui::SUI>(&mut v8, v9), v8, v1, arg6 + arg0.safe_mode_non_refundable_storage_fee)
    }

    public(friend) fun active_validator_addresses(arg0: &SuiSystemStateInnerV2) : vector<address> {
        0x3::validator_set::active_validator_addresses(&arg0.validators)
    }

    public(friend) fun active_validator_voting_powers(arg0: &SuiSystemStateInnerV2) : 0x2::vec_map::VecMap<address, u64> {
        let v0 = 0x2::vec_map::empty<address, u64>();
        let v1 = active_validator_addresses(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            let v3 = 0x1::vector::pop_back<address>(&mut v1);
            0x2::vec_map::insert<address, u64>(&mut v0, v3, 0x3::validator_set::validator_voting_power(&arg0.validators, v3));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<address>(v1);
        v0
    }

    public(friend) fun convert_to_fungible_staked_sui(arg0: &mut SuiSystemStateInnerV2, arg1: 0x3::staking_pool::StakedSui, arg2: &mut 0x2::tx_context::TxContext) : 0x3::staking_pool::FungibleStakedSui {
        0x3::validator_set::convert_to_fungible_staked_sui(&mut arg0.validators, arg1, arg2)
    }

    public(friend) fun create(arg0: vector<0x3::validator::Validator>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: SystemParameters, arg5: 0x3::stake_subsidy::StakeSubsidy, arg6: &mut 0x2::tx_context::TxContext) : SuiSystemStateInner {
        let v0 = 0x3::validator_set::new(arg0, arg6);
        SuiSystemStateInner{
            epoch                                : 0,
            protocol_version                     : arg2,
            system_state_version                 : genesis_system_state_version(),
            validators                           : v0,
            storage_fund                         : 0x3::storage_fund::new(arg1),
            parameters                           : arg4,
            reference_gas_price                  : 0x3::validator_set::derive_reference_gas_price(&v0),
            validator_report_records             : 0x2::vec_map::empty<address, 0x2::vec_set::VecSet<address>>(),
            stake_subsidy                        : arg5,
            safe_mode                            : false,
            safe_mode_storage_rewards            : 0x2::balance::zero<0x2::sui::SUI>(),
            safe_mode_computation_rewards        : 0x2::balance::zero<0x2::sui::SUI>(),
            safe_mode_storage_rebates            : 0,
            safe_mode_non_refundable_storage_fee : 0,
            epoch_start_timestamp_ms             : arg3,
            extra_fields                         : 0x2::bag::new(arg6),
        }
    }

    public(friend) fun create_system_parameters(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : SystemParameters {
        SystemParameters{
            epoch_duration_ms                  : arg0,
            stake_subsidy_start_epoch          : arg1,
            max_validator_count                : arg2,
            min_validator_joining_stake        : arg3,
            validator_low_stake_threshold      : arg4,
            validator_very_low_stake_threshold : arg5,
            validator_low_stake_grace_period   : arg6,
            extra_fields                       : 0x2::bag::new(arg7),
        }
    }

    public(friend) fun epoch_start_timestamp_ms(arg0: &SuiSystemStateInnerV2) : u64 {
        arg0.epoch_start_timestamp_ms
    }

    fun extract_coin_balance(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: 0x1::option::Option<u64>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
        0x1::vector::reverse<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&arg0)) {
            let v2 = v0;
            0x2::coin::join<0x2::sui::SUI>(&mut v2, 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0));
            v0 = v2;
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(arg0);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(v0);
        if (0x1::option::is_some<u64>(&arg1)) {
            if (0x2::balance::value<0x2::sui::SUI>(&v3) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg2), 0x2::tx_context::sender(arg2));
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
            };
            0x2::balance::split<0x2::sui::SUI>(&mut v3, 0x1::option::destroy_some<u64>(arg1))
        } else {
            v3
        }
    }

    public(friend) fun genesis_system_state_version() : u64 {
        1
    }

    public(friend) fun get_reporters_of(arg0: &SuiSystemStateInnerV2, arg1: address) : 0x2::vec_set::VecSet<address> {
        if (0x2::vec_map::contains<address, 0x2::vec_set::VecSet<address>>(&arg0.validator_report_records, &arg1)) {
            *0x2::vec_map::get<address, 0x2::vec_set::VecSet<address>>(&arg0.validator_report_records, &arg1)
        } else {
            0x2::vec_set::empty<address>()
        }
    }

    public(friend) fun get_storage_fund_object_rebates(arg0: &SuiSystemStateInnerV2) : u64 {
        0x3::storage_fund::total_object_storage_rebates(&arg0.storage_fund)
    }

    public(friend) fun get_storage_fund_total_balance(arg0: &SuiSystemStateInnerV2) : u64 {
        0x3::storage_fund::total_balance(&arg0.storage_fund)
    }

    public(friend) fun pool_exchange_rates(arg0: &mut SuiSystemStateInnerV2, arg1: &0x2::object::ID) : &0x2::table::Table<u64, 0x3::staking_pool::PoolTokenExchangeRate> {
        0x3::validator_set::pool_exchange_rates(&mut arg0.validators, arg1)
    }

    public(friend) fun protocol_version(arg0: &SuiSystemStateInnerV2) : u64 {
        arg0.protocol_version
    }

    public(friend) fun redeem_fungible_staked_sui(arg0: &mut SuiSystemStateInnerV2, arg1: 0x3::staking_pool::FungibleStakedSui, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x3::validator_set::redeem_fungible_staked_sui(&mut arg0.validators, arg1, arg2)
    }

    public(friend) fun report_validator(arg0: &mut SuiSystemStateInnerV2, arg1: &0x3::validator_cap::UnverifiedValidatorOperationCap, arg2: address) {
        assert!(0x3::validator_set::is_active_validator_by_sui_address(&arg0.validators, arg2), 0);
        let v0 = &mut arg0.validator_report_records;
        report_validator_impl(0x3::validator_set::verify_cap(&mut arg0.validators, arg1, 1), arg2, v0);
    }

    fun report_validator_impl(arg0: 0x3::validator_cap::ValidatorOperationCap, arg1: address, arg2: &mut 0x2::vec_map::VecMap<address, 0x2::vec_set::VecSet<address>>) {
        let v0 = *0x3::validator_cap::verified_operation_cap_address(&arg0);
        assert!(v0 != arg1, 3);
        if (!0x2::vec_map::contains<address, 0x2::vec_set::VecSet<address>>(arg2, &arg1)) {
            0x2::vec_map::insert<address, 0x2::vec_set::VecSet<address>>(arg2, arg1, 0x2::vec_set::singleton<address>(v0));
        } else {
            let v1 = 0x2::vec_map::get_mut<address, 0x2::vec_set::VecSet<address>>(arg2, &arg1);
            if (!0x2::vec_set::contains<address>(v1, &v0)) {
                0x2::vec_set::insert<address>(v1, v0);
            };
        };
    }

    public(friend) fun request_add_stake(arg0: &mut SuiSystemStateInnerV2, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x3::staking_pool::StakedSui {
        0x3::validator_set::request_add_stake(&mut arg0.validators, arg2, 0x2::coin::into_balance<0x2::sui::SUI>(arg1), arg3)
    }

    public(friend) fun request_add_stake_mul_coin(arg0: &mut SuiSystemStateInnerV2, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: 0x1::option::Option<u64>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x3::staking_pool::StakedSui {
        let v0 = extract_coin_balance(arg1, arg2, arg4);
        0x3::validator_set::request_add_stake(&mut arg0.validators, arg3, v0, arg4)
    }

    public(friend) fun request_add_validator(arg0: &mut SuiSystemStateInnerV2, arg1: &0x2::tx_context::TxContext) {
        assert!(0x3::validator_set::next_epoch_validator_count(&arg0.validators) < arg0.parameters.max_validator_count, 1);
        0x3::validator_set::request_add_validator(&mut arg0.validators, arg1);
    }

    public(friend) fun request_add_validator_candidate(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        0x3::validator_set::request_add_validator_candidate(&mut arg0.validators, 0x3::validator::new(0x2::tx_context::sender(arg15), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15), arg15);
    }

    public(friend) fun request_remove_validator(arg0: &mut SuiSystemStateInnerV2, arg1: &0x2::tx_context::TxContext) {
        if (0x1::vector::length<0x3::validator::Validator>(0x3::validator_set::active_validators(&arg0.validators)) >= arg0.parameters.min_validator_count) {
            assert!(0x3::validator_set::next_epoch_validator_count(&arg0.validators) > arg0.parameters.min_validator_count, 1);
        };
        0x3::validator_set::request_remove_validator(&mut arg0.validators, arg1);
    }

    public(friend) fun request_remove_validator_candidate(arg0: &mut SuiSystemStateInnerV2, arg1: &mut 0x2::tx_context::TxContext) {
        0x3::validator_set::request_remove_validator_candidate(&mut arg0.validators, arg1);
    }

    public(friend) fun request_set_commission_rate(arg0: &mut SuiSystemStateInnerV2, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0x3::validator_set::request_set_commission_rate(&mut arg0.validators, arg1, arg2);
    }

    public(friend) fun request_set_gas_price(arg0: &mut SuiSystemStateInnerV2, arg1: &0x3::validator_cap::UnverifiedValidatorOperationCap, arg2: u64) {
        let v0 = 0x3::validator_set::verify_cap(&mut arg0.validators, arg1, 2);
        0x3::validator::request_set_gas_price(0x3::validator_set::get_validator_mut_with_verified_cap(&mut arg0.validators, &v0, false), v0, arg2);
    }

    public(friend) fun request_withdraw_stake(arg0: &mut SuiSystemStateInnerV2, arg1: 0x3::staking_pool::StakedSui, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x3::validator_set::request_withdraw_stake(&mut arg0.validators, arg1, arg2)
    }

    public(friend) fun rotate_operation_cap(arg0: &mut SuiSystemStateInnerV2, arg1: &mut 0x2::tx_context::TxContext) {
        0x3::validator::new_unverified_validator_operation_cap_and_transfer(0x3::validator_set::get_validator_mut_with_ctx_including_candidates(&mut arg0.validators, arg1), arg1);
    }

    public(friend) fun set_candidate_validator_commission_rate(arg0: &mut SuiSystemStateInnerV2, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0x3::validator::set_candidate_commission_rate(0x3::validator_set::get_validator_mut_with_ctx_including_candidates(&mut arg0.validators, arg2), arg1);
    }

    public(friend) fun set_candidate_validator_gas_price(arg0: &mut SuiSystemStateInnerV2, arg1: &0x3::validator_cap::UnverifiedValidatorOperationCap, arg2: u64) {
        let v0 = 0x3::validator_set::verify_cap(&mut arg0.validators, arg1, 3);
        0x3::validator::set_candidate_gas_price(0x3::validator_set::get_validator_mut_with_verified_cap(&mut arg0.validators, &v0, true), v0, arg2);
    }

    public(friend) fun store_execution_time_estimates(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>) {
        let v0 = 0;
        if (0x2::bag::contains<u64>(&arg0.extra_fields, v0)) {
            0x2::bag::remove<u64, vector<u8>>(&mut arg0.extra_fields, v0);
        };
        0x2::bag::add<u64, vector<u8>>(&mut arg0.extra_fields, v0, arg1);
    }

    public(friend) fun system_state_version(arg0: &SuiSystemStateInnerV2) : u64 {
        arg0.system_state_version
    }

    public(friend) fun undo_report_validator(arg0: &mut SuiSystemStateInnerV2, arg1: &0x3::validator_cap::UnverifiedValidatorOperationCap, arg2: address) {
        let v0 = &mut arg0.validator_report_records;
        undo_report_validator_impl(0x3::validator_set::verify_cap(&mut arg0.validators, arg1, 1), arg2, v0);
    }

    fun undo_report_validator_impl(arg0: 0x3::validator_cap::ValidatorOperationCap, arg1: address, arg2: &mut 0x2::vec_map::VecMap<address, 0x2::vec_set::VecSet<address>>) {
        assert!(0x2::vec_map::contains<address, 0x2::vec_set::VecSet<address>>(arg2, &arg1), 4);
        let v0 = 0x2::vec_map::get_mut<address, 0x2::vec_set::VecSet<address>>(arg2, &arg1);
        let v1 = *0x3::validator_cap::verified_operation_cap_address(&arg0);
        assert!(0x2::vec_set::contains<address>(v0, &v1), 4);
        0x2::vec_set::remove<address>(v0, &v1);
        if (0x2::vec_set::is_empty<address>(v0)) {
            let (_, _) = 0x2::vec_map::remove<address, 0x2::vec_set::VecSet<address>>(arg2, &arg1);
        };
    }

    public(friend) fun update_candidate_validator_network_address(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::validator::update_candidate_network_address(0x3::validator_set::get_validator_mut_with_ctx_including_candidates(&mut arg0.validators, arg2), arg1);
    }

    public(friend) fun update_candidate_validator_network_pubkey(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::validator::update_candidate_network_pubkey(0x3::validator_set::get_validator_mut_with_ctx_including_candidates(&mut arg0.validators, arg2), arg1);
    }

    public(friend) fun update_candidate_validator_p2p_address(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::validator::update_candidate_p2p_address(0x3::validator_set::get_validator_mut_with_ctx_including_candidates(&mut arg0.validators, arg2), arg1);
    }

    public(friend) fun update_candidate_validator_primary_address(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::validator::update_candidate_primary_address(0x3::validator_set::get_validator_mut_with_ctx_including_candidates(&mut arg0.validators, arg2), arg1);
    }

    public(friend) fun update_candidate_validator_protocol_pubkey(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        0x3::validator::update_candidate_protocol_pubkey(0x3::validator_set::get_validator_mut_with_ctx_including_candidates(&mut arg0.validators, arg3), arg1, arg2);
    }

    public(friend) fun update_candidate_validator_worker_address(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::validator::update_candidate_worker_address(0x3::validator_set::get_validator_mut_with_ctx_including_candidates(&mut arg0.validators, arg2), arg1);
    }

    public(friend) fun update_candidate_validator_worker_pubkey(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::validator::update_candidate_worker_pubkey(0x3::validator_set::get_validator_mut_with_ctx_including_candidates(&mut arg0.validators, arg2), arg1);
    }

    public(friend) fun update_validator_description(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::validator::update_description(0x3::validator_set::get_validator_mut_with_ctx_including_candidates(&mut arg0.validators, arg2), arg1);
    }

    public(friend) fun update_validator_image_url(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::validator::update_image_url(0x3::validator_set::get_validator_mut_with_ctx_including_candidates(&mut arg0.validators, arg2), arg1);
    }

    public(friend) fun update_validator_name(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::validator::update_name(0x3::validator_set::get_validator_mut_with_ctx_including_candidates(&mut arg0.validators, arg2), arg1);
    }

    public(friend) fun update_validator_next_epoch_network_address(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x3::validator_set::get_validator_mut_with_ctx(&mut arg0.validators, arg2);
        0x3::validator::update_next_epoch_network_address(v0, arg1);
        0x3::validator_set::assert_no_pending_or_active_duplicates(&arg0.validators, v0);
    }

    public(friend) fun update_validator_next_epoch_network_pubkey(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x3::validator_set::get_validator_mut_with_ctx(&mut arg0.validators, arg2);
        0x3::validator::update_next_epoch_network_pubkey(v0, arg1);
        0x3::validator_set::assert_no_pending_or_active_duplicates(&arg0.validators, v0);
    }

    public(friend) fun update_validator_next_epoch_p2p_address(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x3::validator_set::get_validator_mut_with_ctx(&mut arg0.validators, arg2);
        0x3::validator::update_next_epoch_p2p_address(v0, arg1);
        0x3::validator_set::assert_no_pending_or_active_duplicates(&arg0.validators, v0);
    }

    public(friend) fun update_validator_next_epoch_primary_address(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::validator::update_next_epoch_primary_address(0x3::validator_set::get_validator_mut_with_ctx(&mut arg0.validators, arg2), arg1);
    }

    public(friend) fun update_validator_next_epoch_protocol_pubkey(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x3::validator_set::get_validator_mut_with_ctx(&mut arg0.validators, arg3);
        0x3::validator::update_next_epoch_protocol_pubkey(v0, arg1, arg2);
        0x3::validator_set::assert_no_pending_or_active_duplicates(&arg0.validators, v0);
    }

    public(friend) fun update_validator_next_epoch_worker_address(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::validator::update_next_epoch_worker_address(0x3::validator_set::get_validator_mut_with_ctx(&mut arg0.validators, arg2), arg1);
    }

    public(friend) fun update_validator_next_epoch_worker_pubkey(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x3::validator_set::get_validator_mut_with_ctx(&mut arg0.validators, arg2);
        0x3::validator::update_next_epoch_worker_pubkey(v0, arg1);
        0x3::validator_set::assert_no_pending_or_active_duplicates(&arg0.validators, v0);
    }

    public(friend) fun update_validator_project_url(arg0: &mut SuiSystemStateInnerV2, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        0x3::validator::update_project_url(0x3::validator_set::get_validator_mut_with_ctx_including_candidates(&mut arg0.validators, arg2), arg1);
    }

    public(friend) fun v1_to_v2(arg0: SuiSystemStateInner) : SuiSystemStateInnerV2 {
        let SuiSystemStateInner {
            epoch                                : v0,
            protocol_version                     : v1,
            system_state_version                 : _,
            validators                           : v3,
            storage_fund                         : v4,
            parameters                           : v5,
            reference_gas_price                  : v6,
            validator_report_records             : v7,
            stake_subsidy                        : v8,
            safe_mode                            : v9,
            safe_mode_storage_rewards            : v10,
            safe_mode_computation_rewards        : v11,
            safe_mode_storage_rebates            : v12,
            safe_mode_non_refundable_storage_fee : v13,
            epoch_start_timestamp_ms             : v14,
            extra_fields                         : v15,
        } = arg0;
        let SystemParameters {
            epoch_duration_ms                  : v16,
            stake_subsidy_start_epoch          : v17,
            max_validator_count                : v18,
            min_validator_joining_stake        : v19,
            validator_low_stake_threshold      : v20,
            validator_very_low_stake_threshold : v21,
            validator_low_stake_grace_period   : v22,
            extra_fields                       : v23,
        } = v5;
        let v24 = SystemParametersV2{
            epoch_duration_ms                  : v16,
            stake_subsidy_start_epoch          : v17,
            min_validator_count                : 4,
            max_validator_count                : v18,
            min_validator_joining_stake        : v19,
            validator_low_stake_threshold      : v20,
            validator_very_low_stake_threshold : v21,
            validator_low_stake_grace_period   : v22,
            extra_fields                       : v23,
        };
        SuiSystemStateInnerV2{
            epoch                                : v0,
            protocol_version                     : v1,
            system_state_version                 : 2,
            validators                           : v3,
            storage_fund                         : v4,
            parameters                           : v24,
            reference_gas_price                  : v6,
            validator_report_records             : v7,
            stake_subsidy                        : v8,
            safe_mode                            : v9,
            safe_mode_storage_rewards            : v10,
            safe_mode_computation_rewards        : v11,
            safe_mode_storage_rebates            : v12,
            safe_mode_non_refundable_storage_fee : v13,
            epoch_start_timestamp_ms             : v14,
            extra_fields                         : v15,
        }
    }

    public(friend) fun validator_address_by_pool_id(arg0: &mut SuiSystemStateInnerV2, arg1: &0x2::object::ID) : address {
        0x3::validator_set::validator_address_by_pool_id(&mut arg0.validators, arg1)
    }

    public(friend) fun validator_stake_amount(arg0: &SuiSystemStateInnerV2, arg1: address) : u64 {
        0x3::validator_set::validator_total_stake_amount(&arg0.validators, arg1)
    }

    public(friend) fun validator_staking_pool_id(arg0: &SuiSystemStateInnerV2, arg1: address) : 0x2::object::ID {
        0x3::validator_set::validator_staking_pool_id(&arg0.validators, arg1)
    }

    public(friend) fun validator_staking_pool_mappings(arg0: &SuiSystemStateInnerV2) : &0x2::table::Table<0x2::object::ID, address> {
        0x3::validator_set::staking_pool_mappings(&arg0.validators)
    }

    // decompiled from Move bytecode v6
}

