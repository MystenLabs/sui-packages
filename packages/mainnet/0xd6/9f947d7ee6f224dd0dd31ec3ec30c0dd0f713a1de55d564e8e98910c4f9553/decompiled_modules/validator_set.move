module 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set {
    struct ValidatorSet has store {
        total_stake: u64,
        reward_slashing_rate: u16,
        validators: 0x2::object_table::ObjectTable<0x2::object::ID, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::Validator>,
        active_committee: 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee,
        next_epoch_active_committee: 0x1::option::Option<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>,
        previous_committee: 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee,
        pending_active_set: 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::ExtendedField<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::PendingActiveSet>,
        validator_report_records: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>,
        extra_fields: 0x2::bag::Bag,
    }

    struct ValidatorEpochInfoEventV1 has copy, drop {
        epoch: u64,
        validator_id: 0x2::object::ID,
        stake: u64,
        commission_rate: u16,
        staking_rewards: u64,
        token_exchange_rate: 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::token_exchange_rate::TokenExchangeRate,
        tallying_rule_reporters: vector<0x2::object::ID>,
        tallying_rule_global_score: u64,
    }

    struct ValidatorJoinEvent has copy, drop {
        epoch: u64,
        validator_id: 0x2::object::ID,
    }

    struct ValidatorLeaveEvent has copy, drop {
        withdrawing_epoch: u64,
        validator_id: 0x2::object::ID,
        is_voluntary: bool,
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) : ValidatorSet {
        assert!(arg4 <= 10000, 9);
        ValidatorSet{
            total_stake                 : 0,
            reward_slashing_rate        : arg4,
            validators                  : 0x2::object_table::new<0x2::object::ID, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::Validator>(arg5),
            active_committee            : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::empty(),
            next_epoch_active_committee : 0x1::option::none<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(),
            previous_committee          : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::empty(),
            pending_active_set          : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::new<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::PendingActiveSet>(0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::new(arg0, arg1, arg2, arg3), arg5),
            validator_report_records    : 0x2::vec_map::empty<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(),
            extra_fields                : 0x2::bag::new(arg5),
        }
    }

    public fun pending_active_set(arg0: &ValidatorSet) : &0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::PendingActiveSet {
        0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::borrow<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::PendingActiveSet>(&arg0.pending_active_set)
    }

    public(friend) fun set_max_validator_change_count(arg0: &mut ValidatorSet, arg1: u64) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::set_max_validator_change_count(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::borrow_mut<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::PendingActiveSet>(&mut arg0.pending_active_set), arg1);
    }

    public(friend) fun set_max_validator_count(arg0: &mut ValidatorSet, arg1: u64) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::set_max_validator_count(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::borrow_mut<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::PendingActiveSet>(&mut arg0.pending_active_set), arg1);
    }

    public(friend) fun set_min_validator_count(arg0: &mut ValidatorSet, arg1: u64) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::set_min_validator_count(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::borrow_mut<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::PendingActiveSet>(&mut arg0.pending_active_set), arg1);
    }

    public(friend) fun set_min_validator_joining_stake(arg0: &mut ValidatorSet, arg1: u64) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::set_min_validator_joining_stake(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::borrow_mut<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::PendingActiveSet>(&mut arg0.pending_active_set), arg1);
    }

    public(friend) fun advance_epoch(arg0: &mut ValidatorSet, arg1: u64, arg2: &mut 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>) {
        assert!(0x1::option::is_some<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(&arg0.next_epoch_active_committee), 12);
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::total_voting_power(&arg0.active_committee);
        let v1 = compute_unadjusted_reward_distribution(arg0, v0, 0x2::balance::value<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg2));
        let v2 = compute_slashed_validators(arg0);
        let (v3, v4) = compute_reward_adjustments(get_validator_indices(arg0, &v2), arg0.reward_slashing_rate, &v1);
        let v5 = compute_adjusted_reward_distribution(arg0, v0, 0x1::vector::length<0x2::object::ID>(&v2), v1, v3, v4);
        distribute_reward(arg0, arg1, &v5, arg2);
        arg0.previous_committee = arg0.active_committee;
        arg0.active_committee = 0x1::option::extract<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(&mut arg0.next_epoch_active_committee);
        activate_added_validators(arg0, arg1);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::reset_validator_changes(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::borrow_mut<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::PendingActiveSet>(&mut arg0.pending_active_set));
        emit_validator_epoch_events(arg0, arg1, &v5, &v2);
        let v6 = calculate_total_stakes(arg0);
        arg0.total_stake = v6;
    }

    public(friend) fun calculate_rewards(arg0: &ValidatorSet, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) : u64 {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::calculate_rewards(get_validator(arg0, arg1), arg2, arg3, arg4)
    }

    public(friend) fun collect_commission(arg0: &mut ValidatorSet, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCommissionCap, arg2: 0x1::option::Option<u64>) : 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA> {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::collect_commission(get_validator_mut(arg0, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_commission_cap_validator_id(arg1)), arg1, arg2)
    }

    public(friend) fun request_add_stake(arg0: &mut ValidatorSet, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg4: &mut 0x2::tx_context::TxContext) : 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka {
        let v0 = 0x1::option::is_some<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(&arg0.next_epoch_active_committee);
        assert!(0x2::balance::value<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&arg3) >= 1000000000, 4);
        let v1 = get_validator_mut(arg0, arg2);
        update_pending_active_set(arg0, arg2, arg1, v0, false);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::request_add_stake(v1, arg3, arg1, v0, arg4)
    }

    public(friend) fun request_withdraw_stake(arg0: &mut ValidatorSet, arg1: &mut 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka, arg2: u64) {
        let v0 = 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::validator_id(arg1);
        let v1 = 0x1::option::is_some<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(&arg0.next_epoch_active_committee);
        let v2 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::contains(&arg0.active_committee, &v0);
        let v3 = &arg0.next_epoch_active_committee;
        let v4 = 0x1::option::is_some<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(v3) && 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::contains(0x1::option::borrow<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(v3), &v0);
        let v5 = get_validator_mut(arg0, v0);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::request_withdraw_stake(v5, arg1, v2, v4, arg2);
        update_pending_active_set(arg0, v0, arg2, v1, false);
    }

    public(friend) fun rotate_commission_cap(arg0: &mut ValidatorSet, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap, arg3: &mut 0x2::tx_context::TxContext) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCommissionCap {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::rotate_commission_cap(get_validator_mut(arg0, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_id(arg1)), arg1, arg2, arg3)
    }

    public(friend) fun rotate_operation_cap(arg0: &mut ValidatorSet, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap, arg3: &mut 0x2::tx_context::TxContext) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::rotate_operation_cap(get_validator_mut(arg0, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_id(arg1)), arg1, arg2, arg3)
    }

    public(friend) fun set_next_commission(arg0: &mut ValidatorSet, arg1: u16, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap, arg3: u64) {
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_operation_cap_validator_id(arg2);
        assert_validator_can_set_for_next_epoch(arg0, v0);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::set_next_commission(get_validator_mut(arg0, v0), arg1, arg3, arg2);
    }

    public(friend) fun set_next_epoch_consensus_address(arg0: &mut ValidatorSet, arg1: 0x1::string::String, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_operation_cap_validator_id(arg2);
        assert_validator_can_set_for_next_epoch(arg0, v0);
        let v1 = get_validator_mut(arg0, v0);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::set_next_epoch_consensus_address(v1, arg1, arg2);
        assert_no_pending_or_active_duplicates(arg0, v0);
    }

    public(friend) fun set_next_epoch_consensus_pubkey_bytes(arg0: &mut ValidatorSet, arg1: vector<u8>, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_operation_cap_validator_id(arg2);
        assert_validator_can_set_for_next_epoch(arg0, v0);
        let v1 = get_validator_mut(arg0, v0);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::set_next_epoch_consensus_pubkey_bytes(v1, arg1, arg2);
        assert_no_pending_or_active_duplicates(arg0, v0);
    }

    public(friend) fun set_next_epoch_mpc_data_bytes(arg0: &mut ValidatorSet, arg1: 0x2::table_vec::TableVec<vector<u8>>, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) : 0x1::option::Option<0x2::table_vec::TableVec<vector<u8>>> {
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_operation_cap_validator_id(arg2);
        assert_validator_can_set_for_next_epoch(arg0, v0);
        let v1 = get_validator_mut(arg0, v0);
        assert_no_pending_or_active_duplicates(arg0, v0);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::set_next_epoch_mpc_data_bytes(v1, arg1, arg2)
    }

    public(friend) fun set_next_epoch_network_address(arg0: &mut ValidatorSet, arg1: 0x1::string::String, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_operation_cap_validator_id(arg2);
        assert_validator_can_set_for_next_epoch(arg0, v0);
        let v1 = get_validator_mut(arg0, v0);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::set_next_epoch_network_address(v1, arg1, arg2);
        assert_no_pending_or_active_duplicates(arg0, v0);
    }

    public(friend) fun set_next_epoch_network_pubkey_bytes(arg0: &mut ValidatorSet, arg1: vector<u8>, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_operation_cap_validator_id(arg2);
        assert_validator_can_set_for_next_epoch(arg0, v0);
        let v1 = get_validator_mut(arg0, v0);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::set_next_epoch_network_pubkey_bytes(v1, arg1, arg2);
        assert_no_pending_or_active_duplicates(arg0, v0);
    }

    public(friend) fun set_next_epoch_p2p_address(arg0: &mut ValidatorSet, arg1: 0x1::string::String, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_operation_cap_validator_id(arg2);
        assert_validator_can_set_for_next_epoch(arg0, v0);
        let v1 = get_validator_mut(arg0, v0);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::set_next_epoch_p2p_address(v1, arg1, arg2);
        assert_no_pending_or_active_duplicates(arg0, v0);
    }

    public(friend) fun set_next_epoch_protocol_pubkey_bytes(arg0: &mut ValidatorSet, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_operation_cap_validator_id(arg3);
        assert_validator_can_set_for_next_epoch(arg0, v0);
        let v1 = get_validator_mut(arg0, v0);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::set_next_epoch_protocol_pubkey_bytes(v1, arg1, arg2, arg3, arg4);
        assert_no_pending_or_active_duplicates(arg0, v0);
    }

    public(friend) fun set_validator_metadata(arg0: &mut ValidatorSet, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap, arg2: 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_metadata::ValidatorMetadata) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::set_validator_metadata(get_validator_mut(arg0, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_operation_cap_validator_id(arg1)), arg1, arg2);
    }

    public(friend) fun withdraw_stake(arg0: &mut ValidatorSet, arg1: 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA> {
        let v0 = 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::validator_id(&arg1);
        let v1 = 0x1::option::is_some<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(&arg0.next_epoch_active_committee);
        let v2 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::contains(&arg0.active_committee, &v0);
        let v3 = &arg0.next_epoch_active_committee;
        let v4 = 0x1::option::is_some<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(v3) && 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::contains(0x1::option::borrow<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(v3), &v0);
        let v5 = get_validator_mut(arg0, v0);
        update_pending_active_set(arg0, v0, arg2, v1, false);
        0x2::coin::from_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::withdraw_stake(v5, arg1, v2, v4, arg2), arg3)
    }

    public(friend) fun validator_metadata(arg0: &ValidatorSet, arg1: 0x2::object::ID) : 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_metadata::ValidatorMetadata {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_info::metadata(0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::validator_info(get_validator(arg0, arg1)))
    }

    fun activate_added_validators(arg0: &mut ValidatorSet, arg1: u64) {
        let v0 = *0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::members(&arg0.active_committee);
        0x1::vector::reverse<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>(&mut v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>(&v0)) {
            let v2 = 0x1::vector::pop_back<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>(&mut v0);
            let v3 = get_validator_mut(arg0, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::validator_id(&v2));
            let v4 = 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::activation_epoch(v3);
            let v5 = &v4;
            if (0x1::option::is_some<u64>(v5) && 0x1::option::borrow<u64>(v5) == &arg1) {
                0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::advance_epoch(v3, 0x2::balance::zero<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(), arg1);
                let v6 = ValidatorJoinEvent{
                    epoch        : arg1,
                    validator_id : 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::validator_id(v3),
                };
                0x2::event::emit<ValidatorJoinEvent>(v6);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>(v0);
    }

    public fun active_committee(arg0: &ValidatorSet) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee {
        arg0.active_committee
    }

    public(friend) fun assert_no_pending_or_active_duplicates(arg0: &mut ValidatorSet, arg1: 0x2::object::ID) {
        assert!(0x2::object_table::contains<0x2::object::ID, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::Validator>(&arg0.validators, arg1), 2);
        let v0 = 0x2::object_table::remove<0x2::object::ID, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::Validator>(&mut arg0.validators, arg1);
        assert!(!is_duplicate_with_pending_validator(arg0, &v0), 1);
        0x2::object_table::add<0x2::object::ID, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::Validator>(&mut arg0.validators, arg1, v0);
    }

    public(friend) fun assert_validator_can_set_for_next_epoch(arg0: &ValidatorSet, arg1: 0x2::object::ID) {
        let v0 = &arg0.next_epoch_active_committee;
        let v1 = 0x1::option::is_some<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(v0) && 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::contains(0x1::option::borrow<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(v0), &arg1);
        assert!(!v1, 13);
    }

    fun calculate_total_stakes(arg0: &mut ValidatorSet) : u64 {
        let v0 = 0;
        let v1 = *0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::members(&arg0.active_committee);
        0x1::vector::reverse<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>(&v1)) {
            let v3 = 0x1::vector::pop_back<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>(&mut v1);
            v0 = v0 + 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::ika_balance(get_validator_mut(arg0, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::validator_id(&v3)));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>(v1);
        v0
    }

    public(friend) fun can_withdraw_staked_ika_early(arg0: &ValidatorSet, arg1: &0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka, arg2: u64) : bool {
        let v0 = 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::validator_id(arg1);
        let v1 = &arg0.next_epoch_active_committee;
        let v2 = 0x1::option::is_some<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(v1) && 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::contains(0x1::option::borrow<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(v1), &v0);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::can_withdraw_early(arg1, v2, arg2)
    }

    fun compute_adjusted_reward_distribution(arg0: &ValidatorSet, arg1: u64, arg2: u64, arg3: vector<u64>, arg4: u64, arg5: 0x2::vec_map::VecMap<u64, u64>) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::members(&arg0.active_committee))) {
            let v2 = if (0x2::vec_map::contains<u64, u64>(&arg5, &v1)) {
                *0x1::vector::borrow<u64>(&arg3, v1) - *0x2::vec_map::get<u64, u64>(&arg5, &v1)
            } else {
                *0x1::vector::borrow<u64>(&arg3, v1) + (((arg4 as u128) / ((arg1 - arg2) as u128)) as u64)
            };
            0x1::vector::push_back<u64>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    fun compute_reward_adjustments(arg0: vector<u64>, arg1: u16, arg2: &vector<u64>) : (u64, 0x2::vec_map::VecMap<u64, u64>) {
        let v0 = 0;
        let v1 = 0x2::vec_map::empty<u64, u64>();
        while (!0x1::vector::is_empty<u64>(&arg0)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg0);
            let v3 = (*0x1::vector::borrow<u64>(arg2, v2) as u128) * (arg1 as u128) / 10000;
            0x2::vec_map::insert<u64, u64>(&mut v1, v2, (v3 as u64));
            v0 = v0 + (v3 as u64);
        };
        (v0, v1)
    }

    fun compute_slashed_validators(arg0: &mut ValidatorSet) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        while (!0x2::vec_map::is_empty<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.validator_report_records)) {
            let (v1, v2) = 0x2::vec_map::pop<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.validator_report_records);
            let v3 = v2;
            assert!(is_active_validator(arg0, v1), 0);
            if (0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::is_quorum_threshold(&arg0.active_committee, 0x2::vec_set::length<0x2::object::ID>(&v3))) {
                0x1::vector::push_back<0x2::object::ID>(&mut v0, v1);
            };
        };
        v0
    }

    fun compute_unadjusted_reward_distribution(arg0: &ValidatorSet, arg1: u64, arg2: u64) : vector<u64> {
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::members(&arg0.active_committee);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>(v0)) {
            0x1::vector::push_back<u64>(&mut v1, (((arg2 as u128) / (arg1 as u128)) as u64));
            v2 = v2 + 1;
        };
        v1
    }

    fun distribute_reward(arg0: &mut ValidatorSet, arg1: u64, arg2: &vector<u64>, arg3: &mut 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>) {
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::borrow_mut<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::PendingActiveSet>(&mut arg0.pending_active_set);
        let v1 = *0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::members(&arg0.active_committee);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>(&v1)) {
            let v3 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::validator_id(0x1::vector::borrow<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>(&v1, v2));
            let v4 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::Validator>(&mut arg0.validators, v3);
            0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::advance_epoch(v4, 0x2::balance::split<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg3, *0x1::vector::borrow<u64>(arg2, v2)), arg1);
            0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::update(v0, v3, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::ika_balance_at_epoch(v4, arg1));
            v2 = v2 + 1;
        };
    }

    fun emit_validator_epoch_events(arg0: &ValidatorSet, arg1: u64, arg2: &vector<u64>, arg3: &vector<0x2::object::ID>) {
        let v0 = *0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::members(&arg0.previous_committee);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>(&v0)) {
            let v2 = *0x1::vector::borrow<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>(&v0, v1);
            let v3 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::validator_id(&v2);
            let v4 = get_validator(arg0, v3);
            let v5 = if (0x2::vec_map::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.validator_report_records, &v3)) {
                0x2::vec_set::into_keys<0x2::object::ID>(*0x2::vec_map::get<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.validator_report_records, &v3))
            } else {
                0x1::vector::empty<0x2::object::ID>()
            };
            let v6 = if (0x1::vector::contains<0x2::object::ID>(arg3, &v3)) {
                0
            } else {
                1
            };
            let v7 = ValidatorEpochInfoEventV1{
                epoch                      : arg1,
                validator_id               : v3,
                stake                      : 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::ika_balance(v4),
                commission_rate            : 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::commission_rate(v4),
                staking_rewards            : *0x1::vector::borrow<u64>(arg2, v1),
                token_exchange_rate        : 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::exchange_rate_at_epoch(v4, arg1),
                tallying_rule_reporters    : v5,
                tallying_rule_global_score : v6,
            };
            0x2::event::emit<ValidatorEpochInfoEventV1>(v7);
            v1 = v1 + 1;
        };
    }

    public(friend) fun get_reporters_of(arg0: &ValidatorSet, arg1: 0x2::object::ID) : 0x2::vec_set::VecSet<0x2::object::ID> {
        if (0x2::vec_map::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.validator_report_records, &arg1)) {
            *0x2::vec_map::get<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.validator_report_records, &arg1)
        } else {
            0x2::vec_set::empty<0x2::object::ID>()
        }
    }

    public fun get_validator(arg0: &ValidatorSet, arg1: 0x2::object::ID) : &0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::Validator {
        assert!(0x2::object_table::contains<0x2::object::ID, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::Validator>(&arg0.validators, arg1), 2);
        0x2::object_table::borrow<0x2::object::ID, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::Validator>(&arg0.validators, arg1)
    }

    fun get_validator_indices(arg0: &ValidatorSet, arg1: &vector<0x2::object::ID>) : vector<u64> {
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::validator_ids(&arg0.active_committee);
        let v1 = 0;
        let v2 = vector[];
        while (v1 < 0x1::vector::length<0x2::object::ID>(arg1)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(arg1, v1);
            let (v4, v5) = 0x1::vector::index_of<0x2::object::ID>(&v0, &v3);
            assert!(v4, 2);
            0x1::vector::push_back<u64>(&mut v2, v5);
            v1 = v1 + 1;
        };
        v2
    }

    public(friend) fun get_validator_mut(arg0: &mut ValidatorSet, arg1: 0x2::object::ID) : &mut 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::Validator {
        assert!(0x2::object_table::contains<0x2::object::ID, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::Validator>(&arg0.validators, arg1), 2);
        0x2::object_table::borrow_mut<0x2::object::ID, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::Validator>(&mut arg0.validators, arg1)
    }

    public(friend) fun initiate_mid_epoch_reconfiguration(arg0: &mut ValidatorSet) {
        assert!(0x1::option::is_none<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(&arg0.next_epoch_active_committee), 11);
        process_pending_validators(arg0);
    }

    public(friend) fun is_active_validator(arg0: &ValidatorSet, arg1: 0x2::object::ID) : bool {
        0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::contains(&arg0.active_committee, &arg1)
    }

    fun is_duplicate_with_pending_validator(arg0: &ValidatorSet, arg1: &0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::Validator) : bool {
        let v0 = 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::active_ids(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::borrow<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::PendingActiveSet>(&arg0.pending_active_set));
        let v1 = &v0;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x2::object::ID>(v1)) {
            let v4 = 0x1::vector::borrow<0x2::object::ID>(v1, v2);
            if (0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::validator_id(arg1) == *v4 && false || 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_info::is_duplicate(0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::validator_info(get_validator(arg0, *v4)), 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::validator_info(arg1))) {
                v3 = true;
                return v3
            };
            v2 = v2 + 1;
        };
        v3 = false;
        v3
    }

    public fun is_inactive_validator(arg0: &mut ValidatorSet, arg1: 0x2::object::ID) : bool {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::is_withdrawing(get_validator(arg0, arg1))
    }

    public fun is_validator_candidate(arg0: &mut ValidatorSet, arg1: 0x2::object::ID) : bool {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::is_preactive(get_validator(arg0, arg1))
    }

    public fun next_epoch_active_committee(arg0: &ValidatorSet) : 0x1::option::Option<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee> {
        arg0.next_epoch_active_committee
    }

    public(friend) fun pending_active_validators_count(arg0: &ValidatorSet) : u64 {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::size(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::borrow<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::PendingActiveSet>(&arg0.pending_active_set))
    }

    fun process_pending_validators(arg0: &mut ValidatorSet) {
        let v0 = 0x1::vector::empty<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>();
        let v1 = 0;
        let v2 = 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::active_ids(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::borrow<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::PendingActiveSet>(&arg0.pending_active_set));
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v2)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&v2, v1);
            let v4 = get_validator_mut(arg0, v3);
            0x1::vector::push_back<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>(&mut v0, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::new_bls_committee_member(v3, *0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_info::protocol_pubkey(0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::validator_info(v4))));
            v1 = v1 + 1;
        };
        0x1::option::fill<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(&mut arg0.next_epoch_active_committee, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::new_bls_committee(v0));
    }

    public(friend) fun report_validator(arg0: &mut ValidatorSet, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap, arg2: 0x2::object::ID) {
        assert!(is_active_validator(arg0, arg2), 2);
        assert!(is_active_validator(arg0, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_operation_cap_validator_id(arg1)), 2);
        verify_operation_cap(arg0, arg1);
        let v0 = &mut arg0.validator_report_records;
        report_validator_impl(arg1, arg2, v0);
    }

    fun report_validator_impl(arg0: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap, arg1: 0x2::object::ID, arg2: &mut 0x2::vec_map::VecMap<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>) {
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_operation_cap_validator_id(arg0);
        assert!(v0 != arg1, 6);
        if (!0x2::vec_map::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(arg2, &arg1)) {
            0x2::vec_map::insert<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(arg2, arg1, 0x2::vec_set::singleton<0x2::object::ID>(v0));
        } else {
            let v1 = 0x2::vec_map::get_mut<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(arg2, &arg1);
            if (!0x2::vec_set::contains<0x2::object::ID>(v1, &v0)) {
                0x2::vec_set::insert<0x2::object::ID>(v1, v0);
            };
        };
    }

    public(friend) fun request_add_validator(arg0: &mut ValidatorSet, arg1: u64, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap) {
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_id(arg2);
        assert!(0x2::object_table::contains<0x2::object::ID, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::Validator>(&arg0.validators, v0), 3);
        let v1 = 0x1::option::is_some<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(&arg0.next_epoch_active_committee);
        let v2 = 0x2::object_table::remove<0x2::object::ID, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::Validator>(&mut arg0.validators, v0);
        assert!(!is_duplicate_with_pending_validator(arg0, &v2), 1);
        assert!(0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::is_preactive(&v2), 3);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::activate(&mut v2, arg2, arg1, v1);
        0x2::object_table::add<0x2::object::ID, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::Validator>(&mut arg0.validators, v0, v2);
        assert!(update_pending_active_set(arg0, v0, arg1, v1, true), 8);
    }

    public(friend) fun request_add_validator_candidate(arg0: &mut ValidatorSet, arg1: u64, arg2: 0x1::string::String, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2::table_vec::TableVec<vector<u8>>, arg7: vector<u8>, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: u16, arg12: 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_metadata::ValidatorMetadata, arg13: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap, arg14: &mut 0x2::tx_context::TxContext) : (0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCommissionCap) {
        let (v0, v1, v2, v3) = 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::new(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
        let v4 = v0;
        let v5 = 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::validator_id(&v4);
        assert!(!is_duplicate_with_pending_validator(arg0, &v4), 1);
        assert!(!0x2::object_table::contains<0x2::object::ID, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::Validator>(&arg0.validators, v5), 1);
        assert!(0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::is_preactive(&v4), 3);
        0x2::object_table::add<0x2::object::ID, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::Validator>(&mut arg0.validators, v5, v4);
        (v1, v2, v3)
    }

    public(friend) fun request_remove_validator(arg0: &mut ValidatorSet, arg1: u64, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap) {
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_id(arg2);
        let v1 = 0x1::option::is_some<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(&arg0.next_epoch_active_committee);
        let v2 = get_validator_mut(arg0, v0);
        assert!(!0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::is_withdrawing(v2), 5);
        let v3 = if (v1) {
            arg1 + 2
        } else {
            arg1 + 1
        };
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::set_withdrawing(v2, arg2, v3);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::remove(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::borrow_mut<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::PendingActiveSet>(&mut arg0.pending_active_set), v0);
        let v4 = ValidatorLeaveEvent{
            withdrawing_epoch : v3,
            validator_id      : v0,
            is_voluntary      : true,
        };
        0x2::event::emit<ValidatorLeaveEvent>(v4);
    }

    public(friend) fun request_remove_validator_candidate(arg0: &mut ValidatorSet, arg1: u64, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap) {
        let v0 = get_validator_mut(arg0, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_id(arg2));
        assert!(0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::is_preactive(v0), 3);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::set_withdrawing(v0, arg2, arg1);
    }

    public(friend) fun set_reward_slashing_rate(arg0: &mut ValidatorSet, arg1: u16) {
        assert!(arg1 <= 10000, 9);
        arg0.reward_slashing_rate = arg1;
    }

    public(friend) fun set_validator_name(arg0: &mut ValidatorSet, arg1: 0x1::string::String, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::set_name(get_validator_mut(arg0, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_operation_cap_validator_id(arg2)), arg1, arg2);
    }

    public(friend) fun token_exchange_rates(arg0: &ValidatorSet, arg1: 0x2::object::ID) : &0x2::table::Table<u64, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::token_exchange_rate::TokenExchangeRate> {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::exchange_rates(get_validator(arg0, arg1))
    }

    public fun total_stake(arg0: &ValidatorSet) : u64 {
        arg0.total_stake
    }

    public(friend) fun undo_report_validator(arg0: &mut ValidatorSet, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap, arg2: 0x2::object::ID) {
        assert!(is_active_validator(arg0, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_operation_cap_validator_id(arg1)), 2);
        verify_operation_cap(arg0, arg1);
        let v0 = &mut arg0.validator_report_records;
        undo_report_validator_impl(arg1, arg2, v0);
    }

    fun undo_report_validator_impl(arg0: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap, arg1: 0x2::object::ID, arg2: &mut 0x2::vec_map::VecMap<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>) {
        assert!(0x2::vec_map::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(arg2, &arg1), 7);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(arg2, &arg1);
        let v1 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_operation_cap_validator_id(arg0);
        assert!(0x2::vec_set::contains<0x2::object::ID>(v0, &v1), 7);
        0x2::vec_set::remove<0x2::object::ID>(v0, &v1);
        if (0x2::vec_set::is_empty<0x2::object::ID>(v0)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, 0x2::vec_set::VecSet<0x2::object::ID>>(arg2, &arg1);
        };
    }

    public(friend) fun update_pending_active_set(arg0: &mut ValidatorSet, arg1: 0x2::object::ID, arg2: u64, arg3: bool, arg4: bool) : bool {
        let v0 = get_validator_mut(arg0, arg1);
        let v1 = if (arg3) {
            0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::ika_balance_at_epoch(v0, arg2 + 2)
        } else {
            0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::ika_balance_at_epoch(v0, arg2 + 1)
        };
        let (v2, v3) = if (arg4) {
            0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::insert_or_update_or_remove(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::borrow_mut<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::PendingActiveSet>(&mut arg0.pending_active_set), arg1, v1)
        } else {
            0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::update_or_remove(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::extended_field::borrow_mut<0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::PendingActiveSet>(&mut arg0.pending_active_set), arg1, v1)
        };
        let v4 = v3;
        if (0x1::option::is_some<0x2::object::ID>(&v4)) {
            let v5 = arg2 + 1;
            0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::deactivate(get_validator_mut(arg0, 0x1::option::extract<0x2::object::ID>(&mut v4)), v5);
            let v6 = ValidatorLeaveEvent{
                withdrawing_epoch : v5,
                validator_id      : arg1,
                is_voluntary      : false,
            };
            0x2::event::emit<ValidatorLeaveEvent>(v6);
        };
        v2
    }

    public fun validator_total_stake_amount(arg0: &mut ValidatorSet, arg1: 0x2::object::ID) : u64 {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::ika_balance(get_validator(arg0, arg1))
    }

    public(friend) fun verify_commission_cap(arg0: &ValidatorSet, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCommissionCap) {
        let v0 = 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::commission_cap_id(get_validator(arg0, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_commission_cap_validator_id(arg1)));
        let v1 = 0x2::object::id<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCommissionCap>(arg1);
        assert!(&v0 == &v1, 10);
    }

    public(friend) fun verify_operation_cap(arg0: &ValidatorSet, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        let v0 = 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::operation_cap_id(get_validator(arg0, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_operation_cap_validator_id(arg1)));
        let v1 = 0x2::object::id<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap>(arg1);
        assert!(&v0 == &v1, 10);
    }

    public(friend) fun verify_validator_cap(arg0: &ValidatorSet, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap) {
        let v0 = 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator::validator_cap_id(get_validator(arg0, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::validator_id(arg1)));
        let v1 = 0x2::object::id<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap>(arg1);
        assert!(&v0 == &v1, 10);
    }

    // decompiled from Move bytecode v6
}

