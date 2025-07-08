module 0x3::validator_set {
    struct ValidatorSet has store {
        total_stake: u64,
        active_validators: vector<0x3::validator::Validator>,
        pending_active_validators: 0x2::table_vec::TableVec<0x3::validator::Validator>,
        pending_removals: vector<u64>,
        staking_pool_mappings: 0x2::table::Table<0x2::object::ID, address>,
        inactive_validators: 0x2::table::Table<0x2::object::ID, 0x3::validator_wrapper::ValidatorWrapper>,
        validator_candidates: 0x2::table::Table<address, 0x3::validator_wrapper::ValidatorWrapper>,
        at_risk_validators: 0x2::vec_map::VecMap<address, u64>,
        extra_fields: 0x2::bag::Bag,
    }

    struct ValidatorEpochInfoEvent has copy, drop {
        epoch: u64,
        validator_address: address,
        reference_gas_survey_quote: u64,
        stake: u64,
        commission_rate: u64,
        pool_staking_reward: u64,
        storage_fund_staking_reward: u64,
        pool_token_exchange_rate: 0x3::staking_pool::PoolTokenExchangeRate,
        tallying_rule_reporters: vector<address>,
        tallying_rule_global_score: u64,
    }

    struct ValidatorEpochInfoEventV2 has copy, drop {
        epoch: u64,
        validator_address: address,
        reference_gas_survey_quote: u64,
        stake: u64,
        voting_power: u64,
        commission_rate: u64,
        pool_staking_reward: u64,
        storage_fund_staking_reward: u64,
        pool_token_exchange_rate: 0x3::staking_pool::PoolTokenExchangeRate,
        tallying_rule_reporters: vector<address>,
        tallying_rule_global_score: u64,
    }

    struct ValidatorJoinEvent has copy, drop {
        epoch: u64,
        validator_address: address,
        staking_pool_id: 0x2::object::ID,
    }

    struct ValidatorLeaveEvent has copy, drop {
        epoch: u64,
        validator_address: address,
        staking_pool_id: 0x2::object::ID,
        is_voluntary: bool,
    }

    struct VotingPowerAdmissionStartEpochKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: vector<0x3::validator::Validator>, arg1: &mut 0x2::tx_context::TxContext) : ValidatorSet {
        let v0 = calculate_total_stakes(&arg0);
        let v1 = 0x2::table::new<0x2::object::ID, address>(arg1);
        let v2 = &arg0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x3::validator::Validator>(v2)) {
            let v4 = 0x1::vector::borrow<0x3::validator::Validator>(v2, v3);
            0x2::table::add<0x2::object::ID, address>(&mut v1, 0x3::validator::staking_pool_id(v4), 0x3::validator::sui_address(v4));
            v3 = v3 + 1;
        };
        let v5 = ValidatorSet{
            total_stake               : v0,
            active_validators         : arg0,
            pending_active_validators : 0x2::table_vec::empty<0x3::validator::Validator>(arg1),
            pending_removals          : vector[],
            staking_pool_mappings     : v1,
            inactive_validators       : 0x2::table::new<0x2::object::ID, 0x3::validator_wrapper::ValidatorWrapper>(arg1),
            validator_candidates      : 0x2::table::new<address, 0x3::validator_wrapper::ValidatorWrapper>(arg1),
            at_risk_validators        : 0x2::vec_map::empty<address, u64>(),
            extra_fields              : 0x2::bag::new(arg1),
        };
        0x3::voting_power::set_voting_power(&mut v5.active_validators, v0);
        v5
    }

    fun adjust_stake_and_gas_price(arg0: &mut vector<0x3::validator::Validator>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x3::validator::Validator>(arg0)) {
            0x3::validator::adjust_stake_and_gas_price(0x1::vector::borrow_mut<0x3::validator::Validator>(arg0, v0));
            v0 = v0 + 1;
        };
    }

    public(friend) fun convert_to_fungible_staked_sui(arg0: &mut ValidatorSet, arg1: 0x3::staking_pool::StakedSui, arg2: &mut 0x2::tx_context::TxContext) : 0x3::staking_pool::FungibleStakedSui {
        let v0 = 0x3::staking_pool::pool_id(&arg1);
        let v1 = if (0x2::table::contains<0x2::object::ID, address>(&arg0.staking_pool_mappings, v0)) {
            let v2 = *0x2::table::borrow<0x2::object::ID, address>(&arg0.staking_pool_mappings, v0);
            get_candidate_or_active_validator_mut(arg0, v2)
        } else {
            assert!(0x2::table::contains<0x2::object::ID, 0x3::validator_wrapper::ValidatorWrapper>(&arg0.inactive_validators, v0), 3);
            0x3::validator_wrapper::load_validator_maybe_upgrade(0x2::table::borrow_mut<0x2::object::ID, 0x3::validator_wrapper::ValidatorWrapper>(&mut arg0.inactive_validators, v0))
        };
        0x3::validator::convert_to_fungible_staked_sui(v1, arg1, arg2)
    }

    fun effectuate_staged_metadata(arg0: &mut ValidatorSet) {
        let v0 = &mut arg0.active_validators;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x3::validator::Validator>(v0)) {
            0x3::validator::effectuate_staged_metadata(0x1::vector::borrow_mut<0x3::validator::Validator>(v0, v1));
            v1 = v1 + 1;
        };
    }

    fun process_pending_stakes_and_withdraws(arg0: &mut vector<0x3::validator::Validator>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x3::validator::Validator>(arg0)) {
            0x3::validator::process_pending_stakes_and_withdraws(0x1::vector::borrow_mut<0x3::validator::Validator>(arg0, v0), arg1);
            v0 = v0 + 1;
        };
    }

    public(friend) fun redeem_fungible_staked_sui(arg0: &mut ValidatorSet, arg1: 0x3::staking_pool::FungibleStakedSui, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x3::staking_pool::fungible_staked_sui_pool_id(&arg1);
        let v1 = if (0x2::table::contains<0x2::object::ID, address>(&arg0.staking_pool_mappings, v0)) {
            let v2 = *0x2::table::borrow<0x2::object::ID, address>(&arg0.staking_pool_mappings, v0);
            get_candidate_or_active_validator_mut(arg0, v2)
        } else {
            assert!(0x2::table::contains<0x2::object::ID, 0x3::validator_wrapper::ValidatorWrapper>(&arg0.inactive_validators, v0), 3);
            0x3::validator_wrapper::load_validator_maybe_upgrade(0x2::table::borrow_mut<0x2::object::ID, 0x3::validator_wrapper::ValidatorWrapper>(&mut arg0.inactive_validators, v0))
        };
        0x3::validator::redeem_fungible_staked_sui(v1, arg1, arg2)
    }

    public(friend) fun request_add_stake(arg0: &mut ValidatorSet, arg1: address, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x3::staking_pool::StakedSui {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2) >= 1000000000, 10);
        0x3::validator::request_add_stake(get_candidate_or_active_validator_mut(arg0, arg1), arg2, 0x2::tx_context::sender(arg3), arg3)
    }

    public(friend) fun request_set_commission_rate(arg0: &mut ValidatorSet, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = &mut arg0.active_validators;
        0x3::validator::request_set_commission_rate(get_validator_mut(v0, 0x2::tx_context::sender(arg2)), arg1);
    }

    public(friend) fun request_withdraw_stake(arg0: &mut ValidatorSet, arg1: 0x3::staking_pool::StakedSui, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x3::staking_pool::pool_id(&arg1);
        let v1 = if (0x2::table::contains<0x2::object::ID, address>(&arg0.staking_pool_mappings, v0)) {
            let v2 = *0x2::table::borrow<0x2::object::ID, address>(&arg0.staking_pool_mappings, 0x3::staking_pool::pool_id(&arg1));
            get_candidate_or_active_validator_mut(arg0, v2)
        } else {
            assert!(0x2::table::contains<0x2::object::ID, 0x3::validator_wrapper::ValidatorWrapper>(&arg0.inactive_validators, v0), 3);
            0x3::validator_wrapper::load_validator_maybe_upgrade(0x2::table::borrow_mut<0x2::object::ID, 0x3::validator_wrapper::ValidatorWrapper>(&mut arg0.inactive_validators, v0))
        };
        0x3::validator::request_withdraw_stake(v1, arg1, arg2)
    }

    public fun total_stake(arg0: &ValidatorSet) : u64 {
        arg0.total_stake
    }

    public(friend) fun active_validator_addresses(arg0: &ValidatorSet) : vector<address> {
        let v0 = &arg0.active_validators;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x3::validator::Validator>(v0)) {
            0x1::vector::push_back<address>(&mut v1, 0x3::validator::sui_address(0x1::vector::borrow<0x3::validator::Validator>(v0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun active_validators(arg0: &ValidatorSet) : &vector<0x3::validator::Validator> {
        &arg0.active_validators
    }

    public(friend) fun advance_epoch(arg0: &mut ValidatorSet, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::vec_map::VecMap<address, 0x2::vec_set::VecSet<address>>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg6) + 1;
        let v1 = 0x3::voting_power::total_voting_power();
        let v2 = VotingPowerAdmissionStartEpochKey{dummy_field: false};
        if (!0x2::bag::contains<VotingPowerAdmissionStartEpochKey>(&arg0.extra_fields, v2)) {
            0x2::bag::add<VotingPowerAdmissionStartEpochKey, u64>(&mut arg0.extra_fields, v2, 0x2::tx_context::epoch(arg6));
        };
        let (v3, v4) = compute_unadjusted_reward_distribution(&arg0.active_validators, v1, 0x2::balance::value<0x2::sui::SUI>(arg1), 0x2::balance::value<0x2::sui::SUI>(arg2));
        let v5 = v4;
        let v6 = v3;
        let v7 = compute_slashed_validators(arg0, *arg3);
        let (v8, v9, v10, v11) = compute_reward_adjustments(get_validator_indices(&arg0.active_validators, &v7), arg4, &v6, &v5);
        let (v12, v13) = compute_adjusted_reward_distribution(&arg0.active_validators, v1, sum_voting_power_by_addresses(&arg0.active_validators, &v7), v6, v5, v8, v9, v10, v11);
        let v14 = v13;
        let v15 = v12;
        let v16 = &mut arg0.active_validators;
        distribute_reward(v16, &v15, &v14, arg1, arg2, arg6);
        let v17 = &mut arg0.active_validators;
        adjust_stake_and_gas_price(v17);
        let v18 = &mut arg0.active_validators;
        process_pending_stakes_and_withdraws(v18, arg6);
        emit_validator_epoch_events(v0, &arg0.active_validators, &v15, &v14, arg3, &v7);
        process_pending_removals(arg0, arg3, arg6);
        let v19 = update_validator_positions_and_calculate_total_stake(arg0, arg5, arg3, arg6);
        arg0.total_stake = v19;
        0x3::voting_power::set_voting_power(&mut arg0.active_validators, v19);
        effectuate_staged_metadata(arg0);
    }

    public(friend) fun assert_no_pending_or_active_duplicates(arg0: &ValidatorSet, arg1: &0x3::validator::Validator) {
        assert!(count_duplicates_vec(&arg0.active_validators, arg1) + count_duplicates_tablevec(&arg0.pending_active_validators, arg1) == 1, 2);
    }

    public(friend) fun calculate_total_stakes(arg0: &vector<0x3::validator::Validator>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x3::validator::Validator>(arg0)) {
            v0 = v0 + 0x3::validator::total_stake(0x1::vector::borrow<0x3::validator::Validator>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun can_join(arg0: &ValidatorSet, arg1: u64, arg2: &0x2::tx_context::TxContext) : bool {
        let (v0, _, _) = get_voting_power_thresholds(arg0, arg2);
        0x3::voting_power::derive_raw_voting_power(arg1, arg0.total_stake + arg1) >= v0
    }

    fun clean_report_records_leaving_validator(arg0: &mut 0x2::vec_map::VecMap<address, 0x2::vec_set::VecSet<address>>, arg1: address) {
        if (0x2::vec_map::contains<address, 0x2::vec_set::VecSet<address>>(arg0, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<address, 0x2::vec_set::VecSet<address>>(arg0, &arg1);
        };
        let v2 = 0x2::vec_map::keys<address, 0x2::vec_set::VecSet<address>>(arg0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&v2)) {
            let v4 = 0x1::vector::borrow<address>(&v2, v3);
            let v5 = 0x2::vec_map::get_mut<address, 0x2::vec_set::VecSet<address>>(arg0, v4);
            if (0x2::vec_set::contains<address>(v5, &arg1)) {
                0x2::vec_set::remove<address>(v5, &arg1);
                if (0x2::vec_set::is_empty<address>(v5)) {
                    let (_, _) = 0x2::vec_map::remove<address, 0x2::vec_set::VecSet<address>>(arg0, v4);
                };
            };
            v3 = v3 + 1;
        };
    }

    fun compute_adjusted_reward_distribution(arg0: &vector<0x3::validator::Validator>, arg1: u64, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: u64, arg6: 0x2::vec_map::VecMap<u64, u64>, arg7: u64, arg8: 0x2::vec_map::VecMap<u64, u64>) : (vector<u64>, vector<u64>) {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = 0x1::vector::length<0x3::validator::Validator>(arg0);
        let v3 = 0;
        while (v3 < v2) {
            let v4 = if (0x2::vec_map::contains<u64, u64>(&arg6, &v3)) {
                *0x1::vector::borrow<u64>(&arg3, v3) - *0x2::vec_map::get<u64, u64>(&arg6, &v3)
            } else {
                *0x1::vector::borrow<u64>(&arg3, v3) + (((arg5 as u128) * (0x3::validator::voting_power(0x1::vector::borrow<0x3::validator::Validator>(arg0, v3)) as u128) / ((arg1 - arg2) as u128)) as u64)
            };
            0x1::vector::push_back<u64>(&mut v0, v4);
            let v5 = if (0x2::vec_map::contains<u64, u64>(&arg8, &v3)) {
                *0x1::vector::borrow<u64>(&arg4, v3) - *0x2::vec_map::get<u64, u64>(&arg8, &v3)
            } else {
                *0x1::vector::borrow<u64>(&arg4, v3) + arg7 / (v2 - 0x2::vec_map::size<u64, u64>(&arg6))
            };
            0x1::vector::push_back<u64>(&mut v1, v5);
            v3 = v3 + 1;
        };
        (v0, v1)
    }

    fun compute_reward_adjustments(arg0: vector<u64>, arg1: u64, arg2: &vector<u64>, arg3: &vector<u64>) : (u64, 0x2::vec_map::VecMap<u64, u64>, u64, 0x2::vec_map::VecMap<u64, u64>) {
        let v0 = 0;
        let v1 = 0x2::vec_map::empty<u64, u64>();
        let v2 = 0;
        let v3 = 0x2::vec_map::empty<u64, u64>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&arg0)) {
            let v5 = 0x1::vector::pop_back<u64>(&mut arg0);
            let v6 = (((*0x1::vector::borrow<u64>(arg2, v5) as u128) * (arg1 as u128) / (10000 as u128)) as u64);
            0x2::vec_map::insert<u64, u64>(&mut v1, v5, v6);
            v0 = v0 + v6;
            let v7 = (((*0x1::vector::borrow<u64>(arg3, v5) as u128) * (arg1 as u128) / (10000 as u128)) as u64);
            0x2::vec_map::insert<u64, u64>(&mut v3, v5, v7);
            v2 = v2 + v7;
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<u64>(arg0);
        (v0, v1, v2, v3)
    }

    fun compute_slashed_validators(arg0: &ValidatorSet, arg1: 0x2::vec_map::VecMap<address, 0x2::vec_set::VecSet<address>>) : vector<address> {
        let v0 = vector[];
        while (!0x2::vec_map::is_empty<address, 0x2::vec_set::VecSet<address>>(&arg1)) {
            let (v1, v2) = 0x2::vec_map::pop<address, 0x2::vec_set::VecSet<address>>(&mut arg1);
            assert!(is_active_validator_by_sui_address(arg0, v1), 0);
            let v3 = 0x2::vec_set::into_keys<address>(v2);
            if (sum_voting_power_by_addresses(&arg0.active_validators, &v3) >= 0x3::voting_power::quorum_threshold()) {
                0x1::vector::push_back<address>(&mut v0, v1);
            };
        };
        v0
    }

    fun compute_unadjusted_reward_distribution(arg0: &vector<0x3::validator::Validator>, arg1: u64, arg2: u64, arg3: u64) : (vector<u64>, vector<u64>) {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x3::validator::Validator>(arg0)) {
            0x1::vector::push_back<u64>(&mut v0, (((0x3::validator::voting_power(0x1::vector::borrow<0x3::validator::Validator>(arg0, v2)) as u128) * (arg2 as u128) / (arg1 as u128)) as u64));
            0x1::vector::push_back<u64>(&mut v1, arg3 / 0x1::vector::length<0x3::validator::Validator>(arg0));
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    fun count_duplicates_tablevec(arg0: &0x2::table_vec::TableVec<0x3::validator::Validator>, arg1: &0x3::validator::Validator) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::table_vec::length<0x3::validator::Validator>(arg0)) {
            if (0x3::validator::is_duplicate(0x2::table_vec::borrow<0x3::validator::Validator>(arg0, v1), arg1)) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun count_duplicates_vec(arg0: &vector<0x3::validator::Validator>, arg1: &0x3::validator::Validator) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x3::validator::Validator>(arg0)) {
            if (0x3::validator::is_duplicate(0x1::vector::borrow<0x3::validator::Validator>(arg0, v1), arg1)) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun derive_reference_gas_price(arg0: &ValidatorSet) : u64 {
        let v0 = &arg0.active_validators;
        let v1 = 0x1::vector::empty<0x2::priority_queue::Entry<u64>>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x3::validator::Validator>(v0)) {
            let v3 = 0x1::vector::borrow<0x3::validator::Validator>(v0, v2);
            0x1::vector::push_back<0x2::priority_queue::Entry<u64>>(&mut v1, 0x2::priority_queue::new_entry<u64>(0x3::validator::gas_price(v3), 0x3::validator::voting_power(v3)));
            v2 = v2 + 1;
        };
        let v4 = 0x2::priority_queue::new<u64>(v1);
        let v5 = 0;
        let v6 = 0;
        while (v5 < 0x3::voting_power::total_voting_power() - 0x3::voting_power::quorum_threshold()) {
            let (v7, v8) = 0x2::priority_queue::pop_max<u64>(&mut v4);
            v6 = v7;
            v5 = v5 + v8;
        };
        v6
    }

    fun distribute_reward(arg0: &mut vector<0x3::validator::Validator>, arg1: &vector<u64>, arg2: &vector<u64>, arg3: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x3::validator::Validator>(arg0);
        assert!(v0 > 0, 13);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow_mut<0x3::validator::Validator>(arg0, v1);
            let v3 = *0x1::vector::borrow<u64>(arg1, v1);
            let v4 = 0x2::balance::split<0x2::sui::SUI>(arg3, v3);
            let v5 = 0x2::balance::split<0x2::sui::SUI>(&mut v4, ((((v3 as u128) * (0x3::validator::commission_rate(v2) as u128) / (10000 as u128)) as u64) as u64));
            0x2::balance::join<0x2::sui::SUI>(&mut v5, 0x2::balance::split<0x2::sui::SUI>(arg4, *0x1::vector::borrow<u64>(arg2, v1)));
            if (0x2::balance::value<0x2::sui::SUI>(&v5) > 0) {
                let v6 = 0x3::validator::sui_address(v2);
                0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(0x3::validator::request_add_stake(v2, v5, v6, arg5), v6);
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(v5);
            };
            0x3::validator::deposit_stake_rewards(v2, v4);
            v1 = v1 + 1;
        };
    }

    fun emit_validator_epoch_events(arg0: u64, arg1: &vector<0x3::validator::Validator>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &0x2::vec_map::VecMap<address, 0x2::vec_set::VecSet<address>>, arg5: &vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x3::validator::Validator>(arg1)) {
            let v1 = 0x1::vector::borrow<0x3::validator::Validator>(arg1, v0);
            let v2 = 0x3::validator::sui_address(v1);
            let v3 = if (0x2::vec_map::contains<address, 0x2::vec_set::VecSet<address>>(arg4, &v2)) {
                0x2::vec_set::into_keys<address>(*0x2::vec_map::get<address, 0x2::vec_set::VecSet<address>>(arg4, &v2))
            } else {
                vector[]
            };
            let v4 = if (0x1::vector::contains<address>(arg5, &v2)) {
                0
            } else {
                1
            };
            let v5 = ValidatorEpochInfoEventV2{
                epoch                       : arg0,
                validator_address           : v2,
                reference_gas_survey_quote  : 0x3::validator::gas_price(v1),
                stake                       : 0x3::validator::total_stake(v1),
                voting_power                : 0x3::validator::voting_power(v1),
                commission_rate             : 0x3::validator::commission_rate(v1),
                pool_staking_reward         : *0x1::vector::borrow<u64>(arg2, v0),
                storage_fund_staking_reward : *0x1::vector::borrow<u64>(arg3, v0),
                pool_token_exchange_rate    : 0x3::validator::pool_token_exchange_rate_at_epoch(v1, arg0),
                tallying_rule_reporters     : v3,
                tallying_rule_global_score  : v4,
            };
            0x2::event::emit<ValidatorEpochInfoEventV2>(v5);
            v0 = v0 + 1;
        };
    }

    fun find_validator(arg0: &vector<0x3::validator::Validator>, arg1: address) : 0x1::option::Option<u64> {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<0x3::validator::Validator>(arg0)) {
            if (0x3::validator::sui_address(0x1::vector::borrow<0x3::validator::Validator>(arg0, v0)) == arg1) {
                v1 = 0x1::option::some<u64>(v0);
                return v1
            };
            v0 = v0 + 1;
        };
        v1 = 0x1::option::none<u64>();
        v1
    }

    fun find_validator_from_table_vec(arg0: &0x2::table_vec::TableVec<0x3::validator::Validator>, arg1: address) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x2::table_vec::length<0x3::validator::Validator>(arg0)) {
            if (0x3::validator::sui_address(0x2::table_vec::borrow<0x3::validator::Validator>(arg0, v0)) == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    fun get_active_or_pending_or_candidate_validator_mut(arg0: &mut ValidatorSet, arg1: address, arg2: bool) : &mut 0x3::validator::Validator {
        let v0 = find_validator(&arg0.active_validators, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            return 0x1::vector::borrow_mut<0x3::validator::Validator>(&mut arg0.active_validators, 0x1::option::extract<u64>(&mut v0))
        };
        let v1 = find_validator_from_table_vec(&arg0.pending_active_validators, arg1);
        if (0x1::option::is_some<u64>(&v1)) {
            return 0x2::table_vec::borrow_mut<0x3::validator::Validator>(&mut arg0.pending_active_validators, 0x1::option::extract<u64>(&mut v1))
        };
        assert!(arg2, 9);
        0x3::validator_wrapper::load_validator_maybe_upgrade(0x2::table::borrow_mut<address, 0x3::validator_wrapper::ValidatorWrapper>(&mut arg0.validator_candidates, arg1))
    }

    public(friend) fun get_active_or_pending_or_candidate_validator_ref(arg0: &mut ValidatorSet, arg1: address, arg2: u8) : &0x3::validator::Validator {
        let v0 = find_validator(&arg0.active_validators, arg1);
        if (0x1::option::is_some<u64>(&v0) || arg2 == 1) {
            return 0x1::vector::borrow<0x3::validator::Validator>(&arg0.active_validators, 0x1::option::extract<u64>(&mut v0))
        };
        let v1 = find_validator_from_table_vec(&arg0.pending_active_validators, arg1);
        if (0x1::option::is_some<u64>(&v1) || arg2 == 2) {
            return 0x2::table_vec::borrow<0x3::validator::Validator>(&arg0.pending_active_validators, 0x1::option::extract<u64>(&mut v1))
        };
        0x3::validator_wrapper::load_validator_maybe_upgrade(0x2::table::borrow_mut<address, 0x3::validator_wrapper::ValidatorWrapper>(&mut arg0.validator_candidates, arg1))
    }

    public fun get_active_validator_ref(arg0: &ValidatorSet, arg1: address) : &0x3::validator::Validator {
        let v0 = find_validator(&arg0.active_validators, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            return 0x1::vector::borrow<0x3::validator::Validator>(&arg0.active_validators, 0x1::option::destroy_some<u64>(v0))
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 4
        };
    }

    fun get_candidate_or_active_validator_mut(arg0: &mut ValidatorSet, arg1: address) : &mut 0x3::validator::Validator {
        if (0x2::table::contains<address, 0x3::validator_wrapper::ValidatorWrapper>(&arg0.validator_candidates, arg1)) {
            0x3::validator_wrapper::load_validator_maybe_upgrade(0x2::table::borrow_mut<address, 0x3::validator_wrapper::ValidatorWrapper>(&mut arg0.validator_candidates, arg1))
        } else {
            let v1 = &mut arg0.active_validators;
            get_validator_mut(v1, arg1)
        }
    }

    public fun get_pending_validator_ref(arg0: &ValidatorSet, arg1: address) : &0x3::validator::Validator {
        let v0 = find_validator_from_table_vec(&arg0.pending_active_validators, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            return 0x2::table_vec::borrow<0x3::validator::Validator>(&arg0.pending_active_validators, 0x1::option::destroy_some<u64>(v0))
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 12
        };
    }

    fun get_validator_indices(arg0: &vector<0x3::validator::Validator>, arg1: &vector<address>) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg1)) {
            let v2 = find_validator(arg0, *0x1::vector::borrow<address>(arg1, v1));
            if (0x1::option::is_some<u64>(&v2)) {
                0x1::vector::push_back<u64>(&mut v0, 0x1::option::destroy_some<u64>(v2));
                v1 = v1 + 1;
            } else {
                0x1::option::destroy_none<u64>(v2);
                abort 4
            };
        };
        v0
    }

    public(friend) fun get_validator_mut(arg0: &mut vector<0x3::validator::Validator>, arg1: address) : &mut 0x3::validator::Validator {
        let v0 = find_validator(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            return 0x1::vector::borrow_mut<0x3::validator::Validator>(arg0, 0x1::option::destroy_some<u64>(v0))
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 4
        };
    }

    public(friend) fun get_validator_mut_with_ctx(arg0: &mut ValidatorSet, arg1: &0x2::tx_context::TxContext) : &mut 0x3::validator::Validator {
        get_active_or_pending_or_candidate_validator_mut(arg0, 0x2::tx_context::sender(arg1), false)
    }

    public(friend) fun get_validator_mut_with_ctx_including_candidates(arg0: &mut ValidatorSet, arg1: &0x2::tx_context::TxContext) : &mut 0x3::validator::Validator {
        get_active_or_pending_or_candidate_validator_mut(arg0, 0x2::tx_context::sender(arg1), true)
    }

    public(friend) fun get_validator_mut_with_verified_cap(arg0: &mut ValidatorSet, arg1: &0x3::validator_cap::ValidatorOperationCap, arg2: bool) : &mut 0x3::validator::Validator {
        get_active_or_pending_or_candidate_validator_mut(arg0, *0x3::validator_cap::verified_operation_cap_address(arg1), arg2)
    }

    fun get_validator_ref(arg0: &vector<0x3::validator::Validator>, arg1: address) : &0x3::validator::Validator {
        let v0 = find_validator(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            return 0x1::vector::borrow<0x3::validator::Validator>(arg0, 0x1::option::destroy_some<u64>(v0))
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 4
        };
    }

    fun get_voting_power_thresholds(arg0: &ValidatorSet, arg1: &0x2::tx_context::TxContext) : (u64, u64, u64) {
        let v0 = VotingPowerAdmissionStartEpochKey{dummy_field: false};
        let v1 = if (0x2::bag::contains<VotingPowerAdmissionStartEpochKey>(&arg0.extra_fields, v0)) {
            *0x2::bag::borrow<VotingPowerAdmissionStartEpochKey, u64>(&arg0.extra_fields, v0)
        } else {
            0x2::tx_context::epoch(arg1) + 1
        };
        let v2 = 0x2::tx_context::epoch(arg1);
        if (v2 < v1 + 14) {
            (12, 8, 4)
        } else if (v2 < v1 + 2 * 14) {
            (6, 4, 2)
        } else {
            (3, 2, 1)
        }
    }

    public(friend) fun is_active_validator(arg0: &ValidatorSet, arg1: address) : bool {
        let v0 = &arg0.active_validators;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x3::validator::Validator>(v0)) {
            if (0x3::validator::sui_address(0x1::vector::borrow<0x3::validator::Validator>(v0, v1)) == arg1) {
                v2 = true;
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = false;
        v2
    }

    public(friend) fun is_active_validator_by_sui_address(arg0: &ValidatorSet, arg1: address) : bool {
        let v0 = find_validator(&arg0.active_validators, arg1);
        0x1::option::is_some<u64>(&v0)
    }

    public(friend) fun is_at_risk_validator(arg0: &ValidatorSet, arg1: address) : bool {
        0x2::vec_map::contains<address, u64>(&arg0.at_risk_validators, &arg1)
    }

    public(friend) fun is_duplicate_validator(arg0: &vector<0x3::validator::Validator>, arg1: &0x3::validator::Validator) : bool {
        count_duplicates_vec(arg0, arg1) > 0
    }

    fun is_duplicate_with_active_validator(arg0: &ValidatorSet, arg1: &0x3::validator::Validator) : bool {
        is_duplicate_validator(&arg0.active_validators, arg1)
    }

    fun is_duplicate_with_pending_validator(arg0: &ValidatorSet, arg1: &0x3::validator::Validator) : bool {
        count_duplicates_tablevec(&arg0.pending_active_validators, arg1) > 0
    }

    public fun is_inactive_validator(arg0: &ValidatorSet, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0x3::validator_wrapper::ValidatorWrapper>(&arg0.inactive_validators, arg1)
    }

    public fun is_validator_candidate(arg0: &ValidatorSet, arg1: address) : bool {
        0x2::table::contains<address, 0x3::validator_wrapper::ValidatorWrapper>(&arg0.validator_candidates, arg1)
    }

    public(friend) fun next_epoch_validator_count(arg0: &ValidatorSet) : u64 {
        0x1::vector::length<0x3::validator::Validator>(&arg0.active_validators) - 0x1::vector::length<u64>(&arg0.pending_removals) + 0x2::table_vec::length<0x3::validator::Validator>(&arg0.pending_active_validators)
    }

    public(friend) fun pool_exchange_rates(arg0: &mut ValidatorSet, arg1: &0x2::object::ID) : &0x2::table::Table<u64, 0x3::staking_pool::PoolTokenExchangeRate> {
        let v0 = if (0x2::table::contains<0x2::object::ID, address>(&arg0.staking_pool_mappings, *arg1)) {
            let v1 = *0x2::table::borrow<0x2::object::ID, address>(&arg0.staking_pool_mappings, *arg1);
            get_active_or_pending_or_candidate_validator_ref(arg0, v1, 3)
        } else {
            0x3::validator_wrapper::load_validator_maybe_upgrade(0x2::table::borrow_mut<0x2::object::ID, 0x3::validator_wrapper::ValidatorWrapper>(&mut arg0.inactive_validators, *arg1))
        };
        0x3::staking_pool::exchange_rates(0x3::validator::get_staking_pool_ref(v0))
    }

    fun process_pending_removals(arg0: &mut ValidatorSet, arg1: &mut 0x2::vec_map::VecMap<address, 0x2::vec_set::VecSet<address>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.pending_removals;
        sort_removal_list(v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0.pending_removals)) {
            let v2 = 0x1::vector::remove<0x3::validator::Validator>(&mut arg0.active_validators, 0x1::vector::pop_back<u64>(&mut arg0.pending_removals));
            process_validator_departure(arg0, v2, arg1, true, arg2);
            v1 = v1 + 1;
        };
    }

    fun process_validator_departure(arg0: &mut ValidatorSet, arg1: 0x3::validator::Validator, arg2: &mut 0x2::vec_map::VecMap<address, 0x2::vec_set::VecSet<address>>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::epoch(arg4) + 1;
        let v1 = 0x3::validator::sui_address(&arg1);
        let v2 = 0x3::validator::staking_pool_id(&arg1);
        0x2::table::remove<0x2::object::ID, address>(&mut arg0.staking_pool_mappings, v2);
        if (0x2::vec_map::contains<address, u64>(&arg0.at_risk_validators, &v1)) {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.at_risk_validators, &v1);
        };
        clean_report_records_leaving_validator(arg2, v1);
        let v5 = ValidatorLeaveEvent{
            epoch             : v0,
            validator_address : v1,
            staking_pool_id   : 0x3::validator::staking_pool_id(&arg1),
            is_voluntary      : arg3,
        };
        0x2::event::emit<ValidatorLeaveEvent>(v5);
        0x3::validator::deactivate(&mut arg1, v0);
        0x2::table::add<0x2::object::ID, 0x3::validator_wrapper::ValidatorWrapper>(&mut arg0.inactive_validators, v2, 0x3::validator_wrapper::create_v1(arg1, arg4));
        0x3::validator::total_stake(&arg1)
    }

    public(friend) fun request_add_validator(arg0: &mut ValidatorSet, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, 0x3::validator_wrapper::ValidatorWrapper>(&arg0.validator_candidates, v0), 8);
        let v1 = 0x3::validator_wrapper::destroy(0x2::table::remove<address, 0x3::validator_wrapper::ValidatorWrapper>(&mut arg0.validator_candidates, v0));
        assert!(!is_duplicate_with_active_validator(arg0, &v1) && !is_duplicate_with_pending_validator(arg0, &v1), 2);
        assert!(0x3::validator::is_preactive(&v1), 7);
        assert!(can_join(arg0, 0x3::validator::total_stake(&v1), arg1), 5);
        0x2::table_vec::push_back<0x3::validator::Validator>(&mut arg0.pending_active_validators, v1);
    }

    public(friend) fun request_add_validator_candidate(arg0: &mut ValidatorSet, arg1: 0x3::validator::Validator, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!is_duplicate_with_active_validator(arg0, &arg1) && !is_duplicate_with_pending_validator(arg0, &arg1), 2);
        let v0 = 0x3::validator::sui_address(&arg1);
        assert!(!0x2::table::contains<address, 0x3::validator_wrapper::ValidatorWrapper>(&arg0.validator_candidates, v0), 6);
        assert!(0x3::validator::is_preactive(&arg1), 7);
        0x2::table::add<0x2::object::ID, address>(&mut arg0.staking_pool_mappings, 0x3::validator::staking_pool_id(&arg1), v0);
        0x2::table::add<address, 0x3::validator_wrapper::ValidatorWrapper>(&mut arg0.validator_candidates, 0x3::validator::sui_address(&arg1), 0x3::validator_wrapper::create_v1(arg1, arg2));
    }

    public(friend) fun request_remove_validator(arg0: &mut ValidatorSet, arg1: &0x2::tx_context::TxContext) {
        let v0 = find_validator(&arg0.active_validators, 0x2::tx_context::sender(arg1));
        if (0x1::option::is_some<u64>(&v0)) {
            let v1 = 0x1::option::destroy_some<u64>(v0);
            assert!(!0x1::vector::contains<u64>(&arg0.pending_removals, &v1), 11);
            0x1::vector::push_back<u64>(&mut arg0.pending_removals, v1);
            return
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 4
        };
    }

    public(friend) fun request_remove_validator_candidate(arg0: &mut ValidatorSet, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, 0x3::validator_wrapper::ValidatorWrapper>(&arg0.validator_candidates, v0), 8);
        let v1 = 0x3::validator_wrapper::destroy(0x2::table::remove<address, 0x3::validator_wrapper::ValidatorWrapper>(&mut arg0.validator_candidates, v0));
        assert!(0x3::validator::is_preactive(&v1), 7);
        let v2 = 0x3::validator::staking_pool_id(&v1);
        0x2::table::remove<0x2::object::ID, address>(&mut arg0.staking_pool_mappings, v2);
        0x3::validator::deactivate(&mut v1, 0x2::tx_context::epoch(arg1));
        0x2::table::add<0x2::object::ID, 0x3::validator_wrapper::ValidatorWrapper>(&mut arg0.inactive_validators, v2, 0x3::validator_wrapper::create_v1(v1, arg1));
    }

    fun sort_removal_list(arg0: &mut vector<u64>) {
        let v0 = 1;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            let v1 = v0;
            while (v1 > 0) {
                v1 = v1 - 1;
                if (*0x1::vector::borrow<u64>(arg0, v1) > *0x1::vector::borrow<u64>(arg0, v0)) {
                    0x1::vector::swap<u64>(arg0, v1, v1 + 1);
                } else {
                    break
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun staking_pool_mappings(arg0: &ValidatorSet) : &0x2::table::Table<0x2::object::ID, address> {
        &arg0.staking_pool_mappings
    }

    public fun sum_voting_power_by_addresses(arg0: &vector<0x3::validator::Validator>, arg1: &vector<address>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg1)) {
            v0 = v0 + 0x3::validator::voting_power(get_validator_ref(arg0, *0x1::vector::borrow<address>(arg1, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun update_validator_positions_and_calculate_total_stake(arg0: &mut ValidatorSet, arg1: u64, arg2: &mut 0x2::vec_map::VecMap<address, 0x2::vec_set::VecSet<address>>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x1::vector::empty<0x3::validator::Validator>();
        let v1 = 0;
        while (v1 < 0x2::table_vec::length<0x3::validator::Validator>(&arg0.pending_active_validators)) {
            0x1::vector::push_back<0x3::validator::Validator>(&mut v0, 0x2::table_vec::pop_back<0x3::validator::Validator>(&mut arg0.pending_active_validators));
            v1 = v1 + 1;
        };
        let v2 = calculate_total_stakes(&arg0.active_validators) + calculate_total_stakes(&v0);
        let (v3, v4, v5) = get_voting_power_thresholds(arg0, arg3);
        let v6 = 0;
        let v7 = 0x1::vector::length<0x3::validator::Validator>(&arg0.active_validators);
        while (v7 > 0) {
            v7 = v7 - 1;
            let v8 = 0x1::vector::borrow<0x3::validator::Validator>(&arg0.active_validators, v7);
            let v9 = 0x3::validator::sui_address(v8);
            let v10 = 0x3::voting_power::derive_raw_voting_power(0x3::validator::total_stake(v8), v2);
            if (v10 >= v4) {
                if (0x2::vec_map::contains<address, u64>(&arg0.at_risk_validators, &v9)) {
                    let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.at_risk_validators, &v9);
                    continue
                } else {
                    continue
                };
            };
            if (v10 >= v5) {
                let v13 = if (0x2::vec_map::contains<address, u64>(&arg0.at_risk_validators, &v9)) {
                    let v14 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.at_risk_validators, &v9);
                    *v14 = *v14 + 1;
                    *v14
                } else {
                    0x2::vec_map::insert<address, u64>(&mut arg0.at_risk_validators, v9, 1);
                    1
                };
                if (v13 > arg1) {
                    let v15 = 0x1::vector::remove<0x3::validator::Validator>(&mut arg0.active_validators, v7);
                    let v16 = process_validator_departure(arg0, v15, arg2, false, arg3);
                    v6 = v6 + v16;
                    continue
                } else {
                    continue
                };
            };
            let v17 = 0x1::vector::remove<0x3::validator::Validator>(&mut arg0.active_validators, v7);
            let v18 = process_validator_departure(arg0, v17, arg2, false, arg3);
            v6 = v6 + v18;
        };
        0x1::vector::reverse<0x3::validator::Validator>(&mut v0);
        let v19 = 0;
        while (v19 < 0x1::vector::length<0x3::validator::Validator>(&v0)) {
            let v20 = 0x1::vector::pop_back<0x3::validator::Validator>(&mut v0);
            let v21 = 0x3::validator::total_stake(&v20);
            if (0x3::voting_power::derive_raw_voting_power(v21, v2) >= v3) {
                0x3::validator::activate(&mut v20, 0x2::tx_context::epoch(arg3));
                let v22 = ValidatorJoinEvent{
                    epoch             : 0x2::tx_context::epoch(arg3),
                    validator_address : 0x3::validator::sui_address(&v20),
                    staking_pool_id   : 0x3::validator::staking_pool_id(&v20),
                };
                0x2::event::emit<ValidatorJoinEvent>(v22);
                0x1::vector::push_back<0x3::validator::Validator>(&mut arg0.active_validators, v20);
            } else {
                0x2::table::add<address, 0x3::validator_wrapper::ValidatorWrapper>(&mut arg0.validator_candidates, 0x3::validator::sui_address(&v20), 0x3::validator_wrapper::create_v1(v20, arg3));
                v6 = v6 + v21;
            };
            v19 = v19 + 1;
        };
        0x1::vector::destroy_empty<0x3::validator::Validator>(v0);
        v2 - v6
    }

    public fun validator_address_by_pool_id(arg0: &mut ValidatorSet, arg1: &0x2::object::ID) : address {
        if (0x2::table::contains<0x2::object::ID, address>(&arg0.staking_pool_mappings, *arg1)) {
            *0x2::table::borrow<0x2::object::ID, address>(&arg0.staking_pool_mappings, *arg1)
        } else {
            0x3::validator::sui_address(0x3::validator_wrapper::load_validator_maybe_upgrade(0x2::table::borrow_mut<0x2::object::ID, 0x3::validator_wrapper::ValidatorWrapper>(&mut arg0.inactive_validators, *arg1)))
        }
    }

    public fun validator_stake_amount(arg0: &ValidatorSet, arg1: address) : u64 {
        0x3::validator::total_stake(get_validator_ref(&arg0.active_validators, arg1))
    }

    public fun validator_staking_pool_id(arg0: &ValidatorSet, arg1: address) : 0x2::object::ID {
        0x3::validator::staking_pool_id(get_validator_ref(&arg0.active_validators, arg1))
    }

    public fun validator_total_stake_amount(arg0: &ValidatorSet, arg1: address) : u64 {
        0x3::validator::total_stake(get_validator_ref(&arg0.active_validators, arg1))
    }

    public fun validator_voting_power(arg0: &ValidatorSet, arg1: address) : u64 {
        0x3::validator::voting_power(get_validator_ref(&arg0.active_validators, arg1))
    }

    public(friend) fun verify_cap(arg0: &mut ValidatorSet, arg1: &0x3::validator_cap::UnverifiedValidatorOperationCap, arg2: u8) : 0x3::validator_cap::ValidatorOperationCap {
        let v0 = if (arg2 == 1) {
            get_active_validator_ref(arg0, *0x3::validator_cap::unverified_operation_cap_address(arg1))
        } else {
            get_active_or_pending_or_candidate_validator_ref(arg0, *0x3::validator_cap::unverified_operation_cap_address(arg1), arg2)
        };
        let v1 = 0x2::object::id<0x3::validator_cap::UnverifiedValidatorOperationCap>(arg1);
        assert!(0x3::validator::operation_cap_id(v0) == &v1, 101);
        0x3::validator_cap::into_verified(arg1)
    }

    // decompiled from Move bytecode v6
}

