module 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::namespace {
    struct CreateUsernameOp {
        dummy_field: bool,
    }

    struct Namespace has key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        metadata_uri: 0x1::string::String,
        create_rules: 0x2::object::ID,
        taken: 0x2::table::Table<0x1::string::String, bool>,
        username_to_account: 0x2::table::Table<0x1::string::String, address>,
        account_to_username: 0x2::table::Table<address, 0x1::string::String>,
    }

    struct NamespaceAdminCap has store, key {
        id: 0x2::object::UID,
        namespace: 0x2::object::ID,
    }

    struct Username has store, key {
        id: 0x2::object::UID,
        namespace: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct CreateUsernameTicket {
        namespace: 0x2::object::ID,
        key: address,
        account: address,
        name: 0x1::string::String,
    }

    struct NamespaceCreated has copy, drop {
        namespace: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct UsernameCreated has copy, drop {
        namespace: 0x2::object::ID,
        name: 0x1::string::String,
        by: address,
    }

    struct UsernameAssigned has copy, drop {
        namespace: 0x2::object::ID,
        name: 0x1::string::String,
        account: address,
    }

    struct UsernameUnassigned has copy, drop {
        namespace: 0x2::object::ID,
        name: 0x1::string::String,
        account: address,
    }

    struct UsernameBurned has copy, drop {
        namespace: 0x2::object::ID,
        name: 0x1::string::String,
    }

    public fun account_of(arg0: &Namespace, arg1: 0x1::string::String) : 0x1::option::Option<address> {
        if (0x2::table::contains<0x1::string::String, address>(&arg0.username_to_account, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<0x1::string::String, address>(&arg0.username_to_account, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun admin_create_username(arg0: &mut Namespace, arg1: &NamespaceAdminCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : Username {
        assert_version(arg0);
        assert!(arg1.namespace == 0x2::object::id<Namespace>(arg0), 5);
        assert_valid_name(&arg2);
        mint(arg0, arg2, arg3)
    }

    fun assert_valid_name(arg0: &0x1::string::String) {
        assert!(0x1::string::length(arg0) > 0 && 0x1::string::length(arg0) < 256, 1);
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v2 = *0x1::vector::borrow<u8>(v0, v1);
            assert!(v2 < 65 || v2 > 90, 11);
            v1 = v1 + 1;
        };
    }

    fun assert_version(arg0: &Namespace) {
        assert!(arg0.version == 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(), 9);
    }

    public fun assign(arg0: &mut Namespace, arg1: &Username, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg1.namespace == 0x2::object::id<Namespace>(arg0), 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.username_to_account, arg1.name), 3);
        assert!(!0x2::table::contains<address, 0x1::string::String>(&arg0.account_to_username, v0), 3);
        0x2::table::add<0x1::string::String, address>(&mut arg0.username_to_account, arg1.name, v0);
        0x2::table::add<address, 0x1::string::String>(&mut arg0.account_to_username, v0, arg1.name);
        let v1 = UsernameAssigned{
            namespace : 0x2::object::id<Namespace>(arg0),
            name      : arg1.name,
            account   : v0,
        };
        0x2::event::emit<UsernameAssigned>(v1);
    }

    public fun burn(arg0: &mut Namespace, arg1: Username) {
        assert_version(arg0);
        let Username {
            id        : v0,
            namespace : v1,
            name      : v2,
        } = arg1;
        assert!(v1 == 0x2::object::id<Namespace>(arg0), 2);
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg0.username_to_account, v2), 8);
        0x2::table::remove<0x1::string::String, bool>(&mut arg0.taken, v2);
        0x2::object::delete(v0);
        let v3 = UsernameBurned{
            namespace : v1,
            name      : v2,
        };
        0x2::event::emit<UsernameBurned>(v3);
    }

    public fun create(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : (NamespaceAdminCap, 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSetCap) {
        let (v0, v1) = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::new<CreateUsernameOp>(arg2);
        let v2 = v0;
        let v3 = Namespace{
            id                  : 0x2::object::new(arg2),
            version             : 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(),
            name                : arg0,
            metadata_uri        : arg1,
            create_rules        : 0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<CreateUsernameOp>>(&v2),
            taken               : 0x2::table::new<0x1::string::String, bool>(arg2),
            username_to_account : 0x2::table::new<0x1::string::String, address>(arg2),
            account_to_username : 0x2::table::new<address, 0x1::string::String>(arg2),
        };
        let v4 = NamespaceAdminCap{
            id        : 0x2::object::new(arg2),
            namespace : 0x2::object::id<Namespace>(&v3),
        };
        let v5 = NamespaceCreated{
            namespace : 0x2::object::id<Namespace>(&v3),
            name      : v3.name,
        };
        0x2::event::emit<NamespaceCreated>(v5);
        0x2::transfer::public_share_object<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<CreateUsernameOp>>(v2);
        0x2::transfer::share_object<Namespace>(v3);
        (v4, v1)
    }

    public fun create_rules_id(arg0: &Namespace) : 0x2::object::ID {
        arg0.create_rules
    }

    public fun execute_create_username(arg0: &mut Namespace, arg1: &0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<CreateUsernameOp>, arg2: CreateUsernameTicket, arg3: 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::Request<CreateUsernameOp>, arg4: &mut 0x2::tx_context::TxContext) : Username {
        assert_version(arg0);
        let CreateUsernameTicket {
            namespace : v0,
            key       : v1,
            account   : _,
            name      : v3,
        } = arg2;
        assert!(v0 == 0x2::object::id<Namespace>(arg0), 2);
        assert!(0x2::object::id<0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::RuleSet<CreateUsernameOp>>(arg1) == arg0.create_rules, 6);
        assert!(v1 == 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::request_key<CreateUsernameOp>(&arg3), 7);
        0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::confirm<CreateUsernameOp>(arg1, arg3);
        mint(arg0, v3, arg4)
    }

    public fun is_taken(arg0: &Namespace, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, bool>(&arg0.taken, arg1)
    }

    public fun migrate(arg0: &mut Namespace, arg1: &NamespaceAdminCap) {
        assert!(arg1.namespace == 0x2::object::id<Namespace>(arg0), 5);
        assert!(arg0.version < 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version(), 10);
        arg0.version = 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::current_version();
    }

    fun mint(arg0: &mut Namespace, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : Username {
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg0.taken, arg1), 0);
        0x2::table::add<0x1::string::String, bool>(&mut arg0.taken, arg1, true);
        let v0 = Username{
            id        : 0x2::object::new(arg2),
            namespace : 0x2::object::id<Namespace>(arg0),
            name      : arg1,
        };
        let v1 = UsernameCreated{
            namespace : 0x2::object::id<Namespace>(arg0),
            name      : v0.name,
            by        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<UsernameCreated>(v1);
        v0
    }

    public fun request_create_username(arg0: &Namespace, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : (CreateUsernameTicket, 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::Request<CreateUsernameOp>) {
        assert_version(arg0);
        assert_valid_name(&arg1);
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg0.taken, arg1), 0);
        let v0 = 0x2::tx_context::fresh_object_address(arg2);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = CreateUsernameTicket{
            namespace : 0x2::object::id<Namespace>(arg0),
            key       : v0,
            account   : v1,
            name      : arg1,
        };
        (v2, 0xab4b13423a5f6d06d0c674d34cffcc3ef608b3ecf8995c046ddd08c5f1e02cec::rules::new_request<CreateUsernameOp>(v0, v1))
    }

    public fun set_metadata_uri(arg0: &mut Namespace, arg1: &NamespaceAdminCap, arg2: 0x1::string::String) {
        assert_version(arg0);
        assert!(arg1.namespace == 0x2::object::id<Namespace>(arg0), 5);
        arg0.metadata_uri = arg2;
    }

    public fun ticket_account(arg0: &CreateUsernameTicket) : address {
        arg0.account
    }

    public fun ticket_key(arg0: &CreateUsernameTicket) : address {
        arg0.key
    }

    public fun ticket_name(arg0: &CreateUsernameTicket) : 0x1::string::String {
        arg0.name
    }

    public fun unassign(arg0: &mut Namespace, arg1: &Username) {
        assert_version(arg0);
        assert!(arg1.namespace == 0x2::object::id<Namespace>(arg0), 2);
        assert!(0x2::table::contains<0x1::string::String, address>(&arg0.username_to_account, arg1.name), 4);
        let v0 = 0x2::table::remove<0x1::string::String, address>(&mut arg0.username_to_account, arg1.name);
        0x2::table::remove<address, 0x1::string::String>(&mut arg0.account_to_username, v0);
        let v1 = UsernameUnassigned{
            namespace : 0x2::object::id<Namespace>(arg0),
            name      : arg1.name,
            account   : v0,
        };
        0x2::event::emit<UsernameUnassigned>(v1);
    }

    public fun unassign_self(arg0: &mut Namespace, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, 0x1::string::String>(&arg0.account_to_username, v0), 4);
        let v1 = 0x2::table::remove<address, 0x1::string::String>(&mut arg0.account_to_username, v0);
        0x2::table::remove<0x1::string::String, address>(&mut arg0.username_to_account, v1);
        let v2 = UsernameUnassigned{
            namespace : 0x2::object::id<Namespace>(arg0),
            name      : v1,
            account   : v0,
        };
        0x2::event::emit<UsernameUnassigned>(v2);
    }

    public fun username_name(arg0: &Username) : 0x1::string::String {
        arg0.name
    }

    public fun username_namespace(arg0: &Username) : 0x2::object::ID {
        arg0.namespace
    }

    public fun username_of(arg0: &Namespace, arg1: address) : 0x1::option::Option<0x1::string::String> {
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.account_to_username, arg1)) {
            0x1::option::some<0x1::string::String>(*0x2::table::borrow<address, 0x1::string::String>(&arg0.account_to_username, arg1))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun version(arg0: &Namespace) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

