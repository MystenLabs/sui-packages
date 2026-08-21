module 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::compliance {
    struct Compliance has key {
        id: 0x2::object::UID,
        version: u64,
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

    struct VersionMigrated has copy, drop {
        previous_version: u64,
        new_version: u64,
    }

    public fun accept_ownership(arg0: &mut Compliance, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x1::option::is_some<address>(&arg0.pending_owner), 13838718694565019676);
        let v0 = *0x1::option::borrow<address>(&arg0.pending_owner);
        assert!(0x2::tx_context::sender(arg1) == v0, 13838437228178112538);
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

    public(friend) fun approve_clawback(arg0: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::request::Request<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::clawback_funds::ClawbackFunds<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>>) {
        let v0 = ClawbackApproval{dummy_field: false};
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::request::approve<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::clawback_funds::ClawbackFunds<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>, ClawbackApproval>(arg0, v0);
    }

    public fun approve_transfer(arg0: &Compliance, arg1: &mut 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::request::Request<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::send_funds::SendFunds<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>>) {
        assert_version(arg0);
        assert_transfer_allowed(arg0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::send_funds::sender<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>(0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::request::data<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::send_funds::SendFunds<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>>(arg1)), 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::send_funds::recipient<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>(0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::request::data<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::send_funds::SendFunds<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>>(arg1)));
        let v0 = TransferApproval{dummy_field: false};
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::request::approve<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::send_funds::SendFunds<0x2::balance::Balance<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>>, TransferApproval>(arg1, v0);
    }

    fun assert_can_manage_compliance(arg0: &Compliance, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner || v0 == arg0.token_manager, 13835904911164243976);
    }

    public fun assert_forced_transfer_allowed(arg0: &Compliance, arg1: address, arg2: address) {
        assert_not_paused(arg0);
        assert!(0x2::table::contains<address, bool>(&arg0.frozen, arg1), 13837592588499222548);
        assert!(arg2 != @0x0, 13836466692886822924);
        assert!(!0x2::table::contains<address, bool>(&arg0.frozen, arg2), 13837592597089157140);
        if (arg0.compliance_enabled) {
            assert!(0x2::table::contains<address, vector<u8>>(&arg0.user_ids, arg1), 13837311134997217298);
            assert!(0x2::table::contains<address, vector<u8>>(&arg0.user_ids, arg2), 13837311139292184594);
        };
    }

    public fun assert_freezer(arg0: &Compliance, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::table::contains<address, bool>(&arg0.freezer_roles, 0x2::tx_context::sender(arg1)), 13835340638360633348);
    }

    public fun assert_mint_allowed(arg0: &Compliance, arg1: address) {
        assert_not_paused(arg0);
        assert!(arg1 != @0x0, 13836466645642182668);
        assert!(!0x2::table::contains<address, bool>(&arg0.frozen, arg1), 13837592549844516884);
        if (arg0.compliance_enabled) {
            assert!(0x2::table::contains<address, vector<u8>>(&arg0.user_ids, arg1), 13837311087752577042);
        };
    }

    public fun assert_not_paused(arg0: &Compliance) {
        assert_version(arg0);
        assert!(!arg0.paused, 13836185020341485578);
    }

    public fun assert_owner(arg0: &Compliance, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 13835059141908955138);
    }

    public fun assert_supply_controller(arg0: &Compliance, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::table::contains<address, bool>(&arg0.supply_controller_roles, 0x2::tx_context::sender(arg1)), 13835622143402246150);
    }

    public fun assert_transfer_allowed(arg0: &Compliance, arg1: address, arg2: address) {
        assert_not_paused(arg0);
        assert!(arg2 != @0x0, 13836466594102575116);
        assert!(!0x2::table::contains<address, bool>(&arg0.frozen, arg1), 13837592498304909332);
        assert!(!0x2::table::contains<address, bool>(&arg0.frozen, arg2), 13837592502599876628);
        if (arg0.compliance_enabled) {
            assert!(0x2::table::contains<address, vector<u8>>(&arg0.user_ids, arg1), 13837311040507936786);
            assert!(0x2::table::contains<address, vector<u8>>(&arg0.user_ids, arg2), 13837311044802904082);
        };
    }

    public fun assert_version(arg0: &Compliance) {
        assert!(arg0.version == 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::version::current(), 13838999379267878942);
    }

    public fun batch_delete_identity(arg0: &mut Compliance, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_can_manage_compliance(arg0, arg2);
        assert_not_paused(arg0);
        assert!(0x1::vector::length<address>(&arg1) <= 100, 13837874815095341078);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            remove_identity(arg0, *0x1::vector::borrow<address>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    public fun batch_register_identity(arg0: &mut Compliance, arg1: vector<address>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_can_manage_compliance(arg0, arg3);
        assert_not_paused(arg0);
        assert!(0x1::vector::length<address>(&arg1) <= 100, 13837874694836256790);
        assert!(0x1::vector::length<u8>(&arg2) > 0, 13837030274200698896);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            upsert_identity(arg0, *0x1::vector::borrow<address>(&arg1, v0), arg2);
            v0 = v0 + 1;
        };
    }

    public fun batch_set_address_frozen(arg0: &mut Compliance, arg1: vector<address>, arg2: vector<bool>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_freezer(arg0, arg3);
        assert_not_paused(arg0);
        assert!(0x1::vector::length<address>(&arg1) <= 100, 13837874939649392662);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<bool>(&arg2), 13838156418921201688);
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
        assert!(arg1 != @0x0, 13836467070843944972);
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
        assert!(arg1 != @0x0, 13836467169628192780);
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
            version                 : 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::version::current(),
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

    public(friend) fun migrate(arg0: &mut Compliance, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 13835058789721636866);
        assert!(arg0.version < 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::version::current(), 13839280918669230112);
        arg0.version = 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::version::current();
        let v0 = VersionMigrated{
            previous_version : arg0.version,
            new_version      : 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::version::current(),
        };
        0x2::event::emit<VersionMigrated>(v0);
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
        assert!(arg1 != @0x0, 13836467929837404172);
        assert!(0x2::table::contains<address, vector<u8>>(&arg0.user_ids, arg1), 13837312359062896658);
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

    public fun set_address_frozen_with_deny_list(arg0: &mut Compliance, arg1: &mut 0x2::deny_list::DenyList, arg2: &mut 0x2::coin::DenyCapV2<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>, arg3: address, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert_freezer(arg0, arg5);
        assert_not_paused(arg0);
        set_frozen(arg0, arg3, arg4, 0x2::tx_context::sender(arg5));
        if (arg4) {
            0x2::coin::deny_list_v2_add<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg1, arg2, arg3, arg5);
        } else {
            0x2::coin::deny_list_v2_remove<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg1, arg2, arg3, arg5);
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
        assert!(arg1 != @0x0, 13836467964197142540);
        assert!(arg1 != arg0.owner, 13836749443468951566);
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

    public fun set_global_pause_with_deny_list(arg0: &mut Compliance, arg1: &mut 0x2::deny_list::DenyList, arg2: &mut 0x2::coin::DenyCapV2<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg4);
        arg0.paused = arg3;
        if (arg3) {
            0x2::coin::deny_list_v2_enable_global_pause<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg1, arg2, arg4);
        } else {
            0x2::coin::deny_list_v2_disable_global_pause<0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::xaua::XAUA>(arg1, arg2, arg4);
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
        assert!(arg1 != @0x0, 13836467010714402828);
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
        assert!(arg1 != @0x0, 13836466838915710988);
        arg0.pending_owner = 0x1::option::some<address>(arg1);
        let v0 = OwnershipTransferStarted{
            previous_owner : arg0.owner,
            new_owner      : arg1,
        };
        0x2::event::emit<OwnershipTransferStarted>(v0);
    }

    fun upsert_identity(arg0: &mut Compliance, arg1: address, arg2: vector<u8>) {
        assert!(arg1 != @0x0, 13836467882592763916);
        assert!(0x1::vector::length<u8>(&arg2) > 0, 13837030836841414672);
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

    public fun version(arg0: &Compliance) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

