module 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::vault {
    struct AgentCap<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        agent: address,
        generation: u64,
    }

    struct MakerVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        schema_version: u64,
        owner: address,
        agent: address,
        agent_cap_id: 0x2::object::ID,
        agent_generation: u64,
        pool_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        versioned_id: 0x2::object::ID,
        expected_protocol_version: u64,
        expected_bin_step: u16,
        policy: 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::Policy,
        action_sequence: u64,
        last_action_ms: u64,
        paused: bool,
        position_generation: u64,
        position: 0x1::option::Option<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>,
        idle_a: 0x2::balance::Balance<T0>,
        idle_b: 0x2::balance::Balance<T1>,
        cumulative_fee_a: u128,
        cumulative_fee_b: u128,
        reward_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        rewards: 0x2::bag::Bag,
    }

    struct ExitCommitment has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        generation: u64,
        position_id: 0x2::object::ID,
        sequence: u64,
        policy_version: u64,
        deadline_ms: u64,
        planned_active_bits: u32,
        collect_fee: bool,
        reward_list_hash: vector<u8>,
    }

    struct PlanCommitment has copy, drop, store {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        generation: u64,
        position_id: 0x2::object::ID,
        sequence: u64,
        policy_version: u64,
        deadline_ms: u64,
        planned_active_bits: u32,
        remove_percent_bps: u16,
        collect_fee: bool,
        reward_list_hash: vector<u8>,
        bin_ids: vector<u32>,
        amounts_a: vector<u64>,
        amounts_b: vector<u64>,
    }

    struct ActionTicket<phantom T0, phantom T1> {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        generation: u64,
        sequence: u64,
        policy_version: u64,
        position_id: 0x2::object::ID,
        planned_active_bits: u32,
        observed_active_bits: u32,
        deadline_ms: u64,
        intent_hash: vector<u8>,
        fee_a: u64,
        fee_b: u64,
        reward_count: u8,
        fee_collected: bool,
        collected_reward_types: vector<0x1::type_name::TypeName>,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        versioned_id: 0x2::object::ID,
        owner: address,
        agent: address,
        cap_id: 0x2::object::ID,
        protocol_version: u64,
        bin_step: u16,
    }

    struct AgentRotated has copy, drop {
        vault_id: 0x2::object::ID,
        old_agent: address,
        new_agent: address,
        generation: u64,
        cap_id: 0x2::object::ID,
    }

    struct PolicyUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        version: u64,
        phase: u8,
        paused: bool,
    }

    struct OwnerDeposit has copy, drop {
        vault_id: 0x2::object::ID,
        side: u8,
        amount: u64,
        idle_a: u64,
        idle_b: u64,
    }

    struct OwnerWithdrawal has copy, drop {
        vault_id: 0x2::object::ID,
        side: u8,
        amount: u64,
        idle_a: u64,
        idle_b: u64,
    }

    struct PositionBound has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        generation: u64,
        source: u8,
    }

    struct OwnerPositionClosed has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        principal_a: u64,
        principal_b: u64,
        fee_a: u64,
        fee_b: u64,
    }

    struct RewardClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct RewardRegistered has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
    }

    struct FeeCollected has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sequence: u64,
        fee_a: u64,
        fee_b: u64,
        cumulative_fee_a: u128,
        cumulative_fee_b: u128,
    }

    struct RewardCollected has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sequence: u64,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct MakerRebalanced has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        source_position_id: 0x2::object::ID,
        target_position_id: 0x2::object::ID,
        sequence: u64,
        generation: u64,
        policy_version: u64,
        intent_hash: vector<u8>,
        planned_active_bits: u32,
        observed_active_bits: u32,
        remove_lower_bits: u32,
        remove_upper_bits: u32,
        removed_a: u64,
        removed_b: u64,
        fee_a: u64,
        fee_b: u64,
        added_a: u64,
        added_b: u64,
        idle_a: u64,
        idle_b: u64,
        bin_ids: vector<u32>,
        amounts_a: vector<u64>,
        amounts_b: vector<u64>,
        timestamp_ms: u64,
    }

    struct MakerExited has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sequence: u64,
        intent_hash: vector<u8>,
        removed_a: u64,
        removed_b: u64,
        fee_a: u64,
        fee_b: u64,
        idle_a: u64,
        idle_b: u64,
        timestamp_ms: u64,
    }

    struct EmergencyRecovered has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        position_id: 0x1::option::Option<0x2::object::ID>,
        amount_a: u64,
        amount_b: u64,
        generation: u64,
    }

    public fun agent<T0, T1>(arg0: &MakerVault<T0, T1>) : address {
        arg0.agent
    }

    fun assert_agent<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &AgentCap<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.agent && arg1.agent == arg0.agent, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::not_keeper());
        let v0 = if (0x2::object::id<AgentCap<T0, T1>>(arg1) == arg0.agent_cap_id) {
            if (arg1.vault_id == 0x2::object::id<MakerVault<T0, T1>>(arg0)) {
                arg1.pool_id == arg0.pool_id
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_cap());
        assert!(arg1.generation == arg0.agent_generation, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_generation());
    }

    fun assert_bindings<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned) {
        let v0 = if (0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1) == arg0.pool_id) {
            if (0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig>(arg2) == arg0.config_id) {
                0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned>(arg3) == arg0.versioned_id
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::wrong_binding());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg3);
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::version(arg3) == arg0.expected_protocol_version, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_version());
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_step<T0, T1>(arg1) == arg0.expected_bin_step, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_bin_step());
    }

    fun assert_idle_after<T0, T1>(arg0: &0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::Policy, arg1: &0x2::balance::Balance<T0>, arg2: &0x2::balance::Balance<T1>, arg3: u64, arg4: u64) {
        let v0 = 0x2::balance::value<T0>(arg1);
        let v1 = 0x2::balance::value<T1>(arg2);
        assert!(arg3 <= v0 && arg4 <= v1, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::amount_limit());
        assert!(v0 - arg3 >= 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::min_idle_a(arg0) && v1 - arg4 >= 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::min_idle_b(arg0), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::idle_floor());
    }

    fun assert_owner<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::not_owner());
    }

    fun assert_ticket<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &ActionTicket<T0, T1>) {
        assert!(arg1.vault_id == 0x2::object::id<MakerVault<T0, T1>>(arg0) && arg1.cap_id == arg0.agent_cap_id, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_cap());
        assert!(arg1.generation == arg0.agent_generation, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_generation());
        assert!(arg1.sequence == arg0.action_sequence, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_sequence());
        assert!(arg1.policy_version == 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::version(&arg0.policy), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_policy_version());
    }

    public fun begin_action<T0, T1>(arg0: &MakerVault<T0, T1>, arg1: &AgentCap<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: u64, arg7: u64, arg8: u32, arg9: u64, arg10: vector<u8>, arg11: &0x2::tx_context::TxContext) : ActionTicket<T0, T1> {
        assert_agent<T0, T1>(arg0, arg1, arg11);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        assert!(arg0.schema_version == 1, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_schema());
        assert!(0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::version(&arg0.policy) == arg6, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_policy_version());
        assert!(arg0.action_sequence == arg7, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_sequence());
        assert!(0x1::vector::length<u8>(&arg10) == 32, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_intent_hash());
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg9 >= v0 && arg9 - v0 <= 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::max_plan_ttl_ms(&arg0.policy), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::deadline());
        0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::assert_action(&arg0.policy, v0, arg0.last_action_ms, arg0.paused);
        assert!(0x1::option::is_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.position), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::no_position());
        let v1 = 0x1::option::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.position);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg2));
        assert!(signed_distance(v2, arg8) <= (0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::max_active_drift(&arg0.policy) as u64), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::active_drift());
        ActionTicket<T0, T1>{
            vault_id               : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            cap_id                 : 0x2::object::id<AgentCap<T0, T1>>(arg1),
            generation             : arg0.agent_generation,
            sequence               : arg0.action_sequence,
            policy_version         : arg6,
            position_id            : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v1),
            planned_active_bits    : arg8,
            observed_active_bits   : v2,
            deadline_ms            : arg9,
            intent_hash            : arg10,
            fee_a                  : 0,
            fee_b                  : 0,
            reward_count           : 0,
            fee_collected          : false,
            collected_reward_types : 0x1::vector::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun collect_fee_in_action<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut ActionTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        assert!(0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::allow_harvest(&arg0.policy), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_phase());
        assert!(!arg1.fee_collected, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::fee_already_collected());
        let v0 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v0), arg4, arg5);
        let (v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg2, v0, arg3, arg4, arg6);
        let v3 = v2;
        let v4 = v1;
        arg1.fee_a = 0x2::balance::value<T0>(&v4);
        arg1.fee_b = 0x2::balance::value<T1>(&v3);
        arg1.fee_collected = true;
        arg0.cumulative_fee_a = arg0.cumulative_fee_a + (arg1.fee_a as u128);
        arg0.cumulative_fee_b = arg0.cumulative_fee_b + (arg1.fee_b as u128);
        0x2::balance::join<T0>(&mut arg0.idle_a, v4);
        0x2::balance::join<T1>(&mut arg0.idle_b, v3);
        let v5 = FeeCollected{
            vault_id         : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            position_id      : arg1.position_id,
            sequence         : arg1.sequence,
            fee_a            : arg1.fee_a,
            fee_b            : arg1.fee_b,
            cumulative_fee_a : arg0.cumulative_fee_a,
            cumulative_fee_b : arg0.cumulative_fee_b,
        };
        0x2::event::emit<FeeCollected>(v5);
    }

    public fun collect_reward_in_action<T0, T1, T2>(arg0: &mut MakerVault<T0, T1>, arg1: &mut ActionTicket<T0, T1>, arg2: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_ticket<T0, T1>(arg0, arg1);
        assert_bindings<T0, T1>(arg0, arg2, arg3, arg4);
        assert!(0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::allow_harvest(&arg0.policy), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_phase());
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_types, &v0), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::reward_not_allowed());
        assert!(arg1.reward_count < 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::max_reward_types(&arg0.policy), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::too_many_rewards());
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.collected_reward_types, &v0), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::reward_not_allowed());
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.collected_reward_types, v0);
        let v1 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg2, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v1), arg4, arg5);
        let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg2, v1, arg3, arg4, arg6);
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.rewards, v0)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0), v2);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0, v2);
        };
        arg1.reward_count = arg1.reward_count + 1;
        let v3 = RewardCollected{
            vault_id    : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            position_id : arg1.position_id,
            sequence    : arg1.sequence,
            reward_type : v0,
            amount      : 0x2::balance::value<T2>(&v2),
        };
        0x2::event::emit<RewardCollected>(v3);
    }

    public fun create_vault<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: address, arg5: u64, arg6: u16, arg7: 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::Policy, arg8: &mut 0x2::tx_context::TxContext) {
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::check_version(arg2);
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::version(arg2) == arg5, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_version());
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_step<T0, T1>(arg0) == arg6, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_bin_step());
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(arg4 != v0 && arg4 != @0x0, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::not_keeper());
        0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::assert_creation(&arg7, 0x2::clock::timestamp_ms(arg3));
        let v1 = 0x2::object::new(arg8);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::object::new(arg8);
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
        let v9 = MakerVault<T0, T1>{
            id                        : v1,
            schema_version            : 1,
            owner                     : v0,
            agent                     : arg4,
            agent_cap_id              : v4,
            agent_generation          : 1,
            pool_id                   : v5,
            config_id                 : v6,
            versioned_id              : v7,
            expected_protocol_version : arg5,
            expected_bin_step         : arg6,
            policy                    : arg7,
            action_sequence           : 0,
            last_action_ms            : 0,
            paused                    : false,
            position_generation       : 0,
            position                  : 0x1::option::none<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(),
            idle_a                    : 0x2::balance::zero<T0>(),
            idle_b                    : 0x2::balance::zero<T1>(),
            cumulative_fee_a          : 0,
            cumulative_fee_b          : 0,
            reward_types              : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            rewards                   : 0x2::bag::new(arg8),
        };
        let v10 = VaultCreated{
            vault_id         : v2,
            pool_id          : v5,
            config_id        : v6,
            versioned_id     : v7,
            owner            : v0,
            agent            : arg4,
            cap_id           : v4,
            protocol_version : arg5,
            bin_step         : arg6,
        };
        0x2::event::emit<VaultCreated>(v10);
        0x2::transfer::share_object<MakerVault<T0, T1>>(v9);
        0x2::transfer::transfer<AgentCap<T0, T1>>(v8, arg4);
    }

    public fun cumulative_fees<T0, T1>(arg0: &MakerVault<T0, T1>) : (u128, u128) {
        (arg0.cumulative_fee_a, arg0.cumulative_fee_b)
    }

    public fun exit_hash(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u32, arg9: bool, arg10: vector<u8>) : vector<u8> {
        let v0 = ExitCommitment{
            vault_id            : arg0,
            pool_id             : arg1,
            cap_id              : arg2,
            generation          : arg3,
            position_id         : arg4,
            sequence            : arg5,
            policy_version      : arg6,
            deadline_ms         : arg7,
            planned_active_bits : arg8,
            collect_fee         : arg9,
            reward_list_hash    : arg10,
        };
        let v1 = 0x2::bcs::to_bytes<ExitCommitment>(&v0);
        0x2::hash::blake2b256(&v1)
    }

    public fun finish_exit_to_idle<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &AgentCap<T0, T1>, arg2: ActionTicket<T0, T1>, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_agent<T0, T1>(arg0, arg1, arg7);
        assert_ticket<T0, T1>(arg0, &arg2);
        assert_bindings<T0, T1>(arg0, arg3, arg4, arg5);
        assert!(0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::allow_exit_to_idle(&arg0.policy), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::exit_disabled());
        assert!(arg2.fee_collected && 0x1::vector::length<0x1::type_name::TypeName>(&arg2.collected_reward_types) == (arg2.reward_count as u64), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_intent_hash());
        assert!(arg2.intent_hash == exit_hash(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, arg2.cap_id, arg2.generation, arg2.position_id, arg2.sequence, arg2.policy_version, arg2.deadline_ms, arg2.planned_active_bits, true, reward_list_hash(&arg2.collected_reward_types)), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_intent_hash());
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 <= arg2.deadline_ms, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::deadline());
        let v1 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position);
        let (v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::remove_liquidity_by_percent<T0, T1>(arg3, v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::lower_bin_id(v1)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::upper_bin_id(v1)), 10000, arg4, arg5, arg6, arg7);
        let v4 = v3;
        let v5 = v2;
        0x2::balance::join<T0>(&mut arg0.idle_a, v5);
        0x2::balance::join<T1>(&mut arg0.idle_b, v4);
        arg0.action_sequence = arg0.action_sequence + 1;
        arg0.last_action_ms = v0;
        0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::consume_action(&mut arg0.policy);
        let ActionTicket {
            vault_id               : _,
            cap_id                 : _,
            generation             : _,
            sequence               : _,
            policy_version         : _,
            position_id            : _,
            planned_active_bits    : _,
            observed_active_bits   : _,
            deadline_ms            : _,
            intent_hash            : _,
            fee_a                  : _,
            fee_b                  : _,
            reward_count           : _,
            fee_collected          : _,
            collected_reward_types : _,
        } = arg2;
        let v21 = MakerExited{
            vault_id     : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            pool_id      : arg0.pool_id,
            position_id  : arg2.position_id,
            sequence     : arg2.sequence,
            intent_hash  : arg2.intent_hash,
            removed_a    : 0x2::balance::value<T0>(&v5),
            removed_b    : 0x2::balance::value<T1>(&v4),
            fee_a        : arg2.fee_a,
            fee_b        : arg2.fee_b,
            idle_a       : 0x2::balance::value<T0>(&arg0.idle_a),
            idle_b       : 0x2::balance::value<T1>(&arg0.idle_b),
            timestamp_ms : v0,
        };
        0x2::event::emit<MakerExited>(v21);
    }

    public fun finish_rebalance<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &AgentCap<T0, T1>, arg2: ActionTicket<T0, T1>, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg5: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: u16, arg8: vector<u32>, arg9: vector<u64>, arg10: vector<u64>, arg11: &mut 0x2::tx_context::TxContext) {
        assert_agent<T0, T1>(arg0, arg1, arg11);
        assert_ticket<T0, T1>(arg0, &arg2);
        assert_bindings<T0, T1>(arg0, arg3, arg4, arg5);
        assert!(0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::allow_rebalance(&arg0.policy), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_phase());
        assert!(arg7 == 10000, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_percent());
        assert!(arg2.fee_collected && 0x1::vector::length<0x1::type_name::TypeName>(&arg2.collected_reward_types) == (arg2.reward_count as u64), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_intent_hash());
        assert!(arg2.intent_hash == plan_hash(0x2::object::id<MakerVault<T0, T1>>(arg0), arg0.pool_id, arg2.cap_id, arg2.generation, arg2.position_id, arg2.sequence, arg2.policy_version, arg2.deadline_ms, arg2.planned_active_bits, arg7, true, reward_list_hash(&arg2.collected_reward_types), arg8, arg9, arg10), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bad_intent_hash());
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 <= arg2.deadline_ms, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::deadline());
        assert!(signed_distance(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg3)), arg2.planned_active_bits) <= (0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::max_active_drift(&arg0.policy) as u64), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::active_drift());
        let v1 = 0x1::option::extract<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position);
        let v2 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v1);
        assert!(v2 == arg2.position_id, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::position_mismatch());
        let (v3, v4, v5, v6, v7) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::close_position_with_fee<T0, T1>(arg3, v1, arg4, arg5, arg6, arg11);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        let v12 = 0x2::balance::value<T0>(&v9);
        let v13 = 0x2::balance::value<T1>(&v8);
        0x2::balance::join<T0>(&mut arg0.idle_a, v11);
        0x2::balance::join<T1>(&mut arg0.idle_b, v10);
        0x2::balance::join<T0>(&mut arg0.idle_a, v9);
        0x2::balance::join<T1>(&mut arg0.idle_b, v8);
        arg0.cumulative_fee_a = arg0.cumulative_fee_a + (v12 as u128);
        arg0.cumulative_fee_b = arg0.cumulative_fee_b + (v13 as u128);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::destroy_close_position_cert(v3, arg5);
        let (v14, v15) = validate_plan<T0, T1>(&arg0.policy, arg3, &arg8, &arg9, &arg10, arg2.planned_active_bits);
        assert_idle_after<T0, T1>(&arg0.policy, &arg0.idle_a, &arg0.idle_b, v14, v15);
        let (v16, v17) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_position<T0, T1>(arg3, arg8, arg9, arg10, arg4, arg5, arg6, arg11);
        let v18 = v17;
        let v19 = v16;
        let (v20, v21) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_cert_amounts<T0, T1>(&v18);
        assert!(v20 == v14 && v21 == v15, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::amount_sum());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_open_position<T0, T1>(arg3, &mut v19, v18, 0x2::balance::split<T0>(&mut arg0.idle_a, v20), 0x2::balance::split<T1>(&mut arg0.idle_b, v21), arg5);
        0x1::option::fill<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position, v19);
        arg0.position_generation = arg0.position_generation + 1;
        arg0.action_sequence = arg0.action_sequence + 1;
        arg0.last_action_ms = v0;
        0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::consume_action(&mut arg0.policy);
        let ActionTicket {
            vault_id               : _,
            cap_id                 : _,
            generation             : _,
            sequence               : _,
            policy_version         : _,
            position_id            : _,
            planned_active_bits    : _,
            observed_active_bits   : _,
            deadline_ms            : _,
            intent_hash            : _,
            fee_a                  : _,
            fee_b                  : _,
            reward_count           : _,
            fee_collected          : _,
            collected_reward_types : _,
        } = arg2;
        let v37 = MakerRebalanced{
            vault_id             : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            pool_id              : arg0.pool_id,
            source_position_id   : v2,
            target_position_id   : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v19),
            sequence             : arg2.sequence,
            generation           : arg2.generation,
            policy_version       : arg2.policy_version,
            intent_hash          : arg2.intent_hash,
            planned_active_bits  : arg2.planned_active_bits,
            observed_active_bits : arg2.observed_active_bits,
            remove_lower_bits    : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::lower_bin_id(&v1)),
            remove_upper_bits    : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::upper_bin_id(&v1)),
            removed_a            : 0x2::balance::value<T0>(&v11),
            removed_b            : 0x2::balance::value<T1>(&v10),
            fee_a                : arg2.fee_a + v12,
            fee_b                : arg2.fee_b + v13,
            added_a              : v20,
            added_b              : v21,
            idle_a               : 0x2::balance::value<T0>(&arg0.idle_a),
            idle_b               : 0x2::balance::value<T1>(&arg0.idle_b),
            bin_ids              : arg8,
            amounts_a            : arg9,
            amounts_b            : arg10,
            timestamp_ms         : v0,
        };
        0x2::event::emit<MakerRebalanced>(v37);
    }

    public fun has_position<T0, T1>(arg0: &MakerVault<T0, T1>) : bool {
        0x1::option::is_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.position)
    }

    public fun idle_balances<T0, T1>(arg0: &MakerVault<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.idle_a), 0x2::balance::value<T1>(&arg0.idle_b))
    }

    public fun owner<T0, T1>(arg0: &MakerVault<T0, T1>) : address {
        arg0.owner
    }

    public fun owner_claim_reward<T0, T1, T2>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert!(0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.rewards, v0), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::reward_not_allowed());
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0);
        let v2 = RewardClaimed{
            vault_id    : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            reward_type : v0,
            amount      : 0x2::balance::value<T2>(&v1),
        };
        0x2::event::emit<RewardClaimed>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v1, arg1), arg0.owner);
    }

    public fun owner_close_position<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg5);
        assert_bindings<T0, T1>(arg0, arg1, arg2, arg3);
        assert!(0x1::option::is_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.position), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::no_position());
        let v0 = 0x1::option::extract<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position);
        let (v1, v2, v3, v4, v5) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::close_position_with_fee<T0, T1>(arg1, v0, arg2, arg3, arg4, arg5);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = v2;
        let v10 = 0x2::balance::value<T0>(&v7);
        let v11 = 0x2::balance::value<T1>(&v6);
        0x2::balance::join<T0>(&mut arg0.idle_a, v9);
        0x2::balance::join<T1>(&mut arg0.idle_b, v8);
        0x2::balance::join<T0>(&mut arg0.idle_a, v7);
        0x2::balance::join<T1>(&mut arg0.idle_b, v6);
        arg0.cumulative_fee_a = arg0.cumulative_fee_a + (v10 as u128);
        arg0.cumulative_fee_b = arg0.cumulative_fee_b + (v11 as u128);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::destroy_close_position_cert(v1, arg3);
        let v12 = OwnerPositionClosed{
            vault_id    : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            pool_id     : arg0.pool_id,
            position_id : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v0),
            principal_a : 0x2::balance::value<T0>(&v9),
            principal_b : 0x2::balance::value<T1>(&v8),
            fee_a       : v10,
            fee_b       : v11,
        };
        0x2::event::emit<OwnerPositionClosed>(v12);
    }

    public fun owner_collect_position_fee<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg5);
        assert_bindings<T0, T1>(arg0, arg1, arg2, arg3);
        let v0 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg1, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v0), arg3, arg4);
        let (v1, v2) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_fee<T0, T1>(arg1, v0, arg2, arg3, arg5);
        let v3 = v2;
        let v4 = v1;
        arg0.cumulative_fee_a = arg0.cumulative_fee_a + (0x2::balance::value<T0>(&v4) as u128);
        arg0.cumulative_fee_b = arg0.cumulative_fee_b + (0x2::balance::value<T1>(&v3) as u128);
        0x2::balance::join<T0>(&mut arg0.idle_a, v4);
        0x2::balance::join<T1>(&mut arg0.idle_b, v3);
    }

    public fun owner_collect_position_reward<T0, T1, T2>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg5);
        assert_bindings<T0, T1>(arg0, arg1, arg2, arg3);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_types, &v0), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::reward_not_allowed());
        let v1 = 0x1::option::borrow_mut<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::update_position_fee_and_rewards<T0, T1>(arg1, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v1), arg3, arg4);
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&arg0.rewards, v0)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg1, v1, arg2, arg3, arg5));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.rewards, v0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::collect_position_reward<T0, T1, T2>(arg1, v1, arg2, arg3, arg5));
        };
    }

    public fun owner_deposit_a<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg2);
        0x2::balance::join<T0>(&mut arg0.idle_a, 0x2::coin::into_balance<T0>(arg1));
        let v0 = OwnerDeposit{
            vault_id : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            side     : 0,
            amount   : 0x2::coin::value<T0>(&arg1),
            idle_a   : 0x2::balance::value<T0>(&arg0.idle_a),
            idle_b   : 0x2::balance::value<T1>(&arg0.idle_b),
        };
        0x2::event::emit<OwnerDeposit>(v0);
    }

    public fun owner_deposit_b<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg2);
        0x2::balance::join<T1>(&mut arg0.idle_b, 0x2::coin::into_balance<T1>(arg1));
        let v0 = OwnerDeposit{
            vault_id : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            side     : 1,
            amount   : 0x2::coin::value<T1>(&arg1),
            idle_a   : 0x2::balance::value<T0>(&arg0.idle_a),
            idle_b   : 0x2::balance::value<T1>(&arg0.idle_b),
        };
        0x2::event::emit<OwnerDeposit>(v0);
    }

    public fun owner_emergency_recover<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg1);
        arg0.paused = true;
        arg0.agent_generation = arg0.agent_generation + 1;
        assert!(0x2::bag::is_empty(&arg0.rewards), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::reward_not_allowed());
        let v0 = if (0x1::option::is_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.position)) {
            let v1 = 0x1::option::extract<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position);
            0x2::transfer::public_transfer<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v1, arg0.owner);
            0x1::option::some<0x2::object::ID>(0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v1))
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.idle_a), arg1), arg0.owner);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.idle_b), arg1), arg0.owner);
        let v2 = EmergencyRecovered{
            vault_id    : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            owner       : arg0.owner,
            position_id : v0,
            amount_a    : 0x2::balance::value<T0>(&arg0.idle_a),
            amount_b    : 0x2::balance::value<T1>(&arg0.idle_b),
            generation  : arg0.agent_generation,
        };
        0x2::event::emit<EmergencyRecovered>(v2);
    }

    public fun owner_open_position<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: vector<u32>, arg6: vector<u64>, arg7: vector<u64>, arg8: u32, arg9: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg9);
        assert_bindings<T0, T1>(arg0, arg1, arg2, arg3);
        assert!(0x1::option::is_none<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.position), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::position_exists());
        let (v0, v1) = validate_plan<T0, T1>(&arg0.policy, arg1, &arg5, &arg6, &arg7, arg8);
        assert_idle_after<T0, T1>(&arg0.policy, &arg0.idle_a, &arg0.idle_b, v0, v1);
        let (v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_position<T0, T1>(arg1, arg5, arg6, arg7, arg2, arg3, arg4, arg9);
        let v4 = v3;
        let v5 = v2;
        let (v6, v7) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_cert_amounts<T0, T1>(&v4);
        assert!(v6 == v0 && v7 == v1, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::amount_sum());
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_open_position<T0, T1>(arg1, &mut v5, v4, 0x2::balance::split<T0>(&mut arg0.idle_a, v6), 0x2::balance::split<T1>(&mut arg0.idle_b, v7), arg3);
        0x1::option::fill<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position, v5);
        arg0.position_generation = arg0.position_generation + 1;
        let v8 = PositionBound{
            vault_id    : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            pool_id     : arg0.pool_id,
            position_id : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v5),
            generation  : arg0.position_generation,
            source      : 1,
        };
        0x2::event::emit<PositionBound>(v8);
    }

    public fun owner_pause<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg1);
        arg0.paused = true;
        0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::set_phase(&mut arg0.policy, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::paused_phase());
        let v0 = PolicyUpdated{
            vault_id : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            version  : 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::version(&arg0.policy),
            phase    : 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::paused_phase(),
            paused   : true,
        };
        0x2::event::emit<PolicyUpdated>(v0);
    }

    public fun owner_register_reward<T0, T1, T2>(arg0: &mut MakerVault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.reward_types, &v0)) {
            assert!(0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.reward_types) < (0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::max_reward_types(&arg0.policy) as u64), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::too_many_rewards());
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.reward_types, v0);
            let v1 = RewardRegistered{
                vault_id    : 0x2::object::id<MakerVault<T0, T1>>(arg0),
                reward_type : v0,
            };
            0x2::event::emit<RewardRegistered>(v1);
        };
    }

    public fun owner_rotate_agent<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg2);
        assert!(arg1 != arg0.owner && arg1 != @0x0, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::not_keeper());
        arg0.agent_generation = arg0.agent_generation + 1;
        arg0.agent = arg1;
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::uid_to_inner(&v0);
        arg0.agent_cap_id = v1;
        let v2 = AgentCap<T0, T1>{
            id         : v0,
            vault_id   : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            pool_id    : arg0.pool_id,
            agent      : arg1,
            generation : arg0.agent_generation,
        };
        let v3 = AgentRotated{
            vault_id   : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            old_agent  : arg0.agent,
            new_agent  : arg1,
            generation : arg0.agent_generation,
            cap_id     : v1,
        };
        0x2::event::emit<AgentRotated>(v3);
        0x2::transfer::transfer<AgentCap<T0, T1>>(v2, arg1);
    }

    public fun owner_set_phase<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg2);
        0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::set_phase(&mut arg0.policy, arg1);
        arg0.paused = arg1 == 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::paused_phase();
        let v0 = PolicyUpdated{
            vault_id : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            version  : 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::version(&arg0.policy),
            phase    : arg1,
            paused   : arg0.paused,
        };
        0x2::event::emit<PolicyUpdated>(v0);
    }

    public fun owner_set_policy<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::Policy, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg2);
        0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::replace(&mut arg0.policy, arg1);
        let v0 = PolicyUpdated{
            vault_id : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            version  : 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::version(&arg0.policy),
            phase    : 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::phase(&arg0.policy),
            paused   : arg0.paused,
        };
        0x2::event::emit<PolicyUpdated>(v0);
    }

    public fun owner_unwrap_position<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg1);
        assert!(0x1::option::is_some<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.position), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::no_position());
        let v0 = 0x1::option::extract<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position);
        0x2::transfer::public_transfer<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(v0, arg0.owner);
        let v1 = PositionBound{
            vault_id    : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            pool_id     : arg0.pool_id,
            position_id : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&v0),
            generation  : arg0.position_generation,
            source      : 2,
        };
        0x2::event::emit<PositionBound>(v1);
    }

    public fun owner_withdraw_a<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg2);
        assert!(arg1 > 0, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::zero_amount());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.idle_a, arg1), arg2), arg0.owner);
        let v0 = OwnerWithdrawal{
            vault_id : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            side     : 0,
            amount   : arg1,
            idle_a   : 0x2::balance::value<T0>(&arg0.idle_a),
            idle_b   : 0x2::balance::value<T1>(&arg0.idle_b),
        };
        0x2::event::emit<OwnerWithdrawal>(v0);
    }

    public fun owner_withdraw_b<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg2);
        assert!(arg1 > 0, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::zero_amount());
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.idle_b, arg1), arg2), arg0.owner);
        let v0 = OwnerWithdrawal{
            vault_id : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            side     : 1,
            amount   : arg1,
            idle_a   : 0x2::balance::value<T0>(&arg0.idle_a),
            idle_b   : 0x2::balance::value<T1>(&arg0.idle_b),
        };
        0x2::event::emit<OwnerWithdrawal>(v0);
    }

    public fun owner_wrap_position<T0, T1>(arg0: &mut MakerVault<T0, T1>, arg1: 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1>(arg0, arg2);
        assert!(0x1::option::is_none<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg0.position), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::position_exists());
        assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::pool_id(&arg1) == arg0.pool_id, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::position_mismatch());
        0x1::option::fill<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&mut arg0.position, arg1);
        arg0.position_generation = arg0.position_generation + 1;
        let v0 = PositionBound{
            vault_id    : 0x2::object::id<MakerVault<T0, T1>>(arg0),
            pool_id     : arg0.pool_id,
            position_id : 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position>(&arg1),
            generation  : arg0.position_generation,
            source      : 0,
        };
        0x2::event::emit<PositionBound>(v0);
    }

    public fun plan_hash(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u32, arg9: u16, arg10: bool, arg11: vector<u8>, arg12: vector<u32>, arg13: vector<u64>, arg14: vector<u64>) : vector<u8> {
        let v0 = PlanCommitment{
            vault_id            : arg0,
            pool_id             : arg1,
            cap_id              : arg2,
            generation          : arg3,
            position_id         : arg4,
            sequence            : arg5,
            policy_version      : arg6,
            deadline_ms         : arg7,
            planned_active_bits : arg8,
            remove_percent_bps  : arg9,
            collect_fee         : arg10,
            reward_list_hash    : arg11,
            bin_ids             : arg12,
            amounts_a           : arg13,
            amounts_b           : arg14,
        };
        let v1 = 0x2::bcs::to_bytes<PlanCommitment>(&v0);
        0x2::hash::blake2b256(&v1)
    }

    public fun policy_version<T0, T1>(arg0: &MakerVault<T0, T1>) : u64 {
        0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::version(&arg0.policy)
    }

    public fun pool_id<T0, T1>(arg0: &MakerVault<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun reward_list_hash(arg0: &vector<0x1::type_name::TypeName>) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<vector<0x1::type_name::TypeName>>(arg0);
        0x2::hash::blake2b256(&v0)
    }

    public fun sequence<T0, T1>(arg0: &MakerVault<T0, T1>) : u64 {
        arg0.action_sequence
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

    fun signed_eq(arg0: u32, arg1: u32) : bool {
        arg0 == arg1
    }

    fun signed_gte(arg0: u32, arg1: u32) : bool {
        !signed_lt(arg0, arg1)
    }

    fun signed_lt(arg0: u32, arg1: u32) : bool {
        let v0 = arg0 >= 2147483648;
        v0 != arg1 >= 2147483648 && v0 || arg0 < arg1
    }

    fun validate_plan<T0, T1>(arg0: &0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::Policy, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &vector<u32>, arg3: &vector<u64>, arg4: &vector<u64>, arg5: u32) : (u64, u64) {
        validate_plan_at(arg0, arg2, arg3, arg4, arg5, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg1)))
    }

    public(friend) fun validate_plan_at(arg0: &0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::Policy, arg1: &vector<u32>, arg2: &vector<u64>, arg3: &vector<u64>, arg4: u32, arg5: u32) : (u64, u64) {
        let v0 = 0x1::vector::length<u32>(arg1);
        let v1 = if (v0 > 0) {
            if (v0 == 0x1::vector::length<u64>(arg2)) {
                v0 == 0x1::vector::length<u64>(arg3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::vector_length());
        assert!(v0 <= (0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::max_bins(arg0) as u64), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::vector_length());
        assert!(signed_distance(arg5, arg4) <= (0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::max_active_drift(arg0) as u64), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::active_drift());
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v2 < v0) {
            let v5 = *0x1::vector::borrow<u32>(arg1, v2);
            let v6 = *0x1::vector::borrow<u64>(arg2, v2);
            let v7 = *0x1::vector::borrow<u64>(arg3, v2);
            assert!(v6 > 0 || v7 > 0, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::zero_amount());
            assert!(signed_gte(v5, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::min_bin_bits(arg0)) && signed_gte(0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::max_bin_bits(arg0), v5), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bin_range());
            assert!(signed_distance(v5, arg5) <= (0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::max_distance_from_active(arg0) as u64), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bin_range());
            assert!(!signed_eq(v5, arg5), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::active_bin());
            if (signed_lt(v5, arg5)) {
                assert!(v6 == 0, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::wrong_side());
            } else {
                assert!(v7 == 0, 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::wrong_side());
            };
            if (v2 > 0) {
                assert!(signed_lt(*0x1::vector::borrow<u32>(arg1, v2 - 1), v5), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::bin_order());
            };
            v3 = v3 + v6;
            v4 = v4 + v7;
            v2 = v2 + 1;
        };
        assert!(v3 <= 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::max_deploy_a(arg0) && v4 <= 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::policy::max_deploy_b(arg0), 0x1b34b2a4ba8d14cd1068564bece9fecfb24ac0c8c6b0853d393b4b56d5b2edf0::errors::amount_limit());
        (v3, v4)
    }

    // decompiled from Move bytecode v7
}

