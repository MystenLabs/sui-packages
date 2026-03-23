module 0x3389b8589ec31afd6787d3d8af5d498e9248010efbbd99ceb2113df5cbdb1a4d::registry {
    struct SkillRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        owner: address,
        tags: 0x1::string::String,
        versions: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        version_count: u64,
    }

    struct SkillVersion has key {
        id: 0x2::object::UID,
        obj_version: u64,
        registry_id: 0x2::object::ID,
        version: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        content_hash: 0x1::string::String,
        price: u64,
        seal_policy_id: 0x1::string::String,
        seal_key_id: vector<u8>,
        published_at: u64,
        publisher: address,
        allowed_accounts: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SkillPublished has copy, drop {
        registry_id: 0x2::object::ID,
        version_id: 0x2::object::ID,
        name: 0x1::string::String,
        version: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        content_hash: 0x1::string::String,
        price: u64,
        seal_policy_id: 0x1::string::String,
        publisher: address,
    }

    struct SkillUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        version_id: 0x2::object::ID,
        version: 0x1::string::String,
        publisher: address,
    }

    public(friend) fun add_allowed_account(arg0: &mut SkillVersion, arg1: 0x2::object::ID) {
        if (!0x2::table::contains<0x2::object::ID, bool>(&arg0.allowed_accounts, arg1)) {
            0x2::table::add<0x2::object::ID, bool>(&mut arg0.allowed_accounts, arg1, true);
        };
    }

    public entry fun create_and_publish(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg9);
        0x2::object::uid_to_inner(&v0);
        let v1 = SkillRegistry{
            id            : v0,
            version       : 1,
            name          : arg0,
            description   : arg1,
            owner         : 0x2::tx_context::sender(arg9),
            tags          : arg2,
            versions      : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg9),
            version_count : 0,
        };
        let v2 = &mut v1;
        publish_version(v2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::transfer::share_object<SkillRegistry>(v1);
    }

    public fun create_registry(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg3);
        let v1 = SkillRegistry{
            id            : v0,
            version       : 1,
            name          : arg0,
            description   : arg1,
            owner         : 0x2::tx_context::sender(arg3),
            tags          : arg2,
            versions      : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg3),
            version_count : 0,
        };
        0x2::transfer::share_object<SkillRegistry>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public entry fun create_registry_entry(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        create_registry(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_free(arg0: &SkillVersion) : bool {
        arg0.price == 0
    }

    public fun migrate_registry(arg0: &mut SkillRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        arg0.version = 1;
    }

    public fun publish_version(arg0: &mut SkillRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 5);
        assert!(arg0.owner == 0x2::tx_context::sender(arg7), 0);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.versions, arg1), 1);
        assert!(arg4 == 0 || 0x1::vector::length<u8>(&arg6) > 0, 4);
        let v0 = 0x2::object::new(arg7);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = SkillVersion{
            id               : v0,
            obj_version      : 1,
            registry_id      : 0x2::object::id<SkillRegistry>(arg0),
            version          : arg1,
            walrus_blob_id   : arg2,
            content_hash     : arg3,
            price            : arg4,
            seal_policy_id   : arg5,
            seal_key_id      : arg6,
            published_at     : 0x2::tx_context::epoch_timestamp_ms(arg7),
            publisher        : 0x2::tx_context::sender(arg7),
            allowed_accounts : 0x2::table::new<0x2::object::ID, bool>(arg7),
        };
        let v3 = SkillPublished{
            registry_id    : 0x2::object::id<SkillRegistry>(arg0),
            version_id     : v1,
            name           : arg0.name,
            version        : v2.version,
            walrus_blob_id : v2.walrus_blob_id,
            content_hash   : v2.content_hash,
            price          : arg4,
            seal_policy_id : v2.seal_policy_id,
            publisher      : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<SkillPublished>(v3);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.versions, v2.version, v1);
        arg0.version_count = arg0.version_count + 1;
        0x2::transfer::share_object<SkillVersion>(v2);
    }

    public entry fun publish_version_entry(arg0: &mut SkillRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        publish_version(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun registry_name(arg0: &SkillRegistry) : &0x1::string::String {
        &arg0.name
    }

    public fun registry_owner(arg0: &SkillRegistry) : address {
        arg0.owner
    }

    public fun registry_version(arg0: &SkillRegistry) : u64 {
        arg0.version
    }

    public fun registry_version_count(arg0: &SkillRegistry) : u64 {
        arg0.version_count
    }

    public fun version_allowed_account_count(arg0: &SkillVersion) : u64 {
        0x2::table::length<0x2::object::ID, bool>(&arg0.allowed_accounts)
    }

    public fun version_content_hash(arg0: &SkillVersion) : &0x1::string::String {
        &arg0.content_hash
    }

    public fun version_has_allowed_account(arg0: &SkillVersion, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.allowed_accounts, arg1)
    }

    public fun version_obj_version(arg0: &SkillVersion) : u64 {
        arg0.obj_version
    }

    public fun version_price(arg0: &SkillVersion) : u64 {
        arg0.price
    }

    public fun version_registry_id(arg0: &SkillVersion) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun version_seal_key_id(arg0: &SkillVersion) : &vector<u8> {
        &arg0.seal_key_id
    }

    public fun version_seal_policy_id(arg0: &SkillVersion) : &0x1::string::String {
        &arg0.seal_policy_id
    }

    public fun version_walrus_blob_id(arg0: &SkillVersion) : &0x1::string::String {
        &arg0.walrus_blob_id
    }

    // decompiled from Move bytecode v6
}

