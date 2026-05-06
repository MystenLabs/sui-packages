module 0x5e9624d571464b0edd55bbef88f7d603079f1b5e336873ec853eeaafc76b0ba6::governance {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct GovernanceVault has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        admin_cap: AdminCap,
        governance_authority: address,
        upgrade_authority: address,
        active_operator: address,
        active_operator_epoch: u64,
        pending_operator: address,
        pending_operator_epoch: u64,
        has_pending_operator_transfer: bool,
        fee_recipient: address,
        publishing_fee_level: u8,
        comments_fee_level: u8,
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

    struct OperatorNominatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        nominated_by: address,
        new_operator: address,
        operator_epoch: u64,
    }

    struct OperatorTransferAcceptedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        accepted_by: address,
        operator_epoch: u64,
    }

    struct OperatorTransferCancelledEvent has copy, drop {
        registry_id: 0x2::object::ID,
        cancelled_by: address,
        pending_operator: address,
        pending_operator_epoch: u64,
    }

    struct FeeRecipientChangedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        changed_by: address,
        new_fee_recipient: address,
    }

    struct PublishingFeeLevelChangedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        changed_by: address,
        new_level: u8,
        new_amount: u64,
    }

    struct CommentsFeeLevelChangedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        changed_by: address,
        new_level: u8,
        new_amount: u64,
    }

    struct UpgradeAuthorityChangedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        changed_by: address,
        new_upgrade_authority: address,
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
        0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::accept_transfer<OperatorPermit>(arg1, arg2, arg3);
        arg0.active_operator = arg0.pending_operator;
        arg0.active_operator_epoch = arg0.pending_operator_epoch;
        arg0.pending_operator = @0x0;
        arg0.pending_operator_epoch = 0;
        arg0.has_pending_operator_transfer = false;
        let v0 = OperatorTransferAcceptedEvent{
            registry_id    : arg0.registry_id,
            accepted_by    : 0x2::tx_context::sender(arg3),
            operator_epoch : arg0.active_operator_epoch,
        };
        0x2::event::emit<OperatorTransferAcceptedEvent>(v0);
    }

    public fun active_operator(arg0: &GovernanceVault) : address {
        arg0.active_operator
    }

    public fun active_operator_epoch(arg0: &GovernanceVault) : u64 {
        arg0.active_operator_epoch
    }

    public(friend) fun apply_comments_fee_level(arg0: &mut GovernanceVault, arg1: u8, arg2: address) {
        assert_valid_fee_level(arg1);
        arg0.comments_fee_level = arg1;
        let v0 = CommentsFeeLevelChangedEvent{
            registry_id : arg0.registry_id,
            changed_by  : arg2,
            new_level   : arg1,
            new_amount  : fee_amount_for_level(arg1),
        };
        0x2::event::emit<CommentsFeeLevelChangedEvent>(v0);
    }

    public(friend) fun apply_fee_recipient(arg0: &mut GovernanceVault, arg1: address, arg2: address) {
        assert!(arg1 != @0x0, 1);
        arg0.fee_recipient = arg1;
        let v0 = FeeRecipientChangedEvent{
            registry_id       : arg0.registry_id,
            changed_by        : arg2,
            new_fee_recipient : arg1,
        };
        0x2::event::emit<FeeRecipientChangedEvent>(v0);
    }

    public(friend) fun apply_publishing_fee_level(arg0: &mut GovernanceVault, arg1: u8, arg2: address) {
        assert_valid_fee_level(arg1);
        arg0.publishing_fee_level = arg1;
        let v0 = PublishingFeeLevelChangedEvent{
            registry_id : arg0.registry_id,
            changed_by  : arg2,
            new_level   : arg1,
            new_amount  : fee_amount_for_level(arg1),
        };
        0x2::event::emit<PublishingFeeLevelChangedEvent>(v0);
    }

    public(friend) fun apply_upgrade_authority(arg0: &mut GovernanceVault, arg1: address, arg2: address) {
        assert!(arg1 != @0x0, 1);
        arg0.upgrade_authority = arg1;
        let v0 = UpgradeAuthorityChangedEvent{
            registry_id           : arg0.registry_id,
            changed_by            : arg2,
            new_upgrade_authority : arg1,
        };
        0x2::event::emit<UpgradeAuthorityChangedEvent>(v0);
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

    public fun assert_upgrade_authority(arg0: &GovernanceVault, arg1: address) {
        assert_current_vault(arg0);
        assert!(arg1 == arg0.upgrade_authority, 12);
    }

    fun assert_valid_fee_level(arg0: u8) {
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
        };
        0x2::event::emit<ManagedUpgradeAuthorizedEvent>(v0);
        0x2::package::authorize_upgrade(&mut arg1.cap, arg2, arg3)
    }

    public fun borrow_admin_cap(arg0: &GovernanceVault) : &AdminCap {
        &arg0.admin_cap
    }

    public fun borrow_operator_from_wrapper(arg0: &0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::TwoStepTransferWrapper<OperatorPermit>) : &OperatorPermit {
        0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::borrow<OperatorPermit>(arg0)
    }

    public fun cancel_operator_transfer(arg0: &mut GovernanceVault, arg1: 0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::PendingOwnershipTransfer<OperatorPermit>, arg2: 0x2::transfer::Receiving<0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::TwoStepTransferWrapper<OperatorPermit>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.governance_authority, 3);
        assert!(arg0.has_pending_operator_transfer, 5);
        0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::cancel_transfer<OperatorPermit>(arg1, arg2, arg3);
        arg0.pending_operator = @0x0;
        arg0.pending_operator_epoch = 0;
        arg0.has_pending_operator_transfer = false;
        let v0 = OperatorTransferCancelledEvent{
            registry_id            : arg0.registry_id,
            cancelled_by           : 0x2::tx_context::sender(arg3),
            pending_operator       : arg0.pending_operator,
            pending_operator_epoch : arg0.pending_operator_epoch,
        };
        0x2::event::emit<OperatorTransferCancelledEvent>(v0);
    }

    public fun collect_comments_fee(arg0: &GovernanceVault, arg1: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
        collect_fee(arg0, comments_fee_amount(arg0), arg1, arg2);
    }

    fun collect_fee(arg0: &GovernanceVault, arg1: u64, arg2: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg2)) {
                refund_or_destroy(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2), 0x2::tx_context::sender(arg3));
            };
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
            return
        };
        assert!(0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(&arg2), 10);
        let v0 = 0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2);
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v0) >= arg1, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, arg1, arg3), arg0.fee_recipient);
        refund_or_destroy(v0, 0x2::tx_context::sender(arg3));
    }

    public fun collect_publishing_fee(arg0: &GovernanceVault, arg1: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
        collect_fee(arg0, publishing_fee_amount(arg0), arg1, arg2);
    }

    public fun comments_fee_amount(arg0: &GovernanceVault) : u64 {
        fee_amount_for_level(arg0.comments_fee_level)
    }

    public fun comments_fee_level(arg0: &GovernanceVault) : u8 {
        arg0.comments_fee_level
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

    public fun fee_recipient(arg0: &GovernanceVault) : address {
        arg0.fee_recipient
    }

    public fun governance_authority(arg0: &GovernanceVault) : address {
        arg0.governance_authority
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

    public fun new_vault(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (GovernanceVault, OperatorPermit) {
        assert!(arg1 != @0x0, 1);
        assert!(arg2 != @0x0, 2);
        let v0 = AdminCap{
            id          : 0x2::object::new(arg3),
            registry_id : arg0,
        };
        let v1 = GovernanceVault{
            id                            : 0x2::object::new(arg3),
            version                       : 1,
            registry_id                   : arg0,
            admin_cap                     : v0,
            governance_authority          : arg1,
            upgrade_authority             : arg1,
            active_operator               : arg2,
            active_operator_epoch         : 1,
            pending_operator              : @0x0,
            pending_operator_epoch        : 0,
            has_pending_operator_transfer : false,
            fee_recipient                 : arg1,
            publishing_fee_level          : 0,
            comments_fee_level            : 0,
        };
        let v2 = OperatorPermit{
            id             : 0x2::object::new(arg3),
            registry_id    : arg0,
            operator_epoch : 1,
        };
        (v1, v2)
    }

    public fun nominate_operator(arg0: &mut GovernanceVault, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
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
        0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::initiate_transfer<OperatorPermit>(0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::wrap<OperatorPermit>(v1, arg3), arg1, arg3);
        let v2 = OperatorNominatedEvent{
            registry_id    : arg0.registry_id,
            nominated_by   : arg2,
            new_operator   : arg1,
            operator_epoch : v0,
        };
        0x2::event::emit<OperatorNominatedEvent>(v2);
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

    public fun publishing_fee_amount(arg0: &GovernanceVault) : u64 {
        fee_amount_for_level(arg0.publishing_fee_level)
    }

    public fun publishing_fee_level(arg0: &GovernanceVault) : u8 {
        arg0.publishing_fee_level
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

    public fun set_comments_fee_level(arg0: &mut GovernanceVault, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.governance_authority, 3);
        apply_comments_fee_level(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun set_fee_recipient(arg0: &mut GovernanceVault, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.governance_authority, 3);
        apply_fee_recipient(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun set_publishing_fee_level(arg0: &mut GovernanceVault, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.governance_authority, 3);
        apply_publishing_fee_level(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun set_upgrade_authority(arg0: &mut GovernanceVault, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_current_vault(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.governance_authority, 3);
        apply_upgrade_authority(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun share_managed_upgrade_cap(arg0: ManagedUpgradeCap) {
        0x2::transfer::share_object<ManagedUpgradeCap>(arg0);
    }

    public fun share_vault(arg0: GovernanceVault) {
        0x2::transfer::share_object<GovernanceVault>(arg0);
    }

    public fun unwrap_operator_permit(arg0: 0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::TwoStepTransferWrapper<OperatorPermit>, arg1: &mut 0x2::tx_context::TxContext) : OperatorPermit {
        0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::unwrap<OperatorPermit>(arg0, arg1)
    }

    public fun upgrade_authority(arg0: &GovernanceVault) : address {
        arg0.upgrade_authority
    }

    // decompiled from Move bytecode v7
}

