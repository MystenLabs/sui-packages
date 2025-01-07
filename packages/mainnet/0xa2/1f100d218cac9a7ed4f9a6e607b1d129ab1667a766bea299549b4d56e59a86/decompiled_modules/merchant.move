module 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::merchant {
    struct Merchant has key {
        id: 0x2::object::UID,
        factory_id: 0x2::object::ID,
        merchant_id: vector<u8>,
        super_admin: address,
        admin_role: 0x2::vec_map::VecMap<address, vector<u8>>,
        is_available: bool,
        blocked_admin: 0x2::vec_set::VecSet<address>,
        permission_of_role: 0x2::table::Table<vector<u8>, 0x2::vec_set::VecSet<vector<u8>>>,
        nft_management_id: 0x2::object::ID,
        stamp_rally_management_id: 0x2::object::ID,
        e_ticket_management_id: 0x2::object::ID,
        total_stamp_rally_event: u64,
        total_e_ticket_event: u64,
    }

    struct AdminIds has key {
        id: 0x2::object::UID,
        admin_ids: 0x2::table::Table<vector<u8>, bool>,
    }

    struct SBT has key {
        id: 0x2::object::UID,
        merchant_address: address,
        role: vector<u8>,
        admin_permissions: 0x2::vec_set::VecSet<vector<u8>>,
        expired_time: u64,
    }

    struct SBTCreatedEvent has copy, drop {
        sbt_id: 0x2::object::ID,
        merchant_address: address,
        role: 0x1::string::String,
        expired_time: u64,
    }

    struct SBTRenewedEvent has copy, drop {
        sbt_id: 0x2::object::ID,
        merchant_address: address,
        role: 0x1::string::String,
        expired_time: u64,
    }

    struct AdminAddedEvent has copy, drop {
        merchant_id: 0x2::object::ID,
        admin: address,
        role: vector<u8>,
    }

    struct AdminRemovedEvent has copy, drop {
        merchant_id: 0x2::object::ID,
        admin: address,
    }

    struct RoleAddedEvent has copy, drop {
        merchant_id: 0x2::object::ID,
        role: vector<u8>,
    }

    struct RoleRemovedEvent has copy, drop {
        merchant_id: 0x2::object::ID,
        role: vector<u8>,
    }

    struct RoleOfPermissionAddedEvent has copy, drop {
        merchant_id: 0x2::object::ID,
        role: vector<u8>,
        permission: vector<u8>,
    }

    struct RoleOfPermissionRemovedEvent has copy, drop {
        merchant_id: 0x2::object::ID,
        role: vector<u8>,
        permission: vector<u8>,
    }

    struct BlockAdminEvent has copy, drop {
        merchant_id: 0x2::object::ID,
        admin: address,
    }

    struct UnblockAdminEvent has copy, drop {
        merchant_id: 0x2::object::ID,
        admin: address,
    }

    public entry fun add_admin(arg0: &0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::operator::Operator, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut AdminIds, arg4: &mut Merchant, arg5: address, arg6: vector<u8>) {
        let v0 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::operator::get_public_key(arg0);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg3.admin_ids, arg2), 2005);
        let v1 = b"";
        0x1::vector::append<u8>(&mut v1, arg2);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg5));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<u8>>(&arg6));
        assert!(0x2::ed25519::ed25519_verify(&arg1, &v0, &v1), 2004);
        0x2::table::add<vector<u8>, bool>(&mut arg3.admin_ids, arg2, true);
        assert!(!0x2::vec_map::contains<address, vector<u8>>(&arg4.admin_role, &arg5), 2010);
        0x2::vec_map::insert<address, vector<u8>>(&mut arg4.admin_role, arg5, arg6);
        let v2 = AdminAddedEvent{
            merchant_id : 0x2::object::uid_to_inner(&arg4.id),
            admin       : arg5,
            role        : arg6,
        };
        0x2::event::emit<AdminAddedEvent>(v2);
    }

    fun add_new_permission_of_role(arg0: &mut Merchant, arg1: vector<u8>, arg2: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, 0x2::vec_set::VecSet<vector<u8>>>(&arg0.permission_of_role, arg1), 2007);
        let v0 = 0x2::table::borrow_mut<vector<u8>, 0x2::vec_set::VecSet<vector<u8>>>(&mut arg0.permission_of_role, arg1);
        assert!(!0x2::vec_set::contains<vector<u8>>(v0, &arg2), 2008);
        0x2::vec_set::insert<vector<u8>>(v0, arg2);
        let v1 = RoleOfPermissionAddedEvent{
            merchant_id : 0x2::object::uid_to_inner(&arg0.id),
            role        : arg1,
            permission  : arg2,
        };
        0x2::event::emit<RoleOfPermissionAddedEvent>(v1);
    }

    fun add_new_role(arg0: &mut Merchant, arg1: vector<u8>) {
        assert!(!0x2::table::contains<vector<u8>, 0x2::vec_set::VecSet<vector<u8>>>(&arg0.permission_of_role, arg1), 2007);
        0x2::table::add<vector<u8>, 0x2::vec_set::VecSet<vector<u8>>>(&mut arg0.permission_of_role, arg1, 0x2::vec_set::empty<vector<u8>>());
        let v0 = RoleAddedEvent{
            merchant_id : 0x2::object::uid_to_inner(&arg0.id),
            role        : arg1,
        };
        0x2::event::emit<RoleAddedEvent>(v0);
    }

    public fun add_permission_of_role(arg0: &mut Merchant, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.super_admin, 2001);
        add_new_permission_of_role(arg0, arg1, arg2);
    }

    public fun add_role(arg0: &mut Merchant, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.super_admin, 2001);
        add_new_role(arg0, arg1);
    }

    public fun block_admin(arg0: &mut Merchant, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_exist_admin(arg0, arg1, arg2);
        assert!(!0x2::vec_set::contains<address>(&arg0.blocked_admin, &arg1), 2014);
        0x2::vec_set::insert<address>(&mut arg0.blocked_admin, arg1);
        let v0 = BlockAdminEvent{
            merchant_id : 0x2::object::uid_to_inner(&arg0.id),
            admin       : arg1,
        };
        0x2::event::emit<BlockAdminEvent>(v0);
    }

    public(friend) fun block_merchant(arg0: &mut Merchant) {
        assert!(arg0.is_available, 2013);
        arg0.is_available = false;
    }

    fun check_available_merchant(arg0: &Merchant) {
        assert!(arg0.is_available, 2012);
    }

    fun check_exist_admin(arg0: &Merchant, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.super_admin, 2001);
        assert!(0x2::vec_map::contains<address, vector<u8>>(&arg0.admin_role, &arg1), 2002);
    }

    fun check_exist_role(arg0: &Merchant, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.super_admin, 2001);
        assert!(0x2::table::contains<vector<u8>, 0x2::vec_set::VecSet<vector<u8>>>(&arg0.permission_of_role, arg1), 2007);
    }

    public(friend) fun check_merchant_and_permission_sbt(arg0: &Merchant, arg1: &SBT, arg2: &vector<u8>, arg3: &0x2::clock::Clock) {
        check_available_merchant(arg0);
        assert!(get_sbt_merchant_address(arg1) == 0x2::object::id_address<Merchant>(arg0), 2003);
        let (v0, v1) = get_sbt_admin_permissions(arg1);
        let v2 = v1;
        assert!(v0 != b"blocked", 2011);
        let v3 = if (0x2::vec_set::contains<vector<u8>>(&v2, arg2)) {
            true
        } else {
            let v4 = 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::super_admin();
            0x2::vec_set::contains<vector<u8>>(&v2, &v4)
        };
        assert!(v3, 2001);
        assert!(0x2::clock::timestamp_ms(arg3) < get_sbt_expired_time(arg1), 2006);
    }

    entry fun create_sbt(arg0: &Merchant, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x2::tx_context::sender(arg2) == arg0.super_admin) {
            true
        } else {
            let v1 = 0x2::tx_context::sender(arg2);
            0x2::vec_map::contains<address, vector<u8>>(&arg0.admin_role, &v1)
        };
        assert!(v0, 2001);
        let (v2, v3) = get_info_sbt(0x2::tx_context::sender(arg2), arg0);
        let v4 = SBT{
            id                : 0x2::object::new(arg2),
            merchant_address  : 0x2::object::id_address<Merchant>(arg0),
            role              : v2,
            admin_permissions : v3,
            expired_time      : 0x2::clock::timestamp_ms(arg1) + 7200000,
        };
        let v5 = SBTCreatedEvent{
            sbt_id           : 0x2::object::uid_to_inner(&v4.id),
            merchant_address : v4.merchant_address,
            role             : 0x1::string::utf8(v4.role),
            expired_time     : v4.expired_time,
        };
        0x2::event::emit<SBTCreatedEvent>(v5);
        0x2::transfer::transfer<SBT>(v4, 0x2::tx_context::sender(arg2));
    }

    fun get_info_sbt(arg0: address, arg1: &Merchant) : (vector<u8>, 0x2::vec_set::VecSet<vector<u8>>) {
        let v0 = if (arg0 == arg1.super_admin) {
            b"super_admin"
        } else {
            b"admin"
        };
        if (0x2::vec_set::contains<address>(&arg1.blocked_admin, &arg0)) {
            v0 = b"blocked";
        };
        (v0, *0x2::table::borrow<vector<u8>, 0x2::vec_set::VecSet<vector<u8>>>(&arg1.permission_of_role, *0x2::vec_map::get<address, vector<u8>>(&arg1.admin_role, &arg0)))
    }

    public(friend) fun get_merchant_id(arg0: &Merchant) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun get_sbt_admin_permissions(arg0: &SBT) : (vector<u8>, 0x2::vec_set::VecSet<vector<u8>>) {
        (arg0.role, arg0.admin_permissions)
    }

    public(friend) fun get_sbt_expired_time(arg0: &SBT) : u64 {
        arg0.expired_time
    }

    public(friend) fun get_sbt_merchant_address(arg0: &SBT) : address {
        arg0.merchant_address
    }

    public(friend) fun increase_e_ticket_quantity(arg0: &mut Merchant) {
        arg0.total_e_ticket_event = arg0.total_e_ticket_event + 1;
    }

    public(friend) fun increase_stamp_rally_quantity(arg0: &mut Merchant) {
        arg0.total_stamp_rally_event = arg0.total_stamp_rally_event + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminIds{
            id        : 0x2::object::new(arg0),
            admin_ids : 0x2::table::new<vector<u8>, bool>(arg0),
        };
        0x2::transfer::share_object<AdminIds>(v0);
    }

    public(friend) fun init_merchant(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: address, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) : address {
        let v0 = Merchant{
            id                        : 0x2::object::new(arg6),
            factory_id                : arg0,
            merchant_id               : arg1,
            super_admin               : arg2,
            admin_role                : 0x2::vec_map::empty<address, vector<u8>>(),
            is_available              : true,
            blocked_admin             : 0x2::vec_set::empty<address>(),
            permission_of_role        : 0x2::table::new<vector<u8>, 0x2::vec_set::VecSet<vector<u8>>>(arg6),
            nft_management_id         : arg3,
            stamp_rally_management_id : arg4,
            e_ticket_management_id    : arg5,
            total_stamp_rally_event   : 0,
            total_e_ticket_event      : 0,
        };
        let v1 = &mut v0;
        add_new_role(v1, b"super_admin");
        let v2 = &mut v0;
        add_new_permission_of_role(v2, b"super_admin", 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::super_admin());
        0x2::vec_map::insert<address, vector<u8>>(&mut v0.admin_role, arg2, b"super_admin");
        let v3 = &mut v0;
        add_new_role(v3, b"almighty_admin");
        let v4 = &mut v0;
        add_new_permission_of_role(v4, b"almighty_admin", 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::nft_collection_create());
        let v5 = &mut v0;
        add_new_permission_of_role(v5, b"almighty_admin", 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::nft_collection_update());
        let v6 = &mut v0;
        add_new_permission_of_role(v6, b"almighty_admin", 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::nft_collection_delete());
        let v7 = &mut v0;
        add_new_permission_of_role(v7, b"almighty_admin", 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::stamp_rally_create());
        let v8 = &mut v0;
        add_new_permission_of_role(v8, b"almighty_admin", 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::stamp_rally_update());
        let v9 = &mut v0;
        add_new_permission_of_role(v9, b"almighty_admin", 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::stamp_rally_publish());
        let v10 = &mut v0;
        add_new_permission_of_role(v10, b"almighty_admin", 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::stamp_rally_unpublish());
        let v11 = &mut v0;
        add_new_permission_of_role(v11, b"almighty_admin", 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::stamp_rally_delete());
        let v12 = &mut v0;
        add_new_permission_of_role(v12, b"almighty_admin", 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::e_ticket_create());
        let v13 = &mut v0;
        add_new_permission_of_role(v13, b"almighty_admin", 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::e_ticket_update());
        let v14 = &mut v0;
        add_new_permission_of_role(v14, b"almighty_admin", 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::e_ticket_publish());
        let v15 = &mut v0;
        add_new_permission_of_role(v15, b"almighty_admin", 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::e_ticket_unpublish());
        let v16 = &mut v0;
        add_new_permission_of_role(v16, b"almighty_admin", 0xa21f100d218cac9a7ed4f9a6e607b1d129ab1667a766bea299549b4d56e59a86::permission::e_ticket_delete());
        0x2::transfer::share_object<Merchant>(v0);
        0x2::object::id_address<Merchant>(&v0)
    }

    public entry fun remove_admin(arg0: &mut Merchant, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_exist_admin(arg0, arg1, arg2);
        let (_, _) = 0x2::vec_map::remove<address, vector<u8>>(&mut arg0.admin_role, &arg1);
        let v2 = AdminRemovedEvent{
            merchant_id : 0x2::object::uid_to_inner(&arg0.id),
            admin       : arg1,
        };
        0x2::event::emit<AdminRemovedEvent>(v2);
    }

    public fun remove_permission_of_role(arg0: &mut Merchant, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.super_admin, 2001);
        assert!(0x2::table::contains<vector<u8>, 0x2::vec_set::VecSet<vector<u8>>>(&arg0.permission_of_role, arg1), 2007);
        let v0 = 0x2::table::borrow_mut<vector<u8>, 0x2::vec_set::VecSet<vector<u8>>>(&mut arg0.permission_of_role, arg1);
        assert!(0x2::vec_set::contains<vector<u8>>(v0, &arg2), 2009);
        0x2::vec_set::remove<vector<u8>>(v0, &arg2);
        let v1 = RoleOfPermissionRemovedEvent{
            merchant_id : 0x2::object::uid_to_inner(&arg0.id),
            role        : arg1,
            permission  : arg2,
        };
        0x2::event::emit<RoleOfPermissionRemovedEvent>(v1);
    }

    public fun remove_role(arg0: &mut Merchant, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        check_exist_role(arg0, arg1, arg2);
        0x2::table::remove<vector<u8>, 0x2::vec_set::VecSet<vector<u8>>>(&mut arg0.permission_of_role, arg1);
        let v0 = RoleRemovedEvent{
            merchant_id : 0x2::object::uid_to_inner(&arg0.id),
            role        : arg1,
        };
        0x2::event::emit<RoleRemovedEvent>(v0);
    }

    entry fun renew_sbt(arg0: &Merchant, arg1: &mut SBT, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.merchant_address == 0x2::object::id_address<Merchant>(arg0), 2003);
        let v0 = if (0x2::tx_context::sender(arg3) == arg0.super_admin) {
            true
        } else {
            let v1 = 0x2::tx_context::sender(arg3);
            0x2::vec_map::contains<address, vector<u8>>(&arg0.admin_role, &v1)
        };
        assert!(v0, 2001);
        let (v2, v3) = get_info_sbt(0x2::tx_context::sender(arg3), arg0);
        arg1.role = v2;
        arg1.admin_permissions = v3;
        arg1.expired_time = 0x2::clock::timestamp_ms(arg2) + 7200000;
        let v4 = SBTRenewedEvent{
            sbt_id           : 0x2::object::uid_to_inner(&arg1.id),
            merchant_address : arg1.merchant_address,
            role             : 0x1::string::utf8(arg1.role),
            expired_time     : arg1.expired_time,
        };
        0x2::event::emit<SBTRenewedEvent>(v4);
    }

    public fun unblock_admin(arg0: &mut Merchant, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_exist_admin(arg0, arg1, arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.blocked_admin, &arg1), 2015);
        0x2::vec_set::remove<address>(&mut arg0.blocked_admin, &arg1);
        let v0 = UnblockAdminEvent{
            merchant_id : 0x2::object::uid_to_inner(&arg0.id),
            admin       : arg1,
        };
        0x2::event::emit<UnblockAdminEvent>(v0);
    }

    public(friend) fun unblock_merchant(arg0: &mut Merchant) {
        assert!(!arg0.is_available, 2014);
        arg0.is_available = true;
    }

    // decompiled from Move bytecode v6
}

