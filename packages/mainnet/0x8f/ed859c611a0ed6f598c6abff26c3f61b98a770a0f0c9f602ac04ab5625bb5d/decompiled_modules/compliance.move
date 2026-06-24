module 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::compliance {
    struct Compliance has key {
        id: 0x2::object::UID,
        owner: address,
        pending_owner: 0x1::option::Option<address>,
        token_manager: address,
        freezer_roles: 0x2::table::Table<address, bool>,
        supply_controller_roles: 0x2::table::Table<address, bool>,
        user_ids: 0x2::table::Table<address, vector<u8>>,
        frozen: 0x2::table::Table<address, bool>,
        compliance_enabled: bool,
        paused: bool,
    }

    struct TransferApproval has drop {
        dummy_field: bool,
    }

    struct ClawbackApproval has drop {
        dummy_field: bool,
    }

    struct OwnershipTransferStarted has copy, drop {
        previous_owner: address,
        new_owner: address,
    }

    struct OwnershipTransferred has copy, drop {
        previous_owner: address,
        new_owner: address,
    }

    struct ComplianceCreated has copy, drop {
        owner: address,
    }

    struct RoleUpdated has copy, drop {
        role: vector<u8>,
        account: address,
        enabled: bool,
    }

    struct TokenManagerSet has copy, drop {
        old_manager: address,
        new_manager: address,
    }

    struct IdentityRegistered has copy, drop {
        user: address,
        user_id: vector<u8>,
    }

    struct IdentityRemoved has copy, drop {
        user: address,
    }

    struct AddressFrozen has copy, drop {
        user: address,
        frozen: bool,
        operator: address,
    }

    struct ComplianceModeUpdated has copy, drop {
        enabled: bool,
    }

    struct PauseUpdated has copy, drop {
        paused: bool,
    }

    public fun accept_ownership(arg0: &mut Compliance, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<address>(&arg0.pending_owner), 13838718423982080028);
        let v0 = *0x1::option::borrow<address>(&arg0.pending_owner);
        assert!(0x2::tx_context::sender(arg1) == v0, 13838436957595172890);
        arg0.owner = v0;
        arg0.pending_owner = 0x1::option::none<address>();
        let v1 = OwnershipTransferred{
            previous_owner : arg0.owner,
            new_owner      : v0,
        };
        0x2::event::emit<OwnershipTransferred>(v1);
    }

    fun add_bool(arg0: &mut 0x2::table::Table<address, bool>, arg1: address) {
        if (!0x2::table::contains<address, bool>(arg0, arg1)) {
            0x2::table::add<address, bool>(arg0, arg1, true);
        };
    }

    public(friend) fun approve_clawback(arg0: &mut 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::request::Request<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::clawback_funds::ClawbackFunds<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>>>) {
        let v0 = ClawbackApproval{dummy_field: false};
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::request::approve<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::clawback_funds::ClawbackFunds<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>>, ClawbackApproval>(arg0, v0);
    }

    public fun approve_transfer(arg0: &Compliance, arg1: &mut 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::request::Request<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::send_funds::SendFunds<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>>>) {
        assert_transfer_allowed(arg0, 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::send_funds::sender<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>>(0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::request::data<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::send_funds::SendFunds<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>>>(arg1)), 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::send_funds::recipient<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>>(0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::request::data<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::send_funds::SendFunds<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>>>(arg1)));
        let v0 = TransferApproval{dummy_field: false};
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::request::approve<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::send_funds::SendFunds<0x2::balance::Balance<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>>, TransferApproval>(arg1, v0);
    }

    fun assert_can_manage_compliance(arg0: &Compliance, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner || v0 == arg0.token_manager, 13835904614811500552);
    }

    public fun assert_forced_transfer_allowed(arg0: &Compliance, arg1: address, arg2: address) {
        assert_not_paused(arg0);
        assert!(0x2::table::contains<address, bool>(&arg0.frozen, arg1), 13837592330801184788);
        assert!(arg2 != @0x0, 13836466435188785164);
        assert!(!0x2::table::contains<address, bool>(&arg0.frozen, arg2), 13837592339391119380);
        if (arg0.compliance_enabled) {
            assert!(0x2::table::contains<address, vector<u8>>(&arg0.user_ids, arg1), 13837310877299179538);
            assert!(0x2::table::contains<address, vector<u8>>(&arg0.user_ids, arg2), 13837310881594146834);
        };
    }

    public fun assert_freezer(arg0: &Compliance, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.freezer_roles, 0x2::tx_context::sender(arg1)), 13835340389252530180);
    }

    public fun assert_mint_allowed(arg0: &Compliance, arg1: address) {
        assert_not_paused(arg0);
        assert!(arg1 != @0x0, 13836466387944144908);
        assert!(!0x2::table::contains<address, bool>(&arg0.frozen, arg1), 13837592292146479124);
        if (arg0.compliance_enabled) {
            assert!(0x2::table::contains<address, vector<u8>>(&arg0.user_ids, arg1), 13837310830054539282);
        };
    }

    public fun assert_not_paused(arg0: &Compliance) {
        assert!(!arg0.paused, 13836184779823317002);
    }

    public fun assert_owner(arg0: &Compliance, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 13835058897095819266);
    }

    public fun assert_supply_controller(arg0: &Compliance, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.supply_controller_roles, 0x2::tx_context::sender(arg1)), 13835621889999175686);
    }

    public fun assert_transfer_allowed(arg0: &Compliance, arg1: address, arg2: address) {
        assert_not_paused(arg0);
        assert!(!0x2::table::contains<address, bool>(&arg0.frozen, arg1), 13837592240606871572);
        assert!(!0x2::table::contains<address, bool>(&arg0.frozen, arg2), 13837592244901838868);
        if (arg0.compliance_enabled) {
            assert!(0x2::table::contains<address, vector<u8>>(&arg0.user_ids, arg1), 13837310782809899026);
            assert!(0x2::table::contains<address, vector<u8>>(&arg0.user_ids, arg2), 13837310787104866322);
        };
    }

    public fun batch_delete_identity(arg0: &mut Compliance, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_can_manage_compliance(arg0, arg2);
        assert_not_paused(arg0);
        assert!(0x1::vector::length<address>(&arg1) <= 100, 13837874544512401430);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            remove_identity(arg0, *0x1::vector::borrow<address>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    public fun batch_register_identity(arg0: &mut Compliance, arg1: vector<address>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_can_manage_compliance(arg0, arg3);
        assert_not_paused(arg0);
        assert!(0x1::vector::length<address>(&arg1) <= 100, 13837874424253317142);
        assert!(0x1::vector::length<u8>(&arg2) > 0, 13837030003617759248);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            upsert_identity(arg0, *0x1::vector::borrow<address>(&arg1, v0), arg2);
            v0 = v0 + 1;
        };
    }

    public fun batch_set_address_frozen(arg0: &mut Compliance, arg1: vector<address>, arg2: vector<bool>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_freezer(arg0, arg3);
        assert_not_paused(arg0);
        assert!(0x1::vector::length<address>(&arg1) <= 100, 13837874669066453014);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<bool>(&arg2), 13838156148338262040);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            set_frozen(arg0, *0x1::vector::borrow<address>(&arg1, v0), *0x1::vector::borrow<bool>(&arg2, v0), 0x2::tx_context::sender(arg3));
            v0 = v0 + 1;
        };
    }

    public fun can_transfer(arg0: &Compliance, arg1: address, arg2: address) : bool {
        if (!arg0.paused) {
            if (!0x2::table::contains<address, bool>(&arg0.frozen, arg1)) {
                if (!0x2::table::contains<address, bool>(&arg0.frozen, arg2)) {
                    !arg0.compliance_enabled || 0x2::table::contains<address, vector<u8>>(&arg0.user_ids, arg1) && 0x2::table::contains<address, vector<u8>>(&arg0.user_ids, arg2)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun cancel_ownership_transfer(arg0: &mut Compliance, arg1: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        arg0.pending_owner = 0x1::option::none<address>();
    }

    public fun delete_identity(arg0: &mut Compliance, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_can_manage_compliance(arg0, arg2);
        assert_not_paused(arg0);
        remove_identity(arg0, arg1);
    }

    public fun get_user_id(arg0: &Compliance, arg1: address) : vector<u8> {
        if (0x2::table::contains<address, vector<u8>>(&arg0.user_ids, arg1)) {
            *0x2::table::borrow<address, vector<u8>>(&arg0.user_ids, arg1)
        } else {
            b""
        }
    }

    public fun grant_freezer_role(arg0: &mut Compliance, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert_not_paused(arg0);
        assert!(arg1 != @0x0, 13836466800261005324);
        let v0 = &mut arg0.freezer_roles;
        add_bool(v0, arg1);
        let v1 = RoleUpdated{
            role    : b"FREEZER_ROLE",
            account : arg1,
            enabled : true,
        };
        0x2::event::emit<RoleUpdated>(v1);
    }

    public fun grant_supply_controller_role(arg0: &mut Compliance, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert_not_paused(arg0);
        assert!(arg1 != @0x0, 13836466899045253132);
        let v0 = &mut arg0.supply_controller_roles;
        add_bool(v0, arg1);
        let v1 = RoleUpdated{
            role    : b"SUPPLY_CONTROLLER_ROLE",
            account : arg1,
            enabled : true,
        };
        0x2::event::emit<RoleUpdated>(v1);
    }

    public fun has_freezer_role(arg0: &Compliance, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.freezer_roles, arg1)
    }

    public fun has_supply_controller_role(arg0: &Compliance, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.supply_controller_roles, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::table::new<address, bool>(arg0);
        let v2 = 0x2::table::new<address, bool>(arg0);
        0x2::table::add<address, bool>(&mut v1, v0, true);
        0x2::table::add<address, bool>(&mut v2, v0, true);
        let v3 = Compliance{
            id                      : 0x2::object::new(arg0),
            owner                   : v0,
            pending_owner           : 0x1::option::none<address>(),
            token_manager           : v0,
            freezer_roles           : v1,
            supply_controller_roles : v2,
            user_ids                : 0x2::table::new<address, vector<u8>>(arg0),
            frozen                  : 0x2::table::new<address, bool>(arg0),
            compliance_enabled      : false,
            paused                  : false,
        };
        0x2::transfer::share_object<Compliance>(v3);
        let v4 = ComplianceCreated{owner: v0};
        0x2::event::emit<ComplianceCreated>(v4);
    }

    public fun is_compliance_enabled(arg0: &Compliance) : bool {
        arg0.compliance_enabled
    }

    public fun is_frozen(arg0: &Compliance, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.frozen, arg1)
    }

    public fun is_paused(arg0: &Compliance) : bool {
        arg0.paused
    }

    public fun is_whitelisted(arg0: &Compliance, arg1: address) : bool {
        0x2::table::contains<address, vector<u8>>(&arg0.user_ids, arg1)
    }

    public fun owner(arg0: &Compliance) : address {
        arg0.owner
    }

    public fun pending_owner(arg0: &Compliance) : 0x1::option::Option<address> {
        arg0.pending_owner
    }

    public fun register_identity(arg0: &mut Compliance, arg1: address, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_can_manage_compliance(arg0, arg3);
        assert_not_paused(arg0);
        upsert_identity(arg0, arg1, arg2);
    }

    fun remove_bool(arg0: &mut 0x2::table::Table<address, bool>, arg1: address) {
        if (0x2::table::contains<address, bool>(arg0, arg1)) {
            0x2::table::remove<address, bool>(arg0, arg1);
        };
    }

    fun remove_identity(arg0: &mut Compliance, arg1: address) {
        assert!(arg1 != @0x0, 13836467633484660748);
        assert!(0x2::table::contains<address, vector<u8>>(&arg0.user_ids, arg1), 13837312062710153234);
        0x2::table::remove<address, vector<u8>>(&mut arg0.user_ids, arg1);
        let v0 = IdentityRemoved{user: arg1};
        0x2::event::emit<IdentityRemoved>(v0);
    }

    public fun revoke_freezer_role(arg0: &mut Compliance, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert_not_paused(arg0);
        let v0 = &mut arg0.freezer_roles;
        remove_bool(v0, arg1);
        let v1 = RoleUpdated{
            role    : b"FREEZER_ROLE",
            account : arg1,
            enabled : false,
        };
        0x2::event::emit<RoleUpdated>(v1);
    }

    public fun revoke_supply_controller_role(arg0: &mut Compliance, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert_not_paused(arg0);
        let v0 = &mut arg0.supply_controller_roles;
        remove_bool(v0, arg1);
        let v1 = RoleUpdated{
            role    : b"SUPPLY_CONTROLLER_ROLE",
            account : arg1,
            enabled : false,
        };
        0x2::event::emit<RoleUpdated>(v1);
    }

    public fun set_address_frozen(arg0: &mut Compliance, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert_freezer(arg0, arg3);
        assert_not_paused(arg0);
        set_frozen(arg0, arg1, arg2, 0x2::tx_context::sender(arg3));
    }

    public fun set_address_frozen_with_deny_list(arg0: &mut Compliance, arg1: &mut 0x2::deny_list::DenyList, arg2: &mut 0x2::coin::DenyCapV2<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>, arg3: address, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert_freezer(arg0, arg5);
        assert_not_paused(arg0);
        set_frozen(arg0, arg3, arg4, 0x2::tx_context::sender(arg5));
        if (arg4) {
            0x2::coin::deny_list_v2_add<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(arg1, arg2, arg3, arg5);
        } else {
            0x2::coin::deny_list_v2_remove<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(arg1, arg2, arg3, arg5);
        };
    }

    public fun set_compliance_mode(arg0: &mut Compliance, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert_not_paused(arg0);
        arg0.compliance_enabled = arg1;
        let v0 = ComplianceModeUpdated{enabled: arg1};
        0x2::event::emit<ComplianceModeUpdated>(v0);
    }

    fun set_frozen(arg0: &mut Compliance, arg1: address, arg2: bool, arg3: address) {
        assert!(arg1 != @0x0, 13836467667844399116);
        assert!(arg1 != arg0.owner, 13836749147116208142);
        if (arg2) {
            let v0 = &mut arg0.frozen;
            add_bool(v0, arg1);
        } else {
            let v1 = &mut arg0.frozen;
            remove_bool(v1, arg1);
        };
        let v2 = AddressFrozen{
            user     : arg1,
            frozen   : arg2,
            operator : arg3,
        };
        0x2::event::emit<AddressFrozen>(v2);
    }

    public fun set_global_pause_with_deny_list(arg0: &mut Compliance, arg1: &mut 0x2::deny_list::DenyList, arg2: &mut 0x2::coin::DenyCapV2<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg4);
        arg0.paused = arg3;
        if (arg3) {
            0x2::coin::deny_list_v2_enable_global_pause<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(arg1, arg2, arg4);
        } else {
            0x2::coin::deny_list_v2_disable_global_pause<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::xaua::XAUA>(arg1, arg2, arg4);
        };
        let v0 = PauseUpdated{paused: arg3};
        0x2::event::emit<PauseUpdated>(v0);
    }

    public fun set_paused(arg0: &mut Compliance, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        arg0.paused = arg1;
        let v0 = PauseUpdated{paused: arg1};
        0x2::event::emit<PauseUpdated>(v0);
    }

    public fun set_token_manager(arg0: &mut Compliance, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert_not_paused(arg0);
        assert!(arg1 != @0x0, 13836466740131463180);
        arg0.token_manager = arg1;
        let v0 = TokenManagerSet{
            old_manager : arg0.token_manager,
            new_manager : arg1,
        };
        0x2::event::emit<TokenManagerSet>(v0);
    }

    public fun token_manager(arg0: &Compliance) : address {
        arg0.token_manager
    }

    public(friend) fun transfer_approval_permit() : 0x1::internal::Permit<TransferApproval> {
        0x1::internal::permit<TransferApproval>()
    }

    public fun transfer_ownership(arg0: &mut Compliance, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 != @0x0, 13836466581217673228);
        arg0.pending_owner = 0x1::option::some<address>(arg1);
        let v0 = OwnershipTransferStarted{
            previous_owner : arg0.owner,
            new_owner      : arg1,
        };
        0x2::event::emit<OwnershipTransferStarted>(v0);
    }

    fun upsert_identity(arg0: &mut Compliance, arg1: address, arg2: vector<u8>) {
        assert!(arg1 != @0x0, 13836467586240020492);
        assert!(0x1::vector::length<u8>(&arg2) > 0, 13837030540488671248);
        if (0x2::table::contains<address, vector<u8>>(&arg0.user_ids, arg1)) {
            0x2::table::remove<address, vector<u8>>(&mut arg0.user_ids, arg1);
        };
        0x2::table::add<address, vector<u8>>(&mut arg0.user_ids, arg1, arg2);
        let v0 = IdentityRegistered{
            user    : arg1,
            user_id : arg2,
        };
        0x2::event::emit<IdentityRegistered>(v0);
    }

    // decompiled from Move bytecode v7
}

