module 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system_inner {
    struct SystemInner has store {
        epoch: u64,
        epoch_start_tx_digest: vector<u8>,
        system_object_cap: 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap,
        protocol_version: u64,
        next_protocol_version: 0x1::option::Option<u64>,
        upgrade_caps: vector<0x2::package::UpgradeCap>,
        approved_upgrades: 0x2::vec_map::VecMap<0x2::object::ID, vector<u8>>,
        validator_set: 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::ValidatorSet,
        epoch_duration_ms: u64,
        stake_subsidy_start_epoch: u64,
        protocol_treasury: 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::protocol_treasury::ProtocolTreasury,
        epoch_start_timestamp_ms: u64,
        last_processed_checkpoint_sequence_number: u64,
        previous_epoch_last_checkpoint_sequence_number: u64,
        total_messages_processed: u64,
        remaining_rewards: 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>,
        authorized_protocol_cap_ids: vector<0x2::object::ID>,
        witnesses_approving_advance_epoch: vector<0x1::string::String>,
        received_end_of_publish: bool,
        extra_fields: 0x2::bag::Bag,
    }

    struct SystemEpochInfoEvent has copy, drop {
        epoch: u64,
        protocol_version: u64,
        total_stake: u64,
        stake_subsidy_amount: u64,
        total_computation_fees: u64,
        total_stake_rewards_distributed: u64,
    }

    struct SystemCheckpointInfoEvent has copy, drop {
        epoch: u64,
        sequence_number: u64,
    }

    struct SetNextProtocolVersionEvent has copy, drop {
        epoch: u64,
        next_protocol_version: u64,
    }

    struct SetEpochDurationMsEvent has copy, drop {
        epoch: u64,
        epoch_duration_ms: u64,
    }

    struct SetStakeSubsidyStartEpochEvent has copy, drop {
        epoch: u64,
        stake_subsidy_start_epoch: u64,
    }

    struct SetStakeSubsidyRateEvent has copy, drop {
        epoch: u64,
        stake_subsidy_rate: u16,
    }

    struct SetStakeSubsidyPeriodLengthEvent has copy, drop {
        epoch: u64,
        stake_subsidy_period_length: u64,
    }

    struct SetMinValidatorCountEvent has copy, drop {
        epoch: u64,
        min_validator_count: u64,
    }

    struct SetMaxValidatorCountEvent has copy, drop {
        epoch: u64,
        max_validator_count: u64,
    }

    struct SetMinValidatorJoiningStakeEvent has copy, drop {
        epoch: u64,
        min_validator_joining_stake: u64,
    }

    struct SetMaxValidatorChangeCountEvent has copy, drop {
        epoch: u64,
        max_validator_change_count: u64,
    }

    struct SetRewardSlashingRateEvent has copy, drop {
        epoch: u64,
        reward_slashing_rate: u16,
    }

    struct SetApprovedUpgradeEvent has copy, drop {
        epoch: u64,
        package_id: 0x2::object::ID,
        digest: 0x1::option::Option<vector<u8>>,
    }

    struct EndOfPublishEvent has copy, drop {
        epoch: u64,
    }

    struct SetOrRemoveWitnessApprovingAdvanceEpochEvent has copy, drop {
        epoch: u64,
        witness_type: 0x1::string::String,
        remove: bool,
    }

    public(friend) fun authorize_upgrade(arg0: &mut SystemInner, arg1: 0x2::object::ID) : (0x2::package::UpgradeTicket, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::upgrade_package_approver::UpgradePackageApprover) {
        assert!(0x2::vec_map::contains<0x2::object::ID, vector<u8>>(&arg0.approved_upgrades, &arg1), 4);
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, vector<u8>>(&mut arg0.approved_upgrades, &arg1);
        let v2 = &arg0.upgrade_caps;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<0x2::package::UpgradeCap>(v2)) {
            if (0x2::package::upgrade_package(0x1::vector::borrow<0x2::package::UpgradeCap>(v2, v3)) == arg1) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 8 */
                let v5 = 0x1::option::extract<u64>(&mut v4);
                return (0x2::package::authorize_upgrade(0x1::vector::borrow_mut<0x2::package::UpgradeCap>(&mut arg0.upgrade_caps, v5), 0x2::package::upgrade_policy(0x1::vector::borrow<0x2::package::UpgradeCap>(&arg0.upgrade_caps, v5)), v1), 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::upgrade_package_approver::create(0x2::object::id<0x2::package::UpgradeCap>(0x1::vector::borrow<0x2::package::UpgradeCap>(&arg0.upgrade_caps, v5)), arg0.witnesses_approving_advance_epoch, arg1, arg0.epoch + 1, &arg0.system_object_cap))
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 8 */
    }

    public(friend) fun commit_upgrade(arg0: &mut SystemInner, arg1: 0x2::package::UpgradeReceipt, arg2: &mut 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::upgrade_package_approver::UpgradePackageApprover) {
        0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::upgrade_package_approver::commit(arg2, &arg1, &arg0.system_object_cap);
        let v0 = &arg0.upgrade_caps;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x2::package::UpgradeCap>(v0)) {
            if (0x2::object::id<0x2::package::UpgradeCap>(0x1::vector::borrow<0x2::package::UpgradeCap>(v0, v1)) == 0x2::package::receipt_cap(&arg1)) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                0x2::package::commit_upgrade(0x1::vector::borrow_mut<0x2::package::UpgradeCap>(&mut arg0.upgrade_caps, 0x1::option::extract<u64>(&mut v2)), arg1);
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun create(arg0: 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap, arg1: vector<0x2::package::UpgradeCap>, arg2: 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::ValidatorSet, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::protocol_treasury::ProtocolTreasury, arg8: &mut 0x2::tx_context::TxContext) : (SystemInner, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::ProtocolCap) {
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::create(arg8, &arg0);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::ProtocolCap>(&v0));
        let v2 = SystemInner{
            epoch                                          : 0,
            epoch_start_tx_digest                          : *0x2::tx_context::digest(arg8),
            system_object_cap                              : arg0,
            protocol_version                               : arg3,
            next_protocol_version                          : 0x1::option::none<u64>(),
            upgrade_caps                                   : arg1,
            approved_upgrades                              : 0x2::vec_map::empty<0x2::object::ID, vector<u8>>(),
            validator_set                                  : arg2,
            epoch_duration_ms                              : arg5,
            stake_subsidy_start_epoch                      : arg6,
            protocol_treasury                              : arg7,
            epoch_start_timestamp_ms                       : arg4,
            last_processed_checkpoint_sequence_number      : 0,
            previous_epoch_last_checkpoint_sequence_number : 0,
            total_messages_processed                       : 0,
            remaining_rewards                              : 0x2::balance::zero<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(),
            authorized_protocol_cap_ids                    : v1,
            witnesses_approving_advance_epoch              : 0x1::vector::empty<0x1::string::String>(),
            received_end_of_publish                        : true,
            extra_fields                                   : 0x2::bag::new(arg8),
        };
        (v2, v0)
    }

    public(friend) fun claim_metadata_cap(arg0: &mut SystemInner, arg1: &mut 0x2::coin_registry::Currency<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg2: &mut 0x2::tx_context::TxContext) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::protocol_treasury::claim_metadata_cap(&mut arg0.protocol_treasury, arg1, arg2);
    }

    public(friend) fun active_committee(arg0: &SystemInner) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::active_committee(&arg0.validator_set)
    }

    public(friend) fun add_upgrade_cap_by_cap(arg0: &mut SystemInner, arg1: 0x2::package::UpgradeCap, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::ProtocolCap) {
        verify_protocol_cap_impl(arg0, arg2);
        0x1::vector::push_back<0x2::package::UpgradeCap>(&mut arg0.upgrade_caps, arg1);
    }

    public(friend) fun advance_epoch(arg0: &mut SystemInner, arg1: 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::advance_epoch_approver::AdvanceEpochApprover, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::advance_epoch_approver::assert_all_witnesses_approved(&arg1);
        assert!(arg0.received_end_of_publish, 0);
        arg0.received_end_of_publish = false;
        arg0.epoch_start_tx_digest = *0x2::tx_context::digest(arg3);
        arg0.epoch_start_timestamp_ms = 0x2::clock::timestamp_ms(arg2);
        arg0.previous_epoch_last_checkpoint_sequence_number = arg0.last_processed_checkpoint_sequence_number;
        let v0 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::advance_epoch_approver::new_epoch(&arg1);
        let v1 = 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::advance_epoch_approver::destroy(arg1, &arg0.system_object_cap);
        let v2 = 0x2::balance::zero<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>();
        if (epoch(arg0) >= arg0.stake_subsidy_start_epoch) {
            0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut v2, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::protocol_treasury::stake_subsidy_for_distribution(&mut arg0.protocol_treasury, arg3));
        };
        let v3 = 0x2::balance::zero<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>();
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut v3, v1);
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut v3, v2);
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut v3, 0x2::balance::withdraw_all<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.remaining_rewards));
        arg0.epoch = v0;
        if (0x1::option::is_some<u64>(&arg0.next_protocol_version)) {
            arg0.protocol_version = 0x1::option::extract<u64>(&mut arg0.next_protocol_version);
        };
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::advance_epoch(&mut arg0.validator_set, v0, &mut v3);
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.remaining_rewards, v3);
        let v4 = SystemEpochInfoEvent{
            epoch                           : arg0.epoch,
            protocol_version                : arg0.protocol_version,
            total_stake                     : 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::total_stake(&arg0.validator_set),
            stake_subsidy_amount            : 0x2::balance::value<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&v2),
            total_computation_fees          : 0x2::balance::value<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&v1),
            total_stake_rewards_distributed : 0x2::balance::value<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&v3) - 0x2::balance::value<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&v3),
        };
        0x2::event::emit<SystemEpochInfoEvent>(v4);
    }

    public(friend) fun assert_end_epoch_time(arg0: &SystemInner, arg1: &0x2::clock::Clock) {
        assert!(is_end_epoch_time(arg0, arg1), 0);
    }

    public(friend) fun assert_mid_epoch_time(arg0: &SystemInner, arg1: &0x2::clock::Clock) {
        assert!(is_mid_epoch_time(arg0, arg1), 7);
    }

    public(friend) fun calculate_rewards(arg0: &SystemInner, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) : u64 {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::calculate_rewards(&arg0.validator_set, arg1, arg2, arg3, arg4)
    }

    public(friend) fun can_withdraw_staked_ika_early(arg0: &SystemInner, arg1: &0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka) : bool {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::can_withdraw_staked_ika_early(&arg0.validator_set, arg1, arg0.epoch)
    }

    public(friend) fun collect_commission(arg0: &mut SystemInner, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCommissionCap, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA> {
        0x2::coin::from_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::collect_commission(&mut arg0.validator_set, arg1, arg2), arg3)
    }

    public(friend) fun create_system_current_status_info(arg0: &SystemInner, arg1: &0x2::clock::Clock) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_current_status_info::SystemCurrentStatusInfo {
        0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_current_status_info::create(arg0.epoch, is_mid_epoch_time(arg0, arg1), is_end_epoch_time(arg0, arg1), active_committee(arg0), 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::next_epoch_active_committee(&arg0.validator_set), &arg0.system_object_cap)
    }

    public(friend) fun epoch(arg0: &SystemInner) : u64 {
        arg0.epoch
    }

    public(friend) fun epoch_duration_ms(arg0: &SystemInner) : u64 {
        arg0.epoch_duration_ms
    }

    public(friend) fun epoch_start_timestamp_ms(arg0: &SystemInner) : u64 {
        arg0.epoch_start_timestamp_ms
    }

    public(friend) fun finalize_upgrade(arg0: &SystemInner, arg1: 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::upgrade_package_approver::UpgradePackageApprover) {
        0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::upgrade_package_approver::assert_all_witnesses_approved(&arg1);
        0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::upgrade_package_approver::destroy(arg1, &arg0.system_object_cap);
    }

    public(friend) fun get_reporters_of(arg0: &SystemInner, arg1: 0x2::object::ID) : 0x2::vec_set::VecSet<0x2::object::ID> {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::get_reporters_of(&arg0.validator_set, arg1)
    }

    public(friend) fun initialize(arg0: &mut SystemInner, arg1: u64, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::ProtocolCap, arg3: &0x2::clock::Clock) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::advance_epoch_approver::AdvanceEpochApprover {
        verify_protocol_cap_impl(arg0, arg2);
        assert!(arg0.epoch == 0 && 0x2::clock::timestamp_ms(arg3) >= arg0.epoch_start_timestamp_ms, 6);
        let v0 = active_committee(arg0);
        assert!(0x1::vector::is_empty<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::members(&v0)), 6);
        let v1 = 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::pending_active_set(&arg0.validator_set);
        assert!(0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::size(v1) >= 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::pending_active_set::min_validator_count(v1), 6);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::set_max_validator_change_count(&mut arg0.validator_set, arg1);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::initiate_mid_epoch_reconfiguration(&mut arg0.validator_set);
        0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::advance_epoch_approver::create(arg0.epoch + 1, arg0.witnesses_approving_advance_epoch, 0x2::balance::zero<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(), &arg0.system_object_cap)
    }

    public(friend) fun initiate_advance_epoch(arg0: &SystemInner, arg1: &0x2::clock::Clock) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::advance_epoch_approver::AdvanceEpochApprover {
        assert_end_epoch_time(arg0, arg1);
        0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::advance_epoch_approver::create(arg0.epoch + 1, arg0.witnesses_approving_advance_epoch, 0x2::balance::zero<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(), &arg0.system_object_cap)
    }

    public(friend) fun initiate_mid_epoch_reconfiguration(arg0: &mut SystemInner, arg1: &0x2::clock::Clock) {
        assert_mid_epoch_time(arg0, arg1);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::initiate_mid_epoch_reconfiguration(&mut arg0.validator_set);
    }

    public(friend) fun is_end_epoch_time(arg0: &SystemInner, arg1: &0x2::clock::Clock) : bool {
        if (arg0.epoch > 0) {
            let v1 = 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::next_epoch_active_committee(&arg0.validator_set);
            if (0x1::option::is_some<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(&v1)) {
                0x2::clock::timestamp_ms(arg1) >= arg0.epoch_start_timestamp_ms + arg0.epoch_duration_ms
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun is_mid_epoch_time(arg0: &SystemInner, arg1: &0x2::clock::Clock) : bool {
        if (arg0.epoch > 0) {
            let v1 = 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::next_epoch_active_committee(&arg0.validator_set);
            if (0x1::option::is_none<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee>(&v1)) {
                0x2::clock::timestamp_ms(arg1) >= arg0.epoch_start_timestamp_ms + arg0.epoch_duration_ms / 2
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun next_epoch_active_committee(arg0: &SystemInner) : 0x1::option::Option<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommittee> {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::next_epoch_active_committee(&arg0.validator_set)
    }

    public(friend) fun process_checkpoint_message(arg0: &mut SystemInner, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_u64(&mut v0);
        assert!(v1 == arg0.epoch, 2);
        let v2 = 0x2::bcs::peel_u64(&mut v0);
        assert!(arg0.last_processed_checkpoint_sequence_number + 1 == v2, 3);
        arg0.last_processed_checkpoint_sequence_number = v2;
        let v3 = SystemCheckpointInfoEvent{
            epoch           : v1,
            sequence_number : v2,
        };
        0x2::event::emit<SystemCheckpointInfoEvent>(v3);
        let v4 = 0;
        while (v4 < 0x2::bcs::peel_vec_length(&mut v0)) {
            let v5 = 0x2::bcs::peel_enum_tag(&mut v0);
            let v6 = &v5;
            let v7 = 0;
            if (v6 == &v7) {
                let v8 = 0x2::bcs::peel_u64(&mut v0);
                arg0.next_protocol_version = 0x1::option::some<u64>(v8);
                let v9 = SetNextProtocolVersionEvent{
                    epoch                 : arg0.epoch,
                    next_protocol_version : v8,
                };
                0x2::event::emit<SetNextProtocolVersionEvent>(v9);
            } else {
                let v10 = 1;
                if (v6 == &v10) {
                    let v11 = 0x2::bcs::peel_u64(&mut v0);
                    arg0.epoch_duration_ms = v11;
                    let v12 = SetEpochDurationMsEvent{
                        epoch             : arg0.epoch,
                        epoch_duration_ms : v11,
                    };
                    0x2::event::emit<SetEpochDurationMsEvent>(v12);
                } else {
                    let v13 = 2;
                    if (v6 == &v13) {
                        let v14 = 0x2::bcs::peel_u64(&mut v0);
                        arg0.stake_subsidy_start_epoch = v14;
                        let v15 = SetStakeSubsidyStartEpochEvent{
                            epoch                     : arg0.epoch,
                            stake_subsidy_start_epoch : v14,
                        };
                        0x2::event::emit<SetStakeSubsidyStartEpochEvent>(v15);
                    } else {
                        let v16 = 3;
                        if (v6 == &v16) {
                            let v17 = 0x2::bcs::peel_u16(&mut v0);
                            0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::protocol_treasury::set_stake_subsidy_rate(&mut arg0.protocol_treasury, v17);
                            let v18 = SetStakeSubsidyRateEvent{
                                epoch              : arg0.epoch,
                                stake_subsidy_rate : v17,
                            };
                            0x2::event::emit<SetStakeSubsidyRateEvent>(v18);
                        } else {
                            let v19 = 4;
                            if (v6 == &v19) {
                                let v20 = 0x2::bcs::peel_u64(&mut v0);
                                0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::protocol_treasury::set_stake_subsidy_period_length(&mut arg0.protocol_treasury, v20);
                                let v21 = SetStakeSubsidyPeriodLengthEvent{
                                    epoch                       : arg0.epoch,
                                    stake_subsidy_period_length : v20,
                                };
                                0x2::event::emit<SetStakeSubsidyPeriodLengthEvent>(v21);
                            } else {
                                let v22 = 5;
                                if (v6 == &v22) {
                                    let v23 = 0x2::bcs::peel_u64(&mut v0);
                                    0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::set_min_validator_count(&mut arg0.validator_set, v23);
                                    let v24 = SetMinValidatorCountEvent{
                                        epoch               : arg0.epoch,
                                        min_validator_count : v23,
                                    };
                                    0x2::event::emit<SetMinValidatorCountEvent>(v24);
                                } else {
                                    let v25 = 6;
                                    if (v6 == &v25) {
                                        let v26 = 0x2::bcs::peel_u64(&mut v0);
                                        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::set_max_validator_count(&mut arg0.validator_set, v26);
                                        let v27 = SetMaxValidatorCountEvent{
                                            epoch               : arg0.epoch,
                                            max_validator_count : v26,
                                        };
                                        0x2::event::emit<SetMaxValidatorCountEvent>(v27);
                                    } else {
                                        let v28 = 7;
                                        if (v6 == &v28) {
                                            let v29 = 0x2::bcs::peel_u64(&mut v0);
                                            0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::set_min_validator_joining_stake(&mut arg0.validator_set, v29);
                                            let v30 = SetMinValidatorJoiningStakeEvent{
                                                epoch                       : arg0.epoch,
                                                min_validator_joining_stake : v29,
                                            };
                                            0x2::event::emit<SetMinValidatorJoiningStakeEvent>(v30);
                                        } else {
                                            let v31 = 8;
                                            if (v6 == &v31) {
                                                let v32 = 0x2::bcs::peel_u64(&mut v0);
                                                0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::set_max_validator_change_count(&mut arg0.validator_set, v32);
                                                let v33 = SetMaxValidatorChangeCountEvent{
                                                    epoch                      : arg0.epoch,
                                                    max_validator_change_count : v32,
                                                };
                                                0x2::event::emit<SetMaxValidatorChangeCountEvent>(v33);
                                            } else {
                                                let v34 = 9;
                                                if (v6 == &v34) {
                                                    let v35 = 0x2::bcs::peel_u16(&mut v0);
                                                    0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::set_reward_slashing_rate(&mut arg0.validator_set, v35);
                                                    let v36 = SetRewardSlashingRateEvent{
                                                        epoch                : arg0.epoch,
                                                        reward_slashing_rate : v35,
                                                    };
                                                    0x2::event::emit<SetRewardSlashingRateEvent>(v36);
                                                } else {
                                                    let v37 = 11;
                                                    if (v6 == &v37) {
                                                        let v38 = &mut v0;
                                                        let v39 = if (0x2::bcs::peel_bool(v38)) {
                                                            0x1::option::some<vector<u8>>(0x2::bcs::peel_vec_u8(v38))
                                                        } else {
                                                            0x1::option::none<vector<u8>>()
                                                        };
                                                        set_approved_upgrade(arg0, 0x2::object::id_from_bytes(0x2::bcs::peel_vec_u8(&mut v0)), v39);
                                                    } else {
                                                        let v40 = 10;
                                                        if (v6 == &v40) {
                                                            arg0.received_end_of_publish = true;
                                                            let v41 = EndOfPublishEvent{epoch: arg0.epoch};
                                                            0x2::event::emit<EndOfPublishEvent>(v41);
                                                        } else {
                                                            let v42 = 12;
                                                            if (v6 == &v42) {
                                                                set_or_remove_witness_approving_advance_epoch(arg0, 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::bcs::peel_bool(&mut v0));
                                                            };
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            v4 = v4 + 1;
        };
        arg0.total_messages_processed = arg0.total_messages_processed + v4;
    }

    public(friend) fun process_checkpoint_message_by_cap(arg0: &mut SystemInner, arg1: vector<u8>, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::ProtocolCap, arg3: &mut 0x2::tx_context::TxContext) {
        verify_protocol_cap_impl(arg0, arg2);
        process_checkpoint_message(arg0, arg1, arg3);
    }

    public(friend) fun process_checkpoint_message_by_quorum(arg0: &mut SystemInner, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::active_committee(&arg0.validator_set);
        assert!(!0x1::vector::is_empty<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::BlsCommitteeMember>(0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::members(&v0)), 1);
        let v1 = x"020000";
        0x1::vector::append<u8>(&mut v1, arg3);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg0.epoch));
        0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::bls_committee::verify_certificate(&v0, arg0.epoch, &arg1, &arg2, &v1);
        process_checkpoint_message(arg0, arg3, arg4);
    }

    public(friend) fun protocol_version(arg0: &SystemInner) : u64 {
        arg0.protocol_version
    }

    public(friend) fun report_validator(arg0: &mut SystemInner, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap, arg2: 0x2::object::ID) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::report_validator(&mut arg0.validator_set, arg1, arg2);
    }

    public(friend) fun request_add_stake(arg0: &mut SystemInner, arg1: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::request_add_stake(&mut arg0.validator_set, arg0.epoch, arg2, 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg1), arg3)
    }

    public(friend) fun request_add_validator(arg0: &mut SystemInner, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::request_add_validator(&mut arg0.validator_set, arg0.epoch, arg1);
    }

    public(friend) fun request_add_validator_candidate(arg0: &mut SystemInner, arg1: 0x1::string::String, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::table_vec::TableVec<vector<u8>>, arg6: vector<u8>, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u16, arg11: 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_metadata::ValidatorMetadata, arg12: &mut 0x2::tx_context::TxContext) : (0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap, 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCommissionCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::request_add_validator_candidate(&mut arg0.validator_set, arg0.epoch, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, &arg0.system_object_cap, arg12)
    }

    public(friend) fun validator_metadata(arg0: &SystemInner, arg1: 0x2::object::ID) : 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_metadata::ValidatorMetadata {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::validator_metadata(&arg0.validator_set, arg1)
    }

    public(friend) fun request_remove_validator(arg0: &mut SystemInner, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::request_remove_validator(&mut arg0.validator_set, arg0.epoch, arg1);
    }

    public(friend) fun request_remove_validator_candidate(arg0: &mut SystemInner, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::request_remove_validator_candidate(&mut arg0.validator_set, arg0.epoch, arg1);
    }

    public(friend) fun request_withdraw_stake(arg0: &mut SystemInner, arg1: &mut 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::request_withdraw_stake(&mut arg0.validator_set, arg1, arg0.epoch);
    }

    public(friend) fun rotate_commission_cap(arg0: &mut SystemInner, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap, arg2: &mut 0x2::tx_context::TxContext) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCommissionCap {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::rotate_commission_cap(&mut arg0.validator_set, arg1, &arg0.system_object_cap, arg2)
    }

    public(friend) fun rotate_operation_cap(arg0: &mut SystemInner, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap, arg2: &mut 0x2::tx_context::TxContext) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::rotate_operation_cap(&mut arg0.validator_set, arg1, &arg0.system_object_cap, arg2)
    }

    fun set_approved_upgrade(arg0: &mut SystemInner, arg1: 0x2::object::ID, arg2: 0x1::option::Option<vector<u8>>) {
        if (0x1::option::is_some<vector<u8>>(&arg2)) {
            if (0x2::vec_map::contains<0x2::object::ID, vector<u8>>(&arg0.approved_upgrades, &arg1)) {
                *0x2::vec_map::get_mut<0x2::object::ID, vector<u8>>(&mut arg0.approved_upgrades, &arg1) = *0x1::option::borrow<vector<u8>>(&arg2);
            } else {
                0x2::vec_map::insert<0x2::object::ID, vector<u8>>(&mut arg0.approved_upgrades, arg1, *0x1::option::borrow<vector<u8>>(&arg2));
            };
        } else if (0x2::vec_map::contains<0x2::object::ID, vector<u8>>(&arg0.approved_upgrades, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, vector<u8>>(&mut arg0.approved_upgrades, &arg1);
        };
        let v2 = SetApprovedUpgradeEvent{
            epoch      : arg0.epoch,
            package_id : arg1,
            digest     : arg2,
        };
        0x2::event::emit<SetApprovedUpgradeEvent>(v2);
    }

    public(friend) fun set_approved_upgrade_by_cap(arg0: &mut SystemInner, arg1: 0x2::object::ID, arg2: 0x1::option::Option<vector<u8>>, arg3: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::ProtocolCap) {
        verify_protocol_cap_impl(arg0, arg3);
        set_approved_upgrade(arg0, arg1, arg2);
    }

    public(friend) fun set_next_commission(arg0: &mut SystemInner, arg1: u16, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::set_next_commission(&mut arg0.validator_set, arg1, arg2, arg0.epoch);
    }

    public(friend) fun set_next_epoch_consensus_address(arg0: &mut SystemInner, arg1: 0x1::string::String, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::set_next_epoch_consensus_address(&mut arg0.validator_set, arg1, arg2);
    }

    public(friend) fun set_next_epoch_consensus_pubkey_bytes(arg0: &mut SystemInner, arg1: vector<u8>, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::set_next_epoch_consensus_pubkey_bytes(&mut arg0.validator_set, arg1, arg2);
    }

    public(friend) fun set_next_epoch_mpc_data_bytes(arg0: &mut SystemInner, arg1: 0x2::table_vec::TableVec<vector<u8>>, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) : 0x1::option::Option<0x2::table_vec::TableVec<vector<u8>>> {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::set_next_epoch_mpc_data_bytes(&mut arg0.validator_set, arg1, arg2)
    }

    public(friend) fun set_next_epoch_network_address(arg0: &mut SystemInner, arg1: 0x1::string::String, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::set_next_epoch_network_address(&mut arg0.validator_set, arg1, arg2);
    }

    public(friend) fun set_next_epoch_network_pubkey_bytes(arg0: &mut SystemInner, arg1: vector<u8>, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::set_next_epoch_network_pubkey_bytes(&mut arg0.validator_set, arg1, arg2);
    }

    public(friend) fun set_next_epoch_p2p_address(arg0: &mut SystemInner, arg1: 0x1::string::String, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::set_next_epoch_p2p_address(&mut arg0.validator_set, arg1, arg2);
    }

    public(friend) fun set_next_epoch_protocol_pubkey_bytes(arg0: &mut SystemInner, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap, arg4: &0x2::tx_context::TxContext) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::set_next_epoch_protocol_pubkey_bytes(&mut arg0.validator_set, arg1, arg2, arg3, arg4);
    }

    fun set_or_remove_witness_approving_advance_epoch(arg0: &mut SystemInner, arg1: 0x1::string::String, arg2: bool) {
        let (v0, v1) = 0x1::vector::index_of<0x1::string::String>(&arg0.witnesses_approving_advance_epoch, &arg1);
        if (arg2 && v0) {
            0x1::vector::remove<0x1::string::String>(&mut arg0.witnesses_approving_advance_epoch, v1);
        } else if (!v0) {
            0x1::vector::push_back<0x1::string::String>(&mut arg0.witnesses_approving_advance_epoch, arg1);
        };
        let v2 = SetOrRemoveWitnessApprovingAdvanceEpochEvent{
            epoch        : arg0.epoch,
            witness_type : arg1,
            remove       : arg2,
        };
        0x2::event::emit<SetOrRemoveWitnessApprovingAdvanceEpochEvent>(v2);
    }

    public(friend) fun set_or_remove_witness_approving_advance_epoch_by_cap(arg0: &mut SystemInner, arg1: 0x1::string::String, arg2: bool, arg3: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::ProtocolCap) {
        verify_protocol_cap_impl(arg0, arg3);
        set_or_remove_witness_approving_advance_epoch(arg0, arg1, arg2);
    }

    public(friend) fun set_validator_metadata(arg0: &mut SystemInner, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap, arg2: 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_metadata::ValidatorMetadata) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::set_validator_metadata(&mut arg0.validator_set, arg1, arg2);
    }

    public(friend) fun set_validator_name(arg0: &mut SystemInner, arg1: 0x1::string::String, arg2: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::set_validator_name(&mut arg0.validator_set, arg1, arg2);
    }

    public(friend) fun token_exchange_rates(arg0: &SystemInner, arg1: 0x2::object::ID) : &0x2::table::Table<u64, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::token_exchange_rate::TokenExchangeRate> {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::token_exchange_rates(&arg0.validator_set, arg1)
    }

    public(friend) fun undo_report_validator(arg0: &mut SystemInner, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap, arg2: 0x2::object::ID) {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::undo_report_validator(&mut arg0.validator_set, arg1, arg2);
    }

    public(friend) fun validator_stake_amount(arg0: &mut SystemInner, arg1: 0x2::object::ID) : u64 {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::validator_total_stake_amount(&mut arg0.validator_set, arg1)
    }

    public(friend) fun verify_commission_cap(arg0: &SystemInner, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCommissionCap) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::VerifiedValidatorCommissionCap {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::verify_commission_cap(&arg0.validator_set, arg1);
        0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::create_verified_validator_commission_cap(arg1, &arg0.system_object_cap)
    }

    public(friend) fun verify_operation_cap(arg0: &SystemInner, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorOperationCap) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::VerifiedValidatorOperationCap {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::verify_operation_cap(&arg0.validator_set, arg1);
        0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::create_verified_validator_operation_cap(arg1, &arg0.system_object_cap)
    }

    public(friend) fun verify_protocol_cap(arg0: &SystemInner, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::ProtocolCap) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::VerifiedProtocolCap {
        verify_protocol_cap_impl(arg0, arg1);
        0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::create_verified(&arg0.system_object_cap)
    }

    fun verify_protocol_cap_impl(arg0: &SystemInner, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::ProtocolCap) {
        let v0 = 0x2::object::id<0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::ProtocolCap>(arg1);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg0.authorized_protocol_cap_ids, &v0), 5);
    }

    public(friend) fun verify_validator_cap(arg0: &SystemInner, arg1: &0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::ValidatorCap) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::VerifiedValidatorCap {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::verify_validator_cap(&arg0.validator_set, arg1);
        0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::validator_cap::create_verified_validator_cap(arg1, &arg0.system_object_cap)
    }

    public(friend) fun withdraw_stake(arg0: &mut SystemInner, arg1: 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::staked_ika::StakedIka, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA> {
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::withdraw_stake(&mut arg0.validator_set, arg1, arg0.epoch, arg2)
    }

    // decompiled from Move bytecode v6
}

