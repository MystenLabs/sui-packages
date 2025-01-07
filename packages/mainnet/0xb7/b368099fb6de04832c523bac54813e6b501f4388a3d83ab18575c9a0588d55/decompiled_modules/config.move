module 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BridgeCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        acl: 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::acl::ACL,
        package_version: u64,
        protocol_fee_amount: u64,
        protocol_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        inscription_account: 0xcb5bd7a29f458a1b1e0221516fbfaeb182be027033eb8dcb4f33dd540d20bb87::config::Account,
        confirmed_limit: u64,
        delete_grace: u64,
        skip_verify: bool,
        open_c2i: bool,
    }

    struct InitConfigEvent has copy, drop {
        admin_cap_id: 0x2::object::ID,
        bridge_cap_id: 0x2::object::ID,
        global_config_id: 0x2::object::ID,
        inscription_account_id: 0x2::object::ID,
    }

    struct SetRolesEvent has copy, drop {
        member: address,
        roles: u128,
    }

    struct AddRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct RemoveRoleEvent has copy, drop {
        member: address,
        role: u8,
    }

    struct RemoveMemberEvent has copy, drop {
        member: address,
    }

    struct UpdateProtocolFeeEvent has copy, drop {
        protocol_fee_amount: u64,
    }

    struct ReceiveProtocolFeeEvent has copy, drop {
        amount: u64,
    }

    struct UpdateDeleteGraceEvent has copy, drop {
        grace: u64,
    }

    struct UpdateConfirmedLimit has copy, drop {
        old_limit: u64,
        new_limit: u64,
    }

    struct CollectProtocolFeeEvent has copy, drop {
        amount: u64,
    }

    struct SetPackageVersionEvent has copy, drop {
        new_version: u64,
        old_version: u64,
    }

    public fun add_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        check_package_version(arg1);
        0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::acl::add_role(&mut arg1.acl, arg2, arg3);
        let v0 = AddRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<AddRoleEvent>(v0);
    }

    public fun get_members(arg0: &GlobalConfig) : vector<0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::acl::Member> {
        0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::acl::get_members(&arg0.acl)
    }

    public fun remove_member(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        check_package_version(arg1);
        0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::acl::remove_member(&mut arg1.acl, arg2);
        let v0 = RemoveMemberEvent{member: arg2};
        0x2::event::emit<RemoveMemberEvent>(v0);
    }

    public fun remove_role(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u8) {
        check_package_version(arg1);
        0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::acl::remove_role(&mut arg1.acl, arg2, arg3);
        let v0 = RemoveRoleEvent{
            member : arg2,
            role   : arg3,
        };
        0x2::event::emit<RemoveRoleEvent>(v0);
    }

    public fun set_roles(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: u128) {
        check_package_version(arg1);
        0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::acl::set_roles(&mut arg1.acl, arg2, arg3);
        let v0 = SetRolesEvent{
            member : arg2,
            roles  : arg3,
        };
        0x2::event::emit<SetRolesEvent>(v0);
    }

    public fun check_package_version(arg0: &GlobalConfig) {
        assert!(1 >= arg0.package_version, 1);
    }

    public fun check_validator_manager_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::acl::has_role(&arg0.acl, arg1, 1), 2);
    }

    public fun check_validator_role(arg0: &GlobalConfig, arg1: address) {
        assert!(0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::acl::has_role(&arg0.acl, arg1, 2), 3);
    }

    public fun collect_protocol_fee(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::acl::has_role(&arg0.acl, 0x2::tx_context::sender(arg2), 3), 4);
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.protocol_fees);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2), arg1);
        let v1 = CollectProtocolFeeEvent{amount: 0x2::balance::value<0x2::sui::SUI>(&v0)};
        0x2::event::emit<CollectProtocolFeeEvent>(v1);
    }

    public fun get_confirmed_limit(arg0: &GlobalConfig) : u64 {
        arg0.confirmed_limit
    }

    public fun get_delete_grace(arg0: &GlobalConfig) : u64 {
        arg0.delete_grace
    }

    public fun get_protocol_fee_amount(arg0: &GlobalConfig) : u64 {
        arg0.protocol_fee_amount
    }

    public fun get_received_protocol_fee_amount(arg0: &GlobalConfig) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.protocol_fees)
    }

    public fun has_validator_role(arg0: &GlobalConfig, arg1: address) : bool {
        0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::acl::has_role(&arg0.acl, arg1, 2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcb5bd7a29f458a1b1e0221516fbfaeb182be027033eb8dcb4f33dd540d20bb87::config::create_account(arg0);
        let v1 = GlobalConfig{
            id                  : 0x2::object::new(arg0),
            acl                 : 0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::acl::new(arg0),
            package_version     : 1,
            protocol_fee_amount : 0,
            protocol_fees       : 0x2::balance::zero<0x2::sui::SUI>(),
            inscription_account : v0,
            confirmed_limit     : 1,
            delete_grace        : 2592000000,
            skip_verify         : false,
            open_c2i            : false,
        };
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        let v3 = BridgeCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<BridgeCap>(v3, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GlobalConfig>(v1);
        let v4 = InitConfigEvent{
            admin_cap_id           : 0x2::object::id<AdminCap>(&v2),
            bridge_cap_id          : 0x2::object::id<BridgeCap>(&v3),
            global_config_id       : 0x2::object::id<GlobalConfig>(&v1),
            inscription_account_id : 0x2::object::id<0xcb5bd7a29f458a1b1e0221516fbfaeb182be027033eb8dcb4f33dd540d20bb87::config::Account>(&v0),
        };
        0x2::event::emit<InitConfigEvent>(v4);
    }

    public fun open_c2i(arg0: &GlobalConfig) : bool {
        arg0.open_c2i
    }

    public fun package_version() : u64 {
        1
    }

    public fun receive_protocol_fee(arg0: &mut GlobalConfig, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.protocol_fees, arg1);
        let v0 = ReceiveProtocolFeeEvent{amount: 0x2::balance::value<0x2::sui::SUI>(&arg1)};
        0x2::event::emit<ReceiveProtocolFeeEvent>(v0);
    }

    public fun set_package_version(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        arg1.package_version = arg2;
        let v0 = SetPackageVersionEvent{
            new_version : arg2,
            old_version : arg1.package_version,
        };
        0x2::event::emit<SetPackageVersionEvent>(v0);
    }

    public fun skip_verify(arg0: &GlobalConfig) : bool {
        arg0.skip_verify
    }

    public(friend) fun transfer_from_vault(arg0: &GlobalConfig, arg1: &0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::inscription::Inscription, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::inscription::transfer_from(&arg0.inscription_account, arg1, arg2, arg3)
    }

    public(friend) fun transfer_to_vault(arg0: &GlobalConfig, arg1: &0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::inscription::Inscription, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xb7b368099fb6de04832c523bac54813e6b501f4388a3d83ab18575c9a0588d55::inscription::transfer(&arg0.inscription_account, arg1, arg2)
    }

    public entry fun update_confirmed_limit(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        check_package_version(arg1);
        assert!(arg2 > 0, 5);
        arg1.confirmed_limit = arg2;
        let v0 = UpdateConfirmedLimit{
            old_limit : arg1.confirmed_limit,
            new_limit : arg2,
        };
        0x2::event::emit<UpdateConfirmedLimit>(v0);
    }

    public fun update_delete_grace(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        check_package_version(arg1);
        arg1.delete_grace = arg2;
        let v0 = UpdateDeleteGraceEvent{grace: arg2};
        0x2::event::emit<UpdateDeleteGraceEvent>(v0);
    }

    public entry fun update_protocol_fee_amount(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        check_package_version(arg1);
        arg1.protocol_fee_amount = arg2;
        let v0 = UpdateProtocolFeeEvent{protocol_fee_amount: arg2};
        0x2::event::emit<UpdateProtocolFeeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

