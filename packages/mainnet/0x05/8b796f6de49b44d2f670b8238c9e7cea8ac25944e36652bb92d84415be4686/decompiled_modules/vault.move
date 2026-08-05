module 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::vault {
    struct AgentCap<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        agent: address,
        generation: u64,
    }

    struct Accounting has store {
        cumulative_funded_a: u128,
        cumulative_funded_b: u128,
        cumulative_deployed_a: u128,
        cumulative_deployed_b: u128,
        cumulative_principal_a: u128,
        cumulative_principal_b: u128,
        cumulative_fee_a: u128,
        cumulative_fee_b: u128,
        cumulative_closing_fee_a: u128,
        cumulative_closing_fee_b: u128,
        cumulative_same_asset_reward_a: u128,
        cumulative_same_asset_reward_b: u128,
        cumulative_fee_compounded_a: u128,
        cumulative_fee_compounded_b: u128,
        cumulative_fee_distributed_a: u128,
        cumulative_fee_distributed_b: u128,
        cumulative_reward_compounded_a: u128,
        cumulative_reward_compounded_b: u128,
        cumulative_reward_distributed_a: u128,
        cumulative_reward_distributed_b: u128,
        cumulative_swap_input_a: u128,
        cumulative_swap_input_b: u128,
        cumulative_swap_output_a: u128,
        cumulative_swap_output_b: u128,
    }

    struct OwnerCollection has store {
        owner_fee_collected: bool,
        owner_collection_position_generation: u64,
        owner_collection_below_position_id: 0x1::option::Option<0x2::object::ID>,
        owner_collection_above_position_id: 0x1::option::Option<0x2::object::ID>,
        owner_below_fee_a: u64,
        owner_below_fee_b: u64,
        owner_above_fee_a: u64,
        owner_above_fee_b: u64,
        owner_collected_reward_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        owner_reward_a_collected: bool,
        owner_reward_b_collected: bool,
        owner_reward_order: vector<0x1::type_name::TypeName>,
        owner_below_reward_amounts: vector<u64>,
        owner_above_reward_amounts: vector<u64>,
    }

    struct IncomeSwapPolicy has copy, drop, store {
        version: u64,
        clmm_config_id: 0x2::object::ID,
        usdc_sui_pool_id: 0x2::object::ID,
        cetus_sui_pool_id: 0x2::object::ID,
        cetus_type: 0x1::type_name::TypeName,
        usdc_sqrt_price_limit: u128,
        cetus_sqrt_price_limit: u128,
    }

    struct IncomeState<phantom T0, phantom T1> has store {
        profit_recipient: address,
        last_income_action_ms: u64,
        pending_fee_a: 0x2::balance::Balance<T0>,
        pending_fee_b: 0x2::balance::Balance<T1>,
        pending_reward_a: 0x2::balance::Balance<T0>,
        pending_reward_b: 0x2::balance::Balance<T1>,
        reward_a_enabled: bool,
        reward_b_enabled: bool,
        income_swap_policy: 0x1::option::Option<IncomeSwapPolicy>,
        cumulative_distributed_rewards: 0x2::bag::Bag,
    }

    struct IncomeSwapSeal has copy, drop, store {
        vault_id: 0x2::object::ID,
        clmm_config_id: 0x2::object::ID,
        usdc_sui_pool_id: 0x2::object::ID,
        cetus_sui_pool_id: 0x2::object::ID,
        sequence: u64,
        generation: u64,
        policy_version: u64,
        deadline_ms: u64,
        fee_usdc_input: u64,
        reward_usdc_input: u64,
        fee_sui_input: u64,
        reward_sui_input: u64,
        cetus_input: u64,
        min_usdc_sui_output: u64,
        min_cetus_sui_output: u64,
        min_total_sui: u64,
    }

    struct MakerVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        schema_version: u64,
        owner: address,
        agent: address,
        funding: address,
        agent_cap_id: 0x2::object::ID,
        agent_generation: u64,
        pool_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        versioned_id: 0x2::object::ID,
        expected_protocol_version: u64,
        expected_bin_step: u16,
        policy: 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::Policy,
        action_sequence: u64,
        funding_sequence: u64,
        last_capital_funding_sequence: u64,
        last_action_ms: u64,
        paused: bool,
        position_generation: u64,
        below_position: 0x1::option::Option<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>,
        above_position: 0x1::option::Option<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>,
        principal_idle_a: 0x2::balance::Balance<T0>,
        principal_idle_b: 0x2::balance::Balance<T1>,
        current_deployed_a: u64,
        current_deployed_b: u64,
        accounting: Accounting,
        income: IncomeState<T0, T1>,
        reward_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        rewards: 0x2::bag::Bag,
        cumulative_rewards: 0x2::bag::Bag,
        owner_collection: OwnerCollection,
    }

    struct DualPlanCommitment has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        generation: u64,
        below_source_id: 0x2::object::ID,
        above_source_id: 0x2::object::ID,
        sequence: u64,
        policy_version: u64,
        deadline_ms: u64,
        planned_active_bits: u32,
        collect_fee: bool,
        below_remove_percent_bps: u16,
        above_remove_percent_bps: u16,
        reward_list_hash: vector<u8>,
        swap_direction: u8,
        min_swap_output: u64,
        max_swap_output: u64,
        max_swap_input: u64,
        below_bin_ids: vector<u32>,
        below_amounts_a: vector<u64>,
        below_amounts_b: vector<u64>,
        above_bin_ids: vector<u32>,
        above_amounts_a: vector<u64>,
        above_amounts_b: vector<u64>,
    }

    struct ExitCommitment has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        generation: u64,
        below_source_id: 0x2::object::ID,
        above_source_id: 0x2::object::ID,
        sequence: u64,
        policy_version: u64,
        deadline_ms: u64,
        planned_active_bits: u32,
        collect_fee: bool,
        below_remove_percent_bps: u16,
        above_remove_percent_bps: u16,
        reward_list_hash: vector<u8>,
        swap_direction: u8,
        min_swap_output: u64,
        max_swap_output: u64,
        max_swap_input: u64,
    }

    struct ActionTicket<phantom T0, phantom T1> {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        generation: u64,
        sequence: u64,
        policy_version: u64,
        below_position_id: 0x2::object::ID,
        above_position_id: 0x2::object::ID,
        planned_active_bits: u32,
        observed_active_bits: u32,
        deadline_ms: u64,
        intent_hash: vector<u8>,
        swap_direction: u8,
        min_swap_output: u64,
        max_swap_output: u64,
        max_swap_input: u64,
        below_fee_a: u64,
        below_fee_b: u64,
        above_fee_a: u64,
        above_fee_b: u64,
        below_fee_collected: bool,
        above_fee_collected: bool,
        below_reward_a_collected: bool,
        above_reward_a_collected: bool,
        below_reward_b_collected: bool,
        above_reward_b_collected: bool,
        below_reward_types: vector<0x1::type_name::TypeName>,
        below_reward_amounts: vector<u64>,
        above_reward_types: vector<0x1::type_name::TypeName>,
        above_reward_amounts: vector<u64>,
    }

    struct CapitalCommitment has copy, drop, store {
        action_kind: u8,
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        generation: u64,
        sequence: u64,
        policy_version: u64,
        funding_sequence: u64,
        had_pair: bool,
        below_source_id: 0x2::object::ID,
        above_source_id: 0x2::object::ID,
        deadline_ms: u64,
        planned_active_bits: u32,
        reward_list_hash: vector<u8>,
        swap_direction: u8,
        min_swap_output: u64,
        max_swap_output: u64,
        max_swap_input: u64,
        below_bin_ids: vector<u32>,
        below_amounts_a: vector<u64>,
        below_amounts_b: vector<u64>,
        above_bin_ids: vector<u32>,
        above_amounts_a: vector<u64>,
        above_amounts_b: vector<u64>,
    }

    struct CapitalTicket<phantom T0, phantom T1> {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        generation: u64,
        sequence: u64,
        policy_version: u64,
        funding_sequence: u64,
        had_pair: bool,
        below_position_id: 0x2::object::ID,
        above_position_id: 0x2::object::ID,
        planned_active_bits: u32,
        observed_active_bits: u32,
        deadline_ms: u64,
        intent_hash: vector<u8>,
        swap_direction: u8,
        min_swap_output: u64,
        max_swap_output: u64,
        max_swap_input: u64,
        below_fee_collected: bool,
        above_fee_collected: bool,
        below_reward_a_collected: bool,
        above_reward_a_collected: bool,
        below_reward_b_collected: bool,
        above_reward_b_collected: bool,
        below_reward_types: vector<0x1::type_name::TypeName>,
        below_reward_amounts: vector<u64>,
        above_reward_types: vector<0x1::type_name::TypeName>,
        above_reward_amounts: vector<u64>,
    }

    struct CloseSummary has copy, drop {
        below_id: 0x2::object::ID,
        below_lower_bits: u32,
        below_upper_bits: u32,
        below_principal_a: u64,
        below_principal_b: u64,
        below_closing_fee_a: u64,
        below_closing_fee_b: u64,
        above_id: 0x2::object::ID,
        above_lower_bits: u32,
        above_upper_bits: u32,
        above_principal_a: u64,
        above_principal_b: u64,
        above_closing_fee_a: u64,
        above_closing_fee_b: u64,
    }

    struct OpenSummary has copy, drop {
        below_id: 0x2::object::ID,
        above_id: 0x2::object::ID,
        deployed_a: u64,
        deployed_b: u64,
    }

    struct SwapSummary has copy, drop {
        direction: u8,
        min_output: u64,
        max_output: u64,
        max_input: u64,
        actual_output: u64,
        actual_input: u64,
        pre_active_bits: u32,
        post_active_bits: u32,
    }

    fun add_distributed_foreign_reward<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x1::type_name::TypeName, arg2: u64) : u128 {
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, u128>(&arg0.income.cumulative_distributed_rewards, arg1)) {
            let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, u128>(&mut arg0.income.cumulative_distributed_rewards, arg1);
            *v0 = *v0 + (arg2 as u128);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, u128>(&mut arg0.income.cumulative_distributed_rewards, arg1, (arg2 as u128));
        };
        *0x2::bag::borrow<0x1::type_name::TypeName, u128>(&arg0.income.cumulative_distributed_rewards, arg1)
    }

    public fun agent<T0, T1>(arg0: &MakerVault<T0, T1>) : address {
        arg0.agent
    }

    fun apply_income_policy<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<IncomeSwapPolicy>(&arg0.income.income_swap_policy)) {
            return
        };
        if (!local_pending_income<T0, T1>(arg0)) {
            return
        };
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::assert_income_action(&arg0.policy, arg1, arg0.income.last_income_action_ms);
        let v0 = 0x2::balance::value<T0>(&arg0.income.pending_fee_a);
        let v1 = 0x2::balance::value<T1>(&arg0.income.pending_fee_b);
        let v2 = 0x2::balance::value<T0>(&arg0.income.pending_reward_a);
        let v3 = 0x2::balance::value<T1>(&arg0.income.pending_reward_b);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        let v12 = 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::income_mode(&arg0.policy);
        if (v12 == 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::compound_mode()) {
            v4 = compound_fee_a<T0, T1>(arg0, v0);
            v5 = compound_fee_b<T0, T1>(arg0, v1);
            v6 = compound_reward_a<T0, T1>(arg0, v2);
            v7 = compound_reward_b<T0, T1>(arg0, v3);
        } else if (v12 == 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::harvest_mode()) {
            let (v13, v14) = distribute_local_a<T0, T1>(arg0, v0, v2, arg2);
            v8 = v13;
            v10 = v14;
            let (v15, v16) = distribute_local_b<T0, T1>(arg0, v1, v3, arg2);
            v9 = v15;
            v11 = v16;
        } else {
            let v17 = marked_equity_b(&arg0.policy, 0x2::balance::value<T0>(&arg0.principal_idle_a) + arg0.current_deployed_a, 0x2::balance::value<T1>(&arg0.principal_idle_b) + arg0.current_deployed_b);
            let v18 = (0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::target_equity_b(&arg0.policy) as u128);
            let v19 = if (v18 > v17) {
                v18 - v17
            } else {
                0
            };
            let v20 = 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::max_compound_b_per_action(&arg0.policy);
            let v21 = compound_fee_b<T0, T1>(arg0, min_u64(v1, u128_to_u64_cap(v19, v20)));
            v5 = v21;
            let v22 = v19 - (v21 as u128);
            let v23 = compound_reward_b<T0, T1>(arg0, min_u64(v3, u128_to_u64_cap(v22, v20 - v21)));
            v7 = v23;
            let v24 = v22 - (v23 as u128);
            let v25 = 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::max_compound_a_per_action(&arg0.policy);
            let v26 = min_u64(v0, min_u64(max_a_not_exceeding_b(&arg0.policy, v24), v25));
            let v27 = compound_fee_a<T0, T1>(arg0, v26);
            v4 = v27;
            let v28 = marked_a_value_b(&arg0.policy, v27);
            let v29 = if (v24 > v28) {
                v24 - v28
            } else {
                0
            };
            let v30 = v25 - v27;
            let v31 = min_u64(v2, min_u64(max_a_not_exceeding_b(&arg0.policy, v29), v30));
            let v32 = compound_reward_a<T0, T1>(arg0, v31);
            v6 = v32;
            let v33 = marked_a_value_b(&arg0.policy, v32);
            let v34 = if (v29 > v33) {
                v29 - v33
            } else {
                0
            };
            let v35 = 0x2::balance::value<T0>(&arg0.income.pending_fee_a);
            let v36 = 0x2::balance::value<T0>(&arg0.income.pending_reward_a);
            let v37 = 0x2::balance::value<T1>(&arg0.income.pending_fee_b);
            let v38 = 0x2::balance::value<T1>(&arg0.income.pending_reward_b);
            if (target_ready_for_distribution(&arg0.policy, v34, sum_as_u128(v35, v36), sum_as_u128(v37, v38), v30 - v32)) {
                let (v39, v40) = distribute_local_a<T0, T1>(arg0, v35, v36, arg2);
                v8 = v39;
                v10 = v40;
                let (v41, v42) = distribute_local_b<T0, T1>(arg0, v37, v38, arg2);
                v9 = v41;
                v11 = v42;
            };
        };
        assert!(v0 == 0x2::balance::value<T0>(&arg0.income.pending_fee_a) + v4 + v8, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::amount_sum());
        assert!(v1 == 0x2::balance::value<T1>(&arg0.income.pending_fee_b) + v5 + v9, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::amount_sum());
        assert!(v2 == 0x2::balance::value<T0>(&arg0.income.pending_reward_a) + v6 + v10, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::amount_sum());
        assert!(v3 == 0x2::balance::value<T1>(&arg0.income.pending_reward_b) + v7 + v11, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::amount_sum());
        if (v4 + v5 + v6 + v7 + v8 + v9 + v10 + v11 > 0) {
            arg0.income.last_income_action_ms = arg1;
            0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_income_policy_applied(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.income.profit_recipient, v12, arg0.action_sequence, arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy), v4, v5, v6, v7, v8, v9, v10, v11, 0x2::balance::value<T0>(&arg0.principal_idle_a), 0x2::balance::value<T1>(&arg0.principal_idle_b), 0x2::balance::value<T0>(&arg0.income.pending_fee_a), 0x2::balance::value<T1>(&arg0.income.pending_fee_b), 0x2::balance::value<T0>(&arg0.income.pending_reward_a), 0x2::balance::value<T1>(&arg0.income.pending_reward_b), arg0.accounting.cumulative_fee_compounded_a, arg0.accounting.cumulative_fee_compounded_b, arg0.accounting.cumulative_fee_distributed_a, arg0.accounting.cumulative_fee_distributed_b, arg0.accounting.cumulative_reward_compounded_a, arg0.accounting.cumulative_reward_compounded_b, arg0.accounting.cumulative_reward_distributed_a, arg0.accounting.cumulative_reward_distributed_b);
        };
    }

    public(friend) fun assert_active_unchanged(arg0: u32, arg1: u32) {
        assert!(arg0 == arg1, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::active_bin_crossed());
    }

    fun assert_agent<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &AgentCap<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        validate_authority_fields(0x2::tx_context::sender(arg2), arg0.agent, arg1.agent, 0x2::object::id<AgentCap<T0, T1>>(arg1), arg0.agent_cap_id, arg1.vault_id, 0x2::object::id<MakerVault<T0, T1>>(arg0), arg1.pool_id, arg0.pool_id, arg1.generation, arg0.agent_generation);
    }

    fun assert_bindings<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        validate_binding_ids(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1), arg0.pool_id, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig>(arg2), arg0.config_id, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned>(arg3), arg0.versioned_id);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg3);
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::version(arg3) == arg0.expected_protocol_version, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_version());
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_step<T0, T1>(arg1) == arg0.expected_bin_step, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_bin_step());
    }

    fun assert_capital_ticket<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &CapitalTicket<T0, T1>) {
        assert!(arg1.vault_id == 0x2::object::id<MakerVault<T0, T1>>(arg0) && arg1.cap_id == arg0.agent_cap_id, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_cap());
        assert!(arg1.generation == arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_generation());
        assert!(arg1.sequence == arg0.action_sequence, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_sequence());
        assert!(arg1.policy_version == 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_policy_version());
        assert!(arg1.funding_sequence == arg0.funding_sequence, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::stale_funding_sequence());
        assert_pair_state<T0, T1>(arg0);
        assert!(arg1.had_pair == has_pair<T0, T1>(arg0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
    }

    public(friend) fun assert_complete_owner_collection_count_for_flags(arg0: u64, arg1: bool, arg2: bool, arg3: bool, arg4: bool, arg5: u64, arg6: u64) {
        assert!(arg1 == arg3 && arg2 == arg4, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
        assert!(arg6 == arg0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
        assert!(arg5 == enabled_reward_count_for_flags(arg0, arg1, arg2), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
    }

    public(friend) fun assert_complete_reward_count_for_flags(arg0: u64, arg1: bool, arg2: bool, arg3: u64) {
        assert!(arg3 == enabled_reward_count_for_flags(arg0, arg1, arg2), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
    }

    fun assert_current_owner_collection<T0, T1>(arg0: &MakerVault<T0, T1>) {
        let v0 = &arg0.owner_collection;
        assert!(0x1::option::is_some<0x2::object::ID>(&v0.owner_collection_below_position_id) && 0x1::option::is_some<0x2::object::ID>(&v0.owner_collection_above_position_id), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        assert_owner_collection_binding(*0x1::option::borrow<0x2::object::ID>(&v0.owner_collection_below_position_id), *0x1::option::borrow<0x2::object::ID>(&v0.owner_collection_above_position_id), v0.owner_collection_position_generation, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.below_position)), 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.above_position)), arg0.position_generation);
    }

    public(friend) fun assert_distinct_position_ids(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        assert!(arg0 != arg1, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::duplicate_position());
    }

    fun assert_foreign_reward_type<T0, T1>(arg0: &0x1::type_name::TypeName) {
        assert!(*arg0 != 0x1::type_name::with_defining_ids<T0>() && *arg0 != 0x1::type_name::with_defining_ids<T1>(), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::reward_not_allowed());
    }

    fun assert_funding<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert_funding_sender(0x2::tx_context::sender(arg1), arg0.funding);
    }

    public(friend) fun assert_funding_sender(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::not_funding());
    }

    fun assert_idle_after<T0, T1>(arg0: &0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::Policy, arg1: &0x2::balance::Balance<T0>, arg2: &0x2::balance::Balance<T1>, arg3: u64, arg4: u64) {
        let v0 = 0x2::balance::value<T0>(arg1);
        let v1 = 0x2::balance::value<T1>(arg2);
        assert!(arg3 <= v0 && arg4 <= v1, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::amount_limit());
        assert!(v0 - arg3 >= 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::min_idle_a(arg0) && v1 - arg4 >= 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::min_idle_b(arg0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::idle_floor());
    }

    public(friend) fun assert_income_outputs(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = if (arg0 == 0) {
            if (arg6 == 0) {
                arg3 == 0
            } else {
                false
            }
        } else {
            false
        };
        let v1 = if (v0) {
            true
        } else if (arg0 > 0) {
            if (arg6 > 0) {
                arg3 >= arg6
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::income_output_floor());
        let v2 = if (arg1 == 0) {
            if (arg7 == 0) {
                arg4 == 0
            } else {
                false
            }
        } else {
            false
        };
        let v3 = if (v2) {
            true
        } else if (arg1 > 0) {
            if (arg7 > 0) {
                arg4 >= arg7
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::income_output_floor());
        let v4 = if (arg5 == arg2 + arg3 + arg4) {
            if (arg8 > 0) {
                arg5 >= arg8
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::income_output_floor());
    }

    public(friend) fun assert_income_route_fields(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::type_name::TypeName, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x1::type_name::TypeName, arg8: u64, arg9: u64) {
        let v0 = if (arg0 == arg4) {
            if (arg1 == arg5) {
                if (arg2 == arg6) {
                    if (arg1 != arg2) {
                        arg3 == arg7
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::wrong_income_route());
        assert!(arg8 == arg9, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_policy_version());
    }

    public(friend) fun assert_income_source_bounds(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = if (arg4 <= arg0) {
            if (arg5 <= arg1) {
                if (arg6 <= arg2) {
                    arg7 <= arg3
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::income_source());
    }

    public(friend) fun assert_new_funding_sequence(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg2 == arg0 && arg2 > arg1, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::stale_funding_sequence());
    }

    fun assert_no_swap_inventory<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: u64, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u32) : SwapSummary {
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::assert_swap_input(&arg0.policy, arg3, arg6);
        let (_, _) = validate_swap_deficits(0x2::balance::value<T0>(&arg0.principal_idle_a), 0x2::balance::value<T1>(&arg0.principal_idle_b), arg1 + 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::min_idle_a(&arg0.policy), arg2 + 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::min_idle_b(&arg0.policy), arg3, arg4, arg5, arg6);
        SwapSummary{
            direction        : 0,
            min_output       : 0,
            max_output       : 0,
            max_input        : 0,
            actual_output    : 0,
            actual_input     : 0,
            pre_active_bits  : arg7,
            post_active_bits : arg7,
        }
    }

    fun assert_owner<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::not_owner());
    }

    public(friend) fun assert_owner_collection_binding(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64) {
        let v0 = if (arg0 == arg3) {
            if (arg1 == arg4) {
                arg2 == arg5
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
    }

    fun assert_owner_collection_clear<T0, T1>(arg0: &MakerVault<T0, T1>) {
        let v0 = &arg0.owner_collection;
        let v1 = if (!v0.owner_fee_collected) {
            if (0x1::option::is_none<0x2::object::ID>(&v0.owner_collection_below_position_id)) {
                if (0x1::option::is_none<0x2::object::ID>(&v0.owner_collection_above_position_id)) {
                    if (0x2::vec_set::is_empty<0x1::type_name::TypeName>(&v0.owner_collected_reward_types)) {
                        if (!v0.owner_reward_a_collected) {
                            if (!v0.owner_reward_b_collected) {
                                if (0x1::vector::is_empty<0x1::type_name::TypeName>(&v0.owner_reward_order)) {
                                    if (0x1::vector::is_empty<u64>(&v0.owner_below_reward_amounts)) {
                                        0x1::vector::is_empty<u64>(&v0.owner_above_reward_amounts)
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::duplicate_action());
    }

    fun assert_owner_collection_complete<T0, T1>(arg0: &MakerVault<T0, T1>) {
        let v0 = &arg0.owner_collection;
        assert!(v0.owner_fee_collected, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::duplicate_action());
        assert!(v0.owner_reward_a_collected == arg0.income.reward_a_enabled, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
        assert!(v0.owner_reward_b_collected == arg0.income.reward_b_enabled, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
        assert!(0x2::vec_set::length<0x1::type_name::TypeName>(&v0.owner_collected_reward_types) == 0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.reward_types), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&v0.owner_reward_order) == enabled_reward_count<T0, T1>(arg0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&v0.owner_reward_order) == 0x1::vector::length<u64>(&v0.owner_below_reward_amounts), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&v0.owner_reward_order) == 0x1::vector::length<u64>(&v0.owner_above_reward_amounts), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
    }

    public(friend) fun assert_pair_flags(arg0: bool, arg1: bool) {
        assert!(arg0 == arg1, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::missing_pair());
    }

    fun assert_pair_state<T0, T1>(arg0: &MakerVault<T0, T1>) {
        assert_pair_flags(0x1::option::is_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.below_position), 0x1::option::is_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.above_position));
        if (0x1::option::is_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.below_position)) {
            assert_distinct_position_ids(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.below_position)), 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.above_position)));
        };
    }

    fun assert_pending_income_empty<T0, T1>(arg0: &MakerVault<T0, T1>) {
        let v0 = if (0x2::balance::value<T0>(&arg0.income.pending_fee_a) == 0) {
            if (0x2::balance::value<T1>(&arg0.income.pending_fee_b) == 0) {
                if (0x2::balance::value<T0>(&arg0.income.pending_reward_a) == 0) {
                    if (0x2::balance::value<T1>(&arg0.income.pending_reward_b) == 0) {
                        0x2::bag::is_empty(&arg0.rewards)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::reward_balance_not_empty());
    }

    fun assert_position_range(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg1: &vector<u32>) {
        let v0 = 0x1::vector::length<u32>(arg1);
        assert!(v0 > 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::vector_length());
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::lower_bin_id(arg0)) == *0x1::vector::borrow<u32>(arg1, 0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::upper_bin_id(arg0)) == *0x1::vector::borrow<u32>(arg1, v0 - 1), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
    }

    fun assert_reward_registered<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &0x1::type_name::TypeName) {
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_types, arg1), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::reward_not_allowed());
    }

    fun assert_ticket<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &ActionTicket<T0, T1>) {
        assert!(arg1.vault_id == 0x2::object::id<MakerVault<T0, T1>>(arg0) && arg1.cap_id == arg0.agent_cap_id, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_cap());
        assert!(arg1.generation == arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_generation());
        assert!(arg1.sequence == arg0.action_sequence, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_sequence());
        assert!(arg1.policy_version == 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_policy_version());
        assert_pair_state<T0, T1>(arg0);
    }

    public(friend) fun assert_unique_reward_types(arg0: &vector<0x1::type_name::TypeName>) {
        let v0 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(arg0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(arg0, v1);
            assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&v0, &v2), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::duplicate_reward());
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, v2);
            v1 = v1 + 1;
        };
    }

    fun assert_valid_sqrt_price(arg0: u128) {
        assert!(arg0 >= 4295048017 && arg0 <= 79226673515401279992447579055, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::wrong_income_route());
    }

    fun assert_valid_swap_seal(arg0: u8, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = if (arg0 == 0) {
            if (arg1 == 0) {
                if (arg2 == 0) {
                    arg3 == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_swap_intent());
    }

    public fun begin_capital_action<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &AgentCap<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: 0x2::object::ID, arg11: 0x2::object::ID, arg12: u32, arg13: u64, arg14: vector<u8>, arg15: u8, arg16: u64, arg17: u64, arg18: u64, arg19: &0x2::tx_context::TxContext) : CapitalTicket<T0, T1> {
        assert_agent<T0, T1>(arg0, arg1, arg19);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        assert_pair_state<T0, T1>(arg0);
        assert!(arg0.schema_version == 6, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_schema());
        assert!(0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy) == arg6, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_policy_version());
        assert!(arg0.action_sequence == arg7, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_sequence());
        assert_new_funding_sequence(arg0.funding_sequence, arg0.last_capital_funding_sequence, arg8);
        assert!(0x1::vector::length<u8>(&arg14) == 32, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
        let v0 = has_pair<T0, T1>(arg0);
        assert!(v0 == arg9, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        let v1 = 0x2::object::id_from_address(@0x0);
        let (v2, v3) = if (v0) {
            (0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.below_position)), 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.above_position)))
        } else {
            (v1, v1)
        };
        assert!(v2 == arg10 && v3 == arg11, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        if (v0) {
            assert_distinct_position_ids(v2, v3);
        };
        let v4 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg13 >= v4 && arg13 - v4 <= 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::max_plan_ttl_ms(&arg0.policy), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::deadline());
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::assert_action(&arg0.policy, v4, arg0.last_action_ms, arg0.paused);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg2));
        assert!(signed_distance(v5, arg12) <= (0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::max_active_drift(&arg0.policy) as u64), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::active_drift());
        assert_valid_swap_seal(arg15, arg16, arg17, arg18);
        CapitalTicket<T0, T1>{
            vault_id                 : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            cap_id                   : 0x2::object::id<AgentCap<T0, T1>>(arg1),
            generation               : arg0.agent_generation,
            sequence                 : arg0.action_sequence,
            policy_version           : arg6,
            funding_sequence         : arg8,
            had_pair                 : v0,
            below_position_id        : v2,
            above_position_id        : v3,
            planned_active_bits      : arg12,
            observed_active_bits     : v5,
            deadline_ms              : arg13,
            intent_hash              : arg14,
            swap_direction           : arg15,
            min_swap_output          : arg16,
            max_swap_output          : arg17,
            max_swap_input           : arg18,
            below_fee_collected      : !v0,
            above_fee_collected      : !v0,
            below_reward_a_collected : !v0,
            above_reward_a_collected : !v0,
            below_reward_b_collected : !v0,
            above_reward_b_collected : !v0,
            below_reward_types       : 0x1::vector::empty<0x1::type_name::TypeName>(),
            below_reward_amounts     : vector[],
            above_reward_types       : 0x1::vector::empty<0x1::type_name::TypeName>(),
            above_reward_amounts     : vector[],
        }
    }

    public fun begin_dual_action<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &AgentCap<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: 0x2::object::ID, arg9: 0x2::object::ID, arg10: u32, arg11: u64, arg12: vector<u8>, arg13: u8, arg14: u64, arg15: u64, arg16: u64, arg17: &0x2::tx_context::TxContext) : ActionTicket<T0, T1> {
        assert_agent<T0, T1>(arg0, arg1, arg17);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        assert_pair_state<T0, T1>(arg0);
        assert!(arg0.schema_version == 6, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_schema());
        assert!(0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy) == arg6, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_policy_version());
        assert!(arg0.action_sequence == arg7, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_sequence());
        assert!(0x1::vector::length<u8>(&arg12) == 32, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
        assert!(has_pair<T0, T1>(arg0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::missing_pair());
        let v0 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.below_position));
        let v1 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.above_position));
        assert_distinct_position_ids(v0, v1);
        assert!(v0 == arg8 && v1 == arg9, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        let v2 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg11 >= v2 && arg11 - v2 <= 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::max_plan_ttl_ms(&arg0.policy), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::deadline());
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::assert_action(&arg0.policy, v2, arg0.last_action_ms, arg0.paused);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg2));
        assert!(signed_distance(v3, arg10) <= (0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::max_active_drift(&arg0.policy) as u64), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::active_drift());
        assert_valid_swap_seal(arg13, arg14, arg15, arg16);
        ActionTicket<T0, T1>{
            vault_id                 : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            cap_id                   : 0x2::object::id<AgentCap<T0, T1>>(arg1),
            generation               : arg0.agent_generation,
            sequence                 : arg0.action_sequence,
            policy_version           : arg6,
            below_position_id        : v0,
            above_position_id        : v1,
            planned_active_bits      : arg10,
            observed_active_bits     : v3,
            deadline_ms              : arg11,
            intent_hash              : arg12,
            swap_direction           : arg13,
            min_swap_output          : arg14,
            max_swap_output          : arg15,
            max_swap_input           : arg16,
            below_fee_a              : 0,
            below_fee_b              : 0,
            above_fee_a              : 0,
            above_fee_b              : 0,
            below_fee_collected      : false,
            above_fee_collected      : false,
            below_reward_a_collected : false,
            above_reward_a_collected : false,
            below_reward_b_collected : false,
            above_reward_b_collected : false,
            below_reward_types       : 0x1::vector::empty<0x1::type_name::TypeName>(),
            below_reward_amounts     : vector[],
            above_reward_types       : 0x1::vector::empty<0x1::type_name::TypeName>(),
            above_reward_amounts     : vector[],
        }
    }

    public fun capital_plan_hash(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: 0x2::object::ID, arg9: 0x2::object::ID, arg10: u64, arg11: u32, arg12: vector<u8>, arg13: u8, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u32>, arg18: vector<u64>, arg19: vector<u64>, arg20: vector<u32>, arg21: vector<u64>, arg22: vector<u64>) : vector<u8> {
        let v0 = CapitalCommitment{
            action_kind         : 1,
            vault_id            : arg0,
            pool_id             : arg1,
            cap_id              : arg2,
            generation          : arg3,
            sequence            : arg4,
            policy_version      : arg5,
            funding_sequence    : arg6,
            had_pair            : arg7,
            below_source_id     : arg8,
            above_source_id     : arg9,
            deadline_ms         : arg10,
            planned_active_bits : arg11,
            reward_list_hash    : arg12,
            swap_direction      : arg13,
            min_swap_output     : arg14,
            max_swap_output     : arg15,
            max_swap_input      : arg16,
            below_bin_ids       : arg17,
            below_amounts_a     : arg18,
            below_amounts_b     : arg19,
            above_bin_ids       : arg20,
            above_amounts_a     : arg21,
            above_amounts_b     : arg22,
        };
        let v1 = 0x2::bcs::to_bytes<CapitalCommitment>(&v0);
        0x2::hash::blake2b256(&v1)
    }

    fun close_both_to_idle<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : CloseSummary {
        assert_pair_state<T0, T1>(arg0);
        assert!(has_pair<T0, T1>(arg0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::missing_pair());
        let v0 = 0x1::option::extract<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position);
        let v1 = 0x1::option::extract<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position);
        let v2 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v0);
        let v3 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v1);
        assert_distinct_position_ids(v2, v3);
        let (v4, v5, v6, v7, v8) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::close_position_with_fee<T0, T1>(arg1, v0, arg2, arg3, arg4, arg5);
        let v9 = v8;
        let v10 = v7;
        let v11 = v6;
        let v12 = v5;
        let (v13, v14, v15, v16, v17) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::close_position_with_fee<T0, T1>(arg1, v1, arg2, arg3, arg4, arg5);
        let v18 = v17;
        let v19 = v16;
        let v20 = v15;
        let v21 = v14;
        let v22 = 0x2::balance::value<T0>(&v12);
        let v23 = 0x2::balance::value<T1>(&v11);
        let v24 = 0x2::balance::value<T0>(&v10);
        let v25 = 0x2::balance::value<T1>(&v9);
        let v26 = 0x2::balance::value<T0>(&v21);
        let v27 = 0x2::balance::value<T1>(&v20);
        let v28 = 0x2::balance::value<T0>(&v19);
        let v29 = 0x2::balance::value<T1>(&v18);
        0x2::balance::join<T0>(&mut arg0.principal_idle_a, v12);
        0x2::balance::join<T1>(&mut arg0.principal_idle_b, v11);
        0x2::balance::join<T0>(&mut arg0.income.pending_fee_a, v10);
        0x2::balance::join<T1>(&mut arg0.income.pending_fee_b, v9);
        0x2::balance::join<T0>(&mut arg0.principal_idle_a, v21);
        0x2::balance::join<T1>(&mut arg0.principal_idle_b, v20);
        0x2::balance::join<T0>(&mut arg0.income.pending_fee_a, v19);
        0x2::balance::join<T1>(&mut arg0.income.pending_fee_b, v18);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::destroy_close_position_cert(v4, arg3);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::destroy_close_position_cert(v13, arg3);
        arg0.current_deployed_a = 0;
        arg0.current_deployed_b = 0;
        arg0.accounting.cumulative_principal_a = arg0.accounting.cumulative_principal_a + ((v22 + v26) as u128);
        arg0.accounting.cumulative_principal_b = arg0.accounting.cumulative_principal_b + ((v23 + v27) as u128);
        arg0.accounting.cumulative_closing_fee_a = arg0.accounting.cumulative_closing_fee_a + ((v24 + v28) as u128);
        arg0.accounting.cumulative_closing_fee_b = arg0.accounting.cumulative_closing_fee_b + ((v25 + v29) as u128);
        CloseSummary{
            below_id            : v2,
            below_lower_bits    : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::lower_bin_id(&v0)),
            below_upper_bits    : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::upper_bin_id(&v0)),
            below_principal_a   : v22,
            below_principal_b   : v23,
            below_closing_fee_a : v24,
            below_closing_fee_b : v25,
            above_id            : v3,
            above_lower_bits    : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::lower_bin_id(&v1)),
            above_upper_bits    : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::upper_bin_id(&v1)),
            above_principal_a   : v26,
            above_principal_b   : v27,
            above_closing_fee_a : v28,
            above_closing_fee_b : v29,
        }
    }

    public fun collect_above_fee_in_action<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut ActionTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        assert!(0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::allow_harvest(&arg0.policy), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        assert!(!arg1.above_fee_collected, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::duplicate_action());
        let v0 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v0) == arg1.above_position_id, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.above_position_id, arg4, arg5);
        let (v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg2, v0, arg3, arg4, arg6);
        let v3 = v2;
        let v4 = v1;
        arg1.above_fee_a = 0x2::balance::value<T0>(&v4);
        arg1.above_fee_b = 0x2::balance::value<T1>(&v3);
        arg1.above_fee_collected = true;
        record_fee<T0, T1>(arg0, v4, v3);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_fee_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 1, arg1.above_position_id, arg1.sequence, arg1.above_fee_a, arg1.above_fee_b, arg0.accounting.cumulative_fee_a, arg0.accounting.cumulative_fee_b, arg1.generation, arg1.policy_version);
    }

    public fun collect_above_fee_in_capital_action<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut CapitalTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_capital_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        let v0 = if (arg1.had_pair) {
            if (!arg1.above_fee_collected) {
                0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::allow_harvest(&arg0.policy)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        let v1 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v1) == arg1.above_position_id, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.above_position_id, arg4, arg5);
        let (v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg2, v1, arg3, arg4, arg6);
        let v4 = v3;
        let v5 = v2;
        record_fee<T0, T1>(arg0, v5, v4);
        arg1.above_fee_collected = true;
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_fee_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 1, arg1.above_position_id, arg1.sequence, 0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4), arg0.accounting.cumulative_fee_a, arg0.accounting.cumulative_fee_b, arg1.generation, arg1.policy_version);
    }

    public fun collect_above_reward_a_in_action<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut ActionTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        let v0 = if (arg0.income.reward_a_enabled) {
            if (arg1.above_fee_collected) {
                !arg1.above_reward_a_collected
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v2) == arg1.above_position_id, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.above_position_id, arg4, arg5);
        let v3 = record_same_asset_reward_a<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T0>(arg2, v2, arg3, arg4, arg6));
        arg1.above_reward_a_collected = true;
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.above_reward_types, v1);
        0x1::vector::push_back<u64>(&mut arg1.above_reward_amounts, v3);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 1, arg1.above_position_id, arg1.sequence, v1, v3, arg0.accounting.cumulative_same_asset_reward_a, arg1.generation, arg1.policy_version);
    }

    public fun collect_above_reward_a_in_capital_action<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut CapitalTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_capital_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        let v0 = if (arg1.had_pair) {
            if (arg0.income.reward_a_enabled) {
                if (arg1.above_fee_collected) {
                    !arg1.above_reward_a_collected
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v2) == arg1.above_position_id, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.above_position_id, arg4, arg5);
        let v3 = record_same_asset_reward_a<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T0>(arg2, v2, arg3, arg4, arg6));
        arg1.above_reward_a_collected = true;
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.above_reward_types, v1);
        0x1::vector::push_back<u64>(&mut arg1.above_reward_amounts, v3);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 1, arg1.above_position_id, arg1.sequence, v1, v3, arg0.accounting.cumulative_same_asset_reward_a, arg1.generation, arg1.policy_version);
    }

    public fun collect_above_reward_b_in_action<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut ActionTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        let v0 = if (arg0.income.reward_b_enabled) {
            if (arg1.above_fee_collected) {
                !arg1.above_reward_b_collected
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v2) == arg1.above_position_id, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.above_position_id, arg4, arg5);
        let v3 = record_same_asset_reward_b<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T1>(arg2, v2, arg3, arg4, arg6));
        arg1.above_reward_b_collected = true;
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.above_reward_types, v1);
        0x1::vector::push_back<u64>(&mut arg1.above_reward_amounts, v3);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 1, arg1.above_position_id, arg1.sequence, v1, v3, arg0.accounting.cumulative_same_asset_reward_b, arg1.generation, arg1.policy_version);
    }

    public fun collect_above_reward_b_in_capital_action<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut CapitalTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_capital_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        let v0 = if (arg1.had_pair) {
            if (arg0.income.reward_b_enabled) {
                if (arg1.above_fee_collected) {
                    !arg1.above_reward_b_collected
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v2) == arg1.above_position_id, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.above_position_id, arg4, arg5);
        let v3 = record_same_asset_reward_b<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T1>(arg2, v2, arg3, arg4, arg6));
        arg1.above_reward_b_collected = true;
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.above_reward_types, v1);
        0x1::vector::push_back<u64>(&mut arg1.above_reward_amounts, v3);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 1, arg1.above_position_id, arg1.sequence, v1, v3, arg0.accounting.cumulative_same_asset_reward_b, arg1.generation, arg1.policy_version);
    }

    public fun collect_above_reward_in_action<T0, T1, T2>(arg0: &mut MakerVault<T0, T1>, arg1: &mut ActionTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        assert!(0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::allow_harvest(&arg0.policy) && arg1.above_fee_collected, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert_reward_registered<T0, T1>(arg0, &v0);
        assert_foreign_reward_type<T0, T1>(&v0);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg1.above_reward_types) < (0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::max_reward_types(&arg0.policy) as u64), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::too_many_rewards());
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.above_reward_types, &v0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::duplicate_reward());
        let v1 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v1) == arg1.above_position_id, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.above_position_id, arg4, arg5);
        let v2 = put_reward<T0, T1, T2>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg2, v1, arg3, arg4, arg6));
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.above_reward_types, v0);
        0x1::vector::push_back<u64>(&mut arg1.above_reward_amounts, v2);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 1, arg1.above_position_id, arg1.sequence, v0, v2, cumulative_reward<T0, T1>(arg0, v0), arg1.generation, arg1.policy_version);
    }

    public fun collect_above_reward_in_capital_action<T0, T1, T2>(arg0: &mut MakerVault<T0, T1>, arg1: &mut CapitalTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_capital_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        assert!(arg1.had_pair && arg1.above_fee_collected, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert_reward_registered<T0, T1>(arg0, &v0);
        assert_foreign_reward_type<T0, T1>(&v0);
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.above_reward_types, &v0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::duplicate_reward());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.above_position_id, arg4, arg5);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg2, 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position), arg3, arg4, arg6);
        let v2 = put_reward<T0, T1, T2>(arg0, v1);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.above_reward_types, v0);
        0x1::vector::push_back<u64>(&mut arg1.above_reward_amounts, v2);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 1, arg1.above_position_id, arg1.sequence, v0, v2, cumulative_reward<T0, T1>(arg0, v0), arg1.generation, arg1.policy_version);
    }

    public fun collect_below_fee_in_action<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut ActionTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        assert!(0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::allow_harvest(&arg0.policy), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        assert!(!arg1.below_fee_collected, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::duplicate_action());
        let v0 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v0) == arg1.below_position_id, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.below_position_id, arg4, arg5);
        let (v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg2, v0, arg3, arg4, arg6);
        let v3 = v2;
        let v4 = v1;
        arg1.below_fee_a = 0x2::balance::value<T0>(&v4);
        arg1.below_fee_b = 0x2::balance::value<T1>(&v3);
        arg1.below_fee_collected = true;
        record_fee<T0, T1>(arg0, v4, v3);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_fee_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 0, arg1.below_position_id, arg1.sequence, arg1.below_fee_a, arg1.below_fee_b, arg0.accounting.cumulative_fee_a, arg0.accounting.cumulative_fee_b, arg1.generation, arg1.policy_version);
    }

    public fun collect_below_fee_in_capital_action<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut CapitalTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_capital_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        let v0 = if (arg1.had_pair) {
            if (!arg1.below_fee_collected) {
                0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::allow_harvest(&arg0.policy)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        let v1 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v1) == arg1.below_position_id, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.below_position_id, arg4, arg5);
        let (v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg2, v1, arg3, arg4, arg6);
        let v4 = v3;
        let v5 = v2;
        record_fee<T0, T1>(arg0, v5, v4);
        arg1.below_fee_collected = true;
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_fee_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 0, arg1.below_position_id, arg1.sequence, 0x2::balance::value<T0>(&v5), 0x2::balance::value<T1>(&v4), arg0.accounting.cumulative_fee_a, arg0.accounting.cumulative_fee_b, arg1.generation, arg1.policy_version);
    }

    public fun collect_below_reward_a_in_action<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut ActionTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        let v0 = if (arg0.income.reward_a_enabled) {
            if (arg1.below_fee_collected) {
                !arg1.below_reward_a_collected
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v2) == arg1.below_position_id, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.below_position_id, arg4, arg5);
        let v3 = record_same_asset_reward_a<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T0>(arg2, v2, arg3, arg4, arg6));
        arg1.below_reward_a_collected = true;
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.below_reward_types, v1);
        0x1::vector::push_back<u64>(&mut arg1.below_reward_amounts, v3);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 0, arg1.below_position_id, arg1.sequence, v1, v3, arg0.accounting.cumulative_same_asset_reward_a, arg1.generation, arg1.policy_version);
    }

    public fun collect_below_reward_a_in_capital_action<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut CapitalTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_capital_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        let v0 = if (arg1.had_pair) {
            if (arg0.income.reward_a_enabled) {
                if (arg1.below_fee_collected) {
                    !arg1.below_reward_a_collected
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v2) == arg1.below_position_id, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.below_position_id, arg4, arg5);
        let v3 = record_same_asset_reward_a<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T0>(arg2, v2, arg3, arg4, arg6));
        arg1.below_reward_a_collected = true;
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.below_reward_types, v1);
        0x1::vector::push_back<u64>(&mut arg1.below_reward_amounts, v3);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 0, arg1.below_position_id, arg1.sequence, v1, v3, arg0.accounting.cumulative_same_asset_reward_a, arg1.generation, arg1.policy_version);
    }

    public fun collect_below_reward_b_in_action<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut ActionTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        let v0 = if (arg0.income.reward_b_enabled) {
            if (arg1.below_fee_collected) {
                !arg1.below_reward_b_collected
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v2) == arg1.below_position_id, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.below_position_id, arg4, arg5);
        let v3 = record_same_asset_reward_b<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T1>(arg2, v2, arg3, arg4, arg6));
        arg1.below_reward_b_collected = true;
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.below_reward_types, v1);
        0x1::vector::push_back<u64>(&mut arg1.below_reward_amounts, v3);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 0, arg1.below_position_id, arg1.sequence, v1, v3, arg0.accounting.cumulative_same_asset_reward_b, arg1.generation, arg1.policy_version);
    }

    public fun collect_below_reward_b_in_capital_action<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut CapitalTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_capital_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        let v0 = if (arg1.had_pair) {
            if (arg0.income.reward_b_enabled) {
                if (arg1.below_fee_collected) {
                    !arg1.below_reward_b_collected
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        let v2 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v2) == arg1.below_position_id, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.below_position_id, arg4, arg5);
        let v3 = record_same_asset_reward_b<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T1>(arg2, v2, arg3, arg4, arg6));
        arg1.below_reward_b_collected = true;
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.below_reward_types, v1);
        0x1::vector::push_back<u64>(&mut arg1.below_reward_amounts, v3);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 0, arg1.below_position_id, arg1.sequence, v1, v3, arg0.accounting.cumulative_same_asset_reward_b, arg1.generation, arg1.policy_version);
    }

    public fun collect_below_reward_in_action<T0, T1, T2>(arg0: &mut MakerVault<T0, T1>, arg1: &mut ActionTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        assert!(0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::allow_harvest(&arg0.policy) && arg1.below_fee_collected, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert_reward_registered<T0, T1>(arg0, &v0);
        assert_foreign_reward_type<T0, T1>(&v0);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg1.below_reward_types) < (0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::max_reward_types(&arg0.policy) as u64), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::too_many_rewards());
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.below_reward_types, &v0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::duplicate_reward());
        let v1 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v1) == arg1.below_position_id, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.below_position_id, arg4, arg5);
        let v2 = put_reward<T0, T1, T2>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg2, v1, arg3, arg4, arg6));
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.below_reward_types, v0);
        0x1::vector::push_back<u64>(&mut arg1.below_reward_amounts, v2);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 0, arg1.below_position_id, arg1.sequence, v0, v2, cumulative_reward<T0, T1>(arg0, v0), arg1.generation, arg1.policy_version);
    }

    public fun collect_below_reward_in_capital_action<T0, T1, T2>(arg0: &mut MakerVault<T0, T1>, arg1: &mut CapitalTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_capital_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        assert!(arg1.had_pair && arg1.below_fee_collected, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert_reward_registered<T0, T1>(arg0, &v0);
        assert_foreign_reward_type<T0, T1>(&v0);
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.below_reward_types, &v0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::duplicate_reward());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.below_position_id, arg4, arg5);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg2, 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position), arg3, arg4, arg6);
        let v2 = put_reward<T0, T1, T2>(arg0, v1);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.below_reward_types, v0);
        0x1::vector::push_back<u64>(&mut arg1.below_reward_amounts, v2);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 0, arg1.below_position_id, arg1.sequence, v0, v2, cumulative_reward<T0, T1>(arg0, v0), arg1.generation, arg1.policy_version);
    }

    fun compound_fee_a<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: u64) : u64 {
        if (arg1 > 0) {
            0x2::balance::join<T0>(&mut arg0.principal_idle_a, 0x2::balance::split<T0>(&mut arg0.income.pending_fee_a, arg1));
            arg0.accounting.cumulative_fee_compounded_a = arg0.accounting.cumulative_fee_compounded_a + (arg1 as u128);
        };
        arg1
    }

    fun compound_fee_b<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: u64) : u64 {
        if (arg1 > 0) {
            0x2::balance::join<T1>(&mut arg0.principal_idle_b, 0x2::balance::split<T1>(&mut arg0.income.pending_fee_b, arg1));
            arg0.accounting.cumulative_fee_compounded_b = arg0.accounting.cumulative_fee_compounded_b + (arg1 as u128);
        };
        arg1
    }

    fun compound_reward_a<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: u64) : u64 {
        if (arg1 > 0) {
            0x2::balance::join<T0>(&mut arg0.principal_idle_a, 0x2::balance::split<T0>(&mut arg0.income.pending_reward_a, arg1));
            arg0.accounting.cumulative_reward_compounded_a = arg0.accounting.cumulative_reward_compounded_a + (arg1 as u128);
        };
        arg1
    }

    fun compound_reward_b<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: u64) : u64 {
        if (arg1 > 0) {
            0x2::balance::join<T1>(&mut arg0.principal_idle_b, 0x2::balance::split<T1>(&mut arg0.income.pending_reward_b, arg1));
            arg0.accounting.cumulative_reward_compounded_b = arg0.accounting.cumulative_reward_compounded_b + (arg1 as u128);
        };
        arg1
    }

    public fun create_vault<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: address, arg5: address, arg6: address, arg7: u64, arg8: u16, arg9: 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::Policy, arg10: &mut 0x2::tx_context::TxContext) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg2);
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::version(arg2) == arg7, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_version());
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_step<T0, T1>(arg0) == arg8, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_bin_step());
        let v0 = 0x2::tx_context::sender(arg10);
        validate_role_addresses(v0, arg4, arg5, arg6);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::assert_creation(&arg9, 0x2::clock::timestamp_ms(arg3));
        let v1 = 0x2::object::new(arg10);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::object::new(arg10);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg0);
        let v6 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig>(arg1);
        let v7 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned>(arg2);
        let v8 = AgentCap<T0, T1>{
            id         : v3,
            vault_id   : v2,
            pool_id    : v5,
            agent      : arg4,
            generation : 1,
        };
        let v9 = Accounting{
            cumulative_funded_a             : 0,
            cumulative_funded_b             : 0,
            cumulative_deployed_a           : 0,
            cumulative_deployed_b           : 0,
            cumulative_principal_a          : 0,
            cumulative_principal_b          : 0,
            cumulative_fee_a                : 0,
            cumulative_fee_b                : 0,
            cumulative_closing_fee_a        : 0,
            cumulative_closing_fee_b        : 0,
            cumulative_same_asset_reward_a  : 0,
            cumulative_same_asset_reward_b  : 0,
            cumulative_fee_compounded_a     : 0,
            cumulative_fee_compounded_b     : 0,
            cumulative_fee_distributed_a    : 0,
            cumulative_fee_distributed_b    : 0,
            cumulative_reward_compounded_a  : 0,
            cumulative_reward_compounded_b  : 0,
            cumulative_reward_distributed_a : 0,
            cumulative_reward_distributed_b : 0,
            cumulative_swap_input_a         : 0,
            cumulative_swap_input_b         : 0,
            cumulative_swap_output_a        : 0,
            cumulative_swap_output_b        : 0,
        };
        let v10 = IncomeState<T0, T1>{
            profit_recipient               : arg6,
            last_income_action_ms          : 0,
            pending_fee_a                  : 0x2::balance::zero<T0>(),
            pending_fee_b                  : 0x2::balance::zero<T1>(),
            pending_reward_a               : 0x2::balance::zero<T0>(),
            pending_reward_b               : 0x2::balance::zero<T1>(),
            reward_a_enabled               : false,
            reward_b_enabled               : false,
            income_swap_policy             : 0x1::option::none<IncomeSwapPolicy>(),
            cumulative_distributed_rewards : 0x2::bag::new(arg10),
        };
        let v11 = OwnerCollection{
            owner_fee_collected                  : false,
            owner_collection_position_generation : 0,
            owner_collection_below_position_id   : 0x1::option::none<0x2::object::ID>(),
            owner_collection_above_position_id   : 0x1::option::none<0x2::object::ID>(),
            owner_below_fee_a                    : 0,
            owner_below_fee_b                    : 0,
            owner_above_fee_a                    : 0,
            owner_above_fee_b                    : 0,
            owner_collected_reward_types         : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            owner_reward_a_collected             : false,
            owner_reward_b_collected             : false,
            owner_reward_order                   : 0x1::vector::empty<0x1::type_name::TypeName>(),
            owner_below_reward_amounts           : vector[],
            owner_above_reward_amounts           : vector[],
        };
        let v12 = MakerVault<T0, T1>{
            id                            : v1,
            schema_version                : 6,
            owner                         : v0,
            agent                         : arg4,
            funding                       : arg5,
            agent_cap_id                  : v4,
            agent_generation              : 1,
            pool_id                       : v5,
            config_id                     : v6,
            versioned_id                  : v7,
            expected_protocol_version     : arg7,
            expected_bin_step             : arg8,
            policy                        : arg9,
            action_sequence               : 0,
            funding_sequence              : 0,
            last_capital_funding_sequence : 0,
            last_action_ms                : 0,
            paused                        : false,
            position_generation           : 0,
            below_position                : 0x1::option::none<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(),
            above_position                : 0x1::option::none<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(),
            principal_idle_a              : 0x2::balance::zero<T0>(),
            principal_idle_b              : 0x2::balance::zero<T1>(),
            current_deployed_a            : 0,
            current_deployed_b            : 0,
            accounting                    : v9,
            income                        : v10,
            reward_types                  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            rewards                       : 0x2::bag::new(arg10),
            cumulative_rewards            : 0x2::bag::new(arg10),
            owner_collection              : v11,
        };
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_vault_created(v2, v5, v6, v7, v0, arg4, arg5, arg6, v4, arg7, arg8, 0, 1, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg9));
        0x2::transfer::share_object<MakerVault<T0, T1>>(v12);
        0x2::transfer::transfer<AgentCap<T0, T1>>(v8, arg4);
    }

    fun cumulative_reward<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: 0x1::type_name::TypeName) : u128 {
        assert!(0x2::bag::contains_with_type<0x1::type_name::TypeName, u128>(&arg0.cumulative_rewards, arg1), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::reward_not_allowed());
        *0x2::bag::borrow<0x1::type_name::TypeName, u128>(&arg0.cumulative_rewards, arg1)
    }

    fun distribute_local_a<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        if (sum_as_u128(arg1, arg2) >= (0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::min_harvest_a(&arg0.policy) as u128) && sum_as_u128(arg1, arg2) > 0) {
            let v2 = 0x2::balance::zero<T0>();
            if (arg1 > 0) {
                0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(&mut arg0.income.pending_fee_a, arg1));
                arg0.accounting.cumulative_fee_distributed_a = arg0.accounting.cumulative_fee_distributed_a + (arg1 as u128);
            };
            if (arg2 > 0) {
                0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(&mut arg0.income.pending_reward_a, arg2));
                arg0.accounting.cumulative_reward_distributed_a = arg0.accounting.cumulative_reward_distributed_a + (arg2 as u128);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg3), arg0.income.profit_recipient);
            (arg1, arg2)
        } else {
            (0, 0)
        }
    }

    fun distribute_local_b<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        if (sum_as_u128(arg1, arg2) >= (0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::min_harvest_b(&arg0.policy) as u128) && sum_as_u128(arg1, arg2) > 0) {
            let v2 = 0x2::balance::zero<T1>();
            if (arg1 > 0) {
                0x2::balance::join<T1>(&mut v2, 0x2::balance::split<T1>(&mut arg0.income.pending_fee_b, arg1));
                arg0.accounting.cumulative_fee_distributed_b = arg0.accounting.cumulative_fee_distributed_b + (arg1 as u128);
            };
            if (arg2 > 0) {
                0x2::balance::join<T1>(&mut v2, 0x2::balance::split<T1>(&mut arg0.income.pending_reward_b, arg2));
                arg0.accounting.cumulative_reward_distributed_b = arg0.accounting.cumulative_reward_distributed_b + (arg2 as u128);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg3), arg0.income.profit_recipient);
            (arg1, arg2)
        } else {
            (0, 0)
        }
    }

    public fun dual_exit_hash(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u32, arg10: bool, arg11: u16, arg12: u16, arg13: vector<u8>, arg14: u8, arg15: u64, arg16: u64, arg17: u64) : vector<u8> {
        let v0 = ExitCommitment{
            vault_id                 : arg0,
            pool_id                  : arg1,
            cap_id                   : arg2,
            generation               : arg3,
            below_source_id          : arg4,
            above_source_id          : arg5,
            sequence                 : arg6,
            policy_version           : arg7,
            deadline_ms              : arg8,
            planned_active_bits      : arg9,
            collect_fee              : arg10,
            below_remove_percent_bps : arg11,
            above_remove_percent_bps : arg12,
            reward_list_hash         : arg13,
            swap_direction           : arg14,
            min_swap_output          : arg15,
            max_swap_output          : arg16,
            max_swap_input           : arg17,
        };
        let v1 = 0x2::bcs::to_bytes<ExitCommitment>(&v0);
        0x2::hash::blake2b256(&v1)
    }

    public fun dual_plan_hash(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u32, arg10: bool, arg11: u16, arg12: u16, arg13: vector<u8>, arg14: u8, arg15: u64, arg16: u64, arg17: u64, arg18: vector<u32>, arg19: vector<u64>, arg20: vector<u64>, arg21: vector<u32>, arg22: vector<u64>, arg23: vector<u64>) : vector<u8> {
        let v0 = DualPlanCommitment{
            vault_id                 : arg0,
            pool_id                  : arg1,
            cap_id                   : arg2,
            generation               : arg3,
            below_source_id          : arg4,
            above_source_id          : arg5,
            sequence                 : arg6,
            policy_version           : arg7,
            deadline_ms              : arg8,
            planned_active_bits      : arg9,
            collect_fee              : arg10,
            below_remove_percent_bps : arg11,
            above_remove_percent_bps : arg12,
            reward_list_hash         : arg13,
            swap_direction           : arg14,
            min_swap_output          : arg15,
            max_swap_output          : arg16,
            max_swap_input           : arg17,
            below_bin_ids            : arg18,
            below_amounts_a          : arg19,
            below_amounts_b          : arg20,
            above_bin_ids            : arg21,
            above_amounts_a          : arg22,
            above_amounts_b          : arg23,
        };
        let v1 = 0x2::bcs::to_bytes<DualPlanCommitment>(&v0);
        0x2::hash::blake2b256(&v1)
    }

    fun enabled_reward_count<T0, T1>(arg0: &MakerVault<T0, T1>) : u64 {
        enabled_reward_count_for_flags(0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.reward_types), arg0.income.reward_a_enabled, arg0.income.reward_b_enabled)
    }

    public(friend) fun enabled_reward_count_for_flags(arg0: u64, arg1: bool, arg2: bool) : u64 {
        let v0 = if (arg1) {
            1
        } else {
            0
        };
        let v1 = if (arg2) {
            1
        } else {
            0
        };
        arg0 + v0 + v1
    }

    public fun finish_capital_action<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &AgentCap<T0, T1>, arg2: CapitalTicket<T0, T1>, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: vector<u32>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u32>, arg11: vector<u64>, arg12: vector<u64>, arg13: &mut 0x2::tx_context::TxContext) {
        assert_agent<T0, T1>(arg0, arg1, arg13);
        assert_capital_ticket<T0, T1>(arg0, &arg2);
        assert_bindings<T0, T1>(arg0, arg3, arg4, arg5);
        assert!(0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::allow_rollover(&arg0.policy), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        assert_new_funding_sequence(arg0.funding_sequence, arg0.last_capital_funding_sequence, arg2.funding_sequence);
        assert!(arg2.below_fee_collected && arg2.above_fee_collected, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::duplicate_action());
        assert!(arg2.below_reward_types == arg2.above_reward_types, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
        let v0 = if (arg2.had_pair) {
            enabled_reward_count<T0, T1>(arg0)
        } else {
            0
        };
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2.below_reward_types) == v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
        assert!(arg2.intent_hash == capital_plan_hash(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, arg2.cap_id, arg2.generation, arg2.sequence, arg2.policy_version, arg2.funding_sequence, arg2.had_pair, arg2.below_position_id, arg2.above_position_id, arg2.deadline_ms, arg2.planned_active_bits, reward_list_hash(&arg2.below_reward_types), arg2.swap_direction, arg2.min_swap_output, arg2.max_swap_output, arg2.max_swap_input, arg7, arg8, arg9, arg10, arg11, arg12), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(v1 <= arg2.deadline_ms, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::deadline());
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg3));
        let (v3, v4) = validate_dual_at(&arg0.policy, &arg7, &arg8, &arg9, &arg10, &arg11, &arg12, arg2.planned_active_bits, v2);
        if (arg2.had_pair) {
            let v5 = close_both_to_idle<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg13);
            assert!(v5.below_id == arg2.below_position_id && v5.above_id == arg2.above_position_id, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        } else {
            assert!(!has_pair<T0, T1>(arg0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::pair_exists());
        };
        apply_income_policy<T0, T1>(arg0, v1, arg13);
        let v6 = assert_no_swap_inventory<T0, T1>(arg0, v3, v4, arg2.swap_direction, arg2.min_swap_output, arg2.max_swap_output, arg2.max_swap_input, v2);
        let v7 = open_both_from_idle<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg2.planned_active_bits, arg13);
        arg0.action_sequence = arg0.action_sequence + 1;
        arg0.last_capital_funding_sequence = arg2.funding_sequence;
        arg0.last_action_ms = v1;
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::consume_action(&mut arg0.policy);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_capital_action_settled(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, arg2.had_pair, arg2.below_position_id, arg2.above_position_id, v7.below_id, v7.above_id, arg2.funding_sequence, arg2.sequence, arg2.generation, arg2.policy_version, arg2.planned_active_bits, arg2.observed_active_bits, v1, v7.deployed_a, v7.deployed_b, 0x2::balance::value<T0>(&arg0.principal_idle_a), 0x2::balance::value<T1>(&arg0.principal_idle_b), v6.direction, v6.actual_output, v6.actual_input);
        let CapitalTicket {
            vault_id                 : _,
            cap_id                   : _,
            generation               : _,
            sequence                 : _,
            policy_version           : _,
            funding_sequence         : _,
            had_pair                 : _,
            below_position_id        : _,
            above_position_id        : _,
            planned_active_bits      : _,
            observed_active_bits     : _,
            deadline_ms              : _,
            intent_hash              : _,
            swap_direction           : _,
            min_swap_output          : _,
            max_swap_output          : _,
            max_swap_input           : _,
            below_fee_collected      : _,
            above_fee_collected      : _,
            below_reward_a_collected : _,
            above_reward_a_collected : _,
            below_reward_b_collected : _,
            above_reward_b_collected : _,
            below_reward_types       : _,
            below_reward_amounts     : _,
            above_reward_types       : _,
            above_reward_amounts     : _,
        } = arg2;
    }

    public fun finish_dual_exit<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &AgentCap<T0, T1>, arg2: ActionTicket<T0, T1>, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: bool, arg8: u16, arg9: u16, arg10: &mut 0x2::tx_context::TxContext) {
        assert_agent<T0, T1>(arg0, arg1, arg10);
        assert_ticket<T0, T1>(arg0, &arg2);
        assert_bindings<T0, T1>(arg0, arg3, arg4, arg5);
        assert!(0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::allow_exit_to_idle(&arg0.policy), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::exit_disabled());
        let v0 = if (arg7) {
            if (arg8 == 10000) {
                arg9 == 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_percent());
        assert!(arg2.below_fee_collected && arg2.above_fee_collected, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::duplicate_action());
        assert!(arg2.below_reward_types == arg2.above_reward_types, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2.below_reward_types) == enabled_reward_count<T0, T1>(arg0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
        let v1 = if (arg2.swap_direction == 0) {
            if (arg2.min_swap_output == 0) {
                if (arg2.max_swap_output == 0) {
                    arg2.max_swap_input == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_swap_intent());
        assert!(arg2.intent_hash == dual_exit_hash(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, arg2.cap_id, arg2.generation, arg2.below_position_id, arg2.above_position_id, arg2.sequence, arg2.policy_version, arg2.deadline_ms, arg2.planned_active_bits, arg7, arg8, arg9, reward_list_hash(&arg2.below_reward_types), arg2.swap_direction, arg2.min_swap_output, arg2.max_swap_output, arg2.max_swap_input), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
        let v2 = 0x2::clock::timestamp_ms(arg6);
        assert!(v2 <= arg2.deadline_ms, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::deadline());
        assert!(signed_distance(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg3)), arg2.planned_active_bits) <= (0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::max_active_drift(&arg0.policy) as u64), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::active_drift());
        let v3 = close_both_to_idle<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg10);
        assert!(v3.below_id == arg2.below_position_id && v3.above_id == arg2.above_position_id, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        apply_income_policy<T0, T1>(arg0, v2, arg10);
        reset_owner_collection<T0, T1>(arg0);
        arg0.action_sequence = arg0.action_sequence + 1;
        arg0.last_action_ms = v2;
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::consume_action(&mut arg0.policy);
        let ActionTicket {
            vault_id                 : _,
            cap_id                   : _,
            generation               : v6,
            sequence                 : v7,
            policy_version           : v8,
            below_position_id        : _,
            above_position_id        : _,
            planned_active_bits      : v11,
            observed_active_bits     : v12,
            deadline_ms              : _,
            intent_hash              : _,
            swap_direction           : _,
            min_swap_output          : _,
            max_swap_output          : _,
            max_swap_input           : _,
            below_fee_a              : v19,
            below_fee_b              : v20,
            above_fee_a              : v21,
            above_fee_b              : v22,
            below_fee_collected      : _,
            above_fee_collected      : _,
            below_reward_a_collected : _,
            above_reward_a_collected : _,
            below_reward_b_collected : _,
            above_reward_b_collected : _,
            below_reward_types       : v29,
            below_reward_amounts     : v30,
            above_reward_types       : v31,
            above_reward_amounts     : v32,
        } = arg2;
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_dual_exit_settled(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, v3.below_id, v3.above_id, v3.below_lower_bits, v3.below_upper_bits, v3.above_lower_bits, v3.above_upper_bits, v3.below_principal_a, v3.below_principal_b, v3.above_principal_a, v3.above_principal_b, v19, v20, v21, v22, v3.below_closing_fee_a, v3.below_closing_fee_b, v3.above_closing_fee_a, v3.above_closing_fee_b, v29, v30, v31, v32, 0x2::balance::value<T0>(&arg0.principal_idle_a), 0x2::balance::value<T1>(&arg0.principal_idle_b), v7, v6, v8, v11, v12, v2, arg0.accounting.cumulative_principal_a, arg0.accounting.cumulative_principal_b, arg0.accounting.cumulative_fee_a, arg0.accounting.cumulative_fee_b, arg0.accounting.cumulative_closing_fee_a, arg0.accounting.cumulative_closing_fee_b);
        assert_pair_state<T0, T1>(arg0);
    }

    public fun finish_dual_rollover<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &AgentCap<T0, T1>, arg2: ActionTicket<T0, T1>, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: bool, arg8: u16, arg9: u16, arg10: vector<u32>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u32>, arg14: vector<u64>, arg15: vector<u64>, arg16: &mut 0x2::tx_context::TxContext) {
        assert_agent<T0, T1>(arg0, arg1, arg16);
        assert_ticket<T0, T1>(arg0, &arg2);
        assert_bindings<T0, T1>(arg0, arg3, arg4, arg5);
        assert!(0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::allow_rollover(&arg0.policy), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_phase());
        let v0 = if (arg7) {
            if (arg8 == 10000) {
                arg9 == 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_percent());
        assert!(arg2.below_fee_collected && arg2.above_fee_collected, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::duplicate_action());
        assert!(arg2.below_reward_types == arg2.above_reward_types, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2.below_reward_types) == enabled_reward_count<T0, T1>(arg0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2.below_reward_types) == 0x1::vector::length<u64>(&arg2.below_reward_amounts) && 0x1::vector::length<0x1::type_name::TypeName>(&arg2.above_reward_types) == 0x1::vector::length<u64>(&arg2.above_reward_amounts), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
        assert!(arg2.intent_hash == dual_plan_hash(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, arg2.cap_id, arg2.generation, arg2.below_position_id, arg2.above_position_id, arg2.sequence, arg2.policy_version, arg2.deadline_ms, arg2.planned_active_bits, arg7, arg8, arg9, reward_list_hash(&arg2.below_reward_types), arg2.swap_direction, arg2.min_swap_output, arg2.max_swap_output, arg2.max_swap_input, arg10, arg11, arg12, arg13, arg14, arg15), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_intent_hash());
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(v1 <= arg2.deadline_ms, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::deadline());
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg3));
        assert!(signed_distance(v2, arg2.planned_active_bits) <= (0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::max_active_drift(&arg0.policy) as u64), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::active_drift());
        let (v3, v4) = validate_dual_at(&arg0.policy, &arg10, &arg11, &arg12, &arg13, &arg14, &arg15, arg2.planned_active_bits, v2);
        let v5 = close_both_to_idle<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg16);
        assert!(v5.below_id == arg2.below_position_id && v5.above_id == arg2.above_position_id, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::position_mismatch());
        apply_income_policy<T0, T1>(arg0, v1, arg16);
        let v6 = assert_no_swap_inventory<T0, T1>(arg0, v3, v4, arg2.swap_direction, arg2.min_swap_output, arg2.max_swap_output, arg2.max_swap_input, v2);
        let v7 = open_both_from_idle<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg10, arg11, arg12, arg13, arg14, arg15, arg2.planned_active_bits, arg16);
        arg0.action_sequence = arg0.action_sequence + 1;
        arg0.last_action_ms = v1;
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::consume_action(&mut arg0.policy);
        let ActionTicket {
            vault_id                 : _,
            cap_id                   : _,
            generation               : v10,
            sequence                 : v11,
            policy_version           : v12,
            below_position_id        : _,
            above_position_id        : _,
            planned_active_bits      : v15,
            observed_active_bits     : v16,
            deadline_ms              : _,
            intent_hash              : _,
            swap_direction           : _,
            min_swap_output          : _,
            max_swap_output          : _,
            max_swap_input           : _,
            below_fee_a              : v23,
            below_fee_b              : v24,
            above_fee_a              : v25,
            above_fee_b              : v26,
            below_fee_collected      : _,
            above_fee_collected      : _,
            below_reward_a_collected : _,
            above_reward_a_collected : _,
            below_reward_b_collected : _,
            above_reward_b_collected : _,
            below_reward_types       : v33,
            below_reward_amounts     : v34,
            above_reward_types       : v35,
            above_reward_amounts     : v36,
        } = arg2;
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_dual_rollover_settled(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, v5.below_id, v7.below_id, v5.above_id, v7.above_id, v5.below_lower_bits, v5.below_upper_bits, v5.above_lower_bits, v5.above_upper_bits, arg10, arg11, arg12, arg13, arg14, arg15, v7.deployed_b, v7.deployed_a, v5.below_principal_a, v5.below_principal_b, v5.above_principal_a, v5.above_principal_b, v23, v24, v25, v26, v5.below_closing_fee_a, v5.below_closing_fee_b, v5.above_closing_fee_a, v5.above_closing_fee_b, v33, v34, v35, v36, 0x2::balance::value<T0>(&arg0.principal_idle_a), 0x2::balance::value<T1>(&arg0.principal_idle_b), v11, v10, v12, v15, v16, v1, v6.direction, v6.min_output, v6.max_output, v6.max_input, v6.actual_output, v6.actual_input, v6.pre_active_bits, v6.post_active_bits, arg0.accounting.cumulative_deployed_a, arg0.accounting.cumulative_deployed_b, arg0.accounting.cumulative_principal_a, arg0.accounting.cumulative_principal_b, arg0.accounting.cumulative_fee_a, arg0.accounting.cumulative_fee_b, arg0.accounting.cumulative_closing_fee_a, arg0.accounting.cumulative_closing_fee_b, arg0.accounting.cumulative_swap_input_a, arg0.accounting.cumulative_swap_input_b, arg0.accounting.cumulative_swap_output_a, arg0.accounting.cumulative_swap_output_b);
    }

    public fun funding<T0, T1>(arg0: &MakerVault<T0, T1>) : address {
        arg0.funding
    }

    public fun funding_deposit_a<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert_funding<T0, T1>(arg0, arg2);
        assert_pair_state<T0, T1>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::zero_amount());
        0x2::balance::join<T0>(&mut arg0.principal_idle_a, 0x2::coin::into_balance<T0>(arg1));
        arg0.funding_sequence = arg0.funding_sequence + 1;
        arg0.accounting.cumulative_funded_a = arg0.accounting.cumulative_funded_a + (v0 as u128);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_funding_deposit(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.funding, 0, v0, 0x2::balance::value<T0>(&arg0.principal_idle_a), 0x2::balance::value<T1>(&arg0.principal_idle_b), arg0.funding_sequence, arg0.action_sequence, arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy), arg0.accounting.cumulative_funded_a, arg0.accounting.cumulative_funded_b);
    }

    public fun funding_deposit_b<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::tx_context::TxContext) {
        assert_funding<T0, T1>(arg0, arg2);
        assert_pair_state<T0, T1>(arg0);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::zero_amount());
        0x2::balance::join<T1>(&mut arg0.principal_idle_b, 0x2::coin::into_balance<T1>(arg1));
        arg0.funding_sequence = arg0.funding_sequence + 1;
        arg0.accounting.cumulative_funded_b = arg0.accounting.cumulative_funded_b + (v0 as u128);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_funding_deposit(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.funding, 1, v0, 0x2::balance::value<T0>(&arg0.principal_idle_a), 0x2::balance::value<T1>(&arg0.principal_idle_b), arg0.funding_sequence, arg0.action_sequence, arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy), arg0.accounting.cumulative_funded_a, arg0.accounting.cumulative_funded_b);
    }

    public fun funding_sequence<T0, T1>(arg0: &MakerVault<T0, T1>) : u64 {
        arg0.funding_sequence
    }

    public fun generation<T0, T1>(arg0: &MakerVault<T0, T1>) : u64 {
        arg0.agent_generation
    }

    public fun has_both_positions<T0, T1>(arg0: &MakerVault<T0, T1>) : bool {
        has_pair<T0, T1>(arg0)
    }

    fun has_pair<T0, T1>(arg0: &MakerVault<T0, T1>) : bool {
        0x1::option::is_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.below_position) && 0x1::option::is_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.above_position)
    }

    public fun idle_balances<T0, T1>(arg0: &MakerVault<T0, T1>) : (u64, u64) {
        principal_idle_balances<T0, T1>(arg0)
    }

    public fun income_swap_seal_hash(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64) : vector<u8> {
        let v0 = IncomeSwapSeal{
            vault_id             : arg0,
            clmm_config_id       : arg1,
            usdc_sui_pool_id     : arg2,
            cetus_sui_pool_id    : arg3,
            sequence             : arg4,
            generation           : arg5,
            policy_version       : arg6,
            deadline_ms          : arg7,
            fee_usdc_input       : arg8,
            reward_usdc_input    : arg9,
            fee_sui_input        : arg10,
            reward_sui_input     : arg11,
            cetus_input          : arg12,
            min_usdc_sui_output  : arg13,
            min_cetus_sui_output : arg14,
            min_total_sui        : arg15,
        };
        let v1 = 0x2::bcs::to_bytes<IncomeSwapSeal>(&v0);
        0x2::hash::blake2b256(&v1)
    }

    fun local_pending_income<T0, T1>(arg0: &MakerVault<T0, T1>) : bool {
        if (0x2::balance::value<T0>(&arg0.income.pending_fee_a) > 0) {
            true
        } else if (0x2::balance::value<T1>(&arg0.income.pending_fee_b) > 0) {
            true
        } else if (0x2::balance::value<T0>(&arg0.income.pending_reward_a) > 0) {
            true
        } else {
            0x2::balance::value<T1>(&arg0.income.pending_reward_b) > 0
        }
    }

    fun marked_a_value_b(arg0: &0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::Policy, arg1: u64) : u128 {
        (arg1 as u128) * (0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::mark_a_in_b_num(arg0) as u128) / (0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::mark_a_in_b_den(arg0) as u128)
    }

    fun marked_equity_b(arg0: &0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::Policy, arg1: u64, arg2: u64) : u128 {
        marked_a_value_b(arg0, arg1) + (arg2 as u128)
    }

    fun max_a_not_exceeding_b(arg0: &0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::Policy, arg1: u128) : u64 {
        let v0 = arg1 * (0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::mark_a_in_b_den(arg0) as u128) / (0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::mark_a_in_b_num(arg0) as u128);
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun open_both_from_idle<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: vector<u32>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u32>, arg9: vector<u64>, arg10: vector<u64>, arg11: u32, arg12: &mut 0x2::tx_context::TxContext) : OpenSummary {
        assert!(!has_pair<T0, T1>(arg0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::pair_exists());
        let (v0, v1) = validate_dual<T0, T1>(arg0, arg1, &arg5, &arg6, &arg7, &arg8, &arg9, &arg10, arg11);
        assert_idle_after<T0, T1>(&arg0.policy, &arg0.principal_idle_a, &arg0.principal_idle_b, v0, v1);
        let (v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_position<T0, T1>(arg1, arg5, arg6, arg7, arg2, arg3, arg4, arg12);
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_cert_amounts<T0, T1>(&v4);
        assert!(v6 == 0 && v7 == v1, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::amount_sum());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_open_position<T0, T1>(arg1, &mut v5, v4, 0x2::balance::split<T0>(&mut arg0.principal_idle_a, v6), 0x2::balance::split<T1>(&mut arg0.principal_idle_b, v7), arg3);
        assert_position_range(&v5, &arg5);
        let (v8, v9) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_position<T0, T1>(arg1, arg8, arg9, arg10, arg2, arg3, arg4, arg12);
        let v10 = v9;
        let v11 = v8;
        let (v12, v13) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_cert_amounts<T0, T1>(&v10);
        assert!(v12 == v0 && v13 == 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::amount_sum());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_open_position<T0, T1>(arg1, &mut v11, v10, 0x2::balance::split<T0>(&mut arg0.principal_idle_a, v12), 0x2::balance::split<T1>(&mut arg0.principal_idle_b, v13), arg3);
        assert_position_range(&v11, &arg8);
        let v14 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v5);
        let v15 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v11);
        assert_distinct_position_ids(v14, v15);
        0x1::option::fill<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position, v5);
        0x1::option::fill<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position, v11);
        arg0.position_generation = arg0.position_generation + 1;
        arg0.current_deployed_a = v0;
        arg0.current_deployed_b = v1;
        reset_owner_collection<T0, T1>(arg0);
        arg0.accounting.cumulative_deployed_a = arg0.accounting.cumulative_deployed_a + (v0 as u128);
        arg0.accounting.cumulative_deployed_b = arg0.accounting.cumulative_deployed_b + (v1 as u128);
        OpenSummary{
            below_id   : v14,
            above_id   : v15,
            deployed_a : v0,
            deployed_b : v1,
        }
    }

    public fun owner<T0, T1>(arg0: &MakerVault<T0, T1>) : address {
        arg0.owner
    }

    public fun owner_apply_collected_income<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg2);
        assert_pair_state<T0, T1>(arg0);
        assert!(has_pair<T0, T1>(arg0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::missing_pair());
        assert_current_owner_collection<T0, T1>(arg0);
        assert_owner_collection_complete<T0, T1>(arg0);
        let v0 = *0x1::option::borrow<0x2::object::ID>(&arg0.owner_collection.owner_collection_below_position_id);
        let v1 = *0x1::option::borrow<0x2::object::ID>(&arg0.owner_collection.owner_collection_above_position_id);
        let v2 = arg0.owner_collection.owner_collection_position_generation;
        let v3 = arg0.owner_collection.owner_below_fee_a;
        let v4 = arg0.owner_collection.owner_below_fee_b;
        let v5 = arg0.owner_collection.owner_above_fee_a;
        let v6 = arg0.owner_collection.owner_above_fee_b;
        let v7 = arg0.owner_collection.owner_reward_order;
        let v8 = arg0.owner_collection.owner_below_reward_amounts;
        let v9 = arg0.owner_collection.owner_above_reward_amounts;
        let v10 = arg0.current_deployed_a;
        let v11 = arg0.current_deployed_b;
        let v12 = 0x2::clock::timestamp_ms(arg1);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::assert_action(&arg0.policy, v12, arg0.last_action_ms, arg0.paused);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::assert_income_action(&arg0.policy, v12, arg0.income.last_income_action_ms);
        apply_income_policy<T0, T1>(arg0, v12, arg2);
        assert_owner_collection_binding(v0, v1, v2, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.below_position)), 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.above_position)), arg0.position_generation);
        assert!(arg0.current_deployed_a == v10 && arg0.current_deployed_b == v11, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::amount_sum());
        arg0.action_sequence = arg0.action_sequence + 1;
        arg0.last_action_ms = v12;
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::consume_action(&mut arg0.policy);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_owner_income_collection_applied(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, v0, v1, v2, arg0.action_sequence, arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy), v12, arg0.income.last_income_action_ms, v3, v4, v5, v6, v7, v8, v9, 0x2::balance::value<T0>(&arg0.principal_idle_a), 0x2::balance::value<T1>(&arg0.principal_idle_b), arg0.current_deployed_a, arg0.current_deployed_b, 0x2::balance::value<T0>(&arg0.income.pending_fee_a), 0x2::balance::value<T1>(&arg0.income.pending_fee_b), 0x2::balance::value<T0>(&arg0.income.pending_reward_a), 0x2::balance::value<T1>(&arg0.income.pending_reward_b));
        reset_owner_collection<T0, T1>(arg0);
        assert_pair_state<T0, T1>(arg0);
    }

    public fun owner_apply_income_policy<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg2);
        assert_owner_collection_clear<T0, T1>(arg0);
        apply_income_policy<T0, T1>(arg0, 0x2::clock::timestamp_ms(arg1), arg2);
    }

    public fun owner_close_dual<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg5);
        assert_bindings<T0, T1>(arg0, arg1, arg2, arg3);
        assert_pair_state<T0, T1>(arg0);
        assert!(has_pair<T0, T1>(arg0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::missing_pair());
        assert_current_owner_collection<T0, T1>(arg0);
        assert_owner_collection_complete<T0, T1>(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::assert_action(&arg0.policy, v0, arg0.last_action_ms, arg0.paused);
        let v1 = close_both_to_idle<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        apply_income_policy<T0, T1>(arg0, v0, arg5);
        arg0.action_sequence = arg0.action_sequence + 1;
        arg0.last_action_ms = v0;
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::consume_action(&mut arg0.policy);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_owner_dual_closed(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, v1.below_id, v1.above_id, v1.below_lower_bits, v1.below_upper_bits, v1.above_lower_bits, v1.above_upper_bits, v1.below_principal_a, v1.below_principal_b, v1.above_principal_a, v1.above_principal_b, arg0.owner_collection.owner_below_fee_a, arg0.owner_collection.owner_below_fee_b, arg0.owner_collection.owner_above_fee_a, arg0.owner_collection.owner_above_fee_b, v1.below_closing_fee_a, v1.below_closing_fee_b, v1.above_closing_fee_a, v1.above_closing_fee_b, arg0.owner_collection.owner_reward_order, arg0.owner_collection.owner_below_reward_amounts, arg0.owner_collection.owner_above_reward_amounts, 0x2::balance::value<T0>(&arg0.principal_idle_a), 0x2::balance::value<T1>(&arg0.principal_idle_b), arg0.action_sequence, arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy), arg0.accounting.cumulative_principal_a, arg0.accounting.cumulative_principal_b, arg0.accounting.cumulative_fee_a, arg0.accounting.cumulative_fee_b, arg0.accounting.cumulative_closing_fee_a, arg0.accounting.cumulative_closing_fee_b);
        reset_owner_collection<T0, T1>(arg0);
        assert_pair_state<T0, T1>(arg0);
    }

    public fun owner_collect_dual_fee<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg5);
        assert_bindings<T0, T1>(arg0, arg1, arg2, arg3);
        assert_pair_state<T0, T1>(arg0);
        assert!(has_pair<T0, T1>(arg0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::missing_pair());
        assert_owner_collection_clear<T0, T1>(arg0);
        let v0 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position);
        let v1 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v0);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg1, v1, arg3, arg4);
        let (v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg1, v0, arg2, arg3, arg5);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<T1>(&v4);
        record_fee<T0, T1>(arg0, v5, v4);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_fee_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 0, v1, arg0.action_sequence, v6, v7, arg0.accounting.cumulative_fee_a, arg0.accounting.cumulative_fee_b, arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy));
        let v8 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position);
        let v9 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v8);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg1, v9, arg3, arg4);
        let (v10, v11) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg1, v8, arg2, arg3, arg5);
        let v12 = v11;
        let v13 = v10;
        let v14 = 0x2::balance::value<T0>(&v13);
        let v15 = 0x2::balance::value<T1>(&v12);
        record_fee<T0, T1>(arg0, v13, v12);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_fee_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 1, v9, arg0.action_sequence, v14, v15, arg0.accounting.cumulative_fee_a, arg0.accounting.cumulative_fee_b, arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy));
        arg0.owner_collection.owner_below_fee_a = v6;
        arg0.owner_collection.owner_below_fee_b = v7;
        arg0.owner_collection.owner_above_fee_a = v14;
        arg0.owner_collection.owner_above_fee_b = v15;
        arg0.owner_collection.owner_collection_position_generation = arg0.position_generation;
        arg0.owner_collection.owner_collection_below_position_id = 0x1::option::some<0x2::object::ID>(v1);
        arg0.owner_collection.owner_collection_above_position_id = 0x1::option::some<0x2::object::ID>(v9);
        arg0.owner_collection.owner_fee_collected = true;
    }

    public fun owner_collect_dual_reward<T0, T1, T2>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg5);
        assert_bindings<T0, T1>(arg0, arg1, arg2, arg3);
        assert_pair_state<T0, T1>(arg0);
        assert!(has_pair<T0, T1>(arg0) && arg0.owner_collection.owner_fee_collected, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::missing_pair());
        assert_current_owner_collection<T0, T1>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert_reward_registered<T0, T1>(arg0, &v0);
        assert_foreign_reward_type<T0, T1>(&v0);
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.owner_collection.owner_collected_reward_types, &v0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::duplicate_reward());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.owner_collection.owner_collected_reward_types, v0);
        let v1 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position);
        let v2 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v1);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg1, v2, arg3, arg4);
        let v3 = put_reward<T0, T1, T2>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg1, v1, arg2, arg3, arg5));
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 0, v2, arg0.action_sequence, v0, v3, cumulative_reward<T0, T1>(arg0, v0), arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy));
        let v4 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position);
        let v5 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v4);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg1, v5, arg3, arg4);
        let v6 = put_reward<T0, T1, T2>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg1, v4, arg2, arg3, arg5));
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 1, v5, arg0.action_sequence, v0, v6, cumulative_reward<T0, T1>(arg0, v0), arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy));
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.owner_collection.owner_reward_order, v0);
        0x1::vector::push_back<u64>(&mut arg0.owner_collection.owner_below_reward_amounts, v3);
        0x1::vector::push_back<u64>(&mut arg0.owner_collection.owner_above_reward_amounts, v6);
    }

    public fun owner_collect_dual_reward_a<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg5);
        assert_bindings<T0, T1>(arg0, arg1, arg2, arg3);
        assert_pair_state<T0, T1>(arg0);
        assert!(has_pair<T0, T1>(arg0) && arg0.owner_collection.owner_fee_collected, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::missing_pair());
        assert_current_owner_collection<T0, T1>(arg0);
        assert!(arg0.income.reward_a_enabled && !arg0.owner_collection.owner_reward_a_collected, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::reward_not_allowed());
        arg0.owner_collection.owner_reward_a_collected = true;
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position);
        let v2 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v1);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg1, v2, arg3, arg4);
        let v3 = record_same_asset_reward_a<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T0>(arg1, v1, arg2, arg3, arg5));
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 0, v2, arg0.action_sequence, v0, v3, arg0.accounting.cumulative_same_asset_reward_a, arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy));
        let v4 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position);
        let v5 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v4);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg1, v5, arg3, arg4);
        let v6 = record_same_asset_reward_a<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T0>(arg1, v4, arg2, arg3, arg5));
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 1, v5, arg0.action_sequence, v0, v6, arg0.accounting.cumulative_same_asset_reward_a, arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy));
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.owner_collection.owner_reward_order, v0);
        0x1::vector::push_back<u64>(&mut arg0.owner_collection.owner_below_reward_amounts, v3);
        0x1::vector::push_back<u64>(&mut arg0.owner_collection.owner_above_reward_amounts, v6);
    }

    public fun owner_collect_dual_reward_b<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg5);
        assert_bindings<T0, T1>(arg0, arg1, arg2, arg3);
        assert_pair_state<T0, T1>(arg0);
        assert!(has_pair<T0, T1>(arg0) && arg0.owner_collection.owner_fee_collected, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::missing_pair());
        assert_current_owner_collection<T0, T1>(arg0);
        assert!(arg0.income.reward_b_enabled && !arg0.owner_collection.owner_reward_b_collected, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::reward_not_allowed());
        arg0.owner_collection.owner_reward_b_collected = true;
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position);
        let v2 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v1);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg1, v2, arg3, arg4);
        let v3 = record_same_asset_reward_b<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T1>(arg1, v1, arg2, arg3, arg5));
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 0, v2, arg0.action_sequence, v0, v3, arg0.accounting.cumulative_same_asset_reward_b, arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy));
        let v4 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position);
        let v5 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v4);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg1, v5, arg3, arg4);
        let v6 = record_same_asset_reward_b<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T1>(arg1, v4, arg2, arg3, arg5));
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 1, v5, arg0.action_sequence, v0, v6, arg0.accounting.cumulative_same_asset_reward_b, arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy));
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.owner_collection.owner_reward_order, v0);
        0x1::vector::push_back<u64>(&mut arg0.owner_collection.owner_below_reward_amounts, v3);
        0x1::vector::push_back<u64>(&mut arg0.owner_collection.owner_above_reward_amounts, v6);
    }

    public fun owner_collect_swap_income<T0, T1>(arg0: &mut MakerVault<T0, 0x2::sui::SUI>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u8>, arg18: &mut 0x2::tx_context::TxContext) {
        assert_current_owner_collection<T0, 0x2::sui::SUI>(arg0);
        assert_owner_collection_complete<T0, 0x2::sui::SUI>(arg0);
        swap_pending_income<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
        reset_owner_collection<T0, 0x2::sui::SUI>(arg0);
    }

    public fun owner_configure_income_swap_policy<T0, T1>(arg0: &mut MakerVault<T0, 0x2::sui::SUI>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg4: u64, arg5: u128, arg6: u128, arg7: &0x2::tx_context::TxContext) {
        assert_owner<T0, 0x2::sui::SUI>(arg0, arg7);
        assert!(0x1::option::is_none<IncomeSwapPolicy>(&arg0.income.income_swap_policy), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::income_swap_already_configured());
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert_reward_registered<T0, 0x2::sui::SUI>(arg0, &v0);
        assert_foreign_reward_type<T0, 0x2::sui::SUI>(&v0);
        assert!(arg4 > 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_policy_version());
        assert!(arg4 == 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_policy_version());
        assert_valid_sqrt_price(arg5);
        assert_valid_sqrt_price(arg6);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg2);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>>(arg3);
        assert!(v1 != v2, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::wrong_income_route());
        let v3 = IncomeSwapPolicy{
            version                : arg4,
            clmm_config_id         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1),
            usdc_sui_pool_id       : v1,
            cetus_sui_pool_id      : v2,
            cetus_type             : v0,
            usdc_sqrt_price_limit  : arg5,
            cetus_sqrt_price_limit : arg6,
        };
        arg0.income.income_swap_policy = 0x1::option::some<IncomeSwapPolicy>(v3);
    }

    public fun owner_distribute_foreign_reward<T0, T1, T2>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg1);
        assert!(0x1::option::is_none<IncomeSwapPolicy>(&arg0.income.income_swap_policy), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::income_source());
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert_reward_registered<T0, T1>(arg0, &v0);
        assert_foreign_reward_type<T0, T1>(&v0);
        assert!(0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.rewards, v0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::reward_not_allowed());
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0);
        let v2 = 0x2::balance::value<T2>(&v1);
        let v3 = cumulative_reward<T0, T1>(arg0, v0);
        let v4 = add_distributed_foreign_reward<T0, T1>(arg0, v0, v2);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_foreign_reward_distributed(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.income.profit_recipient, v0, v2, v3, v4, arg0.action_sequence, arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v1, arg1), arg0.income.profit_recipient);
    }

    public fun owner_emergency_recover<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg1);
        assert_pair_state<T0, T1>(arg0);
        assert!(!has_pair<T0, T1>(arg0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::pair_exists());
        assert_pending_income_empty<T0, T1>(arg0);
        arg0.paused = true;
        arg0.agent_generation = arg0.agent_generation + 1;
        arg0.action_sequence = arg0.action_sequence + 1;
        assert!(arg0.current_deployed_a == 0 && arg0.current_deployed_b == 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::amount_sum());
        let v0 = 0x2::balance::value<T0>(&arg0.principal_idle_a);
        let v1 = 0x2::balance::value<T1>(&arg0.principal_idle_b);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.principal_idle_a), arg1), arg0.funding);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.principal_idle_b), arg1), arg0.funding);
        reset_owner_collection<T0, T1>(arg0);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_emergency_recovered(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, arg0.owner, arg0.funding, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::object::ID>(), v0, v1, arg0.action_sequence, arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy));
        assert_pair_state<T0, T1>(arg0);
    }

    public fun owner_open_dual<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: vector<u32>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u32>, arg9: vector<u64>, arg10: vector<u64>, arg11: u32, arg12: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg12);
        assert_bindings<T0, T1>(arg0, arg1, arg2, arg3);
        assert_pair_state<T0, T1>(arg0);
        assert!(!has_pair<T0, T1>(arg0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::pair_exists());
        let v0 = 0x2::clock::timestamp_ms(arg4);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::assert_action(&arg0.policy, v0, arg0.last_action_ms, arg0.paused);
        let v1 = open_both_from_idle<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        arg0.action_sequence = arg0.action_sequence + 1;
        arg0.last_action_ms = v0;
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::consume_action(&mut arg0.policy);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_owner_dual_opened(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, v1.below_id, v1.above_id, arg5, arg6, arg7, arg8, arg9, arg10, v1.deployed_b, v1.deployed_a, 0x2::balance::value<T0>(&arg0.principal_idle_a), 0x2::balance::value<T1>(&arg0.principal_idle_b), arg0.action_sequence, arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy), arg0.accounting.cumulative_deployed_a, arg0.accounting.cumulative_deployed_b);
    }

    public fun owner_pause<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg1);
        arg0.paused = true;
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::set_phase(&mut arg0.policy, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::paused_phase());
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_policy_updated(0x2::object::id<MakerVault<T0, T1>>(arg0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::paused_phase(), true, arg0.action_sequence, arg0.agent_generation);
    }

    public fun owner_register_reward<T0, T1, T2>(arg0: &mut MakerVault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert_foreign_reward_type<T0, T1>(&v0);
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_types, &v0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::duplicate_reward());
        assert!(0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.reward_types) < (0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::max_reward_types(&arg0.policy) as u64), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::too_many_rewards());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.reward_types, v0);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_reward_registered(0x2::object::id<MakerVault<T0, T1>>(arg0), v0, arg0.action_sequence, arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy));
    }

    public fun owner_register_reward_a<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg1);
        assert!(!arg0.income.reward_a_enabled, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::duplicate_reward());
        arg0.income.reward_a_enabled = true;
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_reward_registered(0x2::object::id<MakerVault<T0, T1>>(arg0), 0x1::type_name::with_defining_ids<T0>(), arg0.action_sequence, arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy));
    }

    public fun owner_register_reward_b<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg1);
        assert!(!arg0.income.reward_b_enabled, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::duplicate_reward());
        arg0.income.reward_b_enabled = true;
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_reward_registered(0x2::object::id<MakerVault<T0, T1>>(arg0), 0x1::type_name::with_defining_ids<T1>(), arg0.action_sequence, arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy));
    }

    public fun owner_rotate_agent<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg2);
        let v0 = if (arg1 != arg0.owner) {
            if (arg1 != arg0.funding) {
                if (arg1 != arg0.income.profit_recipient) {
                    arg1 != @0x0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::not_agent());
        arg0.agent_generation = arg0.agent_generation + 1;
        arg0.agent = arg1;
        let v1 = 0x2::object::new(arg2);
        let v2 = 0x2::object::uid_to_inner(&v1);
        arg0.agent_cap_id = v2;
        let v3 = AgentCap<T0, T1>{
            id         : v1,
            vault_id   : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            pool_id    : arg0.pool_id,
            agent      : arg1,
            generation : arg0.agent_generation,
        };
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_agent_rotated(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, arg0.agent, arg1, arg0.agent_generation, v2, arg0.action_sequence, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy));
        0x2::transfer::transfer<AgentCap<T0, T1>>(v3, arg1);
    }

    public fun owner_set_phase<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg2);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::set_phase(&mut arg0.policy, arg1);
        arg0.paused = arg1 == 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::paused_phase();
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_policy_updated(0x2::object::id<MakerVault<T0, T1>>(arg0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy), arg1, arg0.paused, arg0.action_sequence, arg0.agent_generation);
    }

    public fun owner_set_policy<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::Policy, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg2);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::replace(&mut arg0.policy, arg1);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_policy_updated(0x2::object::id<MakerVault<T0, T1>>(arg0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::phase(&arg0.policy), arg0.paused, arg0.action_sequence, arg0.agent_generation);
    }

    public fun owner_swap_pending_income<T0, T1>(arg0: &mut MakerVault<T0, 0x2::sui::SUI>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u8>, arg18: &mut 0x2::tx_context::TxContext) {
        assert_owner_collection_clear<T0, 0x2::sui::SUI>(arg0);
        swap_pending_income<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
    }

    public fun pending_income_balances<T0, T1>(arg0: &MakerVault<T0, T1>) : (u64, u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.income.pending_fee_a), 0x2::balance::value<T1>(&arg0.income.pending_fee_b), 0x2::balance::value<T0>(&arg0.income.pending_reward_a), 0x2::balance::value<T1>(&arg0.income.pending_reward_b))
    }

    public fun policy_version<T0, T1>(arg0: &MakerVault<T0, T1>) : u64 {
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy)
    }

    public fun pool_id<T0, T1>(arg0: &MakerVault<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun principal_idle_balances<T0, T1>(arg0: &MakerVault<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.principal_idle_a), 0x2::balance::value<T1>(&arg0.principal_idle_b))
    }

    public fun profit_recipient<T0, T1>(arg0: &MakerVault<T0, T1>) : address {
        arg0.income.profit_recipient
    }

    fun put_reward<T0, T1, T2>(arg0: &mut MakerVault<T0, T1>, arg1: 0x2::balance::Balance<T2>) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let v1 = 0x2::balance::value<T2>(&arg1);
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.rewards, v0)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0, arg1);
        };
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, u128>(&arg0.cumulative_rewards, v0)) {
            let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, u128>(&mut arg0.cumulative_rewards, v0);
            *v2 = *v2 + (v1 as u128);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, u128>(&mut arg0.cumulative_rewards, v0, (v1 as u128));
        };
        v1
    }

    fun record_fee<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        arg0.accounting.cumulative_fee_a = arg0.accounting.cumulative_fee_a + (0x2::balance::value<T0>(&arg1) as u128);
        arg0.accounting.cumulative_fee_b = arg0.accounting.cumulative_fee_b + (0x2::balance::value<T1>(&arg2) as u128);
        0x2::balance::join<T0>(&mut arg0.income.pending_fee_a, arg1);
        0x2::balance::join<T1>(&mut arg0.income.pending_fee_b, arg2);
    }

    fun record_same_asset_reward_a<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x2::balance::Balance<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg1);
        arg0.accounting.cumulative_same_asset_reward_a = arg0.accounting.cumulative_same_asset_reward_a + (v0 as u128);
        0x2::balance::join<T0>(&mut arg0.income.pending_reward_a, arg1);
        v0
    }

    fun record_same_asset_reward_b<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x2::balance::Balance<T1>) : u64 {
        let v0 = 0x2::balance::value<T1>(&arg1);
        arg0.accounting.cumulative_same_asset_reward_b = arg0.accounting.cumulative_same_asset_reward_b + (v0 as u128);
        0x2::balance::join<T1>(&mut arg0.income.pending_reward_b, arg1);
        v0
    }

    fun reset_owner_collection<T0, T1>(arg0: &mut MakerVault<T0, T1>) {
        arg0.owner_collection.owner_fee_collected = false;
        arg0.owner_collection.owner_collection_position_generation = 0;
        arg0.owner_collection.owner_collection_below_position_id = 0x1::option::none<0x2::object::ID>();
        arg0.owner_collection.owner_collection_above_position_id = 0x1::option::none<0x2::object::ID>();
        arg0.owner_collection.owner_below_fee_a = 0;
        arg0.owner_collection.owner_below_fee_b = 0;
        arg0.owner_collection.owner_above_fee_a = 0;
        arg0.owner_collection.owner_above_fee_b = 0;
        arg0.owner_collection.owner_collected_reward_types = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        arg0.owner_collection.owner_reward_a_collected = false;
        arg0.owner_collection.owner_reward_b_collected = false;
        arg0.owner_collection.owner_reward_order = 0x1::vector::empty<0x1::type_name::TypeName>();
        arg0.owner_collection.owner_below_reward_amounts = vector[];
        arg0.owner_collection.owner_above_reward_amounts = vector[];
    }

    public fun reward_list_hash(arg0: &vector<0x1::type_name::TypeName>) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<vector<0x1::type_name::TypeName>>(arg0);
        0x2::hash::blake2b256(&v0)
    }

    public fun sequence<T0, T1>(arg0: &MakerVault<T0, T1>) : u64 {
        arg0.action_sequence
    }

    fun signed_contiguous(arg0: u32, arg1: u32) : bool {
        arg0 == 2147483647 && false || arg0 == 4294967295 && arg1 == 0 || arg1 == arg0 + 1
    }

    fun signed_distance(arg0: u32, arg1: u32) : u64 {
        let v0 = arg0 >= 2147483648;
        if (v0 == arg1 >= 2147483648) {
            if (arg0 >= arg1) {
                ((arg0 - arg1) as u64)
            } else {
                ((arg1 - arg0) as u64)
            }
        } else {
            let v2 = if (v0) {
                arg0
            } else {
                arg1
            };
            let v3 = if (v0) {
                arg1
            } else {
                arg0
            };
            (v3 as u64) + 4294967296 - (v2 as u64)
        }
    }

    fun signed_gte(arg0: u32, arg1: u32) : bool {
        !signed_lt(arg0, arg1)
    }

    fun signed_lt(arg0: u32, arg1: u32) : bool {
        let v0 = arg0 >= 2147483648;
        v0 != arg1 >= 2147483648 && v0 || arg0 < arg1
    }

    fun sum_as_u128(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) + (arg1 as u128)
    }

    fun swap_exact_a_to_sui<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: u128) : 0x2::balance::Balance<0x2::sui::SUI> {
        if (arg4 == 0) {
            assert!(arg5 == 0 && 0x2::balance::value<T0>(&arg3) == 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::income_source());
            0x2::balance::destroy_zero<T0>(arg3);
            return 0x2::balance::zero<0x2::sui::SUI>()
        };
        assert!(arg5 > 0 && 0x2::balance::value<T0>(&arg3) == arg4, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::income_source());
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, true, true, arg4, arg6, arg2);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        assert!(0x2::balance::value<T0>(&v5) == 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::income_debt());
        0x2::balance::destroy_zero<T0>(v5);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3) == arg4, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::income_debt());
        assert!(0x2::balance::value<0x2::sui::SUI>(&v4) >= arg5, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::income_output_floor());
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, arg3, 0x2::balance::zero<0x2::sui::SUI>(), v3);
        v4
    }

    fun swap_pending_income<T0, T1>(arg0: &mut MakerVault<T0, 0x2::sui::SUI>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: vector<u8>, arg18: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, 0x2::sui::SUI>(arg0, arg18);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg8 >= v0 && arg8 - v0 <= 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::max_plan_ttl_ms(&arg0.policy), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::deadline());
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::assert_action(&arg0.policy, v0, arg0.last_action_ms, arg0.paused);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::assert_income_action(&arg0.policy, v0, arg0.income.last_income_action_ms);
        assert!(arg5 == arg0.action_sequence, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_sequence());
        assert!(arg6 == arg0.agent_generation, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_generation());
        assert!(arg7 == 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::version(&arg0.policy), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_policy_version());
        assert!(0x1::vector::length<u8>(&arg17) == 32, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::income_seal());
        assert!(0x1::option::is_some<IncomeSwapPolicy>(&arg0.income.income_swap_policy), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::income_swap_disabled());
        let v1 = 0x1::option::borrow<IncomeSwapPolicy>(&arg0.income.income_swap_policy);
        let v2 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg1);
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg2);
        let v4 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>>(arg3);
        assert_income_route_fields(v2, v3, v4, 0x1::type_name::with_defining_ids<T1>(), v1.clmm_config_id, v1.usdc_sui_pool_id, v1.cetus_sui_pool_id, v1.cetus_type, arg7, v1.version);
        assert!(arg17 == income_swap_seal_hash(0x2::object::id<MakerVault<T0, 0x2::sui::SUI>>(arg0), v2, v3, v4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::income_seal());
        assert_income_source_bounds(0x2::balance::value<T0>(&arg0.income.pending_fee_a), 0x2::balance::value<T0>(&arg0.income.pending_reward_a), 0x2::balance::value<0x2::sui::SUI>(&arg0.income.pending_fee_b), 0x2::balance::value<0x2::sui::SUI>(&arg0.income.pending_reward_b), arg9, arg10, arg11, arg12);
        assert!((arg9 as u128) + (arg10 as u128) + (arg11 as u128) + (arg12 as u128) + (arg13 as u128) > 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::zero_amount());
        let v5 = 0x2::balance::zero<T0>();
        if (arg9 > 0) {
            0x2::balance::join<T0>(&mut v5, 0x2::balance::split<T0>(&mut arg0.income.pending_fee_a, arg9));
        };
        if (arg10 > 0) {
            0x2::balance::join<T0>(&mut v5, 0x2::balance::split<T0>(&mut arg0.income.pending_reward_a, arg10));
        };
        let v6 = arg9 + arg10;
        let v7 = swap_exact_a_to_sui<T0>(arg1, arg2, arg4, v5, v6, arg14, v1.usdc_sqrt_price_limit);
        let v8 = 0x2::balance::value<0x2::sui::SUI>(&v7);
        let v9 = 0x1::type_name::with_defining_ids<T1>();
        let v10 = 0x2::balance::zero<T1>();
        if (arg13 > 0) {
            assert_reward_registered<T0, 0x2::sui::SUI>(arg0, &v9);
            assert!(0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.rewards, v9), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::income_source());
            assert!(0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.rewards, v9)) >= arg13, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::income_source());
            0x2::balance::join<T1>(&mut v10, 0x2::balance::split<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v9), arg13));
        };
        let v11 = swap_exact_a_to_sui<T1>(arg1, arg3, arg4, v10, arg13, arg15, v1.cetus_sqrt_price_limit);
        let v12 = 0x2::balance::value<0x2::sui::SUI>(&v11);
        let v13 = 0x2::balance::zero<0x2::sui::SUI>();
        if (arg11 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut v13, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.income.pending_fee_b, arg11));
        };
        if (arg12 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut v13, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.income.pending_reward_b, arg12));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut v13, v7);
        0x2::balance::join<0x2::sui::SUI>(&mut v13, v11);
        let v14 = arg11 + arg12;
        let v15 = 0x2::balance::value<0x2::sui::SUI>(&v13);
        assert_income_outputs(v6, arg13, v14, v8, v12, v15, arg14, arg15, arg16);
        arg0.accounting.cumulative_fee_distributed_a = arg0.accounting.cumulative_fee_distributed_a + (arg9 as u128);
        arg0.accounting.cumulative_reward_distributed_a = arg0.accounting.cumulative_reward_distributed_a + (arg10 as u128);
        arg0.accounting.cumulative_fee_distributed_b = arg0.accounting.cumulative_fee_distributed_b + (arg11 as u128);
        arg0.accounting.cumulative_reward_distributed_b = arg0.accounting.cumulative_reward_distributed_b + (arg12 as u128);
        if (arg13 > 0) {
            add_distributed_foreign_reward<T0, 0x2::sui::SUI>(arg0, v9, arg13);
        };
        let v16 = if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.rewards, v9)) {
            0x2::balance::value<T1>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.rewards, v9))
        } else {
            0
        };
        if (v16 == 0 && 0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&arg0.rewards, v9)) {
            0x2::balance::destroy_zero<T1>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.rewards, v9));
        };
        arg0.income.last_income_action_ms = v0;
        arg0.action_sequence = arg0.action_sequence + 1;
        arg0.last_action_ms = v0;
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::consume_action(&mut arg0.policy);
        0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::events::emit_income_swapped_to_sui(0x2::object::id<MakerVault<T0, 0x2::sui::SUI>>(arg0), arg0.income.profit_recipient, v6, arg13, v14, v8, v12, v15, 0x2::balance::value<T0>(&arg0.income.pending_fee_a), 0x2::balance::value<T0>(&arg0.income.pending_reward_a), 0x2::balance::value<0x2::sui::SUI>(&arg0.income.pending_fee_b), 0x2::balance::value<0x2::sui::SUI>(&arg0.income.pending_reward_b), v16, v3, v4, arg5, arg6, arg7, arg8, arg17);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v13, arg18), arg0.income.profit_recipient);
    }

    fun target_ready_for_distribution(arg0: &0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::Policy, arg1: u128, arg2: u128, arg3: u128, arg4: u64) : bool {
        if (arg1 == 0) {
            return true
        };
        if (arg3 > 0) {
            return false
        };
        let v0 = max_a_not_exceeding_b(arg0, arg1);
        let v1 = if (arg2 > 0) {
            if (v0 > 0) {
                arg4 == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            return false
        };
        let v2 = if (arg2 > 0) {
            if (v0 > 0) {
                arg4 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            return false
        };
        true
    }

    fun u128_to_u64_cap(arg0: u128, arg1: u64) : u64 {
        if (arg0 > (arg1 as u128)) {
            arg1
        } else {
            (arg0 as u64)
        }
    }

    public(friend) fun validate_authority_fields(arg0: address, arg1: address, arg2: address, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: u64, arg10: u64) {
        assert!(arg0 == arg1 && arg2 == arg1, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::not_agent());
        let v0 = if (arg3 == arg4) {
            if (arg5 == arg6) {
                arg7 == arg8
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_cap());
        assert!(arg9 == arg10, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bad_generation());
    }

    fun validate_bin(arg0: &0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::Policy, arg1: u32, arg2: u32) {
        assert!(signed_gte(arg1, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::min_bin_bits(arg0)) && signed_gte(0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::max_bin_bits(arg0), arg1), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bin_range());
        assert!(signed_distance(arg1, arg2) <= (0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::max_distance_from_active(arg0) as u64), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::bin_range());
        assert!(arg1 != arg2, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::active_bin());
    }

    public(friend) fun validate_binding_ids(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID) {
        let v0 = if (arg0 == arg1) {
            if (arg2 == arg3) {
                arg4 == arg5
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::wrong_binding());
    }

    fun validate_dual<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &vector<u32>, arg3: &vector<u64>, arg4: &vector<u64>, arg5: &vector<u32>, arg6: &vector<u64>, arg7: &vector<u64>, arg8: u32) : (u64, u64) {
        validate_dual_at(&arg0.policy, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg1)))
    }

    public(friend) fun validate_dual_at(arg0: &0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::Policy, arg1: &vector<u32>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u32>, arg5: &vector<u64>, arg6: &vector<u64>, arg7: u32, arg8: u32) : (u64, u64) {
        let v0 = 0x1::vector::length<u32>(arg1);
        let v1 = 0x1::vector::length<u32>(arg4);
        assert!(v0 > 0 && v1 > 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::missing_pair());
        assert!(v0 == 0x1::vector::length<u64>(arg2) && v0 == 0x1::vector::length<u64>(arg3), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::vector_length());
        assert!(v1 == 0x1::vector::length<u64>(arg5) && v1 == 0x1::vector::length<u64>(arg6), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::vector_length());
        assert!(v0 + v1 <= (0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::max_total_bins(arg0) as u64), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::vector_length());
        assert!(signed_distance(arg8, arg7) <= (0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::max_active_drift(arg0) as u64), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::active_drift());
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v2 < v0) {
            let v5 = *0x1::vector::borrow<u32>(arg1, v2);
            let v6 = *0x1::vector::borrow<u64>(arg3, v2);
            assert!(*0x1::vector::borrow<u64>(arg2, v2) == 0 && v6 > 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::wrong_side());
            assert!(signed_lt(v5, arg7) && signed_lt(v5, arg8), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::active_bin());
            validate_bin(arg0, v5, arg8);
            assert!(v5 != arg7, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::active_bin());
            if (v2 > 0) {
                assert!(signed_contiguous(*0x1::vector::borrow<u32>(arg1, v2 - 1), v5), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::noncontiguous());
            };
            v4 = v4 + v6;
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < v1) {
            let v7 = *0x1::vector::borrow<u32>(arg4, v2);
            let v8 = *0x1::vector::borrow<u64>(arg5, v2);
            assert!(v8 > 0 && *0x1::vector::borrow<u64>(arg6, v2) == 0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::wrong_side());
            assert!(signed_lt(arg7, v7) && signed_lt(arg8, v7), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::active_bin());
            validate_bin(arg0, v7, arg8);
            assert!(v7 != arg7, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::active_bin());
            if (v2 > 0) {
                assert!(signed_contiguous(*0x1::vector::borrow<u32>(arg4, v2 - 1), v7), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::noncontiguous());
            };
            v3 = v3 + v8;
            v2 = v2 + 1;
        };
        assert!(v3 <= 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::max_deploy_a(arg0) && v4 <= 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::max_deploy_b(arg0), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::amount_limit());
        assert!(marked_equity_b(arg0, v3, v4) <= (0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::policy::max_pilot_exposure_b(arg0) as u128), 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::exposure_limit());
        (v3, v4)
    }

    public(friend) fun validate_role_addresses(arg0: address, arg1: address, arg2: address, arg3: address) {
        let v0 = if (arg0 != @0x0) {
            if (arg1 != @0x0) {
                if (arg2 != @0x0) {
                    arg3 != @0x0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::not_funding());
        let v1 = if (arg0 != arg1) {
            if (arg0 != arg2) {
                if (arg0 != arg3) {
                    if (arg1 != arg2) {
                        if (arg1 != arg3) {
                            arg2 != arg3
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::not_funding());
    }

    public(friend) fun validate_swap_deficits(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64) : (u64, u64) {
        assert_valid_swap_seal(arg4, arg5, arg6, arg7);
        assert!(arg2 <= arg0 && arg3 <= arg1, 0x58b796f6de49b44d2f670b8238c9e7cea8ac25944e36652bb92d84415be4686::errors::amount_limit());
        (0, 0)
    }

    // decompiled from Move bytecode v7
}

