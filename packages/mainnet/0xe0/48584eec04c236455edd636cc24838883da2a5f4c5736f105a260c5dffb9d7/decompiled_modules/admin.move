module 0xe048584eec04c236455edd636cc24838883da2a5f4c5736f105a260c5dffb9d7::admin {
    struct ADMIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    struct GuardianCap has key {
        id: 0x2::object::UID,
    }

    struct AdminRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        valid_operator_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
        valid_guardian_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
        protocol_fee_recipient: address,
        pending_fee_recipient: 0x1::option::Option<PendingFeeRecipient>,
        extra: 0x2::bag::Bag,
    }

    struct PendingFeeRecipient has drop, store {
        new_address: address,
        eta_ms: u64,
    }

    struct PendingAdminTransfer has key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        proposer: address,
        recipient: address,
        accept_after_ms: u64,
    }

    struct AdminTransferProposed has copy, drop {
        pending_transfer_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        proposer: address,
        recipient: address,
        accept_after_ms: u64,
    }

    struct AdminTransferAccepted has copy, drop {
        admin_cap_id: 0x2::object::ID,
        new_admin: address,
    }

    struct AdminTransferCancelled has copy, drop {
        admin_cap_id: 0x2::object::ID,
        proposer: address,
        recipient: address,
    }

    struct AdminTransferGuardianCancelled has copy, drop {
        admin_cap_id: 0x2::object::ID,
        proposer: address,
        recipient: address,
    }

    struct RegistryMigrated has copy, drop {
        registry_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
    }

    struct OperatorCapMinted has copy, drop {
        cap_id: 0x2::object::ID,
        recipient: address,
        registry_version: u64,
    }

    struct OperatorCapRevoked has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct GuardianCapMinted has copy, drop {
        cap_id: 0x2::object::ID,
        recipient: address,
        registry_version: u64,
    }

    struct GuardianCapRevoked has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct AllCapsRevoked has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct FeeRecipientProposed has copy, drop {
        registry_id: 0x2::object::ID,
        new_address: address,
        eta_ms: u64,
    }

    struct FeeRecipientChanged has copy, drop {
        registry_id: 0x2::object::ID,
        old_address: address,
        new_address: address,
    }

    struct FeeRecipientCancelled has copy, drop {
        registry_id: 0x2::object::ID,
        new_address: address,
    }

    struct AdminInitialized has copy, drop {
        admin_cap_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        admin: address,
    }

    entry fun accept_admin(arg0: &AdminRegistry, arg1: PendingAdminTransfer, arg2: 0x2::transfer::Receiving<AdminCap>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_registry_recovery_version(arg0);
        let PendingAdminTransfer {
            id              : v0,
            admin_cap_id    : v1,
            proposer        : _,
            recipient       : v3,
            accept_after_ms : v4,
        } = arg1;
        let v5 = v0;
        assert!(0x2::tx_context::sender(arg4) == v3, 100);
        assert!(0x2::clock::timestamp_ms(arg3) >= v4, 103);
        assert!(0x2::transfer::receiving_object_id<AdminCap>(&arg2) == v1, 102);
        0x2::object::delete(v5);
        let v6 = AdminTransferAccepted{
            admin_cap_id : v1,
            new_admin    : v3,
        };
        0x2::event::emit<AdminTransferAccepted>(v6);
        0x2::transfer::transfer<AdminCap>(0x2::transfer::receive<AdminCap>(&mut v5, arg2), v3);
    }

    fun add_timelock(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 110);
        arg0 + arg1
    }

    public fun admin_transfer_timelock_ms() : u64 {
        172800000
    }

    entry fun apply_fee_recipient(arg0: &AdminCap, arg1: &mut AdminRegistry, arg2: &0x2::clock::Clock) {
        assert_registry_version(arg1);
        assert!(0x1::option::is_some<PendingFeeRecipient>(&arg1.pending_fee_recipient), 107);
        let PendingFeeRecipient {
            new_address : v0,
            eta_ms      : v1,
        } = 0x1::option::extract<PendingFeeRecipient>(&mut arg1.pending_fee_recipient);
        assert!(0x2::clock::timestamp_ms(arg2) >= v1, 108);
        arg1.protocol_fee_recipient = v0;
        let v2 = FeeRecipientChanged{
            registry_id : 0x2::object::id<AdminRegistry>(arg1),
            old_address : arg1.protocol_fee_recipient,
            new_address : v0,
        };
        0x2::event::emit<FeeRecipientChanged>(v2);
    }

    public(friend) fun assert_guardian_cap(arg0: &AdminRegistry, arg1: &GuardianCap) {
        assert_registry_version(arg0);
        let v0 = 0x2::object::id<GuardianCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.valid_guardian_caps, &v0), 105);
    }

    public(friend) fun assert_guardian_cap_recovery(arg0: &AdminRegistry, arg1: &GuardianCap) {
        assert_registry_recovery_version(arg0);
        let v0 = 0x2::object::id<GuardianCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.valid_guardian_caps, &v0), 105);
    }

    public(friend) fun assert_nonzero_recipient(arg0: address) {
        assert!(arg0 != @0x0, 114);
    }

    public(friend) fun assert_operator_cap(arg0: &AdminRegistry, arg1: &OperatorCap) {
        assert_registry_version(arg0);
        let v0 = 0x2::object::id<OperatorCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.valid_operator_caps, &v0), 104);
    }

    fun assert_registry_recovery_version(arg0: &AdminRegistry) {
        assert!(arg0.version <= 1, 106);
    }

    public(friend) fun assert_registry_version(arg0: &AdminRegistry) {
        assert!(1 == arg0.version, 106);
    }

    entry fun cancel_admin_transfer(arg0: &AdminRegistry, arg1: PendingAdminTransfer, arg2: 0x2::transfer::Receiving<AdminCap>, arg3: &0x2::tx_context::TxContext) {
        assert_registry_recovery_version(arg0);
        let PendingAdminTransfer {
            id              : v0,
            admin_cap_id    : v1,
            proposer        : v2,
            recipient       : v3,
            accept_after_ms : _,
        } = arg1;
        let v5 = v0;
        assert!(0x2::tx_context::sender(arg3) == v2, 101);
        assert!(0x2::transfer::receiving_object_id<AdminCap>(&arg2) == v1, 102);
        0x2::object::delete(v5);
        let v6 = AdminTransferCancelled{
            admin_cap_id : v1,
            proposer     : v2,
            recipient    : v3,
        };
        0x2::event::emit<AdminTransferCancelled>(v6);
        0x2::transfer::transfer<AdminCap>(0x2::transfer::receive<AdminCap>(&mut v5, arg2), v2);
    }

    entry fun cancel_fee_recipient(arg0: &AdminCap, arg1: &mut AdminRegistry) {
        assert_registry_version(arg1);
        assert!(0x1::option::is_some<PendingFeeRecipient>(&arg1.pending_fee_recipient), 107);
        let PendingFeeRecipient {
            new_address : v0,
            eta_ms      : _,
        } = 0x1::option::extract<PendingFeeRecipient>(&mut arg1.pending_fee_recipient);
        let v2 = FeeRecipientCancelled{
            registry_id : 0x2::object::id<AdminRegistry>(arg1),
            new_address : v0,
        };
        0x2::event::emit<FeeRecipientCancelled>(v2);
    }

    fun clear_lower_caps(arg0: &mut AdminRegistry) {
        emit_revoked_ids(&arg0.valid_operator_caps, true);
        emit_revoked_ids(&arg0.valid_guardian_caps, false);
        arg0.valid_operator_caps = 0x2::vec_set::empty<0x2::object::ID>();
        arg0.valid_guardian_caps = 0x2::vec_set::empty<0x2::object::ID>();
    }

    fun emit_revoked_ids(arg0: &0x2::vec_set::VecSet<0x2::object::ID>, arg1: bool) {
        let v0 = *0x2::vec_set::keys<0x2::object::ID>(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            if (arg1) {
                let v2 = OperatorCapRevoked{cap_id: *0x1::vector::borrow<0x2::object::ID>(&v0, v1)};
                0x2::event::emit<OperatorCapRevoked>(v2);
            } else {
                let v3 = GuardianCapRevoked{cap_id: *0x1::vector::borrow<0x2::object::ID>(&v0, v1)};
                0x2::event::emit<GuardianCapRevoked>(v3);
            };
            v1 = v1 + 1;
        };
    }

    public fun fee_recipient_timelock_ms() : u64 {
        86400000
    }

    entry fun guardian_cancel_admin_transfer(arg0: &AdminRegistry, arg1: &GuardianCap, arg2: PendingAdminTransfer, arg3: 0x2::transfer::Receiving<AdminCap>) {
        assert_guardian_cap_recovery(arg0, arg1);
        let PendingAdminTransfer {
            id              : v0,
            admin_cap_id    : v1,
            proposer        : v2,
            recipient       : v3,
            accept_after_ms : _,
        } = arg2;
        let v5 = v0;
        assert!(0x2::transfer::receiving_object_id<AdminCap>(&arg3) == v1, 102);
        0x2::object::delete(v5);
        let v6 = AdminTransferGuardianCancelled{
            admin_cap_id : v1,
            proposer     : v2,
            recipient    : v3,
        };
        0x2::event::emit<AdminTransferGuardianCancelled>(v6);
        0x2::transfer::transfer<AdminCap>(0x2::transfer::receive<AdminCap>(&mut v5, arg3), v2);
    }

    public fun has_pending_fee_recipient(arg0: &AdminRegistry) : bool {
        0x1::option::is_some<PendingFeeRecipient>(&arg0.pending_fee_recipient)
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ADMIN>(arg0, arg1), v0);
        initialize_admin_state(v0, arg1);
    }

    fun initialize_admin_state(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_admin_cap(arg0, arg1);
        let v1 = AdminInitialized{
            admin_cap_id : v0,
            registry_id  : new_registry(arg0, arg1),
            admin        : arg0,
        };
        0x2::event::emit<AdminInitialized>(v1);
    }

    entry fun migrate_registry(arg0: &AdminCap, arg1: &mut AdminRegistry) {
        migrate_registry_impl(arg1);
    }

    fun migrate_registry_impl(arg0: &mut AdminRegistry) {
        assert!(1 > arg0.version, 109);
        let v0 = arg0.version;
        let v1 = 1;
        arg0.version = v1;
        clear_lower_caps(arg0);
        let v2 = RegistryMigrated{
            registry_id : 0x2::object::id<AdminRegistry>(arg0),
            old_version : v0,
            new_version : v1,
        };
        0x2::event::emit<RegistryMigrated>(v2);
    }

    fun mint_admin_cap(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, arg0);
        0x2::object::id<AdminCap>(&v0)
    }

    entry fun mint_guardian_cap(arg0: &AdminCap, arg1: &mut AdminRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_registry_version(arg1);
        assert_nonzero_recipient(arg2);
        let v0 = GuardianCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<GuardianCap>(&v0);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.valid_guardian_caps, v1);
        0x2::transfer::transfer<GuardianCap>(v0, arg2);
        let v2 = GuardianCapMinted{
            cap_id           : v1,
            recipient        : arg2,
            registry_version : arg1.version,
        };
        0x2::event::emit<GuardianCapMinted>(v2);
        v1
    }

    entry fun mint_operator_cap(arg0: &AdminCap, arg1: &mut AdminRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_registry_version(arg1);
        assert_nonzero_recipient(arg2);
        let v0 = OperatorCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<OperatorCap>(&v0);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.valid_operator_caps, v1);
        0x2::transfer::transfer<OperatorCap>(v0, arg2);
        let v2 = OperatorCapMinted{
            cap_id           : v1,
            recipient        : arg2,
            registry_version : arg1.version,
        };
        0x2::event::emit<OperatorCapMinted>(v2);
        v1
    }

    fun new_registry(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = AdminRegistry{
            id                     : 0x2::object::new(arg1),
            version                : 1,
            valid_operator_caps    : 0x2::vec_set::empty<0x2::object::ID>(),
            valid_guardian_caps    : 0x2::vec_set::empty<0x2::object::ID>(),
            protocol_fee_recipient : arg0,
            pending_fee_recipient  : 0x1::option::none<PendingFeeRecipient>(),
            extra                  : 0x2::bag::new(arg1),
        };
        0x2::transfer::share_object<AdminRegistry>(v0);
        0x2::object::id<AdminRegistry>(&v0)
    }

    public fun pending_accept_after_ms(arg0: &PendingAdminTransfer) : u64 {
        arg0.accept_after_ms
    }

    public fun pending_admin_cap_id(arg0: &PendingAdminTransfer) : 0x2::object::ID {
        arg0.admin_cap_id
    }

    public fun pending_proposer(arg0: &PendingAdminTransfer) : address {
        arg0.proposer
    }

    public fun pending_recipient(arg0: &PendingAdminTransfer) : address {
        arg0.recipient
    }

    entry fun propose_admin(arg0: AdminCap, arg1: &AdminRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_registry_version(arg1);
        assert_nonzero_recipient(arg2);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::id<AdminCap>(&arg0);
        let v2 = add_timelock(0x2::clock::timestamp_ms(arg3), 172800000);
        let v3 = PendingAdminTransfer{
            id              : 0x2::object::new(arg4),
            admin_cap_id    : v1,
            proposer        : v0,
            recipient       : arg2,
            accept_after_ms : v2,
        };
        0x2::transfer::transfer<AdminCap>(arg0, 0x2::object::uid_to_address(&v3.id));
        let v4 = AdminTransferProposed{
            pending_transfer_id : 0x2::object::id<PendingAdminTransfer>(&v3),
            admin_cap_id        : v1,
            proposer            : v0,
            recipient           : arg2,
            accept_after_ms     : v2,
        };
        0x2::event::emit<AdminTransferProposed>(v4);
        0x2::transfer::share_object<PendingAdminTransfer>(v3);
    }

    entry fun propose_fee_recipient(arg0: &AdminCap, arg1: &mut AdminRegistry, arg2: address, arg3: &0x2::clock::Clock) {
        assert_registry_version(arg1);
        assert!(arg2 != @0x0, 113);
        if (0x1::option::is_some<PendingFeeRecipient>(&arg1.pending_fee_recipient)) {
            let PendingFeeRecipient {
                new_address : v0,
                eta_ms      : _,
            } = 0x1::option::extract<PendingFeeRecipient>(&mut arg1.pending_fee_recipient);
            let v2 = FeeRecipientCancelled{
                registry_id : 0x2::object::id<AdminRegistry>(arg1),
                new_address : v0,
            };
            0x2::event::emit<FeeRecipientCancelled>(v2);
        };
        let v3 = add_timelock(0x2::clock::timestamp_ms(arg3), 86400000);
        let v4 = PendingFeeRecipient{
            new_address : arg2,
            eta_ms      : v3,
        };
        arg1.pending_fee_recipient = 0x1::option::some<PendingFeeRecipient>(v4);
        let v5 = FeeRecipientProposed{
            registry_id : 0x2::object::id<AdminRegistry>(arg1),
            new_address : arg2,
            eta_ms      : v3,
        };
        0x2::event::emit<FeeRecipientProposed>(v5);
    }

    public fun protocol_fee_recipient(arg0: &AdminRegistry) : address {
        arg0.protocol_fee_recipient
    }

    public fun registry_id(arg0: &AdminRegistry) : 0x2::object::ID {
        0x2::object::id<AdminRegistry>(arg0)
    }

    public fun registry_version(arg0: &AdminRegistry) : u64 {
        arg0.version
    }

    entry fun revoke_all_caps(arg0: &AdminCap, arg1: &mut AdminRegistry) {
        assert_registry_version(arg1);
        clear_lower_caps(arg1);
        let v0 = AllCapsRevoked{registry_id: 0x2::object::id<AdminRegistry>(arg1)};
        0x2::event::emit<AllCapsRevoked>(v0);
    }

    entry fun revoke_guardian_cap(arg0: &AdminCap, arg1: &mut AdminRegistry, arg2: 0x2::object::ID) {
        assert_registry_version(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.valid_guardian_caps, &arg2), 105);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.valid_guardian_caps, &arg2);
        let v0 = GuardianCapRevoked{cap_id: arg2};
        0x2::event::emit<GuardianCapRevoked>(v0);
    }

    entry fun revoke_operator_cap(arg0: &AdminCap, arg1: &mut AdminRegistry, arg2: 0x2::object::ID) {
        assert_registry_version(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.valid_operator_caps, &arg2), 104);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg1.valid_operator_caps, &arg2);
        let v0 = OperatorCapRevoked{cap_id: arg2};
        0x2::event::emit<OperatorCapRevoked>(v0);
    }

    // decompiled from Move bytecode v7
}

