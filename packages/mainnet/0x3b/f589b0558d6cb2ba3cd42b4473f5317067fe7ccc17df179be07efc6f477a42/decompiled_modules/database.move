module 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::database {
    struct Operation has copy, drop, store {
        encrypted_sql: vector<u8>,
        sql_hash: vector<u8>,
        timestamp: u64,
        client_id: address,
        schema_version: u64,
    }

    struct AccessRequest has copy, drop, store {
        id: 0x2::object::ID,
        from: address,
        requested_permission: 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission,
        message: 0x1::option::Option<0x1::string::String>,
        created_at: u64,
    }

    struct SealPolicy has copy, drop, store {
        policy_version: u64,
        created_at: u64,
        updated_at: u64,
    }

    struct WalrusConfig has copy, drop, store {
        blob_id: 0x1::string::String,
        blob_size: u64,
        storage_epochs: u64,
        content_hash: vector<u8>,
        encrypted_at: u64,
    }

    struct Database has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        owner: address,
        seal_policy: 0x1::option::Option<SealPolicy>,
        walrus_config: 0x1::option::Option<WalrusConfig>,
        schema_version: u64,
        authorized_users: 0x2::table::Table<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>,
        operation_queue: vector<Operation>,
        pending_requests: 0x2::table::Table<0x2::object::ID, AccessRequest>,
    }

    struct DatabaseCreated has copy, drop {
        database_id: 0x2::object::ID,
        name: 0x1::string::String,
        owner: address,
    }

    struct OperationAdded has copy, drop {
        database_id: 0x2::object::ID,
        operation: Operation,
    }

    struct AccessGranted has copy, drop {
        database_id: 0x2::object::ID,
        to: address,
        permission: 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission,
    }

    struct AccessRevoked has copy, drop {
        database_id: 0x2::object::ID,
        from: address,
    }

    struct AccessRequested has copy, drop {
        database_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        from: address,
        requested_permission: 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission,
    }

    struct RequestApproved has copy, drop {
        database_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        user: address,
        approved_by: address,
    }

    struct RequestRejected has copy, drop {
        database_id: 0x2::object::ID,
        request_id: 0x2::object::ID,
        user: address,
        rejected_by: address,
    }

    struct SealPolicyUpdated has copy, drop {
        database_id: 0x2::object::ID,
        policy_version: u64,
        updated_by: address,
    }

    struct EncryptedContentStored has copy, drop {
        database_id: 0x2::object::ID,
        walrus_blob_id: 0x1::string::String,
        content_size: u64,
        stored_by: address,
    }

    struct SecureDatabaseCreated has copy, drop {
        database_id: 0x2::object::ID,
        name: 0x1::string::String,
        owner: address,
        has_seal_policy: bool,
        has_walrus_content: bool,
    }

    public entry fun add_operation(arg0: &mut Database, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(check_permission(arg0, v0, 2, arg4), 3);
        assert!(0x1::option::is_some<SealPolicy>(&arg0.seal_policy), 7);
        let v1 = Operation{
            encrypted_sql  : arg1,
            sql_hash       : arg2,
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg4),
            client_id      : v0,
            schema_version : arg3,
        };
        0x1::vector::push_back<Operation>(&mut arg0.operation_queue, v1);
        let v2 = OperationAdded{
            database_id : 0x2::object::id<Database>(arg0),
            operation   : v1,
        };
        0x2::event::emit<OperationAdded>(v2);
    }

    public entry fun approve_request(arg0: &mut Database, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner || check_permission(arg0, v0, 3, arg2), 1);
        assert!(0x2::table::contains<0x2::object::ID, AccessRequest>(&arg0.pending_requests, arg1), 4);
        let v1 = 0x2::table::remove<0x2::object::ID, AccessRequest>(&mut arg0.pending_requests, arg1);
        let v2 = v1.from;
        let v3 = v1.requested_permission;
        if (0x2::table::contains<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&arg0.authorized_users, v2)) {
            0x2::table::remove<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&mut arg0.authorized_users, v2);
        };
        0x2::table::add<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&mut arg0.authorized_users, v2, v3);
        let v4 = RequestApproved{
            database_id : 0x2::object::id<Database>(arg0),
            request_id  : arg1,
            user        : v2,
            approved_by : v0,
        };
        0x2::event::emit<RequestApproved>(v4);
        let v5 = AccessGranted{
            database_id : 0x2::object::id<Database>(arg0),
            to          : v2,
            permission  : v3,
        };
        0x2::event::emit<AccessGranted>(v5);
    }

    public fun check_admin_permission(arg0: &Database, arg1: address, arg2: &0x2::tx_context::TxContext) : bool {
        check_permission(arg0, arg1, 3, arg2)
    }

    public fun check_permission(arg0: &Database, arg1: address, arg2: u8, arg3: &0x2::tx_context::TxContext) : bool {
        if (arg1 == arg0.owner) {
            return true
        };
        if (!0x2::table::contains<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&arg0.authorized_users, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&arg0.authorized_users, arg1);
        let (_, _, _, v4) = 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::get_permission_details(v0);
        let v5 = v4;
        if (0x1::option::is_some<u64>(&v5)) {
            if (*0x1::option::borrow<u64>(&v5) <= 0x2::tx_context::epoch_timestamp_ms(arg3)) {
                return false
            };
        };
        let (v6, v7, v8, _) = 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::get_permission_details(v0);
        if (arg2 == 1) {
            return v6
        };
        if (arg2 == 2) {
            return v7
        };
        if (arg2 == 3) {
            return v8
        };
        false
    }

    public entry fun clear_operation_queue(arg0: &mut Database, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 2);
        arg0.operation_queue = 0x1::vector::empty<Operation>();
    }

    public entry fun clear_walrus_storage(arg0: &mut Database, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 2);
        arg0.walrus_config = 0x1::option::none<WalrusConfig>();
        let v1 = EncryptedContentStored{
            database_id    : 0x2::object::id<Database>(arg0),
            walrus_blob_id : 0x1::string::utf8(b""),
            content_size   : 0,
            stored_by      : v0,
        };
        0x2::event::emit<EncryptedContentStored>(v1);
    }

    public entry fun create_database(arg0: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::GlobalRegistry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = Database{
            id               : 0x2::object::new(arg2),
            name             : arg1,
            owner            : v0,
            seal_policy      : 0x1::option::none<SealPolicy>(),
            walrus_config    : 0x1::option::none<WalrusConfig>(),
            schema_version   : 0,
            authorized_users : 0x2::table::new<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(arg2),
            operation_queue  : 0x1::vector::empty<Operation>(),
            pending_requests : 0x2::table::new<0x2::object::ID, AccessRequest>(arg2),
        };
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::get_or_create_registry(arg0, arg2);
        let v2 = DatabaseCreated{
            database_id : 0x2::object::id<Database>(&v1),
            name        : arg1,
            owner       : v0,
        };
        0x2::event::emit<DatabaseCreated>(v2);
        0x2::transfer::share_object<Database>(v1);
    }

    public fun create_database_and_get_id(arg0: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::GlobalRegistry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = Database{
            id               : 0x2::object::new(arg2),
            name             : arg1,
            owner            : v0,
            seal_policy      : 0x1::option::none<SealPolicy>(),
            walrus_config    : 0x1::option::none<WalrusConfig>(),
            schema_version   : 0,
            authorized_users : 0x2::table::new<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(arg2),
            operation_queue  : 0x1::vector::empty<Operation>(),
            pending_requests : 0x2::table::new<0x2::object::ID, AccessRequest>(arg2),
        };
        let v2 = 0x2::object::id<Database>(&v1);
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::get_or_create_registry(arg0, arg2);
        let v3 = DatabaseCreated{
            database_id : v2,
            name        : arg1,
            owner       : v0,
        };
        0x2::event::emit<DatabaseCreated>(v3);
        0x2::transfer::share_object<Database>(v1);
        v2
    }

    public entry fun create_database_with_seal(arg0: &mut 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::GlobalRegistry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = SealPolicy{
            policy_version : 1,
            created_at     : 0x2::tx_context::epoch_timestamp_ms(arg2),
            updated_at     : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        let v2 = Database{
            id               : 0x2::object::new(arg2),
            name             : arg1,
            owner            : v0,
            seal_policy      : 0x1::option::some<SealPolicy>(v1),
            walrus_config    : 0x1::option::none<WalrusConfig>(),
            schema_version   : 0,
            authorized_users : 0x2::table::new<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(arg2),
            operation_queue  : 0x1::vector::empty<Operation>(),
            pending_requests : 0x2::table::new<0x2::object::ID, AccessRequest>(arg2),
        };
        0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::registry::get_or_create_registry(arg0, arg2);
        let v3 = SecureDatabaseCreated{
            database_id        : 0x2::object::id<Database>(&v2),
            name               : arg1,
            owner              : v0,
            has_seal_policy    : true,
            has_walrus_content : false,
        };
        0x2::event::emit<SecureDatabaseCreated>(v3);
        0x2::transfer::share_object<Database>(v2);
    }

    public fun get_access_request(arg0: &Database, arg1: 0x2::object::ID) : 0x1::option::Option<AccessRequest> {
        if (0x2::table::contains<0x2::object::ID, AccessRequest>(&arg0.pending_requests, arg1)) {
            0x1::option::some<AccessRequest>(*0x2::table::borrow<0x2::object::ID, AccessRequest>(&arg0.pending_requests, arg1))
        } else {
            0x1::option::none<AccessRequest>()
        }
    }

    public fun get_access_request_details(arg0: &AccessRequest) : (0x2::object::ID, address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission, 0x1::option::Option<0x1::string::String>, u64) {
        (arg0.id, arg0.from, arg0.requested_permission, arg0.message, arg0.created_at)
    }

    public fun get_all_operations(arg0: &Database) : vector<Operation> {
        arg0.operation_queue
    }

    public fun get_database_info(arg0: &Database) : (0x1::string::String, address, bool, bool) {
        (arg0.name, arg0.owner, 0x1::option::is_some<SealPolicy>(&arg0.seal_policy), 0x1::option::is_some<WalrusConfig>(&arg0.walrus_config))
    }

    public fun get_encrypted_sql(arg0: &Operation) : vector<u8> {
        arg0.encrypted_sql
    }

    public fun get_name(arg0: &Database) : 0x1::string::String {
        arg0.name
    }

    public fun get_operation(arg0: &Database, arg1: u64) : 0x1::option::Option<Operation> {
        if (arg1 < 0x1::vector::length<Operation>(&arg0.operation_queue)) {
            0x1::option::some<Operation>(*0x1::vector::borrow<Operation>(&arg0.operation_queue, arg1))
        } else {
            0x1::option::none<Operation>()
        }
    }

    public fun get_operation_details(arg0: &Operation) : (vector<u8>, vector<u8>, u64, address, u64) {
        (arg0.encrypted_sql, arg0.sql_hash, arg0.timestamp, arg0.client_id, arg0.schema_version)
    }

    public fun get_operation_metadata(arg0: &Operation) : (u64, address, u64) {
        (arg0.timestamp, arg0.client_id, arg0.schema_version)
    }

    public fun get_operation_queue_size(arg0: &Database) : u64 {
        0x1::vector::length<Operation>(&arg0.operation_queue)
    }

    public fun get_owner(arg0: &Database) : address {
        arg0.owner
    }

    public fun get_pending_request_count(arg0: &Database) : u64 {
        0x2::table::length<0x2::object::ID, AccessRequest>(&arg0.pending_requests)
    }

    public fun get_schema_version(arg0: &Database) : u64 {
        arg0.schema_version
    }

    public fun get_seal_policy(arg0: &Database) : 0x1::option::Option<SealPolicy> {
        arg0.seal_policy
    }

    public fun get_sql_hash(arg0: &Operation) : vector<u8> {
        arg0.sql_hash
    }

    public fun get_storage_type(arg0: &Database) : 0x1::option::Option<0x1::string::String> {
        if (0x1::option::is_some<WalrusConfig>(&arg0.walrus_config)) {
            0x1::option::some<0x1::string::String>(0x1::string::utf8(b"walrus"))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun get_walrus_blob_id(arg0: &Database) : 0x1::option::Option<0x1::string::String> {
        if (0x1::option::is_some<WalrusConfig>(&arg0.walrus_config)) {
            0x1::option::some<0x1::string::String>(0x1::option::borrow<WalrusConfig>(&arg0.walrus_config).blob_id)
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun get_walrus_config(arg0: &Database) : 0x1::option::Option<WalrusConfig> {
        arg0.walrus_config
    }

    public entry fun grant_access(arg0: &mut Database, arg1: address, arg2: bool, arg3: bool, arg4: bool, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == arg0.owner || check_permission(arg0, v0, 3, arg6), 1);
        let v1 = 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::create_permission(arg2, arg3, arg4, arg5);
        if (0x2::table::contains<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&arg0.authorized_users, arg1)) {
            0x2::table::remove<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&mut arg0.authorized_users, arg1);
        };
        0x2::table::add<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&mut arg0.authorized_users, arg1, v1);
        let v2 = AccessGranted{
            database_id : 0x2::object::id<Database>(arg0),
            to          : arg1,
            permission  : v1,
        };
        0x2::event::emit<AccessGranted>(v2);
    }

    public fun grant_access_with_permission(arg0: &mut Database, arg1: address, arg2: 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner || check_permission(arg0, v0, 3, arg3), 1);
        if (0x2::table::contains<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&arg0.authorized_users, arg1)) {
            0x2::table::remove<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&mut arg0.authorized_users, arg1);
        };
        0x2::table::add<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&mut arg0.authorized_users, arg1, arg2);
        let v1 = AccessGranted{
            database_id : 0x2::object::id<Database>(arg0),
            to          : arg1,
            permission  : arg2,
        };
        0x2::event::emit<AccessGranted>(v1);
    }

    public fun has_encrypted_content(arg0: &Database) : bool {
        0x1::option::is_some<WalrusConfig>(&arg0.walrus_config)
    }

    public fun has_pending_request(arg0: &Database, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, AccessRequest>(&arg0.pending_requests, arg1)
    }

    public fun has_seal_policy(arg0: &Database) : bool {
        0x1::option::is_some<SealPolicy>(&arg0.seal_policy)
    }

    public fun has_walrus_content(arg0: &Database) : bool {
        0x1::option::is_some<WalrusConfig>(&arg0.walrus_config)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun reject_request(arg0: &mut Database, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner || check_permission(arg0, v0, 3, arg2), 1);
        assert!(0x2::table::contains<0x2::object::ID, AccessRequest>(&arg0.pending_requests, arg1), 4);
        let v1 = 0x2::table::remove<0x2::object::ID, AccessRequest>(&mut arg0.pending_requests, arg1);
        let v2 = RequestRejected{
            database_id : 0x2::object::id<Database>(arg0),
            request_id  : arg1,
            user        : v1.from,
            rejected_by : v0,
        };
        0x2::event::emit<RequestRejected>(v2);
    }

    public entry fun request_access(arg0: &mut Database, arg1: bool, arg2: bool, arg3: bool, arg4: 0x1::option::Option<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!0x2::table::contains<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&arg0.authorized_users, v0), 5);
        let v1 = 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::create_permission(arg1, arg2, arg3, 0x1::option::none<u64>());
        let v2 = 0x2::object::new(arg5);
        let v3 = 0x2::object::uid_to_inner(&v2);
        0x2::object::delete(v2);
        let v4 = AccessRequest{
            id                   : v3,
            from                 : v0,
            requested_permission : v1,
            message              : arg4,
            created_at           : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::table::add<0x2::object::ID, AccessRequest>(&mut arg0.pending_requests, v3, v4);
        let v5 = AccessRequested{
            database_id          : 0x2::object::id<Database>(arg0),
            request_id           : v3,
            from                 : v0,
            requested_permission : v1,
        };
        0x2::event::emit<AccessRequested>(v5);
    }

    public entry fun revoke_access(arg0: &mut Database, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner || check_permission(arg0, v0, 3, arg2), 1);
        assert!(0x2::table::contains<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&arg0.authorized_users, arg1), 0);
        0x2::table::remove<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&mut arg0.authorized_users, arg1);
        let v1 = AccessRevoked{
            database_id : 0x2::object::id<Database>(arg0),
            from        : arg1,
        };
        0x2::event::emit<AccessRevoked>(v1);
    }

    public fun seal_approve(arg0: &Database, arg1: address, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) : bool {
        if (arg1 == arg0.owner) {
            return true
        };
        if (!0x2::table::contains<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&arg0.authorized_users, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&arg0.authorized_users, arg1);
        let (_, _, _, v4) = 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::get_permission_details(v0);
        let v5 = v4;
        if (0x1::option::is_some<u64>(&v5)) {
            if (0x2::tx_context::epoch_timestamp_ms(arg3) > *0x1::option::borrow<u64>(&v5)) {
                return false
            };
        };
        let (v6, _, _, _) = 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::get_permission_details(v0);
        v6
    }

    public fun seal_approve_write(arg0: &Database, arg1: address, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) : bool {
        if (arg1 == arg0.owner) {
            return true
        };
        if (!0x2::table::contains<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&arg0.authorized_users, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&arg0.authorized_users, arg1);
        let (_, _, _, v4) = 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::get_permission_details(v0);
        let v5 = v4;
        if (0x1::option::is_some<u64>(&v5)) {
            if (0x2::tx_context::epoch_timestamp_ms(arg3) > *0x1::option::borrow<u64>(&v5)) {
                return false
            };
        };
        let (_, v7, _, _) = 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::get_permission_details(v0);
        v7
    }

    public entry fun store_encrypted_content(arg0: &mut Database, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0.owner, 2);
        let v1 = WalrusConfig{
            blob_id        : arg1,
            blob_size      : arg2,
            storage_epochs : arg3,
            content_hash   : arg4,
            encrypted_at   : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        arg0.walrus_config = 0x1::option::some<WalrusConfig>(v1);
        let v2 = EncryptedContentStored{
            database_id    : 0x2::object::id<Database>(arg0),
            walrus_blob_id : arg1,
            content_size   : arg2,
            stored_by      : v0,
        };
        0x2::event::emit<EncryptedContentStored>(v2);
    }

    public entry fun update_schema_version(arg0: &mut Database, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 2);
        arg0.schema_version = arg1;
    }

    public entry fun update_seal_policy(arg0: &mut Database, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 2);
        assert!(0x1::option::is_some<SealPolicy>(&arg0.seal_policy), 7);
        let v1 = 0x1::option::borrow_mut<SealPolicy>(&mut arg0.seal_policy);
        v1.policy_version = v1.policy_version + 1;
        v1.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg1);
        let v2 = SealPolicyUpdated{
            database_id    : 0x2::object::id<Database>(arg0),
            policy_version : v1.policy_version,
            updated_by     : v0,
        };
        0x2::event::emit<SealPolicyUpdated>(v2);
    }

    public entry fun update_walrus_and_clear_queue(arg0: &mut Database, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0.owner, 2);
        let v1 = WalrusConfig{
            blob_id        : arg1,
            blob_size      : arg2,
            storage_epochs : arg3,
            content_hash   : arg4,
            encrypted_at   : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        arg0.walrus_config = 0x1::option::some<WalrusConfig>(v1);
        arg0.operation_queue = 0x1::vector::empty<Operation>();
        let v2 = EncryptedContentStored{
            database_id    : 0x2::object::id<Database>(arg0),
            walrus_blob_id : arg1,
            content_size   : arg2,
            stored_by      : v0,
        };
        0x2::event::emit<EncryptedContentStored>(v2);
    }

    public entry fun update_walrus_storage(arg0: &mut Database, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg0.owner, 2);
        let v1 = WalrusConfig{
            blob_id        : arg1,
            blob_size      : arg2,
            storage_epochs : arg3,
            content_hash   : arg4,
            encrypted_at   : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        arg0.walrus_config = 0x1::option::some<WalrusConfig>(v1);
        let v2 = EncryptedContentStored{
            database_id    : 0x2::object::id<Database>(arg0),
            walrus_blob_id : arg1,
            content_size   : arg2,
            stored_by      : v0,
        };
        0x2::event::emit<EncryptedContentStored>(v2);
    }

    public fun verify_operation_hash(arg0: &Operation, arg1: vector<u8>) : bool {
        arg0.sql_hash == arg1
    }

    public fun view_permissions(arg0: &Database, arg1: address) : 0x1::option::Option<0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission> {
        if (0x2::table::contains<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&arg0.authorized_users, arg1)) {
            0x1::option::some<0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(*0x2::table::borrow<address, 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>(&arg0.authorized_users, arg1))
        } else {
            0x1::option::none<0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite::Permission>()
        }
    }

    // decompiled from Move bytecode v6
}

