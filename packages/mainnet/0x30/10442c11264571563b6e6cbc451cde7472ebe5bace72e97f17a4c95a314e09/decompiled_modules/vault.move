module 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::vault {
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
        owner_reward_order: vector<0x1::type_name::TypeName>,
        owner_below_reward_amounts: vector<u64>,
        owner_above_reward_amounts: vector<u64>,
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
        policy: 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::Policy,
        action_sequence: u64,
        funding_sequence: u64,
        last_capital_funding_sequence: u64,
        last_action_ms: u64,
        paused: bool,
        position_generation: u64,
        below_position: 0x1::option::Option<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>,
        above_position: 0x1::option::Option<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>,
        idle_a: 0x2::balance::Balance<T0>,
        idle_b: 0x2::balance::Balance<T1>,
        current_deployed_a: u64,
        current_deployed_b: u64,
        accounting: Accounting,
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

    public fun agent<T0, T1>(arg0: &MakerVault<T0, T1>) : address {
        arg0.agent
    }

    public(friend) fun assert_active_unchanged(arg0: u32, arg1: u32) {
        assert!(arg0 == arg1, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::active_bin_crossed());
    }

    fun assert_agent<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &AgentCap<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        validate_authority_fields(0x2::tx_context::sender(arg2), arg0.agent, arg1.agent, 0x2::object::id<AgentCap<T0, T1>>(arg1), arg0.agent_cap_id, arg1.vault_id, 0x2::object::id<MakerVault<T0, T1>>(arg0), arg1.pool_id, arg0.pool_id, arg1.generation, arg0.agent_generation);
    }

    fun assert_bindings<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        validate_binding_ids(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1), arg0.pool_id, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig>(arg2), arg0.config_id, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned>(arg3), arg0.versioned_id);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg3);
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::version(arg3) == arg0.expected_protocol_version, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_version());
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_step<T0, T1>(arg1) == arg0.expected_bin_step, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_bin_step());
    }

    fun assert_capital_ticket<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &CapitalTicket<T0, T1>) {
        assert!(arg1.vault_id == 0x2::object::id<MakerVault<T0, T1>>(arg0) && arg1.cap_id == arg0.agent_cap_id, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_cap());
        assert!(arg1.generation == arg0.agent_generation, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_generation());
        assert!(arg1.sequence == arg0.action_sequence, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_sequence());
        assert!(arg1.policy_version == 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_policy_version());
        assert!(arg1.funding_sequence == arg0.funding_sequence, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::stale_funding_sequence());
        assert_pair_state<T0, T1>(arg0);
        assert!(arg1.had_pair == has_pair<T0, T1>(arg0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::position_mismatch());
    }

    fun assert_current_owner_collection<T0, T1>(arg0: &MakerVault<T0, T1>) {
        let v0 = &arg0.owner_collection;
        assert!(0x1::option::is_some<0x2::object::ID>(&v0.owner_collection_below_position_id) && 0x1::option::is_some<0x2::object::ID>(&v0.owner_collection_above_position_id), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::position_mismatch());
        assert_owner_collection_binding(*0x1::option::borrow<0x2::object::ID>(&v0.owner_collection_below_position_id), *0x1::option::borrow<0x2::object::ID>(&v0.owner_collection_above_position_id), v0.owner_collection_position_generation, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.below_position)), 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.above_position)), arg0.position_generation);
    }

    public(friend) fun assert_distinct_position_ids(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        assert!(arg0 != arg1, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::duplicate_position());
    }

    fun assert_funding<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert_funding_sender(0x2::tx_context::sender(arg1), arg0.funding);
    }

    public(friend) fun assert_funding_sender(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::not_funding());
    }

    fun assert_idle_after<T0, T1>(arg0: &0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::Policy, arg1: &0x2::balance::Balance<T0>, arg2: &0x2::balance::Balance<T1>, arg3: u64, arg4: u64) {
        let v0 = 0x2::balance::value<T0>(arg1);
        let v1 = 0x2::balance::value<T1>(arg2);
        assert!(arg3 <= v0 && arg4 <= v1, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::amount_limit());
        assert!(v0 - arg3 >= 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::min_idle_a(arg0) && v1 - arg4 >= 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::min_idle_b(arg0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::idle_floor());
    }

    public(friend) fun assert_new_funding_sequence(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg2 == arg0 && arg2 > arg1, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::stale_funding_sequence());
    }

    fun assert_owner<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::not_owner());
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
        assert!(v0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::position_mismatch());
    }

    fun assert_owner_collection_clear<T0, T1>(arg0: &MakerVault<T0, T1>) {
        let v0 = &arg0.owner_collection;
        let v1 = if (!v0.owner_fee_collected) {
            if (0x1::option::is_none<0x2::object::ID>(&v0.owner_collection_below_position_id)) {
                if (0x1::option::is_none<0x2::object::ID>(&v0.owner_collection_above_position_id)) {
                    if (0x2::vec_set::is_empty<0x1::type_name::TypeName>(&v0.owner_collected_reward_types)) {
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
        };
        assert!(v1, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::duplicate_action());
    }

    public(friend) fun assert_pair_flags(arg0: bool, arg1: bool) {
        assert!(arg0 == arg1, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::missing_pair());
    }

    fun assert_pair_state<T0, T1>(arg0: &MakerVault<T0, T1>) {
        assert_pair_flags(0x1::option::is_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.below_position), 0x1::option::is_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.above_position));
        if (0x1::option::is_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.below_position)) {
            assert_distinct_position_ids(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.below_position)), 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.above_position)));
        };
    }

    fun assert_position_range(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg1: &vector<u32>) {
        let v0 = 0x1::vector::length<u32>(arg1);
        assert!(v0 > 0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::vector_length());
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::lower_bin_id(arg0)) == *0x1::vector::borrow<u32>(arg1, 0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::position_mismatch());
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::upper_bin_id(arg0)) == *0x1::vector::borrow<u32>(arg1, v0 - 1), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::position_mismatch());
    }

    fun assert_reward_registered<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &0x1::type_name::TypeName) {
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_types, arg1), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::reward_not_allowed());
    }

    fun assert_ticket<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &ActionTicket<T0, T1>) {
        assert!(arg1.vault_id == 0x2::object::id<MakerVault<T0, T1>>(arg0) && arg1.cap_id == arg0.agent_cap_id, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_cap());
        assert!(arg1.generation == arg0.agent_generation, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_generation());
        assert!(arg1.sequence == arg0.action_sequence, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_sequence());
        assert!(arg1.policy_version == 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_policy_version());
        assert_pair_state<T0, T1>(arg0);
    }

    public(friend) fun assert_unique_reward_types(arg0: &vector<0x1::type_name::TypeName>) {
        let v0 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(arg0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(arg0, v1);
            assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&v0, &v2), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::duplicate_reward());
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, v2);
            v1 = v1 + 1;
        };
    }

    fun assert_valid_swap_seal(arg0: u8, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg0 <= 2, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_swap_intent());
        if (arg0 == 0) {
            let v0 = if (arg1 == 0) {
                if (arg2 == 0) {
                    arg3 == 0
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_swap_intent());
        } else {
            let v1 = if (arg1 > 0) {
                if (arg1 == arg2) {
                    arg3 > 0
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v1, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_swap_intent());
        };
    }

    public fun begin_capital_action<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &AgentCap<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: 0x2::object::ID, arg11: 0x2::object::ID, arg12: u32, arg13: u64, arg14: vector<u8>, arg15: u8, arg16: u64, arg17: u64, arg18: u64, arg19: &0x2::tx_context::TxContext) : CapitalTicket<T0, T1> {
        assert_agent<T0, T1>(arg0, arg1, arg19);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        assert_pair_state<T0, T1>(arg0);
        assert!(arg0.schema_version == 4, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_schema());
        assert!(0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy) == arg6, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_policy_version());
        assert!(arg0.action_sequence == arg7, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_sequence());
        assert_new_funding_sequence(arg0.funding_sequence, arg0.last_capital_funding_sequence, arg8);
        assert!(0x1::vector::length<u8>(&arg14) == 32, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_intent_hash());
        let v0 = has_pair<T0, T1>(arg0);
        assert!(v0 == arg9, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::position_mismatch());
        let v1 = 0x2::object::id_from_address(@0x0);
        let (v2, v3) = if (v0) {
            (0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.below_position)), 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.above_position)))
        } else {
            (v1, v1)
        };
        assert!(v2 == arg10 && v3 == arg11, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::position_mismatch());
        if (v0) {
            assert_distinct_position_ids(v2, v3);
        };
        let v4 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg13 >= v4 && arg13 - v4 <= 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::max_plan_ttl_ms(&arg0.policy), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::deadline());
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::assert_action(&arg0.policy, v4, arg0.last_action_ms, arg0.paused);
        let v5 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg2));
        assert!(signed_distance(v5, arg12) <= (0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::max_active_drift(&arg0.policy) as u64), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::active_drift());
        assert_valid_swap_seal(arg15, arg16, arg17, arg18);
        CapitalTicket<T0, T1>{
            vault_id             : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            cap_id               : 0x2::object::id<AgentCap<T0, T1>>(arg1),
            generation           : arg0.agent_generation,
            sequence             : arg0.action_sequence,
            policy_version       : arg6,
            funding_sequence     : arg8,
            had_pair             : v0,
            below_position_id    : v2,
            above_position_id    : v3,
            planned_active_bits  : arg12,
            observed_active_bits : v5,
            deadline_ms          : arg13,
            intent_hash          : arg14,
            swap_direction       : arg15,
            min_swap_output      : arg16,
            max_swap_output      : arg17,
            max_swap_input       : arg18,
            below_fee_collected  : !v0,
            above_fee_collected  : !v0,
            below_reward_types   : 0x1::vector::empty<0x1::type_name::TypeName>(),
            below_reward_amounts : vector[],
            above_reward_types   : 0x1::vector::empty<0x1::type_name::TypeName>(),
            above_reward_amounts : vector[],
        }
    }

    public fun begin_dual_action<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &AgentCap<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: 0x2::object::ID, arg9: 0x2::object::ID, arg10: u32, arg11: u64, arg12: vector<u8>, arg13: u8, arg14: u64, arg15: u64, arg16: u64, arg17: &0x2::tx_context::TxContext) : ActionTicket<T0, T1> {
        assert_agent<T0, T1>(arg0, arg1, arg17);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        assert_pair_state<T0, T1>(arg0);
        assert!(arg0.schema_version == 4, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_schema());
        assert!(0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy) == arg6, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_policy_version());
        assert!(arg0.action_sequence == arg7, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_sequence());
        assert!(0x1::vector::length<u8>(&arg12) == 32, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_intent_hash());
        assert!(has_pair<T0, T1>(arg0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::missing_pair());
        let v0 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.below_position));
        let v1 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.above_position));
        assert_distinct_position_ids(v0, v1);
        assert!(v0 == arg8 && v1 == arg9, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::position_mismatch());
        let v2 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg11 >= v2 && arg11 - v2 <= 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::max_plan_ttl_ms(&arg0.policy), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::deadline());
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::assert_action(&arg0.policy, v2, arg0.last_action_ms, arg0.paused);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg2));
        assert!(signed_distance(v3, arg10) <= (0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::max_active_drift(&arg0.policy) as u64), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::active_drift());
        assert_valid_swap_seal(arg13, arg14, arg15, arg16);
        ActionTicket<T0, T1>{
            vault_id             : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            cap_id               : 0x2::object::id<AgentCap<T0, T1>>(arg1),
            generation           : arg0.agent_generation,
            sequence             : arg0.action_sequence,
            policy_version       : arg6,
            below_position_id    : v0,
            above_position_id    : v1,
            planned_active_bits  : arg10,
            observed_active_bits : v3,
            deadline_ms          : arg11,
            intent_hash          : arg12,
            swap_direction       : arg13,
            min_swap_output      : arg14,
            max_swap_output      : arg15,
            max_swap_input       : arg16,
            below_fee_a          : 0,
            below_fee_b          : 0,
            above_fee_a          : 0,
            above_fee_b          : 0,
            below_fee_collected  : false,
            above_fee_collected  : false,
            below_reward_types   : 0x1::vector::empty<0x1::type_name::TypeName>(),
            below_reward_amounts : vector[],
            above_reward_types   : 0x1::vector::empty<0x1::type_name::TypeName>(),
            above_reward_amounts : vector[],
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
        assert!(has_pair<T0, T1>(arg0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::missing_pair());
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
        0x2::balance::join<T0>(&mut arg0.idle_a, v12);
        0x2::balance::join<T1>(&mut arg0.idle_b, v11);
        0x2::balance::join<T0>(&mut arg0.idle_a, v10);
        0x2::balance::join<T1>(&mut arg0.idle_b, v9);
        0x2::balance::join<T0>(&mut arg0.idle_a, v21);
        0x2::balance::join<T1>(&mut arg0.idle_b, v20);
        0x2::balance::join<T0>(&mut arg0.idle_a, v19);
        0x2::balance::join<T1>(&mut arg0.idle_b, v18);
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
        assert!(0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::allow_harvest(&arg0.policy), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_phase());
        assert!(!arg1.above_fee_collected, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::duplicate_action());
        let v0 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v0) == arg1.above_position_id, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.above_position_id, arg4, arg5);
        let (v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg2, v0, arg3, arg4, arg6);
        let v3 = v2;
        let v4 = v1;
        arg1.above_fee_a = 0x2::balance::value<T0>(&v4);
        arg1.above_fee_b = 0x2::balance::value<T1>(&v3);
        arg1.above_fee_collected = true;
        record_fee<T0, T1>(arg0, v4, v3);
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_slot_fee_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 1, arg1.above_position_id, arg1.sequence, arg1.above_fee_a, arg1.above_fee_b, arg0.accounting.cumulative_fee_a, arg0.accounting.cumulative_fee_b, arg1.generation, arg1.policy_version);
    }

    public fun collect_above_fee_in_capital_action<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut CapitalTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_capital_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        let v0 = if (arg1.had_pair) {
            if (!arg1.above_fee_collected) {
                0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::allow_harvest(&arg0.policy)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_phase());
        let v1 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v1) == arg1.above_position_id, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.above_position_id, arg4, arg5);
        let (v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg2, v1, arg3, arg4, arg6);
        record_fee<T0, T1>(arg0, v2, v3);
        arg1.above_fee_collected = true;
    }

    public fun collect_above_reward_in_action<T0, T1, T2>(arg0: &mut MakerVault<T0, T1>, arg1: &mut ActionTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        assert!(0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::allow_harvest(&arg0.policy) && arg1.above_fee_collected, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_phase());
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert_reward_registered<T0, T1>(arg0, &v0);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg1.above_reward_types) < (0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::max_reward_types(&arg0.policy) as u64), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::too_many_rewards());
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.above_reward_types, &v0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::duplicate_reward());
        let v1 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v1) == arg1.above_position_id, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.above_position_id, arg4, arg5);
        let v2 = put_reward<T0, T1, T2>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg2, v1, arg3, arg4, arg6));
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.above_reward_types, v0);
        0x1::vector::push_back<u64>(&mut arg1.above_reward_amounts, v2);
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 1, arg1.above_position_id, arg1.sequence, v0, v2, cumulative_reward<T0, T1>(arg0, v0), arg1.generation, arg1.policy_version);
    }

    public fun collect_above_reward_in_capital_action<T0, T1, T2>(arg0: &mut MakerVault<T0, T1>, arg1: &mut CapitalTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_capital_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        assert!(arg1.had_pair && arg1.above_fee_collected, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_phase());
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert_reward_registered<T0, T1>(arg0, &v0);
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.above_reward_types, &v0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::duplicate_reward());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.above_position_id, arg4, arg5);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg2, 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position), arg3, arg4, arg6);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.above_reward_types, v0);
        0x1::vector::push_back<u64>(&mut arg1.above_reward_amounts, put_reward<T0, T1, T2>(arg0, v1));
    }

    public fun collect_below_fee_in_action<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut ActionTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        assert!(0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::allow_harvest(&arg0.policy), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_phase());
        assert!(!arg1.below_fee_collected, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::duplicate_action());
        let v0 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v0) == arg1.below_position_id, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.below_position_id, arg4, arg5);
        let (v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg2, v0, arg3, arg4, arg6);
        let v3 = v2;
        let v4 = v1;
        arg1.below_fee_a = 0x2::balance::value<T0>(&v4);
        arg1.below_fee_b = 0x2::balance::value<T1>(&v3);
        arg1.below_fee_collected = true;
        record_fee<T0, T1>(arg0, v4, v3);
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_slot_fee_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 0, arg1.below_position_id, arg1.sequence, arg1.below_fee_a, arg1.below_fee_b, arg0.accounting.cumulative_fee_a, arg0.accounting.cumulative_fee_b, arg1.generation, arg1.policy_version);
    }

    public fun collect_below_fee_in_capital_action<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut CapitalTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_capital_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        let v0 = if (arg1.had_pair) {
            if (!arg1.below_fee_collected) {
                0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::allow_harvest(&arg0.policy)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_phase());
        let v1 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v1) == arg1.below_position_id, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.below_position_id, arg4, arg5);
        let (v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg2, v1, arg3, arg4, arg6);
        record_fee<T0, T1>(arg0, v2, v3);
        arg1.below_fee_collected = true;
    }

    public fun collect_below_reward_in_action<T0, T1, T2>(arg0: &mut MakerVault<T0, T1>, arg1: &mut ActionTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        assert!(0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::allow_harvest(&arg0.policy) && arg1.below_fee_collected, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_phase());
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert_reward_registered<T0, T1>(arg0, &v0);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg1.below_reward_types) < (0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::max_reward_types(&arg0.policy) as u64), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::too_many_rewards());
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.below_reward_types, &v0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::duplicate_reward());
        let v1 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position);
        assert!(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v1) == arg1.below_position_id, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::position_mismatch());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.below_position_id, arg4, arg5);
        let v2 = put_reward<T0, T1, T2>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg2, v1, arg3, arg4, arg6));
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.below_reward_types, v0);
        0x1::vector::push_back<u64>(&mut arg1.below_reward_amounts, v2);
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 0, arg1.below_position_id, arg1.sequence, v0, v2, cumulative_reward<T0, T1>(arg0, v0), arg1.generation, arg1.policy_version);
    }

    public fun collect_below_reward_in_capital_action<T0, T1, T2>(arg0: &mut MakerVault<T0, T1>, arg1: &mut CapitalTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_capital_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        assert!(arg1.had_pair && arg1.below_fee_collected, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_phase());
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert_reward_registered<T0, T1>(arg0, &v0);
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.below_reward_types, &v0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::duplicate_reward());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, arg1.below_position_id, arg4, arg5);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg2, 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position), arg3, arg4, arg6);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.below_reward_types, v0);
        0x1::vector::push_back<u64>(&mut arg1.below_reward_amounts, put_reward<T0, T1, T2>(arg0, v1));
    }

    public fun create_vault<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: address, arg5: address, arg6: u64, arg7: u16, arg8: 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::Policy, arg9: &mut 0x2::tx_context::TxContext) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg2);
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::version(arg2) == arg6, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_version());
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_step<T0, T1>(arg0) == arg7, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_bin_step());
        let v0 = 0x2::tx_context::sender(arg9);
        validate_role_addresses(v0, arg4, arg5);
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::assert_creation(&arg8, 0x2::clock::timestamp_ms(arg3));
        let v1 = 0x2::object::new(arg9);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::object::new(arg9);
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
            cumulative_funded_a      : 0,
            cumulative_funded_b      : 0,
            cumulative_deployed_a    : 0,
            cumulative_deployed_b    : 0,
            cumulative_principal_a   : 0,
            cumulative_principal_b   : 0,
            cumulative_fee_a         : 0,
            cumulative_fee_b         : 0,
            cumulative_closing_fee_a : 0,
            cumulative_closing_fee_b : 0,
            cumulative_swap_input_a  : 0,
            cumulative_swap_input_b  : 0,
            cumulative_swap_output_a : 0,
            cumulative_swap_output_b : 0,
        };
        let v10 = OwnerCollection{
            owner_fee_collected                  : false,
            owner_collection_position_generation : 0,
            owner_collection_below_position_id   : 0x1::option::none<0x2::object::ID>(),
            owner_collection_above_position_id   : 0x1::option::none<0x2::object::ID>(),
            owner_below_fee_a                    : 0,
            owner_below_fee_b                    : 0,
            owner_above_fee_a                    : 0,
            owner_above_fee_b                    : 0,
            owner_collected_reward_types         : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            owner_reward_order                   : 0x1::vector::empty<0x1::type_name::TypeName>(),
            owner_below_reward_amounts           : vector[],
            owner_above_reward_amounts           : vector[],
        };
        let v11 = MakerVault<T0, T1>{
            id                            : v1,
            schema_version                : 4,
            owner                         : v0,
            agent                         : arg4,
            funding                       : arg5,
            agent_cap_id                  : v4,
            agent_generation              : 1,
            pool_id                       : v5,
            config_id                     : v6,
            versioned_id                  : v7,
            expected_protocol_version     : arg6,
            expected_bin_step             : arg7,
            policy                        : arg8,
            action_sequence               : 0,
            funding_sequence              : 0,
            last_capital_funding_sequence : 0,
            last_action_ms                : 0,
            paused                        : false,
            position_generation           : 0,
            below_position                : 0x1::option::none<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(),
            above_position                : 0x1::option::none<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(),
            idle_a                        : 0x2::balance::zero<T0>(),
            idle_b                        : 0x2::balance::zero<T1>(),
            current_deployed_a            : 0,
            current_deployed_b            : 0,
            accounting                    : v9,
            reward_types                  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            rewards                       : 0x2::bag::new(arg9),
            cumulative_rewards            : 0x2::bag::new(arg9),
            owner_collection              : v10,
        };
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_vault_created(v2, v5, v6, v7, v0, arg4, arg5, v4, arg6, arg7, 0, 1, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg8));
        0x2::transfer::share_object<MakerVault<T0, T1>>(v11);
        0x2::transfer::transfer<AgentCap<T0, T1>>(v8, arg4);
    }

    fun cumulative_reward<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: 0x1::type_name::TypeName) : u128 {
        assert!(0x2::bag::contains_with_type<0x1::type_name::TypeName, u128>(&arg0.cumulative_rewards, arg1), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::reward_not_allowed());
        *0x2::bag::borrow<0x1::type_name::TypeName, u128>(&arg0.cumulative_rewards, arg1)
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

    public fun finish_capital_action<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &AgentCap<T0, T1>, arg2: CapitalTicket<T0, T1>, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: vector<u32>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u32>, arg11: vector<u64>, arg12: vector<u64>, arg13: &mut 0x2::tx_context::TxContext) {
        assert_agent<T0, T1>(arg0, arg1, arg13);
        assert_capital_ticket<T0, T1>(arg0, &arg2);
        assert_bindings<T0, T1>(arg0, arg3, arg4, arg5);
        assert!(0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::allow_rollover(&arg0.policy), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_phase());
        assert_new_funding_sequence(arg0.funding_sequence, arg0.last_capital_funding_sequence, arg2.funding_sequence);
        assert!(arg2.below_fee_collected && arg2.above_fee_collected, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::duplicate_action());
        assert!(arg2.below_reward_types == arg2.above_reward_types, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_intent_hash());
        let v0 = if (arg2.had_pair) {
            0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.reward_types)
        } else {
            0
        };
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2.below_reward_types) == v0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_intent_hash());
        assert!(arg2.intent_hash == capital_plan_hash(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, arg2.cap_id, arg2.generation, arg2.sequence, arg2.policy_version, arg2.funding_sequence, arg2.had_pair, arg2.below_position_id, arg2.above_position_id, arg2.deadline_ms, arg2.planned_active_bits, reward_list_hash(&arg2.below_reward_types), arg2.swap_direction, arg2.min_swap_output, arg2.max_swap_output, arg2.max_swap_input, arg7, arg8, arg9, arg10, arg11, arg12), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_intent_hash());
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(v1 <= arg2.deadline_ms, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::deadline());
        let (v2, v3) = validate_dual_at(&arg0.policy, &arg7, &arg8, &arg9, &arg10, &arg11, &arg12, arg2.planned_active_bits, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg3)));
        if (arg2.had_pair) {
            let v4 = close_both_to_idle<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg13);
            assert!(v4.below_id == arg2.below_position_id && v4.above_id == arg2.above_position_id, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::position_mismatch());
        } else {
            assert!(!has_pair<T0, T1>(arg0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::pair_exists());
        };
        let v5 = rebalance_inventory<T0, T1>(arg0, arg3, arg4, arg5, arg6, v2, v3, arg2.swap_direction, arg2.min_swap_output, arg2.max_swap_output, arg2.max_swap_input, arg13);
        let v6 = open_both_from_idle<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg2.planned_active_bits, arg13);
        arg0.action_sequence = arg0.action_sequence + 1;
        arg0.last_capital_funding_sequence = arg2.funding_sequence;
        arg0.last_action_ms = v1;
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::consume_action(&mut arg0.policy);
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_capital_action_settled(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, arg2.had_pair, arg2.below_position_id, arg2.above_position_id, v6.below_id, v6.above_id, arg2.funding_sequence, arg2.sequence, arg2.generation, arg2.policy_version, arg2.planned_active_bits, arg2.observed_active_bits, v1, v6.deployed_a, v6.deployed_b, 0x2::balance::value<T0>(&arg0.idle_a), 0x2::balance::value<T1>(&arg0.idle_b), v5.direction, v5.actual_output, v5.actual_input);
        let CapitalTicket {
            vault_id             : _,
            cap_id               : _,
            generation           : _,
            sequence             : _,
            policy_version       : _,
            funding_sequence     : _,
            had_pair             : _,
            below_position_id    : _,
            above_position_id    : _,
            planned_active_bits  : _,
            observed_active_bits : _,
            deadline_ms          : _,
            intent_hash          : _,
            swap_direction       : _,
            min_swap_output      : _,
            max_swap_output      : _,
            max_swap_input       : _,
            below_fee_collected  : _,
            above_fee_collected  : _,
            below_reward_types   : _,
            below_reward_amounts : _,
            above_reward_types   : _,
            above_reward_amounts : _,
        } = arg2;
    }

    public fun finish_dual_exit<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &AgentCap<T0, T1>, arg2: ActionTicket<T0, T1>, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: bool, arg8: u16, arg9: u16, arg10: &0x2::tx_context::TxContext) {
        assert_agent<T0, T1>(arg0, arg1, arg10);
        assert_ticket<T0, T1>(arg0, &arg2);
        assert_bindings<T0, T1>(arg0, arg3, arg4, arg5);
        assert!(0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::allow_exit_to_idle(&arg0.policy), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::exit_disabled());
        let v0 = if (arg7) {
            if (arg8 == 10000) {
                arg9 == 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_percent());
        assert!(arg2.below_fee_collected && arg2.above_fee_collected, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::duplicate_action());
        assert!(arg2.below_reward_types == arg2.above_reward_types, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_intent_hash());
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2.below_reward_types) == 0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.reward_types), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_intent_hash());
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
        assert!(v1, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_swap_intent());
        assert!(arg2.intent_hash == dual_exit_hash(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, arg2.cap_id, arg2.generation, arg2.below_position_id, arg2.above_position_id, arg2.sequence, arg2.policy_version, arg2.deadline_ms, arg2.planned_active_bits, arg7, arg8, arg9, reward_list_hash(&arg2.below_reward_types), arg2.swap_direction, arg2.min_swap_output, arg2.max_swap_output, arg2.max_swap_input), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_intent_hash());
        let v2 = 0x2::clock::timestamp_ms(arg6);
        assert!(v2 <= arg2.deadline_ms, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::deadline());
        assert!(signed_distance(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg3)), arg2.planned_active_bits) <= (0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::max_active_drift(&arg0.policy) as u64), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::active_drift());
        let v3 = close_both_to_idle<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg10);
        assert!(v3.below_id == arg2.below_position_id && v3.above_id == arg2.above_position_id, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::position_mismatch());
        reset_owner_collection<T0, T1>(arg0);
        arg0.action_sequence = arg0.action_sequence + 1;
        arg0.last_action_ms = v2;
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::consume_action(&mut arg0.policy);
        let ActionTicket {
            vault_id             : _,
            cap_id               : _,
            generation           : v6,
            sequence             : v7,
            policy_version       : v8,
            below_position_id    : _,
            above_position_id    : _,
            planned_active_bits  : v11,
            observed_active_bits : v12,
            deadline_ms          : _,
            intent_hash          : _,
            swap_direction       : _,
            min_swap_output      : _,
            max_swap_output      : _,
            max_swap_input       : _,
            below_fee_a          : v19,
            below_fee_b          : v20,
            above_fee_a          : v21,
            above_fee_b          : v22,
            below_fee_collected  : _,
            above_fee_collected  : _,
            below_reward_types   : v25,
            below_reward_amounts : v26,
            above_reward_types   : v27,
            above_reward_amounts : v28,
        } = arg2;
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_dual_exit_settled(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, v3.below_id, v3.above_id, v3.below_lower_bits, v3.below_upper_bits, v3.above_lower_bits, v3.above_upper_bits, v3.below_principal_a, v3.below_principal_b, v3.above_principal_a, v3.above_principal_b, v19, v20, v21, v22, v3.below_closing_fee_a, v3.below_closing_fee_b, v3.above_closing_fee_a, v3.above_closing_fee_b, v25, v26, v27, v28, 0x2::balance::value<T0>(&arg0.idle_a), 0x2::balance::value<T1>(&arg0.idle_b), v7, v6, v8, v11, v12, v2, arg0.accounting.cumulative_principal_a, arg0.accounting.cumulative_principal_b, arg0.accounting.cumulative_fee_a, arg0.accounting.cumulative_fee_b, arg0.accounting.cumulative_closing_fee_a, arg0.accounting.cumulative_closing_fee_b);
        assert_pair_state<T0, T1>(arg0);
    }

    public fun finish_dual_rollover<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &AgentCap<T0, T1>, arg2: ActionTicket<T0, T1>, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: bool, arg8: u16, arg9: u16, arg10: vector<u32>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u32>, arg14: vector<u64>, arg15: vector<u64>, arg16: &mut 0x2::tx_context::TxContext) {
        assert_agent<T0, T1>(arg0, arg1, arg16);
        assert_ticket<T0, T1>(arg0, &arg2);
        assert_bindings<T0, T1>(arg0, arg3, arg4, arg5);
        assert!(0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::allow_rollover(&arg0.policy), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_phase());
        let v0 = if (arg7) {
            if (arg8 == 10000) {
                arg9 == 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_percent());
        assert!(arg2.below_fee_collected && arg2.above_fee_collected, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::duplicate_action());
        assert!(arg2.below_reward_types == arg2.above_reward_types, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_intent_hash());
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2.below_reward_types) == 0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.reward_types), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_intent_hash());
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg2.below_reward_types) == 0x1::vector::length<u64>(&arg2.below_reward_amounts) && 0x1::vector::length<0x1::type_name::TypeName>(&arg2.above_reward_types) == 0x1::vector::length<u64>(&arg2.above_reward_amounts), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_intent_hash());
        assert!(arg2.intent_hash == dual_plan_hash(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, arg2.cap_id, arg2.generation, arg2.below_position_id, arg2.above_position_id, arg2.sequence, arg2.policy_version, arg2.deadline_ms, arg2.planned_active_bits, arg7, arg8, arg9, reward_list_hash(&arg2.below_reward_types), arg2.swap_direction, arg2.min_swap_output, arg2.max_swap_output, arg2.max_swap_input, arg10, arg11, arg12, arg13, arg14, arg15), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_intent_hash());
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(v1 <= arg2.deadline_ms, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::deadline());
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg3));
        assert!(signed_distance(v2, arg2.planned_active_bits) <= (0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::max_active_drift(&arg0.policy) as u64), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::active_drift());
        let (v3, v4) = validate_dual_at(&arg0.policy, &arg10, &arg11, &arg12, &arg13, &arg14, &arg15, arg2.planned_active_bits, v2);
        let v5 = close_both_to_idle<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg16);
        assert!(v5.below_id == arg2.below_position_id && v5.above_id == arg2.above_position_id, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::position_mismatch());
        let v6 = rebalance_inventory<T0, T1>(arg0, arg3, arg4, arg5, arg6, v3, v4, arg2.swap_direction, arg2.min_swap_output, arg2.max_swap_output, arg2.max_swap_input, arg16);
        let v7 = open_both_from_idle<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg10, arg11, arg12, arg13, arg14, arg15, arg2.planned_active_bits, arg16);
        arg0.action_sequence = arg0.action_sequence + 1;
        arg0.last_action_ms = v1;
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::consume_action(&mut arg0.policy);
        let ActionTicket {
            vault_id             : _,
            cap_id               : _,
            generation           : v10,
            sequence             : v11,
            policy_version       : v12,
            below_position_id    : _,
            above_position_id    : _,
            planned_active_bits  : v15,
            observed_active_bits : v16,
            deadline_ms          : _,
            intent_hash          : _,
            swap_direction       : _,
            min_swap_output      : _,
            max_swap_output      : _,
            max_swap_input       : _,
            below_fee_a          : v23,
            below_fee_b          : v24,
            above_fee_a          : v25,
            above_fee_b          : v26,
            below_fee_collected  : _,
            above_fee_collected  : _,
            below_reward_types   : v29,
            below_reward_amounts : v30,
            above_reward_types   : v31,
            above_reward_amounts : v32,
        } = arg2;
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_dual_rollover_settled(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, v5.below_id, v7.below_id, v5.above_id, v7.above_id, v5.below_lower_bits, v5.below_upper_bits, v5.above_lower_bits, v5.above_upper_bits, arg10, arg11, arg12, arg13, arg14, arg15, v7.deployed_b, v7.deployed_a, v5.below_principal_a, v5.below_principal_b, v5.above_principal_a, v5.above_principal_b, v23, v24, v25, v26, v5.below_closing_fee_a, v5.below_closing_fee_b, v5.above_closing_fee_a, v5.above_closing_fee_b, v29, v30, v31, v32, 0x2::balance::value<T0>(&arg0.idle_a), 0x2::balance::value<T1>(&arg0.idle_b), v11, v10, v12, v15, v16, v1, v6.direction, v6.min_output, v6.max_output, v6.max_input, v6.actual_output, v6.actual_input, v6.pre_active_bits, v6.post_active_bits, arg0.accounting.cumulative_deployed_a, arg0.accounting.cumulative_deployed_b, arg0.accounting.cumulative_principal_a, arg0.accounting.cumulative_principal_b, arg0.accounting.cumulative_fee_a, arg0.accounting.cumulative_fee_b, arg0.accounting.cumulative_closing_fee_a, arg0.accounting.cumulative_closing_fee_b, arg0.accounting.cumulative_swap_input_a, arg0.accounting.cumulative_swap_input_b, arg0.accounting.cumulative_swap_output_a, arg0.accounting.cumulative_swap_output_b);
    }

    public fun funding<T0, T1>(arg0: &MakerVault<T0, T1>) : address {
        arg0.funding
    }

    public fun funding_deposit_a<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert_funding<T0, T1>(arg0, arg2);
        assert_pair_state<T0, T1>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::zero_amount());
        0x2::balance::join<T0>(&mut arg0.idle_a, 0x2::coin::into_balance<T0>(arg1));
        arg0.funding_sequence = arg0.funding_sequence + 1;
        arg0.accounting.cumulative_funded_a = arg0.accounting.cumulative_funded_a + (v0 as u128);
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_funding_deposit(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.funding, 0, v0, 0x2::balance::value<T0>(&arg0.idle_a), 0x2::balance::value<T1>(&arg0.idle_b), arg0.funding_sequence, arg0.action_sequence, arg0.agent_generation, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy), arg0.accounting.cumulative_funded_a, arg0.accounting.cumulative_funded_b);
    }

    public fun funding_deposit_b<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::tx_context::TxContext) {
        assert_funding<T0, T1>(arg0, arg2);
        assert_pair_state<T0, T1>(arg0);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::zero_amount());
        0x2::balance::join<T1>(&mut arg0.idle_b, 0x2::coin::into_balance<T1>(arg1));
        arg0.funding_sequence = arg0.funding_sequence + 1;
        arg0.accounting.cumulative_funded_b = arg0.accounting.cumulative_funded_b + (v0 as u128);
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_funding_deposit(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.funding, 1, v0, 0x2::balance::value<T0>(&arg0.idle_a), 0x2::balance::value<T1>(&arg0.idle_b), arg0.funding_sequence, arg0.action_sequence, arg0.agent_generation, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy), arg0.accounting.cumulative_funded_a, arg0.accounting.cumulative_funded_b);
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
        (0x2::balance::value<T0>(&arg0.idle_a), 0x2::balance::value<T1>(&arg0.idle_b))
    }

    fun open_both_from_idle<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: vector<u32>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u32>, arg9: vector<u64>, arg10: vector<u64>, arg11: u32, arg12: &mut 0x2::tx_context::TxContext) : OpenSummary {
        assert!(!has_pair<T0, T1>(arg0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::pair_exists());
        let (v0, v1) = validate_dual<T0, T1>(arg0, arg1, &arg5, &arg6, &arg7, &arg8, &arg9, &arg10, arg11);
        assert_idle_after<T0, T1>(&arg0.policy, &arg0.idle_a, &arg0.idle_b, v0, v1);
        let (v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_position<T0, T1>(arg1, arg5, arg6, arg7, arg2, arg3, arg4, arg12);
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_cert_amounts<T0, T1>(&v4);
        assert!(v6 == 0 && v7 == v1, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::amount_sum());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_open_position<T0, T1>(arg1, &mut v5, v4, 0x2::balance::split<T0>(&mut arg0.idle_a, v6), 0x2::balance::split<T1>(&mut arg0.idle_b, v7), arg3);
        assert_position_range(&v5, &arg5);
        let (v8, v9) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_position<T0, T1>(arg1, arg8, arg9, arg10, arg2, arg3, arg4, arg12);
        let v10 = v9;
        let v11 = v8;
        let (v12, v13) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_cert_amounts<T0, T1>(&v10);
        assert!(v12 == v0 && v13 == 0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::amount_sum());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_open_position<T0, T1>(arg1, &mut v11, v10, 0x2::balance::split<T0>(&mut arg0.idle_a, v12), 0x2::balance::split<T1>(&mut arg0.idle_b, v13), arg3);
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

    public fun owner_claim_reward<T0, T1, T2>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert!(0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.rewards, v0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::reward_not_allowed());
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0);
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_reward_claimed(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.funding, v0, 0x2::balance::value<T2>(&v1), cumulative_reward<T0, T1>(arg0, v0), arg0.action_sequence, arg0.agent_generation, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v1, arg1), arg0.funding);
    }

    public fun owner_close_dual<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg5);
        assert_bindings<T0, T1>(arg0, arg1, arg2, arg3);
        assert_pair_state<T0, T1>(arg0);
        assert!(has_pair<T0, T1>(arg0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::missing_pair());
        assert!(arg0.owner_collection.owner_fee_collected && 0x1::vector::length<0x1::type_name::TypeName>(&arg0.owner_collection.owner_reward_order) == 0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.reward_types), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::duplicate_action());
        assert_current_owner_collection<T0, T1>(arg0);
        let v0 = close_both_to_idle<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        arg0.action_sequence = arg0.action_sequence + 1;
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_owner_dual_closed(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, v0.below_id, v0.above_id, v0.below_lower_bits, v0.below_upper_bits, v0.above_lower_bits, v0.above_upper_bits, v0.below_principal_a, v0.below_principal_b, v0.above_principal_a, v0.above_principal_b, arg0.owner_collection.owner_below_fee_a, arg0.owner_collection.owner_below_fee_b, arg0.owner_collection.owner_above_fee_a, arg0.owner_collection.owner_above_fee_b, v0.below_closing_fee_a, v0.below_closing_fee_b, v0.above_closing_fee_a, v0.above_closing_fee_b, arg0.owner_collection.owner_reward_order, arg0.owner_collection.owner_below_reward_amounts, arg0.owner_collection.owner_above_reward_amounts, 0x2::balance::value<T0>(&arg0.idle_a), 0x2::balance::value<T1>(&arg0.idle_b), arg0.action_sequence, arg0.agent_generation, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy), arg0.accounting.cumulative_principal_a, arg0.accounting.cumulative_principal_b, arg0.accounting.cumulative_fee_a, arg0.accounting.cumulative_fee_b, arg0.accounting.cumulative_closing_fee_a, arg0.accounting.cumulative_closing_fee_b);
        reset_owner_collection<T0, T1>(arg0);
        assert_pair_state<T0, T1>(arg0);
    }

    public fun owner_collect_dual_fee<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg5);
        assert_bindings<T0, T1>(arg0, arg1, arg2, arg3);
        assert_pair_state<T0, T1>(arg0);
        assert!(has_pair<T0, T1>(arg0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::missing_pair());
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
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_slot_fee_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 0, v1, arg0.action_sequence, v6, v7, arg0.accounting.cumulative_fee_a, arg0.accounting.cumulative_fee_b, arg0.agent_generation, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy));
        let v8 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position);
        let v9 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v8);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg1, v9, arg3, arg4);
        let (v10, v11) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg1, v8, arg2, arg3, arg5);
        let v12 = v11;
        let v13 = v10;
        let v14 = 0x2::balance::value<T0>(&v13);
        let v15 = 0x2::balance::value<T1>(&v12);
        record_fee<T0, T1>(arg0, v13, v12);
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_slot_fee_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 1, v9, arg0.action_sequence, v14, v15, arg0.accounting.cumulative_fee_a, arg0.accounting.cumulative_fee_b, arg0.agent_generation, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy));
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
        assert!(has_pair<T0, T1>(arg0) && arg0.owner_collection.owner_fee_collected, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::missing_pair());
        assert_current_owner_collection<T0, T1>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert_reward_registered<T0, T1>(arg0, &v0);
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.owner_collection.owner_collected_reward_types, &v0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::duplicate_reward());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.owner_collection.owner_collected_reward_types, v0);
        let v1 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position);
        let v2 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v1);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg1, v2, arg3, arg4);
        let v3 = put_reward<T0, T1, T2>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg1, v1, arg2, arg3, arg5));
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 0, v2, arg0.action_sequence, v0, v3, cumulative_reward<T0, T1>(arg0, v0), arg0.agent_generation, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy));
        let v4 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position);
        let v5 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v4);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg1, v5, arg3, arg4);
        let v6 = put_reward<T0, T1, T2>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg1, v4, arg2, arg3, arg5));
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_slot_reward_collected(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, 1, v5, arg0.action_sequence, v0, v6, cumulative_reward<T0, T1>(arg0, v0), arg0.agent_generation, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy));
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.owner_collection.owner_reward_order, v0);
        0x1::vector::push_back<u64>(&mut arg0.owner_collection.owner_below_reward_amounts, v3);
        0x1::vector::push_back<u64>(&mut arg0.owner_collection.owner_above_reward_amounts, v6);
    }

    public fun owner_emergency_recover<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg1);
        assert_pair_state<T0, T1>(arg0);
        assert!(0x2::bag::is_empty(&arg0.rewards), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::reward_balance_not_empty());
        arg0.paused = true;
        arg0.agent_generation = arg0.agent_generation + 1;
        arg0.action_sequence = arg0.action_sequence + 1;
        let v0 = if (0x1::option::is_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.below_position)) {
            let v1 = 0x1::option::extract<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.below_position);
            0x2::transfer::public_transfer<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v1, arg0.funding);
            0x1::option::some<0x2::object::ID>(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v1))
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        let v2 = if (0x1::option::is_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.above_position)) {
            let v3 = 0x1::option::extract<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.above_position);
            0x2::transfer::public_transfer<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v3, arg0.funding);
            0x1::option::some<0x2::object::ID>(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v3))
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        arg0.current_deployed_a = 0;
        arg0.current_deployed_b = 0;
        let v4 = 0x2::balance::value<T0>(&arg0.idle_a);
        let v5 = 0x2::balance::value<T1>(&arg0.idle_b);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.idle_a), arg1), arg0.funding);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.idle_b), arg1), arg0.funding);
        reset_owner_collection<T0, T1>(arg0);
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_emergency_recovered(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, arg0.owner, arg0.funding, v0, v2, v4, v5, arg0.action_sequence, arg0.agent_generation, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy));
        assert_pair_state<T0, T1>(arg0);
    }

    public fun owner_open_dual<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: vector<u32>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u32>, arg9: vector<u64>, arg10: vector<u64>, arg11: u32, arg12: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg12);
        assert_bindings<T0, T1>(arg0, arg1, arg2, arg3);
        assert_pair_state<T0, T1>(arg0);
        assert!(!has_pair<T0, T1>(arg0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::pair_exists());
        let v0 = open_both_from_idle<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        arg0.action_sequence = arg0.action_sequence + 1;
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_owner_dual_opened(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, v0.below_id, v0.above_id, arg5, arg6, arg7, arg8, arg9, arg10, v0.deployed_b, v0.deployed_a, 0x2::balance::value<T0>(&arg0.idle_a), 0x2::balance::value<T1>(&arg0.idle_b), arg0.action_sequence, arg0.agent_generation, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy), arg0.accounting.cumulative_deployed_a, arg0.accounting.cumulative_deployed_b);
    }

    public fun owner_pause<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg1);
        arg0.paused = true;
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::set_phase(&mut arg0.policy, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::paused_phase());
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_policy_updated(0x2::object::id<MakerVault<T0, T1>>(arg0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::paused_phase(), true, arg0.action_sequence, arg0.agent_generation);
    }

    public fun owner_register_reward<T0, T1, T2>(arg0: &mut MakerVault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_types, &v0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::duplicate_reward());
        assert!(0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.reward_types) < (0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::max_reward_types(&arg0.policy) as u64), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::too_many_rewards());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.reward_types, v0);
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_reward_registered(0x2::object::id<MakerVault<T0, T1>>(arg0), v0, arg0.action_sequence, arg0.agent_generation, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy));
    }

    public fun owner_rotate_agent<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg2);
        let v0 = if (arg1 != arg0.owner) {
            if (arg1 != arg0.funding) {
                arg1 != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::not_agent());
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
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_agent_rotated(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, arg0.agent, arg1, arg0.agent_generation, v2, arg0.action_sequence, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy));
        0x2::transfer::transfer<AgentCap<T0, T1>>(v3, arg1);
    }

    public fun owner_set_phase<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg2);
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::set_phase(&mut arg0.policy, arg1);
        arg0.paused = arg1 == 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::paused_phase();
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_policy_updated(0x2::object::id<MakerVault<T0, T1>>(arg0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy), arg1, arg0.paused, arg0.action_sequence, arg0.agent_generation);
    }

    public fun owner_set_policy<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::Policy, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg2);
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::replace(&mut arg0.policy, arg1);
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_policy_updated(0x2::object::id<MakerVault<T0, T1>>(arg0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::phase(&arg0.policy), arg0.paused, arg0.action_sequence, arg0.agent_generation);
    }

    public fun owner_withdraw_a<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg2);
        assert_pair_state<T0, T1>(arg0);
        assert!(arg1 > 0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::zero_amount());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.idle_a, arg1), arg2), arg0.funding);
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_owner_withdrawal(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.funding, 0, arg1, 0x2::balance::value<T0>(&arg0.idle_a), 0x2::balance::value<T1>(&arg0.idle_b), arg0.action_sequence, arg0.agent_generation, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy));
    }

    public fun owner_withdraw_b<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg2);
        assert_pair_state<T0, T1>(arg0);
        assert!(arg1 > 0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::zero_amount());
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.idle_b, arg1), arg2), arg0.funding);
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_owner_withdrawal(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.funding, 1, arg1, 0x2::balance::value<T0>(&arg0.idle_a), 0x2::balance::value<T1>(&arg0.idle_b), arg0.action_sequence, arg0.agent_generation, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy));
    }

    public fun policy_version<T0, T1>(arg0: &MakerVault<T0, T1>) : u64 {
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy)
    }

    public fun pool_id<T0, T1>(arg0: &MakerVault<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
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

    fun rebalance_inventory<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::tx_context::TxContext) : SwapSummary {
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::assert_swap_input(&arg0.policy, arg7, arg10);
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg1));
        let v1 = arg5 + 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::min_idle_a(&arg0.policy);
        let v2 = arg6 + 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::min_idle_b(&arg0.policy);
        let (v3, v4) = validate_swap_deficits(0x2::balance::value<T0>(&arg0.idle_a), 0x2::balance::value<T1>(&arg0.idle_b), v1, v2, arg7, arg8, arg9, arg10);
        let (v5, v6) = if (v3 == 0 && v4 == 0) {
            let v7 = if (arg7 == 0) {
                if (arg8 == 0) {
                    if (arg9 == 0) {
                        arg10 == 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v7, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_swap_intent());
            (0, 0)
        } else if (v4 > 0) {
            assert!(arg7 == 1 && arg8 == v4, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_swap_intent());
            let (v8, v9, v10) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg1, true, false, arg8, arg2, arg3, arg4, arg11);
            let v11 = v10;
            let v12 = v9;
            let v13 = v8;
            assert!(0x2::balance::value<T0>(&v13) == 0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::swap_output_bounds());
            0x2::balance::destroy_zero<T0>(v13);
            let v14 = 0x2::balance::value<T1>(&v12);
            let v15 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v11);
            assert!(v14 == arg8, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::swap_output_bounds());
            0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::assert_swap_input(&arg0.policy, arg7, v15);
            assert!(v15 <= arg10 && v15 <= 0x2::balance::value<T0>(&arg0.idle_a), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::swap_input_limit());
            assert!(0x2::balance::value<T0>(&arg0.idle_a) - v15 >= v1, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::idle_floor());
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg1, 0x2::balance::split<T0>(&mut arg0.idle_a, v15), 0x2::balance::zero<T1>(), v11, arg3);
            0x2::balance::join<T1>(&mut arg0.idle_b, v12);
            arg0.accounting.cumulative_swap_input_a = arg0.accounting.cumulative_swap_input_a + (v15 as u128);
            arg0.accounting.cumulative_swap_output_b = arg0.accounting.cumulative_swap_output_b + (v14 as u128);
            (v15, v14)
        } else {
            assert!(arg7 == 2 && arg8 == v3, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_swap_intent());
            let (v16, v17, v18) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg1, false, false, arg8, arg2, arg3, arg4, arg11);
            let v19 = v18;
            let v20 = v17;
            let v21 = v16;
            assert!(0x2::balance::value<T1>(&v20) == 0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::swap_output_bounds());
            0x2::balance::destroy_zero<T1>(v20);
            let v22 = 0x2::balance::value<T0>(&v21);
            let v23 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T0, T1>(&v19);
            assert!(v22 == arg8, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::swap_output_bounds());
            0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::assert_swap_input(&arg0.policy, arg7, v23);
            assert!(v23 <= arg10 && v23 <= 0x2::balance::value<T1>(&arg0.idle_b), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::swap_input_limit());
            assert!(0x2::balance::value<T1>(&arg0.idle_b) - v23 >= v2, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::idle_floor());
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg0.idle_b, v23), v19, arg3);
            0x2::balance::join<T0>(&mut arg0.idle_a, v21);
            arg0.accounting.cumulative_swap_input_b = arg0.accounting.cumulative_swap_input_b + (v23 as u128);
            arg0.accounting.cumulative_swap_output_a = arg0.accounting.cumulative_swap_output_a + (v22 as u128);
            (v23, v22)
        };
        let v24 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg1));
        assert_active_unchanged(v0, v24);
        0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::events::emit_inventory_rebalanced(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, arg0.action_sequence, arg0.agent_generation, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::version(&arg0.policy), arg7, arg8, arg9, arg10, v6, v5, v0, v24, 0x2::balance::value<T0>(&arg0.idle_a), 0x2::balance::value<T1>(&arg0.idle_b), arg0.accounting.cumulative_swap_input_a, arg0.accounting.cumulative_swap_input_b, arg0.accounting.cumulative_swap_output_a, arg0.accounting.cumulative_swap_output_b);
        SwapSummary{
            direction        : arg7,
            min_output       : arg8,
            max_output       : arg9,
            max_input        : arg10,
            actual_output    : v6,
            actual_input     : v5,
            pre_active_bits  : v0,
            post_active_bits : v24,
        }
    }

    fun record_fee<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        arg0.accounting.cumulative_fee_a = arg0.accounting.cumulative_fee_a + (0x2::balance::value<T0>(&arg1) as u128);
        arg0.accounting.cumulative_fee_b = arg0.accounting.cumulative_fee_b + (0x2::balance::value<T1>(&arg2) as u128);
        0x2::balance::join<T0>(&mut arg0.idle_a, arg1);
        0x2::balance::join<T1>(&mut arg0.idle_b, arg2);
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

    public(friend) fun validate_authority_fields(arg0: address, arg1: address, arg2: address, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: u64, arg10: u64) {
        assert!(arg0 == arg1 && arg2 == arg1, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::not_agent());
        let v0 = if (arg3 == arg4) {
            if (arg5 == arg6) {
                arg7 == arg8
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_cap());
        assert!(arg9 == arg10, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_generation());
    }

    fun validate_bin(arg0: &0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::Policy, arg1: u32, arg2: u32) {
        assert!(signed_gte(arg1, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::min_bin_bits(arg0)) && signed_gte(0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::max_bin_bits(arg0), arg1), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bin_range());
        assert!(signed_distance(arg1, arg2) <= (0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::max_distance_from_active(arg0) as u64), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bin_range());
        assert!(arg1 != arg2, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::active_bin());
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
        assert!(v0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::wrong_binding());
    }

    fun validate_dual<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &vector<u32>, arg3: &vector<u64>, arg4: &vector<u64>, arg5: &vector<u32>, arg6: &vector<u64>, arg7: &vector<u64>, arg8: u32) : (u64, u64) {
        validate_dual_at(&arg0.policy, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg1)))
    }

    public(friend) fun validate_dual_at(arg0: &0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::Policy, arg1: &vector<u32>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u32>, arg5: &vector<u64>, arg6: &vector<u64>, arg7: u32, arg8: u32) : (u64, u64) {
        let v0 = 0x1::vector::length<u32>(arg1);
        let v1 = 0x1::vector::length<u32>(arg4);
        assert!(v0 > 0 && v1 > 0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::missing_pair());
        assert!(v0 == 0x1::vector::length<u64>(arg2) && v0 == 0x1::vector::length<u64>(arg3), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::vector_length());
        assert!(v1 == 0x1::vector::length<u64>(arg5) && v1 == 0x1::vector::length<u64>(arg6), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::vector_length());
        assert!(v0 + v1 <= (0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::max_total_bins(arg0) as u64), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::vector_length());
        assert!(signed_distance(arg8, arg7) <= (0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::max_active_drift(arg0) as u64), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::active_drift());
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v2 < v0) {
            let v5 = *0x1::vector::borrow<u32>(arg1, v2);
            let v6 = *0x1::vector::borrow<u64>(arg3, v2);
            assert!(*0x1::vector::borrow<u64>(arg2, v2) == 0 && v6 > 0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::wrong_side());
            assert!(signed_lt(v5, arg7) && signed_lt(v5, arg8), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::active_bin());
            validate_bin(arg0, v5, arg8);
            assert!(v5 != arg7, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::active_bin());
            if (v2 > 0) {
                assert!(signed_contiguous(*0x1::vector::borrow<u32>(arg1, v2 - 1), v5), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::noncontiguous());
            };
            v4 = v4 + v6;
            v2 = v2 + 1;
        };
        v2 = 0;
        while (v2 < v1) {
            let v7 = *0x1::vector::borrow<u32>(arg4, v2);
            let v8 = *0x1::vector::borrow<u64>(arg5, v2);
            assert!(v8 > 0 && *0x1::vector::borrow<u64>(arg6, v2) == 0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::wrong_side());
            assert!(signed_lt(arg7, v7) && signed_lt(arg8, v7), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::active_bin());
            validate_bin(arg0, v7, arg8);
            assert!(v7 != arg7, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::active_bin());
            if (v2 > 0) {
                assert!(signed_contiguous(*0x1::vector::borrow<u32>(arg4, v2 - 1), v7), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::noncontiguous());
            };
            v3 = v3 + v8;
            v2 = v2 + 1;
        };
        assert!(v3 <= 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::max_deploy_a(arg0) && v4 <= 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::policy::max_deploy_b(arg0), 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::amount_limit());
        (v3, v4)
    }

    public(friend) fun validate_role_addresses(arg0: address, arg1: address, arg2: address) {
        let v0 = if (arg0 != @0x0) {
            if (arg1 != @0x0) {
                arg2 != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::not_funding());
        let v1 = if (arg0 != arg1) {
            if (arg0 != arg2) {
                arg1 != arg2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::not_funding());
    }

    public(friend) fun validate_swap_deficits(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64) : (u64, u64) {
        assert_valid_swap_seal(arg4, arg5, arg6, arg7);
        let v0 = if (arg0 < arg2) {
            arg2 - arg0
        } else {
            0
        };
        let v1 = if (arg1 < arg3) {
            arg3 - arg1
        } else {
            0
        };
        assert!(v0 == 0 || v1 == 0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::dual_deficit());
        if (v0 == 0 && v1 == 0) {
            assert!(arg4 == 0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_swap_intent());
        } else if (v1 > 0) {
            assert!(arg4 == 1 && arg5 == v1, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_swap_intent());
        } else {
            assert!(arg4 == 2 && arg5 == v0, 0x3010442c11264571563b6e6cbc451cde7472ebe5bace72e97f17a4c95a314e09::errors::bad_swap_intent());
        };
        (v0, v1)
    }

    // decompiled from Move bytecode v7
}

