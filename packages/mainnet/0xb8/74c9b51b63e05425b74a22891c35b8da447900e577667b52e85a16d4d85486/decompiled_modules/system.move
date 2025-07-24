module 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system {
    struct System has key {
        id: 0x2::object::UID,
        version: u64,
        package_id: 0x2::object::ID,
        new_package_id: 0x1::option::Option<0x2::object::ID>,
        migration_epoch: 0x1::option::Option<u64>,
    }

    public fun active_committee(arg0: &System) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::active_committee(inner(arg0))
    }

    public fun add_upgrade_cap_by_cap(arg0: &mut System, arg1: 0x2::package::UpgradeCap, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::ProtocolCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::add_upgrade_cap_by_cap(inner_mut(arg0), arg1, arg2);
    }

    public fun advance_epoch(arg0: &mut System, arg1: 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::advance_epoch_approver::AdvanceEpochApprover, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::advance_epoch(inner_mut(arg0), arg1, arg2, arg3);
    }

    public fun authorize_upgrade(arg0: &mut System, arg1: 0x2::object::ID) : (0x2::package::UpgradeTicket, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::upgrade_package_approver::UpgradePackageApprover) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::authorize_upgrade(inner_mut(arg0), arg1)
    }

    public fun calculate_rewards(arg0: &System, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) : u64 {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::calculate_rewards(inner(arg0), arg1, arg2, arg3, arg4)
    }

    public fun can_withdraw_staked_ika_early(arg0: &System, arg1: &0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka) : bool {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::can_withdraw_staked_ika_early(inner(arg0), arg1)
    }

    public fun collect_commission(arg0: &mut System, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCommissionCap, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA> {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::collect_commission(inner_mut(arg0), arg1, arg2, arg3)
    }

    public fun commit_upgrade(arg0: &mut System, arg1: 0x2::package::UpgradeReceipt, arg2: &mut 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::upgrade_package_approver::UpgradePackageApprover) {
        let v0 = inner_mut(arg0);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::commit_upgrade(v0, arg1, arg2);
        if (arg0.package_id == 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::upgrade_package_approver::old_package_id(arg2)) {
            arg0.migration_epoch = 0x1::option::some<u64>(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::upgrade_package_approver::migration_epoch(arg2));
            let v1 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::upgrade_package_approver::new_package_id(arg2);
            arg0.new_package_id = 0x1::option::some<0x2::object::ID>(*0x1::option::borrow<0x2::object::ID>(&v1));
        };
    }

    public(friend) fun create(arg0: 0x2::object::ID, arg1: 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap, arg2: vector<0x2::package::UpgradeCap>, arg3: 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::ValidatorSet, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::protocol_treasury::ProtocolTreasury, arg9: &mut 0x2::tx_context::TxContext) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::ProtocolCap {
        let (v0, v1) = 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::create(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v2 = System{
            id              : 0x2::object::new(arg9),
            version         : 1,
            package_id      : arg0,
            new_package_id  : 0x1::option::none<0x2::object::ID>(),
            migration_epoch : 0x1::option::none<u64>(),
        };
        0x2::dynamic_field::add<u64, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::SystemInner>(&mut v2.id, 1, v0);
        0x2::transfer::share_object<System>(v2);
        v1
    }

    public fun create_system_current_status_info(arg0: &System, arg1: &0x2::clock::Clock) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_current_status_info::SystemCurrentStatusInfo {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::create_system_current_status_info(inner(arg0), arg1)
    }

    public fun finalize_upgrade(arg0: &mut System, arg1: 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::upgrade_package_approver::UpgradePackageApprover) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::finalize_upgrade(inner(arg0), arg1);
    }

    public fun initialize(arg0: &mut System, arg1: u64, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::ProtocolCap, arg3: &0x2::clock::Clock) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::advance_epoch_approver::AdvanceEpochApprover {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::initialize(inner_mut(arg0), arg1, arg2, arg3)
    }

    public fun initiate_advance_epoch(arg0: &System, arg1: &0x2::clock::Clock) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::advance_epoch_approver::AdvanceEpochApprover {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::initiate_advance_epoch(inner(arg0), arg1)
    }

    public fun initiate_mid_epoch_reconfiguration(arg0: &mut System, arg1: &0x2::clock::Clock) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::initiate_mid_epoch_reconfiguration(inner_mut(arg0), arg1);
    }

    fun inner(arg0: &System) : &0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::SystemInner {
        assert!(arg0.version == 1, 0);
        0x2::dynamic_field::borrow<u64, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::SystemInner>(&arg0.id, 1)
    }

    fun inner_mut(arg0: &mut System) : &mut 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::SystemInner {
        assert!(arg0.version == 1, 0);
        0x2::dynamic_field::borrow_mut<u64, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::SystemInner>(&mut arg0.id, 1)
    }

    fun inner_without_version_check(arg0: &System) : &0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::SystemInner {
        0x2::dynamic_field::borrow<u64, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::SystemInner>(&arg0.id, arg0.version)
    }

    public fun next_epoch_active_committee(arg0: &System) : 0x1::option::Option<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee> {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::next_epoch_active_committee(inner(arg0))
    }

    public fun process_checkpoint_message_by_cap(arg0: &mut System, arg1: vector<u8>, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::ProtocolCap, arg3: &mut 0x2::tx_context::TxContext) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::process_checkpoint_message_by_cap(inner_mut(arg0), arg1, arg2, arg3);
    }

    public fun process_checkpoint_message_by_quorum(arg0: &mut System, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::process_checkpoint_message_by_quorum(inner_mut(arg0), arg1, arg2, arg3, arg4);
    }

    public fun report_validator(arg0: &mut System, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap, arg2: 0x2::object::ID) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::report_validator(inner_mut(arg0), arg1, arg2);
    }

    public fun request_add_stake(arg0: &mut System, arg1: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::request_add_stake(inner_mut(arg0), arg1, arg2, arg3)
    }

    public fun request_add_validator(arg0: &mut System, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::request_add_validator(inner_mut(arg0), arg1);
    }

    public fun request_add_validator_candidate(arg0: &mut System, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::table_vec::TableVec<vector<u8>>, arg6: vector<u8>, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u16, arg11: 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_metadata::ValidatorMetadata, arg12: &mut 0x2::tx_context::TxContext) : (0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCommissionCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::request_add_validator_candidate(inner_mut(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun validator_metadata(arg0: &System, arg1: 0x2::object::ID) : 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_metadata::ValidatorMetadata {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::validator_metadata(inner(arg0), arg1)
    }

    public fun request_remove_validator(arg0: &mut System, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::request_remove_validator(inner_mut(arg0), arg1);
    }

    public fun request_remove_validator_candidate(arg0: &mut System, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::request_remove_validator_candidate(inner_mut(arg0), arg1);
    }

    public fun request_withdraw_stake(arg0: &mut System, arg1: &mut 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::request_withdraw_stake(inner_mut(arg0), arg1);
    }

    public fun rotate_commission_cap(arg0: &mut System, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap, arg2: &mut 0x2::tx_context::TxContext) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCommissionCap {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::rotate_commission_cap(inner_mut(arg0), arg1, arg2)
    }

    public fun rotate_operation_cap(arg0: &mut System, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap, arg2: &mut 0x2::tx_context::TxContext) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::rotate_operation_cap(inner_mut(arg0), arg1, arg2)
    }

    public fun set_approved_upgrade_by_cap(arg0: &mut System, arg1: 0x2::object::ID, arg2: 0x1::option::Option<vector<u8>>, arg3: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::ProtocolCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::set_approved_upgrade_by_cap(inner_mut(arg0), arg1, arg2, arg3);
    }

    public fun set_next_commission(arg0: &mut System, arg1: u16, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::set_next_commission(inner_mut(arg0), arg1, arg2);
    }

    public fun set_next_epoch_consensus_address(arg0: &mut System, arg1: 0x1::string::String, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::set_next_epoch_consensus_address(inner_mut(arg0), arg1, arg2);
    }

    public fun set_next_epoch_consensus_pubkey_bytes(arg0: &mut System, arg1: vector<u8>, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::set_next_epoch_consensus_pubkey_bytes(inner_mut(arg0), arg1, arg2);
    }

    public fun set_next_epoch_mpc_data_bytes(arg0: &mut System, arg1: 0x2::table_vec::TableVec<vector<u8>>, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) : 0x1::option::Option<0x2::table_vec::TableVec<vector<u8>>> {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::set_next_epoch_mpc_data_bytes(inner_mut(arg0), arg1, arg2)
    }

    public fun set_next_epoch_network_address(arg0: &mut System, arg1: 0x1::string::String, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::set_next_epoch_network_address(inner_mut(arg0), arg1, arg2);
    }

    public fun set_next_epoch_network_pubkey_bytes(arg0: &mut System, arg1: vector<u8>, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::set_next_epoch_network_pubkey_bytes(inner_mut(arg0), arg1, arg2);
    }

    public fun set_next_epoch_p2p_address(arg0: &mut System, arg1: 0x1::string::String, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::set_next_epoch_p2p_address(inner_mut(arg0), arg1, arg2);
    }

    public fun set_next_epoch_protocol_pubkey_bytes(arg0: &mut System, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap, arg4: &mut 0x2::tx_context::TxContext) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::set_next_epoch_protocol_pubkey_bytes(inner_mut(arg0), arg1, arg2, arg3, arg4);
    }

    public fun set_or_remove_witness_approving_advance_epoch_by_cap(arg0: &mut System, arg1: 0x1::string::String, arg2: bool, arg3: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::ProtocolCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::set_or_remove_witness_approving_advance_epoch_by_cap(inner_mut(arg0), arg1, arg2, arg3);
    }

    public fun set_validator_metadata(arg0: &mut System, arg1: 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_metadata::ValidatorMetadata, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::set_validator_metadata(inner_mut(arg0), arg2, arg1);
    }

    public fun set_validator_name(arg0: &mut System, arg1: 0x1::string::String, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::set_validator_name(inner_mut(arg0), arg1, arg2);
    }

    public fun token_exchange_rates(arg0: &System, arg1: 0x2::object::ID) : &0x2::table::Table<u64, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::token_exchange_rate::TokenExchangeRate> {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::token_exchange_rates(inner(arg0), arg1)
    }

    public fun try_migrate(arg0: &mut System) {
        assert!(arg0.version < 1, 1);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.new_package_id), 1);
        let v0 = &arg0.migration_epoch;
        assert!(0x1::option::is_some<u64>(v0) && 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::epoch(inner_without_version_check(arg0)) >= *0x1::option::borrow<u64>(v0), 1);
        try_migrate_impl(arg0);
    }

    public fun try_migrate_by_cap(arg0: &mut System, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::ProtocolCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::verify_protocol_cap(inner(arg0), arg1);
        assert!(arg0.version < 1, 1);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.new_package_id), 1);
        try_migrate_impl(arg0);
    }

    fun try_migrate_impl(arg0: &mut System) {
        0x2::dynamic_field::add<u64, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::SystemInner>(&mut arg0.id, 1, 0x2::dynamic_field::remove<u64, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::SystemInner>(&mut arg0.id, arg0.version));
        arg0.version = 1;
        arg0.package_id = 0x1::option::extract<0x2::object::ID>(&mut arg0.new_package_id);
        if (0x1::option::is_some<u64>(&arg0.migration_epoch)) {
            0x1::option::extract<u64>(&mut arg0.migration_epoch);
        };
    }

    public fun undo_report_validator(arg0: &mut System, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap, arg2: 0x2::object::ID) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::undo_report_validator(inner_mut(arg0), arg1, arg2);
    }

    public fun verify_commission_cap(arg0: &System, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCommissionCap) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::VerifiedValidatorCommissionCap {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::verify_commission_cap(inner(arg0), arg1)
    }

    public fun verify_operation_cap(arg0: &System, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::VerifiedValidatorOperationCap {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::verify_operation_cap(inner(arg0), arg1)
    }

    public fun verify_protocol_cap(arg0: &System, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::ProtocolCap) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::VerifiedProtocolCap {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::verify_protocol_cap(inner(arg0), arg1)
    }

    public fun verify_validator_cap(arg0: &System, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::VerifiedValidatorCap {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::verify_validator_cap(inner(arg0), arg1)
    }

    public fun version(arg0: &System) : u64 {
        arg0.version
    }

    public fun withdraw_stake(arg0: &mut System, arg1: 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA> {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner::withdraw_stake(inner_mut(arg0), arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

