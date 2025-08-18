module 0x964a96f4cb6cdfb6f488773398a528c86b2b695ea74a3ad689d266bf103413f2::claim {
    struct CLAIM has drop {
        dummy_field: bool,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct MappingAdminCap has key {
        id: 0x2::object::UID,
    }

    struct ApprovalAdminCap has key {
        id: 0x2::object::UID,
    }

    struct AdminRegistry has key {
        id: 0x2::object::UID,
        owner: address,
        pending_transfer: 0x1::option::Option<PendingOwnershipTransfer>,
        pending_mapping_admin_transfer: 0x1::option::Option<PendingMappingAdminTransfer>,
        pending_approval_admin_transfer: 0x1::option::Option<PendingApprovalAdminTransfer>,
        admins: 0x2::vec_set::VecSet<address>,
        mapping_admin: address,
        approval_admin: address,
        max_admins: u64,
    }

    struct PauseState has key {
        id: 0x2::object::UID,
        is_paused: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        token_balance: 0x2::balance::Balance<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>,
    }

    struct Mapping has drop, store {
        sui_address: address,
        eth_address: vector<u8>,
        amount: u64,
        claimed: bool,
        audit_approved: bool,
        manual_approved: bool,
        requires_manual_approval: bool,
    }

    struct MappingsStorage has key {
        id: 0x2::object::UID,
        eth_mappings: 0x2::table::Table<vector<u8>, Mapping>,
        claim_stats: 0x2::table::Table<address, u64>,
    }

    struct LimitManager has key {
        id: 0x2::object::UID,
        daily_claim_limit: 0x1::option::Option<u64>,
        daily_claims: 0x2::table::Table<u64, u64>,
        last_reset_timestamp: u64,
    }

    struct PendingOwnershipTransfer has drop, store {
        new_owner: address,
        initiated_at: u64,
        expires_at: u64,
    }

    struct FunctionCallEvent has copy, drop {
        function_name: 0x1::ascii::String,
        caller: address,
        timestamp: u64,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct OwnershipTransferInitiated has copy, drop {
        current_owner: address,
        pending_owner: address,
        expires_at: u64,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct OwnershipTransferred has copy, drop {
        previous_owner: address,
        new_owner: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct OwnershipTransferCancelled has copy, drop {
        current_owner: address,
        cancelled_pending_owner: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct OwnershipTransferExpired has copy, drop {
        current_owner: address,
        expired_pending_owner: address,
        expired_at: u64,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct AdminAdded has copy, drop {
        admin_address: address,
        added_by: address,
        total_admins_after: u64,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct AdminRemoved has copy, drop {
        admin_address: address,
        removed_by: address,
        total_admins_after: u64,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct PendingApprovalAdminTransfer has drop, store {
        new_approval_admin: address,
        initiated_at: u64,
        expires_at: u64,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct PendingMappingAdminTransfer has drop, store {
        new_mapping_admin: address,
        initiated_at: u64,
        expires_at: u64,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct TreasuryPaused has copy, drop {
        paused_by: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct TreasuryUnpaused has copy, drop {
        unpaused_by: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct TokenDeposited has copy, drop {
        amount: u64,
        deposited_by: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct DailyClaimLimitSet has copy, drop {
        daily_limit: u64,
        set_by: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct MappingCreated has copy, drop {
        eth_tx_hash: vector<u8>,
        sui_address: address,
        eth_address: vector<u8>,
        amount: u64,
        updated_by: address,
        requires_manual_approval: bool,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct AuditApprovalStatusChanged has copy, drop {
        eth_tx_hash: vector<u8>,
        sui_address: address,
        audit_approval_state: bool,
        changed_by: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct ManualApprovalStatusChanged has copy, drop {
        eth_tx_hash: vector<u8>,
        sui_address: address,
        new_status: bool,
        changed_by: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct ManualApprovalRequired has copy, drop {
        eth_tx_hash: vector<u8>,
        recipient: address,
        amount: u64,
        created_by: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct ClaimCompleted has copy, drop {
        eth_tx_hash: vector<u8>,
        claimer: address,
        amount: u64,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct TokenWithdrawn has copy, drop {
        amount: u64,
        withdrawn_by: address,
        recipient: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct MappingAdminTransferInitiated has copy, drop {
        current_mapping_admin: address,
        pending_mapping_admin: address,
        expires_at: u64,
        initiated_by: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct MappingAdminChanged has copy, drop {
        old_admin: address,
        new_admin: address,
        changed_by: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct MappingAdminTransferCancelled has copy, drop {
        current_mapping_admin: address,
        cancelled_pending_admin: address,
        cancelled_by: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct ApprovalAdminTransferInitiated has copy, drop {
        current_approval_admin: address,
        pending_approval_admin: address,
        expires_at: u64,
        initiated_by: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct ApprovalAdminChanged has copy, drop {
        old_admin: address,
        new_admin: address,
        changed_by: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct ApprovalAdminTransferCancelled has copy, drop {
        current_approval_admin: address,
        cancelled_pending_admin: address,
        cancelled_by: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct MappingAdminTransferExpired has copy, drop {
        current_mapping_admin: address,
        expired_pending_admin: address,
        expired_at: u64,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct ApprovalAdminTransferExpired has copy, drop {
        current_approval_admin: address,
        expired_pending_admin: address,
        expired_at: u64,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct CapabilityDestroyed has copy, drop {
        capability_type: 0x1::ascii::String,
        destroyed_by: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    entry fun make_immutable(arg0: 0x2::package::UpgradeCap, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        emit_function_call(b"make_immutable", 0x2::tx_context::sender(arg2), arg1, arg2);
        0x2::package::make_immutable(arg0);
    }

    entry fun claim(arg0: &PauseState, arg1: &mut LimitManager, arg2: &mut Treasury, arg3: &mut MappingsStorage, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        emit_function_call(b"claim", v0, arg5, arg6);
        assert!(!arg0.is_paused, 1200);
        validate_eth_tx_hash(&arg4);
        let v1 = create_mapping_key(arg4, v0);
        assert!(0x2::table::contains<vector<u8>, Mapping>(&arg3.eth_mappings, v1), 1401);
        let v2 = 0x2::table::remove<vector<u8>, Mapping>(&mut arg3.eth_mappings, v1);
        assert!(v2.sui_address == v0, 1403);
        assert!(!v2.claimed, 1402);
        assert!(v2.audit_approved, 1450);
        if (v2.requires_manual_approval) {
            assert!(v2.manual_approved, 1451);
        };
        let v3 = v2.amount;
        assert!(0x2::balance::value<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&arg2.token_balance) >= v3, 1302);
        if (0x1::option::is_some<u64>(&arg1.daily_claim_limit)) {
            let v4 = *0x1::option::borrow<u64>(&arg1.daily_claim_limit);
            let v5 = 0x2::clock::timestamp_ms(arg5);
            reset_daily_claims_if_needed(arg1, v5);
            let v6 = get_noon_adjusted_day_key(v5);
            if (!0x2::table::contains<u64, u64>(&arg1.daily_claims, v6)) {
                assert!(v3 <= v4, 1500);
                0x2::table::add<u64, u64>(&mut arg1.daily_claims, v6, v3);
            } else {
                let v7 = 0x2::table::borrow_mut<u64, u64>(&mut arg1.daily_claims, v6);
                let v8 = safe_add(*v7, v3);
                assert!(v8 <= v4, 1500);
                *v7 = v8;
            };
        };
        v2.claimed = true;
        if (!0x2::table::contains<address, u64>(&arg3.claim_stats, v0)) {
            0x2::table::add<address, u64>(&mut arg3.claim_stats, v0, v3);
        } else {
            let v9 = 0x2::table::borrow_mut<address, u64>(&mut arg3.claim_stats, v0);
            *v9 = safe_add(*v9, v3);
        };
        0x2::table::add<vector<u8>, Mapping>(&mut arg3.eth_mappings, v1, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>>(0x2::coin::from_balance<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(0x2::balance::split<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&mut arg2.token_balance, v3), arg6), v0);
        let v10 = ClaimCompleted{
            eth_tx_hash : arg4,
            claimer     : v0,
            amount      : v3,
            tx_digest   : *0x2::tx_context::digest(arg6),
            epoch       : 0x2::tx_context::epoch(arg6),
        };
        0x2::event::emit<ClaimCompleted>(v10);
    }

    entry fun accept_approval_admin_transfer(arg0: &mut AdminRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        emit_function_call(b"accept_approval_admin_transfer", v0, arg1, arg2);
        assert!(0x1::option::is_some<PendingApprovalAdminTransfer>(&arg0.pending_approval_admin_transfer), 1619);
        let v1 = 0x1::option::extract<PendingApprovalAdminTransfer>(&mut arg0.pending_approval_admin_transfer);
        assert!(v0 == v1.new_approval_admin, 1620);
        assert!(0x2::clock::timestamp_ms(arg1) <= v1.expires_at, 1621);
        arg0.approval_admin = v0;
        let v2 = ApprovalAdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<ApprovalAdminCap>(v2, v0);
        let v3 = ApprovalAdminChanged{
            old_admin  : arg0.approval_admin,
            new_admin  : v0,
            changed_by : v0,
            tx_digest  : *0x2::tx_context::digest(arg2),
            epoch      : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<ApprovalAdminChanged>(v3);
    }

    entry fun accept_mapping_admin_transfer(arg0: &mut AdminRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        emit_function_call(b"accept_mapping_admin_transfer", v0, arg1, arg2);
        validate_sui_address(v0);
        assert!(0x1::option::is_some<PendingMappingAdminTransfer>(&arg0.pending_mapping_admin_transfer), 1615);
        let v1 = 0x1::option::extract<PendingMappingAdminTransfer>(&mut arg0.pending_mapping_admin_transfer);
        assert!(v0 == v1.new_mapping_admin, 1616);
        assert!(0x2::clock::timestamp_ms(arg1) <= v1.expires_at, 1617);
        arg0.mapping_admin = v0;
        let v2 = MappingAdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<MappingAdminCap>(v2, v0);
        let v3 = MappingAdminChanged{
            old_admin  : arg0.mapping_admin,
            new_admin  : v0,
            changed_by : v0,
            tx_digest  : *0x2::tx_context::digest(arg2),
            epoch      : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<MappingAdminChanged>(v3);
    }

    entry fun accept_ownership_transfer(arg0: &mut AdminRegistry, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        emit_function_call(b"accept_ownership_transfer", v0, arg1, arg2);
        assert!(0x1::option::is_some<PendingOwnershipTransfer>(&arg0.pending_transfer), 1610);
        let v1 = 0x1::option::extract<PendingOwnershipTransfer>(&mut arg0.pending_transfer);
        assert!(v0 == v1.new_owner, 1612);
        assert!(0x2::clock::timestamp_ms(arg1) <= v1.expires_at, 1611);
        arg0.owner = v0;
        0x2::transfer::transfer<OwnerCap>(0x2::dynamic_field::remove<vector<u8>, OwnerCap>(&mut arg0.id, b"escrowed_owner_cap"), v0);
        let v2 = OwnershipTransferred{
            previous_owner : arg0.owner,
            new_owner      : v0,
            tx_digest      : *0x2::tx_context::digest(arg2),
            epoch          : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<OwnershipTransferred>(v2);
    }

    entry fun add_admin(arg0: &OwnerCap, arg1: &mut AdminRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"add_admin", v0, arg3, arg4);
        assert!(arg1.owner == v0, 1001);
        validate_sui_address(arg2);
        assert!(arg2 != v0, 1005);
        assert!(arg2 != arg1.owner, 1006);
        assert!(arg2 != arg1.mapping_admin, 1624);
        assert!(arg2 != arg1.approval_admin, 1625);
        assert!(!0x2::vec_set::contains<address>(&arg1.admins, &arg2), 1100);
        assert!(0x2::vec_set::size<address>(&arg1.admins) < arg1.max_admins, 1101);
        0x2::vec_set::insert<address>(&mut arg1.admins, arg2);
        let v1 = AdminCap{id: 0x2::object::new(arg4)};
        0x2::transfer::transfer<AdminCap>(v1, arg2);
        let v2 = AdminAdded{
            admin_address      : arg2,
            added_by           : v0,
            total_admins_after : 0x2::vec_set::size<address>(&arg1.admins),
            tx_digest          : *0x2::tx_context::digest(arg4),
            epoch              : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<AdminAdded>(v2);
    }

    fun audit_approval(arg0: &mut MappingsStorage, arg1: vector<u8>, arg2: address, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        emit_function_call(b"audit_approval", v0, arg4, arg5);
        validate_sui_address(arg2);
        validate_eth_tx_hash(&arg1);
        let v1 = create_mapping_key(arg1, arg2);
        assert!(0x2::table::contains<vector<u8>, Mapping>(&arg0.eth_mappings, v1), 1401);
        0x2::table::borrow_mut<vector<u8>, Mapping>(&mut arg0.eth_mappings, v1).audit_approved = arg3;
        let v2 = AuditApprovalStatusChanged{
            eth_tx_hash          : arg1,
            sui_address          : arg2,
            audit_approval_state : arg3,
            changed_by           : v0,
            tx_digest            : *0x2::tx_context::digest(arg5),
            epoch                : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<AuditApprovalStatusChanged>(v2);
    }

    entry fun audit_approval_from_admin(arg0: &AdminCap, arg1: &AdminRegistry, arg2: &PauseState, arg3: &mut MappingsStorage, arg4: vector<u8>, arg5: address, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert!(is_admin(arg1, 0x2::tx_context::sender(arg8)), 1000);
        assert!(!arg2.is_paused, 1200);
        audit_approval(arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun audit_approval_from_approval_admin(arg0: &ApprovalAdminCap, arg1: &AdminRegistry, arg2: &PauseState, arg3: &mut MappingsStorage, arg4: vector<u8>, arg5: address, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert!(is_approval_admin(arg1, 0x2::tx_context::sender(arg8)), 1003);
        assert!(!arg2.is_paused, 1200);
        audit_approval(arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun audit_approval_from_owner(arg0: &OwnerCap, arg1: &AdminRegistry, arg2: &PauseState, arg3: &mut MappingsStorage, arg4: vector<u8>, arg5: address, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg8), 1001);
        audit_approval(arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun cancel_approval_admin_transfer(arg0: &OwnerCap, arg1: &mut AdminRegistry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        emit_function_call(b"cancel_approval_admin_transfer", v0, arg2, arg3);
        assert!(arg1.owner == v0, 1001);
        assert!(0x1::option::is_some<PendingApprovalAdminTransfer>(&arg1.pending_approval_admin_transfer), 1619);
        let v1 = 0x1::option::extract<PendingApprovalAdminTransfer>(&mut arg1.pending_approval_admin_transfer);
        let v2 = ApprovalAdminTransferCancelled{
            current_approval_admin  : arg1.approval_admin,
            cancelled_pending_admin : v1.new_approval_admin,
            cancelled_by            : v0,
            tx_digest               : *0x2::tx_context::digest(arg3),
            epoch                   : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<ApprovalAdminTransferCancelled>(v2);
    }

    entry fun cancel_mapping_admin_transfer(arg0: &OwnerCap, arg1: &mut AdminRegistry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        emit_function_call(b"cancel_mapping_admin_transfer", v0, arg2, arg3);
        assert!(arg1.owner == v0, 1001);
        assert!(0x1::option::is_some<PendingMappingAdminTransfer>(&arg1.pending_mapping_admin_transfer), 1615);
        let v1 = 0x1::option::extract<PendingMappingAdminTransfer>(&mut arg1.pending_mapping_admin_transfer);
        let v2 = MappingAdminTransferCancelled{
            current_mapping_admin   : arg1.mapping_admin,
            cancelled_pending_admin : v1.new_mapping_admin,
            cancelled_by            : v0,
            tx_digest               : *0x2::tx_context::digest(arg3),
            epoch                   : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<MappingAdminTransferCancelled>(v2);
    }

    entry fun cancel_ownership_transfer(arg0: &mut AdminRegistry, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        emit_function_call(b"cancel_ownership_transfer", v0, arg1, arg2);
        assert!(arg0.owner == v0, 1001);
        assert!(0x1::option::is_some<PendingOwnershipTransfer>(&arg0.pending_transfer), 1610);
        let v1 = 0x1::option::extract<PendingOwnershipTransfer>(&mut arg0.pending_transfer);
        0x2::transfer::transfer<OwnerCap>(0x2::dynamic_field::remove<vector<u8>, OwnerCap>(&mut arg0.id, b"escrowed_owner_cap"), v0);
        let v2 = OwnershipTransferCancelled{
            current_owner           : v0,
            cancelled_pending_owner : v1.new_owner,
            tx_digest               : *0x2::tx_context::digest(arg2),
            epoch                   : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<OwnershipTransferCancelled>(v2);
    }

    entry fun cleanup_expired_approval_admin_transfer(arg0: &mut AdminRegistry, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        emit_function_call(b"cleanup_expired_approval_admin_transfer", 0x2::tx_context::sender(arg2), arg1, arg2);
        assert!(0x1::option::is_some<PendingApprovalAdminTransfer>(&arg0.pending_approval_admin_transfer), 1619);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 > 0x1::option::borrow<PendingApprovalAdminTransfer>(&arg0.pending_approval_admin_transfer).expires_at, 1632);
        let v1 = 0x1::option::extract<PendingApprovalAdminTransfer>(&mut arg0.pending_approval_admin_transfer);
        let v2 = ApprovalAdminTransferExpired{
            current_approval_admin : arg0.approval_admin,
            expired_pending_admin  : v1.new_approval_admin,
            expired_at             : v0,
            tx_digest              : *0x2::tx_context::digest(arg2),
            epoch                  : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<ApprovalAdminTransferExpired>(v2);
    }

    entry fun cleanup_expired_mapping_admin_transfer(arg0: &mut AdminRegistry, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        emit_function_call(b"cleanup_expired_mapping_admin_transfer", 0x2::tx_context::sender(arg2), arg1, arg2);
        assert!(0x1::option::is_some<PendingMappingAdminTransfer>(&arg0.pending_mapping_admin_transfer), 1615);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 > 0x1::option::borrow<PendingMappingAdminTransfer>(&arg0.pending_mapping_admin_transfer).expires_at, 1631);
        let v1 = 0x1::option::extract<PendingMappingAdminTransfer>(&mut arg0.pending_mapping_admin_transfer);
        let v2 = MappingAdminTransferExpired{
            current_mapping_admin : arg0.mapping_admin,
            expired_pending_admin : v1.new_mapping_admin,
            expired_at            : v0,
            tx_digest             : *0x2::tx_context::digest(arg2),
            epoch                 : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<MappingAdminTransferExpired>(v2);
    }

    entry fun cleanup_expired_transfer(arg0: &mut AdminRegistry, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        emit_function_call(b"cleanup_expired_transfer", 0x2::tx_context::sender(arg2), arg1, arg2);
        assert!(0x1::option::is_some<PendingOwnershipTransfer>(&arg0.pending_transfer), 1610);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 > 0x1::option::borrow<PendingOwnershipTransfer>(&arg0.pending_transfer).expires_at, 1630);
        let v1 = 0x1::option::extract<PendingOwnershipTransfer>(&mut arg0.pending_transfer);
        0x2::transfer::transfer<OwnerCap>(0x2::dynamic_field::remove<vector<u8>, OwnerCap>(&mut arg0.id, b"escrowed_owner_cap"), arg0.owner);
        let v2 = OwnershipTransferExpired{
            current_owner         : arg0.owner,
            expired_pending_owner : v1.new_owner,
            expired_at            : v0,
            tx_digest             : *0x2::tx_context::digest(arg2),
            epoch                 : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<OwnershipTransferExpired>(v2);
    }

    fun create_mapping_key(arg0: vector<u8>, arg1: address) : vector<u8> {
        0x1::vector::append<u8>(&mut arg0, 0x1::bcs::to_bytes<address>(&arg1));
        0x1::hash::sha3_256(arg0)
    }

    fun deposit_tokens(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"deposit_tokens", v0, arg3, arg4);
        validate_amount(arg2);
        let v1 = 0x2::coin::value<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&arg1);
        assert!(v1 >= arg2, 1302);
        if (v1 == arg2) {
            0x2::balance::join<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&mut arg0.token_balance, 0x2::coin::into_balance<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(arg1));
        } else {
            0x2::balance::join<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&mut arg0.token_balance, 0x2::coin::into_balance<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(0x2::coin::split<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&mut arg1, arg2, arg4)));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>>(arg1, v0);
        };
        let v2 = TokenDeposited{
            amount       : arg2,
            deposited_by : v0,
            tx_digest    : *0x2::tx_context::digest(arg4),
            epoch        : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<TokenDeposited>(v2);
    }

    entry fun deposit_tokens_from_admin(arg0: &AdminCap, arg1: &AdminRegistry, arg2: &PauseState, arg3: &mut Treasury, arg4: 0x2::coin::Coin<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg1, 0x2::tx_context::sender(arg7)), 1000);
        assert!(!arg2.is_paused, 1200);
        deposit_tokens(arg3, arg4, arg5, arg6, arg7);
    }

    entry fun deposit_tokens_from_owner(arg0: &OwnerCap, arg1: &AdminRegistry, arg2: &PauseState, arg3: &mut Treasury, arg4: 0x2::coin::Coin<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg7), 1001);
        deposit_tokens(arg3, arg4, arg5, arg6, arg7);
    }

    entry fun destroy_old_admin_cap(arg0: AdminCap, arg1: &AdminRegistry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        emit_function_call(b"destroy_old_admin_cap", v0, arg2, arg3);
        assert!(!0x2::vec_set::contains<address>(&arg1.admins, &v0), 1628);
        let AdminCap { id: v1 } = arg0;
        0x2::object::delete(v1);
        let v2 = CapabilityDestroyed{
            capability_type : 0x1::ascii::string(b"AdminCap"),
            destroyed_by    : v0,
            tx_digest       : *0x2::tx_context::digest(arg3),
            epoch           : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<CapabilityDestroyed>(v2);
    }

    entry fun destroy_old_approval_admin_cap(arg0: ApprovalAdminCap, arg1: &AdminRegistry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        emit_function_call(b"destroy_old_approval_admin_cap", v0, arg2, arg3);
        assert!(v0 != arg1.approval_admin, 1628);
        let ApprovalAdminCap { id: v1 } = arg0;
        0x2::object::delete(v1);
        let v2 = CapabilityDestroyed{
            capability_type : 0x1::ascii::string(b"ApprovalAdminCap"),
            destroyed_by    : v0,
            tx_digest       : *0x2::tx_context::digest(arg3),
            epoch           : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<CapabilityDestroyed>(v2);
    }

    entry fun destroy_old_mapping_admin_cap(arg0: MappingAdminCap, arg1: &AdminRegistry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        emit_function_call(b"destroy_old_mapping_admin_cap", v0, arg2, arg3);
        assert!(v0 != arg1.mapping_admin, 1628);
        let MappingAdminCap { id: v1 } = arg0;
        0x2::object::delete(v1);
        let v2 = CapabilityDestroyed{
            capability_type : 0x1::ascii::string(b"MappingAdminCap"),
            destroyed_by    : v0,
            tx_digest       : *0x2::tx_context::digest(arg3),
            epoch           : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<CapabilityDestroyed>(v2);
    }

    fun emit_function_call(arg0: vector<u8>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = FunctionCallEvent{
            function_name : 0x1::ascii::string(arg0),
            caller        : arg1,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
            tx_digest     : *0x2::tx_context::digest(arg3),
            epoch         : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<FunctionCallEvent>(v0);
    }

    public fun get_admin_count(arg0: &AdminRegistry) : u64 {
        0x2::vec_set::size<address>(&arg0.admins)
    }

    public fun get_approval_admin(arg0: &AdminRegistry) : address {
        arg0.approval_admin
    }

    public fun get_daily_claims_for_timestamp(arg0: &LimitManager, arg1: u64) : u64 {
        let v0 = get_noon_adjusted_day_key(arg1);
        if (0x2::table::contains<u64, u64>(&arg0.daily_claims, v0)) {
            *0x2::table::borrow<u64, u64>(&arg0.daily_claims, v0)
        } else {
            0
        }
    }

    public fun get_daily_limit_details(arg0: &LimitManager, arg1: &0x2::clock::Clock) : (bool, u64, u64, u64) {
        if (0x1::option::is_none<u64>(&arg0.daily_claim_limit)) {
            return (false, 0, 0, 0)
        };
        let v0 = *0x1::option::borrow<u64>(&arg0.daily_claim_limit);
        let v1 = get_noon_adjusted_day_key(0x2::clock::timestamp_ms(arg1));
        let v2 = if (0x2::table::contains<u64, u64>(&arg0.daily_claims, v1)) {
            *0x2::table::borrow<u64, u64>(&arg0.daily_claims, v1)
        } else {
            0
        };
        let v3 = if (v2 >= v0) {
            0
        } else {
            v0 - v2
        };
        (true, v0, v2, v3)
    }

    fun get_day_from_timestamp(arg0: u64) : u64 {
        arg0 / 86400000
    }

    fun get_day_from_timestamp_noon_adjusted(arg0: u64) : u64 {
        let v0 = if (arg0 >= 43200000) {
            arg0 - 43200000
        } else {
            0
        };
        v0 / 86400000
    }

    public fun get_mapping(arg0: &MappingsStorage, arg1: vector<u8>, arg2: address) : (bool, u64, bool, vector<u8>, bool, bool, bool) {
        let v0 = create_mapping_key(arg1, arg2);
        if (0x2::table::contains<vector<u8>, Mapping>(&arg0.eth_mappings, v0)) {
            let v8 = 0x2::table::borrow<vector<u8>, Mapping>(&arg0.eth_mappings, v0);
            (true, v8.amount, v8.claimed, v8.eth_address, v8.audit_approved, v8.manual_approved, v8.requires_manual_approval)
        } else {
            (false, 0, false, 0x1::vector::empty<u8>(), false, false, false)
        }
    }

    public fun get_mapping_admin(arg0: &AdminRegistry) : address {
        arg0.mapping_admin
    }

    fun get_noon_adjusted_day_key(arg0: u64) : u64 {
        let v0 = get_day_from_timestamp(arg0);
        if (arg0 % 86400000 / 3600000 < 12 && v0 > 0) {
            v0 - 1
        } else {
            v0
        }
    }

    public fun get_owner(arg0: &AdminRegistry) : address {
        arg0.owner
    }

    public fun get_pending_approval_admin_transfer(arg0: &AdminRegistry) : (bool, address, u64, u64) {
        if (0x1::option::is_some<PendingApprovalAdminTransfer>(&arg0.pending_approval_admin_transfer)) {
            let v4 = 0x1::option::borrow<PendingApprovalAdminTransfer>(&arg0.pending_approval_admin_transfer);
            (true, v4.new_approval_admin, v4.initiated_at, v4.expires_at)
        } else {
            (false, @0x0, 0, 0)
        }
    }

    public fun get_pending_mapping_admin_transfer(arg0: &AdminRegistry) : (bool, address, u64, u64) {
        if (0x1::option::is_some<PendingMappingAdminTransfer>(&arg0.pending_mapping_admin_transfer)) {
            let v4 = 0x1::option::borrow<PendingMappingAdminTransfer>(&arg0.pending_mapping_admin_transfer);
            (true, v4.new_mapping_admin, v4.initiated_at, v4.expires_at)
        } else {
            (false, @0x0, 0, 0)
        }
    }

    public fun get_pending_transfer(arg0: &AdminRegistry) : (bool, address, u64, u64) {
        if (0x1::option::is_some<PendingOwnershipTransfer>(&arg0.pending_transfer)) {
            let v4 = 0x1::option::borrow<PendingOwnershipTransfer>(&arg0.pending_transfer);
            (true, v4.new_owner, v4.initiated_at, v4.expires_at)
        } else {
            (false, @0x0, 0, 0)
        }
    }

    public fun get_total_claimed(arg0: &MappingsStorage, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.claim_stats, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.claim_stats, arg1)
        } else {
            0
        }
    }

    public fun get_treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&arg0.token_balance)
    }

    fun init(arg0: CLAIM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = OwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OwnerCap>(v1, v0);
        let v2 = MappingAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MappingAdminCap>(v2, v0);
        let v3 = ApprovalAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<ApprovalAdminCap>(v3, v0);
        let v4 = AdminRegistry{
            id                              : 0x2::object::new(arg1),
            owner                           : v0,
            pending_transfer                : 0x1::option::none<PendingOwnershipTransfer>(),
            pending_mapping_admin_transfer  : 0x1::option::none<PendingMappingAdminTransfer>(),
            pending_approval_admin_transfer : 0x1::option::none<PendingApprovalAdminTransfer>(),
            admins                          : 0x2::vec_set::empty<address>(),
            mapping_admin                   : v0,
            approval_admin                  : v0,
            max_admins                      : 2,
        };
        let v5 = Treasury{
            id            : 0x2::object::new(arg1),
            token_balance : 0x2::balance::zero<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(),
        };
        let v6 = MappingsStorage{
            id           : 0x2::object::new(arg1),
            eth_mappings : 0x2::table::new<vector<u8>, Mapping>(arg1),
            claim_stats  : 0x2::table::new<address, u64>(arg1),
        };
        let v7 = PauseState{
            id        : 0x2::object::new(arg1),
            is_paused : false,
        };
        let v8 = LimitManager{
            id                   : 0x2::object::new(arg1),
            daily_claim_limit    : 0x1::option::some<u64>(10000000000000000),
            daily_claims         : 0x2::table::new<u64, u64>(arg1),
            last_reset_timestamp : 0,
        };
        0x2::transfer::share_object<LimitManager>(v8);
        0x2::transfer::share_object<PauseState>(v7);
        0x2::transfer::share_object<MappingsStorage>(v6);
        0x2::transfer::share_object<AdminRegistry>(v4);
        0x2::transfer::share_object<Treasury>(v5);
    }

    entry fun initiate_approval_admin_transfer(arg0: &OwnerCap, arg1: &mut AdminRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"initiate_approval_admin_transfer", v0, arg3, arg4);
        assert!(arg1.owner == v0, 1001);
        validate_sui_address(arg2);
        validate_role_assignments(arg1, arg2, 2);
        assert!(arg2 != v0, 1004);
        assert!(0x1::option::is_none<PendingApprovalAdminTransfer>(&arg1.pending_approval_admin_transfer), 1618);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = PendingApprovalAdminTransfer{
            new_approval_admin : arg2,
            initiated_at       : v1,
            expires_at         : v1 + 86400000,
            tx_digest          : *0x2::tx_context::digest(arg4),
            epoch              : 0x2::tx_context::epoch(arg4),
        };
        arg1.pending_approval_admin_transfer = 0x1::option::some<PendingApprovalAdminTransfer>(v2);
        let v3 = ApprovalAdminTransferInitiated{
            current_approval_admin : arg1.approval_admin,
            pending_approval_admin : arg2,
            expires_at             : v1 + 86400000,
            initiated_by           : v0,
            tx_digest              : *0x2::tx_context::digest(arg4),
            epoch                  : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<ApprovalAdminTransferInitiated>(v3);
    }

    entry fun initiate_mapping_admin_transfer(arg0: &OwnerCap, arg1: &mut AdminRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"initiate_mapping_admin_transfer", v0, arg3, arg4);
        assert!(arg1.owner == v0, 1001);
        validate_sui_address(arg2);
        validate_role_assignments(arg1, arg2, 1);
        assert!(arg2 != v0, 1004);
        assert!(0x1::option::is_none<PendingMappingAdminTransfer>(&arg1.pending_mapping_admin_transfer), 1614);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = PendingMappingAdminTransfer{
            new_mapping_admin : arg2,
            initiated_at      : v1,
            expires_at        : v1 + 86400000,
            tx_digest         : *0x2::tx_context::digest(arg4),
            epoch             : 0x2::tx_context::epoch(arg4),
        };
        arg1.pending_mapping_admin_transfer = 0x1::option::some<PendingMappingAdminTransfer>(v2);
        let v3 = MappingAdminTransferInitiated{
            current_mapping_admin : arg1.mapping_admin,
            pending_mapping_admin : arg2,
            expires_at            : v1 + 86400000,
            initiated_by          : v0,
            tx_digest             : *0x2::tx_context::digest(arg4),
            epoch                 : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<MappingAdminTransferInitiated>(v3);
    }

    entry fun initiate_ownership_transfer(arg0: OwnerCap, arg1: &mut AdminRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"initiate_ownership_transfer", v0, arg3, arg4);
        assert!(arg1.owner == v0, 1001);
        validate_sui_address(arg2);
        validate_role_assignments(arg1, arg2, 3);
        assert!(arg2 != v0, 1004);
        assert!(0x1::option::is_none<PendingOwnershipTransfer>(&arg1.pending_transfer), 1613);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = PendingOwnershipTransfer{
            new_owner    : arg2,
            initiated_at : v1,
            expires_at   : v1 + 86400000,
        };
        arg1.pending_transfer = 0x1::option::some<PendingOwnershipTransfer>(v2);
        0x2::dynamic_field::add<vector<u8>, OwnerCap>(&mut arg1.id, b"escrowed_owner_cap", arg0);
        let v3 = OwnershipTransferInitiated{
            current_owner : v0,
            pending_owner : arg2,
            expires_at    : v1 + 86400000,
            tx_digest     : *0x2::tx_context::digest(arg4),
            epoch         : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<OwnershipTransferInitiated>(v3);
    }

    public fun is_admin(arg0: &AdminRegistry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admins, &arg1)
    }

    public fun is_approval_admin(arg0: &AdminRegistry, arg1: address) : bool {
        arg0.approval_admin == arg1
    }

    public fun is_approval_admin_transfer_expired(arg0: &AdminRegistry, arg1: &0x2::clock::Clock) : bool {
        0x1::option::is_some<PendingApprovalAdminTransfer>(&arg0.pending_approval_admin_transfer) && 0x2::clock::timestamp_ms(arg1) > 0x1::option::borrow<PendingApprovalAdminTransfer>(&arg0.pending_approval_admin_transfer).expires_at
    }

    public fun is_mapping_admin(arg0: &AdminRegistry, arg1: address) : bool {
        arg0.mapping_admin == arg1
    }

    public fun is_mapping_admin_transfer_expired(arg0: &AdminRegistry, arg1: &0x2::clock::Clock) : bool {
        0x1::option::is_some<PendingMappingAdminTransfer>(&arg0.pending_mapping_admin_transfer) && 0x2::clock::timestamp_ms(arg1) > 0x1::option::borrow<PendingMappingAdminTransfer>(&arg0.pending_mapping_admin_transfer).expires_at
    }

    public fun is_mapping_claimable(arg0: &MappingsStorage, arg1: vector<u8>, arg2: address) : bool {
        let v0 = create_mapping_key(arg1, arg2);
        if (0x2::table::contains<vector<u8>, Mapping>(&arg0.eth_mappings, v0)) {
            let v2 = 0x2::table::borrow<vector<u8>, Mapping>(&arg0.eth_mappings, v0);
            if (!v2.audit_approved || v2.claimed) {
                return false
            };
            v2.requires_manual_approval && v2.manual_approved || true
        } else {
            false
        }
    }

    public fun is_paused(arg0: &PauseState) : bool {
        arg0.is_paused
    }

    public fun is_transfer_expired(arg0: &AdminRegistry, arg1: &0x2::clock::Clock) : bool {
        0x1::option::is_some<PendingOwnershipTransfer>(&arg0.pending_transfer) && 0x2::clock::timestamp_ms(arg1) > 0x1::option::borrow<PendingOwnershipTransfer>(&arg0.pending_transfer).expires_at
    }

    fun manual_approval(arg0: &mut MappingsStorage, arg1: vector<u8>, arg2: address, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        emit_function_call(b"manual_approval", v0, arg4, arg5);
        validate_sui_address(arg2);
        validate_eth_tx_hash(&arg1);
        let v1 = create_mapping_key(arg1, arg2);
        assert!(0x2::table::contains<vector<u8>, Mapping>(&arg0.eth_mappings, v1), 1401);
        let v2 = 0x2::table::borrow_mut<vector<u8>, Mapping>(&mut arg0.eth_mappings, v1);
        assert!(v2.requires_manual_approval, 1405);
        v2.manual_approved = arg3;
        let v3 = ManualApprovalStatusChanged{
            eth_tx_hash : arg1,
            sui_address : arg2,
            new_status  : arg3,
            changed_by  : v0,
            tx_digest   : *0x2::tx_context::digest(arg5),
            epoch       : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<ManualApprovalStatusChanged>(v3);
    }

    entry fun manual_approval_from_admin(arg0: &AdminCap, arg1: &AdminRegistry, arg2: &PauseState, arg3: &mut MappingsStorage, arg4: vector<u8>, arg5: address, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert!(is_admin(arg1, 0x2::tx_context::sender(arg8)), 1000);
        assert!(!arg2.is_paused, 1200);
        manual_approval(arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun manual_approval_from_owner(arg0: &OwnerCap, arg1: &AdminRegistry, arg2: &PauseState, arg3: &mut MappingsStorage, arg4: vector<u8>, arg5: address, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg8), 1001);
        manual_approval(arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun pause(arg0: &OwnerCap, arg1: &AdminRegistry, arg2: &mut PauseState, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"pause", v0, arg3, arg4);
        assert!(!arg2.is_paused, 1201);
        assert!(arg1.owner == v0, 1001);
        arg2.is_paused = true;
        let v1 = TreasuryPaused{
            paused_by : v0,
            tx_digest : *0x2::tx_context::digest(arg4),
            epoch     : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<TreasuryPaused>(v1);
    }

    entry fun remove_admin(arg0: &OwnerCap, arg1: &mut AdminRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"remove_admin", v0, arg3, arg4);
        assert!(arg1.owner == v0, 1001);
        validate_sui_address(arg2);
        assert!(0x2::vec_set::size<address>(&arg1.admins) > 0, 1102);
        assert!(0x2::vec_set::contains<address>(&arg1.admins, &arg2), 1000);
        0x2::vec_set::remove<address>(&mut arg1.admins, &arg2);
        let v1 = AdminRemoved{
            admin_address      : arg2,
            removed_by         : v0,
            total_admins_after : 0x2::vec_set::size<address>(&arg1.admins),
            tx_digest          : *0x2::tx_context::digest(arg4),
            epoch              : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<AdminRemoved>(v1);
    }

    fun reset_daily_claims_if_needed(arg0: &mut LimitManager, arg1: u64) {
        let v0 = get_day_from_timestamp_noon_adjusted(arg1);
        if (v0 > get_day_from_timestamp_noon_adjusted(arg0.last_reset_timestamp)) {
            arg0.last_reset_timestamp = safe_add(safe_mul(v0, 86400000), 43200000);
        };
    }

    fun safe_add(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 1303);
        arg0 + arg1
    }

    fun safe_mul(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 18446744073709551615 / arg1, 1303);
        arg0 * arg1
    }

    fun set_daily_claim_limit(arg0: &mut LimitManager, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        emit_function_call(b"set_daily_claim_limit", v0, arg2, arg3);
        validate_amount(arg1);
        if (0x1::option::is_some<u64>(&arg0.daily_claim_limit)) {
            assert!(*0x1::option::borrow<u64>(&arg0.daily_claim_limit) != arg1, 1501);
        };
        arg0.daily_claim_limit = 0x1::option::some<u64>(arg1);
        let v1 = DailyClaimLimitSet{
            daily_limit : arg1,
            set_by      : v0,
            tx_digest   : *0x2::tx_context::digest(arg3),
            epoch       : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<DailyClaimLimitSet>(v1);
    }

    entry fun set_daily_claim_limit_from_admin(arg0: &AdminCap, arg1: &AdminRegistry, arg2: &PauseState, arg3: &mut LimitManager, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(is_admin(arg1, 0x2::tx_context::sender(arg6)), 1000);
        assert!(!arg2.is_paused, 1200);
        set_daily_claim_limit(arg3, arg4, arg5, arg6);
    }

    entry fun set_daily_claim_limit_from_owner(arg0: &OwnerCap, arg1: &AdminRegistry, arg2: &PauseState, arg3: &mut LimitManager, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg6), 1001);
        set_daily_claim_limit(arg3, arg4, arg5, arg6);
    }

    entry fun unpause(arg0: &OwnerCap, arg1: &AdminRegistry, arg2: &mut PauseState, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"unpause", v0, arg3, arg4);
        assert!(arg2.is_paused, 1202);
        assert!(arg1.owner == v0, 1001);
        arg2.is_paused = false;
        let v1 = TreasuryUnpaused{
            unpaused_by : v0,
            tx_digest   : *0x2::tx_context::digest(arg4),
            epoch       : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<TreasuryUnpaused>(v1);
    }

    fun update_mapping(arg0: &mut MappingsStorage, arg1: vector<u8>, arg2: address, arg3: vector<u8>, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        emit_function_call(b"update_mapping", v0, arg6, arg7);
        validate_amount(arg4);
        validate_sui_address(arg2);
        validate_eth_tx_hash(&arg1);
        validate_eth_address(&arg3);
        let v1 = create_mapping_key(arg1, arg2);
        assert!(!0x2::table::contains<vector<u8>, Mapping>(&arg0.eth_mappings, v1), 1400);
        let v2 = Mapping{
            sui_address              : arg2,
            eth_address              : arg3,
            amount                   : arg4,
            claimed                  : false,
            audit_approved           : false,
            manual_approved          : false,
            requires_manual_approval : arg5,
        };
        0x2::table::add<vector<u8>, Mapping>(&mut arg0.eth_mappings, v1, v2);
        let v3 = MappingCreated{
            eth_tx_hash              : arg1,
            sui_address              : arg2,
            eth_address              : arg3,
            amount                   : arg4,
            updated_by               : v0,
            requires_manual_approval : arg5,
            tx_digest                : *0x2::tx_context::digest(arg7),
            epoch                    : 0x2::tx_context::epoch(arg7),
        };
        0x2::event::emit<MappingCreated>(v3);
        if (arg5) {
            let v4 = ManualApprovalRequired{
                eth_tx_hash : arg1,
                recipient   : arg2,
                amount      : arg4,
                created_by  : v0,
                tx_digest   : *0x2::tx_context::digest(arg7),
                epoch       : 0x2::tx_context::epoch(arg7),
            };
            0x2::event::emit<ManualApprovalRequired>(v4);
        };
    }

    entry fun update_mapping_from_admin(arg0: &AdminCap, arg1: &AdminRegistry, arg2: &PauseState, arg3: &mut MappingsStorage, arg4: vector<u8>, arg5: address, arg6: vector<u8>, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        assert!(is_admin(arg1, 0x2::tx_context::sender(arg10)), 1000);
        assert!(!arg2.is_paused, 1200);
        update_mapping(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    entry fun update_mapping_from_mapping_admin(arg0: &MappingAdminCap, arg1: &AdminRegistry, arg2: &PauseState, arg3: &mut MappingsStorage, arg4: vector<u8>, arg5: address, arg6: vector<u8>, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        assert!(is_mapping_admin(arg1, 0x2::tx_context::sender(arg10)), 1002);
        assert!(!arg2.is_paused, 1200);
        update_mapping(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    entry fun update_mapping_from_owner(arg0: &OwnerCap, arg1: &AdminRegistry, arg2: &PauseState, arg3: &mut MappingsStorage, arg4: vector<u8>, arg5: address, arg6: vector<u8>, arg7: u64, arg8: bool, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg10), 1001);
        update_mapping(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    fun validate_amount(arg0: u64) {
        assert!(arg0 > 0, 1301);
    }

    fun validate_eth_address(arg0: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0, 1304);
        assert!(v0 == 20, 1304);
        assert!(*arg0 != x"0000000000000000000000000000000000000000", 1300);
    }

    fun validate_eth_tx_hash(arg0: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0, 1305);
        assert!(v0 == 32, 1305);
        assert!(*arg0 != x"0000000000000000000000000000000000000000000000000000000000000000", 1300);
    }

    fun validate_role_assignments(arg0: &AdminRegistry, arg1: address, arg2: u8) {
        validate_sui_address(arg1);
        if (arg2 == 1) {
            assert!(arg1 != arg0.mapping_admin, 1005);
            assert!(arg1 != arg0.owner, 1006);
            assert!(arg1 != arg0.approval_admin, 1627);
            assert!(!0x2::vec_set::contains<address>(&arg0.admins, &arg1), 1622);
        } else if (arg2 == 2) {
            assert!(arg1 != arg0.approval_admin, 1005);
            assert!(arg1 != arg0.owner, 1006);
            assert!(arg1 != arg0.mapping_admin, 1626);
            assert!(!0x2::vec_set::contains<address>(&arg0.admins, &arg1), 1623);
        } else if (arg2 == 3) {
            assert!(arg1 != arg0.owner, 1005);
            assert!(arg1 != arg0.mapping_admin, 1624);
            assert!(arg1 != arg0.approval_admin, 1625);
            assert!(!0x2::vec_set::contains<address>(&arg0.admins, &arg1), 1629);
        };
    }

    fun validate_sui_address(arg0: address) {
        assert!(arg0 != @0x0, 1300);
        let v0 = 0x1::bcs::to_bytes<address>(&arg0);
        assert!(0x1::vector::length<u8>(&v0) == 32, 1306);
        assert!(v0 != x"0000000000000000000000000000000000000000000000000000000000000000", 1300);
    }

    fun withdraw_tokens(arg0: &mut Treasury, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        emit_function_call(b"withdraw_tokens", v0, arg3, arg4);
        validate_amount(arg1);
        validate_sui_address(arg2);
        assert!(0x2::balance::value<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&arg0.token_balance) >= arg1, 1302);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>>(0x2::coin::from_balance<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(0x2::balance::split<0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI>(&mut arg0.token_balance, arg1), arg4), arg2);
        let v1 = TokenWithdrawn{
            amount       : arg1,
            withdrawn_by : v0,
            recipient    : arg2,
            tx_digest    : *0x2::tx_context::digest(arg4),
            epoch        : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<TokenWithdrawn>(v1);
    }

    entry fun withdraw_tokens_from_owner(arg0: &OwnerCap, arg1: &AdminRegistry, arg2: &PauseState, arg3: &mut Treasury, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg7), 1001);
        withdraw_tokens(arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

