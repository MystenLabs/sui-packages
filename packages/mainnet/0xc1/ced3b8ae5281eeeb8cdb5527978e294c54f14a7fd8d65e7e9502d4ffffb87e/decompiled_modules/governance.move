module 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct GovernanceVault has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        governance_config_id: 0x2::object::ID,
        admin_cap: AdminCap,
        governance_authority: address,
        upgrade_authority: address,
        active_operator: address,
        active_operator_epoch: u64,
        pending_operator: address,
        pending_operator_epoch: u64,
        pending_operator_wrapper_id: 0x2::object::ID,
        has_pending_operator_transfer: bool,
        fee_recipient: address,
        direct_authority_mode: u8,
        direct_authority_permanently_disabled: bool,
    }

    struct FeeManager has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        fee_levels: 0x2::table::Table<u8, u8>,
    }

    struct GovernanceActionTicket {
        registry_id: 0x2::object::ID,
        action_type: u8,
        payload_u64_1: u64,
        payload_u64_2: u64,
        executed_by: address,
    }

    struct GovernanceActionExecutorCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        governance_vault_id: 0x2::object::ID,
    }

    struct OperatorPermit has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        operator_epoch: u64,
    }

    struct ManagedUpgradeCap has key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        cap: 0x2::package::UpgradeCap,
    }

    struct GovernanceVaultCreatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        governance_config_id: 0x2::object::ID,
        governance_authority: address,
        upgrade_authority: address,
        active_operator: address,
        active_operator_epoch: u64,
        fee_recipient: address,
        direct_authority_mode: u8,
    }

    struct FeeManagerCreatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        fee_manager_id: 0x2::object::ID,
        created_by: address,
    }

    struct GovernanceConfigBoundEvent has copy, drop {
        registry_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        governance_config_id: 0x2::object::ID,
        bound_by: address,
    }

    struct OperatorNominatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        nominated_by: address,
        new_operator: address,
        operator_epoch: u64,
        pending_operator_wrapper_id: 0x2::object::ID,
    }

    struct OperatorTransferAcceptedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        accepted_by: address,
        operator_epoch: u64,
        operator_wrapper_id: 0x2::object::ID,
    }

    struct OperatorTransferCancelledEvent has copy, drop {
        registry_id: 0x2::object::ID,
        cancelled_by: address,
        pending_operator: address,
        pending_operator_epoch: u64,
        pending_operator_wrapper_id: 0x2::object::ID,
    }

    struct FeeRecipientChangedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        changed_by: address,
        old_fee_recipient: address,
        new_fee_recipient: address,
    }

    struct GovernanceAuthorityChangedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        changed_by: address,
        old_governance_authority: address,
        new_governance_authority: address,
    }

    struct CommentsFeeLevelChangedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        changed_by: address,
        old_level: u8,
        new_level: u8,
        new_amount: u64,
    }

    struct ArtifactFeeLevelChangedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        artifact_type: u8,
        changed_by: address,
        old_fee_level: u8,
        fee_level: u8,
        fee_amount: u64,
    }

    struct UpgradeAuthorityChangedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        changed_by: address,
        old_upgrade_authority: address,
        new_upgrade_authority: address,
    }

    struct FeeCollectedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        fee_key: u8,
        artifact_type: u8,
        payer: address,
        recipient: address,
        amount: u64,
    }

    struct DirectAuthorityModeChangedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        changed_by: address,
        old_mode: u8,
        new_mode: u8,
        permanently_disabled: bool,
    }

    struct ManagedUpgradeCapRegisteredEvent has copy, drop {
        registry_id: 0x2::object::ID,
        registered_by: address,
        package_id: 0x2::object::ID,
    }

    struct ManagedUpgradeAuthorizedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        authorized_by: address,
        package_id: 0x2::object::ID,
        policy: u8,
        digest: vector<u8>,
    }

    struct ManagedUpgradeCommittedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        committed_by: address,
        package_id: 0x2::object::ID,
    }

    struct GovernanceVaultMigratedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        migrated_by: address,
        new_version: u64,
    }

    public fun accept_operator_transfer(arg0: &mut GovernanceVault, arg1: 0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::PendingOwnershipTransfer<OperatorPermit>, arg2: 0x2::transfer::Receiving<0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::TwoStepTransferWrapper<OperatorPermit>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
        assert!(arg0.has_pending_operator_transfer, 5);
        assert!(0x2::transfer::receiving_object_id<0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::TwoStepTransferWrapper<OperatorPermit>>(&arg2) == arg0.pending_operator_wrapper_id, 17);
        0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::accept_transfer<OperatorPermit>(arg1, arg2, arg3);
        arg0.active_operator = arg0.pending_operator;
        arg0.active_operator_epoch = arg0.pending_operator_epoch;
        arg0.pending_operator = @0x0;
        arg0.pending_operator_epoch = 0;
        arg0.pending_operator_wrapper_id = 0x2::object::id_from_address(@0x0);
        arg0.has_pending_operator_transfer = false;
        let v0 = OperatorTransferAcceptedEvent{
            registry_id         : arg0.registry_id,
            accepted_by         : 0x2::tx_context::sender(arg3),
            operator_epoch      : arg0.active_operator_epoch,
            operator_wrapper_id : arg0.pending_operator_wrapper_id,
        };
        0x2::event::emit<OperatorTransferAcceptedEvent>(v0);
    }

    public fun action_executor_cap_registry_id(arg0: &GovernanceActionExecutorCap) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun action_ticket_action_type(arg0: &GovernanceActionTicket) : u8 {
        arg0.action_type
    }

    public fun action_ticket_payload_u64_1(arg0: &GovernanceActionTicket) : u64 {
        arg0.payload_u64_1
    }

    public fun action_ticket_payload_u64_2(arg0: &GovernanceActionTicket) : u64 {
        arg0.payload_u64_2
    }

    public fun action_ticket_registry_id(arg0: &GovernanceActionTicket) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun active_operator(arg0: &GovernanceVault) : address {
        arg0.active_operator
    }

    public fun active_operator_epoch(arg0: &GovernanceVault) : u64 {
        arg0.active_operator_epoch
    }

    public fun apply_artifact_fee_level_from_ticket(arg0: &GovernanceVault, arg1: &mut FeeManager, arg2: GovernanceActionTicket) {
        assert_current_vault(arg0);
        let GovernanceActionTicket {
            registry_id   : v0,
            action_type   : v1,
            payload_u64_1 : v2,
            payload_u64_2 : v3,
            executed_by   : v4,
        } = arg2;
        assert!(v0 == arg0.registry_id, 6);
        assert!(arg1.registry_id == arg0.registry_id, 6);
        assert!(v1 == 10 || v1 == 11, 1);
        let v5 = (v2 as u8);
        let v6 = (v3 as u8);
        assert_valid_fee_level(v6);
        let v7 = artifact_fee_level(arg1, v5);
        set_fee_level(arg1, v5, v6);
        let v8 = ArtifactFeeLevelChangedEvent{
            registry_id   : arg1.registry_id,
            artifact_type : v5,
            changed_by    : v4,
            old_fee_level : v7,
            fee_level     : v6,
            fee_amount    : fee_amount_for_level(v6),
        };
        0x2::event::emit<ArtifactFeeLevelChangedEvent>(v8);
    }

    fun apply_comments_fee_level(arg0: &mut FeeManager, arg1: u8, arg2: address) {
        assert_valid_fee_level(arg1);
        let v0 = comments_fee_level(arg0);
        set_fee_level(arg0, 0, arg1);
        let v1 = CommentsFeeLevelChangedEvent{
            registry_id : arg0.registry_id,
            changed_by  : arg2,
            old_level   : v0,
            new_level   : arg1,
            new_amount  : fee_amount_for_level(arg1),
        };
        0x2::event::emit<CommentsFeeLevelChangedEvent>(v1);
    }

    public(friend) fun apply_comments_fee_level_from_ticket(arg0: &GovernanceVault, arg1: &mut FeeManager, arg2: GovernanceActionTicket) {
        assert_current_vault(arg0);
        let GovernanceActionTicket {
            registry_id   : v0,
            action_type   : v1,
            payload_u64_1 : v2,
            payload_u64_2 : _,
            executed_by   : v4,
        } = arg2;
        assert!(v0 == arg0.registry_id, 6);
        assert!(arg1.registry_id == arg0.registry_id, 6);
        assert!(v1 == 2, 1);
        apply_comments_fee_level(arg1, (v2 as u8), v4);
    }

    public(friend) fun apply_direct_authority_mode_from_vote(arg0: &mut GovernanceVault, arg1: u8, arg2: address) {
        assert_valid_direct_authority_mode(arg1);
        assert!(!arg0.direct_authority_permanently_disabled || arg1 == 3, 16);
        arg0.direct_authority_mode = arg1;
        if (arg1 == 3) {
            arg0.direct_authority_permanently_disabled = true;
        };
        let v0 = DirectAuthorityModeChangedEvent{
            registry_id          : arg0.registry_id,
            changed_by           : arg2,
            old_mode             : arg0.direct_authority_mode,
            new_mode             : arg1,
            permanently_disabled : arg0.direct_authority_permanently_disabled,
        };
        0x2::event::emit<DirectAuthorityModeChangedEvent>(v0);
    }

    public(friend) fun apply_fee_recipient(arg0: &mut GovernanceVault, arg1: address, arg2: address) {
        assert!(arg1 != @0x0, 1);
        arg0.fee_recipient = arg1;
        let v0 = FeeRecipientChangedEvent{
            registry_id       : arg0.registry_id,
            changed_by        : arg2,
            old_fee_recipient : arg0.fee_recipient,
            new_fee_recipient : arg1,
        };
        0x2::event::emit<FeeRecipientChangedEvent>(v0);
    }

    public(friend) fun apply_governance_authority(arg0: &mut GovernanceVault, arg1: address, arg2: address) {
        assert!(arg1 != @0x0, 1);
        arg0.governance_authority = arg1;
        let v0 = GovernanceAuthorityChangedEvent{
            registry_id              : arg0.registry_id,
            changed_by               : arg2,
            old_governance_authority : arg0.governance_authority,
            new_governance_authority : arg1,
        };
        0x2::event::emit<GovernanceAuthorityChangedEvent>(v0);
    }

    public(friend) fun apply_upgrade_authority(arg0: &mut GovernanceVault, arg1: address, arg2: address) {
        assert!(arg1 != @0x0, 1);
        arg0.upgrade_authority = arg1;
        let v0 = UpgradeAuthorityChangedEvent{
            registry_id           : arg0.registry_id,
            changed_by            : arg2,
            old_upgrade_authority : arg0.upgrade_authority,
            new_upgrade_authority : arg1,
        };
        0x2::event::emit<UpgradeAuthorityChangedEvent>(v0);
    }

    public fun artifact_fee_amount(arg0: &FeeManager, arg1: u8) : u64 {
        fee_amount_for_level(artifact_fee_level(arg0, arg1))
    }

    public fun artifact_fee_level(arg0: &FeeManager, arg1: u8) : u8 {
        fee_level(arg0, arg1)
    }

    public fun assert_action_executor_cap(arg0: &GovernanceVault, arg1: &GovernanceActionExecutorCap) {
        assert_current_vault(arg0);
        assert!(arg1.registry_id == arg0.registry_id, 6);
        assert!(arg1.governance_vault_id == 0x2::object::id<GovernanceVault>(arg0), 6);
    }

    public fun assert_active_operator(arg0: &GovernanceVault, arg1: &OperatorPermit, arg2: 0x2::object::ID, arg3: address) {
        assert_current_vault(arg0);
        assert!(arg0.registry_id == arg2, 6);
        assert!(arg1.registry_id == arg2, 6);
        assert!(arg3 == arg0.active_operator, 7);
        assert!(arg1.operator_epoch == arg0.active_operator_epoch, 8);
    }

    public fun assert_current_vault(arg0: &GovernanceVault) {
        assert!(arg0.version == 1, 13);
    }

    fun assert_direct_authority_allowed(arg0: &GovernanceVault, arg1: bool) {
        assert!(arg0.direct_authority_mode == 0 || arg1 && arg0.direct_authority_mode == 1, 16);
    }

    public fun assert_upgrade_authority(arg0: &GovernanceVault, arg1: address) {
        assert_current_vault(arg0);
        assert!(arg1 == arg0.upgrade_authority, 12);
    }

    public fun assert_valid_direct_authority_mode(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else {
            arg0 == 3
        };
        assert!(v0, 15);
    }

    public fun assert_valid_fee_level(arg0: u8) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else {
            arg0 == 5
        };
        assert!(v0, 9);
    }

    public fun authorize_managed_upgrade(arg0: &GovernanceVault, arg1: &mut ManagedUpgradeCap, arg2: u8, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        assert_current_vault(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.upgrade_authority, 12);
        assert!(arg1.registry_id == arg0.registry_id, 6);
        let v0 = ManagedUpgradeAuthorizedEvent{
            registry_id   : arg0.registry_id,
            authorized_by : 0x2::tx_context::sender(arg4),
            package_id    : 0x2::package::upgrade_package(&arg1.cap),
            policy        : arg2,
            digest        : arg3,
        };
        0x2::event::emit<ManagedUpgradeAuthorizedEvent>(v0);
        0x2::package::authorize_upgrade(&mut arg1.cap, arg2, arg3)
    }

    public(friend) fun bind_governance_config(arg0: &mut GovernanceVault, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
        assert!(arg0.governance_config_id == 0x2::object::id_from_address(@0x0), 18);
        arg0.governance_config_id = arg1;
        let v0 = GovernanceConfigBoundEvent{
            registry_id          : arg0.registry_id,
            vault_id             : 0x2::object::id<GovernanceVault>(arg0),
            governance_config_id : arg1,
            bound_by             : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<GovernanceConfigBoundEvent>(v0);
    }

    public fun borrow_admin_cap(arg0: &GovernanceVault) : &AdminCap {
        &arg0.admin_cap
    }

    public fun borrow_operator_from_wrapper(arg0: &0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::TwoStepTransferWrapper<OperatorPermit>) : &OperatorPermit {
        0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::borrow<OperatorPermit>(arg0)
    }

    public fun cancel_operator_transfer(arg0: &mut GovernanceVault, arg1: 0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::PendingOwnershipTransfer<OperatorPermit>, arg2: 0x2::transfer::Receiving<0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::TwoStepTransferWrapper<OperatorPermit>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
        assert_direct_authority_allowed(arg0, true);
        assert!(0x2::tx_context::sender(arg3) == arg0.governance_authority, 3);
        assert!(arg0.has_pending_operator_transfer, 5);
        assert!(0x2::transfer::receiving_object_id<0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::TwoStepTransferWrapper<OperatorPermit>>(&arg2) == arg0.pending_operator_wrapper_id, 17);
        0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::cancel_transfer<OperatorPermit>(arg1, arg2, arg3);
        arg0.pending_operator = @0x0;
        arg0.pending_operator_epoch = 0;
        arg0.pending_operator_wrapper_id = 0x2::object::id_from_address(@0x0);
        arg0.has_pending_operator_transfer = false;
        let v0 = OperatorTransferCancelledEvent{
            registry_id                 : arg0.registry_id,
            cancelled_by                : 0x2::tx_context::sender(arg3),
            pending_operator            : arg0.pending_operator,
            pending_operator_epoch      : arg0.pending_operator_epoch,
            pending_operator_wrapper_id : arg0.pending_operator_wrapper_id,
        };
        0x2::event::emit<OperatorTransferCancelledEvent>(v0);
    }

    public(friend) fun cancel_operator_transfer_from_vote(arg0: &mut GovernanceVault, arg1: 0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::PendingOwnershipTransfer<OperatorPermit>, arg2: 0x2::transfer::Receiving<0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::TwoStepTransferWrapper<OperatorPermit>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
        assert!(arg0.has_pending_operator_transfer, 5);
        assert!(0x2::transfer::receiving_object_id<0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::TwoStepTransferWrapper<OperatorPermit>>(&arg2) == arg0.pending_operator_wrapper_id, 17);
        0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::cancel_transfer<OperatorPermit>(arg1, arg2, arg3);
        arg0.pending_operator = @0x0;
        arg0.pending_operator_epoch = 0;
        arg0.pending_operator_wrapper_id = 0x2::object::id_from_address(@0x0);
        arg0.has_pending_operator_transfer = false;
        let v0 = OperatorTransferCancelledEvent{
            registry_id                 : arg0.registry_id,
            cancelled_by                : 0x2::tx_context::sender(arg3),
            pending_operator            : arg0.pending_operator,
            pending_operator_epoch      : arg0.pending_operator_epoch,
            pending_operator_wrapper_id : arg0.pending_operator_wrapper_id,
        };
        0x2::event::emit<OperatorTransferCancelledEvent>(v0);
    }

    public fun collect_artifact_fee(arg0: &GovernanceVault, arg1: &FeeManager, arg2: u8, arg3: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
        assert!(arg1.registry_id == arg0.registry_id, 6);
        collect_fee(arg0, arg2, arg2, artifact_fee_amount(arg1, arg2), arg3, arg4);
    }

    public fun collect_comments_fee(arg0: &GovernanceVault, arg1: &FeeManager, arg2: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
        assert!(arg1.registry_id == arg0.registry_id, 6);
        collect_fee(arg0, 0, 0, comments_fee_amount(arg1), arg2, arg3);
    }

    fun collect_fee(arg0: &GovernanceVault, arg1: u8, arg2: u8, arg3: u64, arg4: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        if (arg3 == 0) {
            if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg4)) {
                refund_or_destroy(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg4), v0);
            };
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg4);
            return
        };
        assert!(0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg4), 10);
        let v1 = 0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg4);
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v1) >= arg3, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, arg3, arg5), arg0.fee_recipient);
        let v2 = FeeCollectedEvent{
            registry_id   : arg0.registry_id,
            fee_key       : arg1,
            artifact_type : arg2,
            payer         : v0,
            recipient     : arg0.fee_recipient,
            amount        : arg3,
        };
        0x2::event::emit<FeeCollectedEvent>(v2);
        refund_or_destroy(v1, v0);
    }

    public fun comments_fee_amount(arg0: &FeeManager) : u64 {
        fee_amount_for_level(comments_fee_level(arg0))
    }

    public fun comments_fee_level(arg0: &FeeManager) : u8 {
        fee_level(arg0, 0)
    }

    public fun commit_managed_upgrade(arg0: &GovernanceVault, arg1: &mut ManagedUpgradeCap, arg2: 0x2::package::UpgradeReceipt, arg3: &0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.upgrade_authority, 12);
        assert!(arg1.registry_id == arg0.registry_id, 6);
        0x2::package::commit_upgrade(&mut arg1.cap, arg2);
        let v0 = ManagedUpgradeCommittedEvent{
            registry_id  : arg0.registry_id,
            committed_by : 0x2::tx_context::sender(arg3),
            package_id   : 0x2::package::upgrade_package(&arg1.cap),
        };
        0x2::event::emit<ManagedUpgradeCommittedEvent>(v0);
    }

    public fun current_governance_vault_version() : u64 {
        1
    }

    public fun direct_authority_mode(arg0: &GovernanceVault) : u8 {
        arg0.direct_authority_mode
    }

    public fun direct_authority_mode_disabled() : u8 {
        3
    }

    public fun direct_authority_mode_emergency() : u8 {
        1
    }

    public fun direct_authority_mode_full() : u8 {
        0
    }

    public fun direct_authority_mode_read_only() : u8 {
        2
    }

    public fun direct_authority_permanently_disabled(arg0: &GovernanceVault) : bool {
        arg0.direct_authority_permanently_disabled
    }

    fun fee_amount_for_level(arg0: u8) : u64 {
        assert_valid_fee_level(arg0);
        if (arg0 == 0) {
            0
        } else if (arg0 == 1) {
            10000
        } else if (arg0 == 2) {
            100000
        } else if (arg0 == 3) {
            1000000
        } else if (arg0 == 4) {
            10000000
        } else {
            100000000
        }
    }

    public fun fee_level(arg0: &FeeManager, arg1: u8) : u8 {
        if (0x2::table::contains<u8, u8>(&arg0.fee_levels, arg1)) {
            *0x2::table::borrow<u8, u8>(&arg0.fee_levels, arg1)
        } else {
            0
        }
    }

    public fun fee_manager_id(arg0: &FeeManager) : 0x2::object::ID {
        0x2::object::id<FeeManager>(arg0)
    }

    public fun fee_manager_registry_id(arg0: &FeeManager) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun fee_recipient(arg0: &GovernanceVault) : address {
        arg0.fee_recipient
    }

    public fun governance_authority(arg0: &GovernanceVault) : address {
        arg0.governance_authority
    }

    public fun governance_config_id(arg0: &GovernanceVault) : 0x2::object::ID {
        arg0.governance_config_id
    }

    public fun governance_vault_version(arg0: &GovernanceVault) : u64 {
        arg0.version
    }

    public fun has_pending_operator_transfer(arg0: &GovernanceVault) : bool {
        arg0.has_pending_operator_transfer
    }

    public fun managed_upgrade_package(arg0: &ManagedUpgradeCap) : 0x2::object::ID {
        0x2::package::upgrade_package(&arg0.cap)
    }

    public fun migrate_vault(arg0: &mut GovernanceVault, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.upgrade_authority, 12);
        migrate_vault_version(arg0);
        let v0 = GovernanceVaultMigratedEvent{
            registry_id : arg0.registry_id,
            migrated_by : 0x2::tx_context::sender(arg1),
            new_version : arg0.version,
        };
        0x2::event::emit<GovernanceVaultMigratedEvent>(v0);
    }

    fun migrate_vault_version(arg0: &mut GovernanceVault) {
        assert!(arg0.version <= 1, 13);
        if (arg0.version < 1) {
            arg0.version = 1;
        };
    }

    public(friend) fun new_action_ticket(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: u64, arg4: address) : GovernanceActionTicket {
        GovernanceActionTicket{
            registry_id   : arg0,
            action_type   : arg1,
            payload_u64_1 : arg2,
            payload_u64_2 : arg3,
            executed_by   : arg4,
        }
    }

    public fun new_fee_manager(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : FeeManager {
        FeeManager{
            id          : 0x2::object::new(arg1),
            version     : 1,
            registry_id : arg0,
            fee_levels  : 0x2::table::new<u8, u8>(arg1),
        }
    }

    public fun new_vault(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (GovernanceVault, OperatorPermit) {
        assert!(arg1 != @0x0, 1);
        assert!(arg2 != @0x0, 2);
        let v0 = AdminCap{
            id          : 0x2::object::new(arg3),
            registry_id : arg0,
        };
        let v1 = GovernanceVault{
            id                                    : 0x2::object::new(arg3),
            version                               : 1,
            registry_id                           : arg0,
            governance_config_id                  : 0x2::object::id_from_address(@0x0),
            admin_cap                             : v0,
            governance_authority                  : arg1,
            upgrade_authority                     : arg1,
            active_operator                       : arg2,
            active_operator_epoch                 : 1,
            pending_operator                      : @0x0,
            pending_operator_epoch                : 0,
            pending_operator_wrapper_id           : 0x2::object::id_from_address(@0x0),
            has_pending_operator_transfer         : false,
            fee_recipient                         : arg1,
            direct_authority_mode                 : 0,
            direct_authority_permanently_disabled : false,
        };
        let v2 = OperatorPermit{
            id             : 0x2::object::new(arg3),
            registry_id    : arg0,
            operator_epoch : 1,
        };
        (v1, v2)
    }

    public fun new_vault_with_action_executor_cap(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (GovernanceVault, OperatorPermit, GovernanceActionExecutorCap) {
        let (v0, v1) = new_vault(arg0, arg1, arg2, arg3);
        let v2 = v0;
        let v3 = GovernanceActionExecutorCap{
            id                  : 0x2::object::new(arg3),
            registry_id         : arg0,
            governance_vault_id : 0x2::object::id<GovernanceVault>(&v2),
        };
        (v2, v1, v3)
    }

    public fun nominate_operator(arg0: &mut GovernanceVault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
        assert_direct_authority_allowed(arg0, true);
        assert!(0x2::tx_context::sender(arg2) == arg0.governance_authority, 3);
        let v0 = 0x2::tx_context::sender(arg2);
        nominate_operator_internal(arg0, arg1, v0, arg2);
    }

    public(friend) fun nominate_operator_from_vote(arg0: &mut GovernanceVault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        nominate_operator_internal(arg0, arg1, v0, arg2);
    }

    fun nominate_operator_internal(arg0: &mut GovernanceVault, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.has_pending_operator_transfer, 4);
        assert!(arg1 != @0x0, 2);
        let v0 = arg0.active_operator_epoch + 1;
        let v1 = OperatorPermit{
            id             : 0x2::object::new(arg3),
            registry_id    : arg0.registry_id,
            operator_epoch : v0,
        };
        arg0.pending_operator = arg1;
        arg0.pending_operator_epoch = v0;
        arg0.has_pending_operator_transfer = true;
        let v2 = 0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::wrap<OperatorPermit>(v1, arg3);
        let v3 = 0x2::object::id<0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::TwoStepTransferWrapper<OperatorPermit>>(&v2);
        arg0.pending_operator_wrapper_id = v3;
        0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::initiate_transfer<OperatorPermit>(v2, arg1, arg3);
        let v4 = OperatorNominatedEvent{
            registry_id                 : arg0.registry_id,
            nominated_by                : arg2,
            new_operator                : arg1,
            operator_epoch              : v0,
            pending_operator_wrapper_id : v3,
        };
        0x2::event::emit<OperatorNominatedEvent>(v4);
    }

    public fun operator_epoch(arg0: &OperatorPermit) : u64 {
        arg0.operator_epoch
    }

    public fun pending_operator(arg0: &GovernanceVault) : address {
        arg0.pending_operator
    }

    public fun pending_operator_epoch(arg0: &GovernanceVault) : u64 {
        arg0.pending_operator_epoch
    }

    public fun pending_operator_wrapper_id(arg0: &GovernanceVault) : 0x2::object::ID {
        arg0.pending_operator_wrapper_id
    }

    fun refund_or_destroy(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
        };
    }

    public fun register_managed_upgrade_cap(arg0: &GovernanceVault, arg1: 0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) : ManagedUpgradeCap {
        assert_current_vault(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.upgrade_authority, 12);
        let v0 = 0x2::package::upgrade_package(&arg1);
        assert!(0x2::object::id_to_address(&v0) != @0x0, 14);
        let v1 = ManagedUpgradeCap{
            id          : 0x2::object::new(arg2),
            registry_id : arg0.registry_id,
            cap         : arg1,
        };
        let v2 = ManagedUpgradeCapRegisteredEvent{
            registry_id   : arg0.registry_id,
            registered_by : 0x2::tx_context::sender(arg2),
            package_id    : 0x2::package::upgrade_package(&arg1),
        };
        0x2::event::emit<ManagedUpgradeCapRegisteredEvent>(v2);
        v1
    }

    public fun registry_id(arg0: &GovernanceVault) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun set_comments_fee_level(arg0: &GovernanceVault, arg1: &mut FeeManager, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
        assert_direct_authority_allowed(arg0, false);
        assert!(0x2::tx_context::sender(arg3) == arg0.governance_authority, 3);
        assert!(arg1.registry_id == arg0.registry_id, 6);
        apply_comments_fee_level(arg1, arg2, 0x2::tx_context::sender(arg3));
    }

    fun set_fee_level(arg0: &mut FeeManager, arg1: u8, arg2: u8) {
        assert_valid_fee_level(arg2);
        if (0x2::table::contains<u8, u8>(&arg0.fee_levels, arg1)) {
            *0x2::table::borrow_mut<u8, u8>(&mut arg0.fee_levels, arg1) = arg2;
        } else {
            0x2::table::add<u8, u8>(&mut arg0.fee_levels, arg1, arg2);
        };
    }

    public fun set_fee_recipient(arg0: &mut GovernanceVault, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
        assert_direct_authority_allowed(arg0, false);
        assert!(0x2::tx_context::sender(arg2) == arg0.governance_authority, 3);
        apply_fee_recipient(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun set_governance_authority(arg0: &mut GovernanceVault, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
        assert_direct_authority_allowed(arg0, true);
        assert!(0x2::tx_context::sender(arg2) == arg0.governance_authority, 3);
        apply_governance_authority(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun set_upgrade_authority(arg0: &mut GovernanceVault, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
        assert_direct_authority_allowed(arg0, true);
        assert!(0x2::tx_context::sender(arg2) == arg0.governance_authority, 3);
        apply_upgrade_authority(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun share_fee_manager(arg0: FeeManager) {
        0x2::transfer::share_object<FeeManager>(arg0);
    }

    public fun share_managed_upgrade_cap(arg0: ManagedUpgradeCap) {
        0x2::transfer::share_object<ManagedUpgradeCap>(arg0);
    }

    public fun share_vault(arg0: GovernanceVault) {
        0x2::transfer::share_object<GovernanceVault>(arg0);
    }

    public fun unpack_artifact_type_enabled_ticket(arg0: GovernanceActionTicket) : (0x2::object::ID, u64, u64, address) {
        let GovernanceActionTicket {
            registry_id   : v0,
            action_type   : v1,
            payload_u64_1 : v2,
            payload_u64_2 : v3,
            executed_by   : v4,
        } = arg0;
        assert!(v1 == 9, 1);
        (v0, v2, v3, v4)
    }

    public fun unwrap_operator_permit(arg0: 0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::TwoStepTransferWrapper<OperatorPermit>, arg1: &mut 0x2::tx_context::TxContext) : OperatorPermit {
        0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::unwrap<OperatorPermit>(arg0, arg1)
    }

    public fun upgrade_authority(arg0: &GovernanceVault) : address {
        arg0.upgrade_authority
    }

    // decompiled from Move bytecode v7
}

