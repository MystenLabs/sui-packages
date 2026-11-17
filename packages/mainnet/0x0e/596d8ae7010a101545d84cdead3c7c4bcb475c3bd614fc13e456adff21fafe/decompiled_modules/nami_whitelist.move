module 0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::nami_whitelist {
    struct MasterWhitelistCap has store, key {
        id: 0x2::object::UID,
    }

    struct WhitelistRegistry has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        assets: 0x2::table::Table<0x1::type_name::TypeName, AssetEntry>,
        protocols: 0x2::table::Table<0x2::object::ID, ProtocolEntry>,
        pools: 0x2::table::Table<0x2::object::ID, PoolEntry>,
        max_assets: u32,
        max_protocols: u32,
        max_pools: u32,
    }

    struct AssetEntry has store {
        type_name: 0x1::type_name::TypeName,
        display_name: 0x1::string::String,
        decimals: u8,
        status: u8,
        added_at: u64,
        deprecated_at: 0x1::option::Option<u64>,
    }

    struct ProtocolEntry has store {
        protocol_id: 0x2::object::ID,
        display_name: 0x1::string::String,
        protocol_type: u8,
        status: u8,
        added_at: u64,
        deprecated_at: 0x1::option::Option<u64>,
    }

    struct PoolEntry has store {
        pool_id: 0x2::object::ID,
        protocol_id: 0x2::object::ID,
        display_name: 0x1::string::String,
        status: u8,
        added_at: u64,
        deprecated_at: 0x1::option::Option<u64>,
        suspended: bool,
    }

    struct AssetAddedEvent has copy, drop {
        type_name: 0x1::type_name::TypeName,
        display_name: 0x1::string::String,
    }

    struct AssetDeprecatedEvent has copy, drop {
        type_name: 0x1::type_name::TypeName,
        grace_period_ends_at: u64,
    }

    struct AssetUndeprecatedEvent has copy, drop {
        type_name: 0x1::type_name::TypeName,
    }

    struct AssetRemovedEvent has copy, drop {
        type_name: 0x1::type_name::TypeName,
    }

    struct ProtocolAddedEvent has copy, drop {
        protocol_id: 0x2::object::ID,
        display_name: 0x1::string::String,
    }

    struct ProtocolDeprecatedEvent has copy, drop {
        protocol_id: 0x2::object::ID,
        grace_period_ends_at: u64,
    }

    struct ProtocolUndeprecatedEvent has copy, drop {
        protocol_id: 0x2::object::ID,
    }

    struct ProtocolRemovedEvent has copy, drop {
        protocol_id: 0x2::object::ID,
    }

    struct MaxAssetsUpdatedEvent has copy, drop {
        old_max: u32,
        new_max: u32,
    }

    struct PoolAddedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        protocol_id: 0x2::object::ID,
        display_name: 0x1::string::String,
    }

    struct PoolDeprecatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        grace_period_ends_at: u64,
    }

    struct PoolUndeprecatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct PoolRemovedEvent has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct PoolSuspendedEvent has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct PoolUnsuspendedEvent has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct MaxPoolsUpdatedEvent has copy, drop {
        old_max: u32,
        new_max: u32,
    }

    struct MaxProtocolsUpdatedEvent has copy, drop {
        old_max: u32,
        new_max: u32,
    }

    struct VersionEnabledEvent has copy, drop {
        object_id: 0x2::object::ID,
        version: u64,
    }

    struct VersionDisabledEvent has copy, drop {
        object_id: 0x2::object::ID,
        version: u64,
    }

    public fun add_asset(arg0: &MasterWhitelistCap, arg1: &mut WhitelistRegistry, arg2: 0x1::type_name::TypeName, arg3: 0x1::string::String, arg4: u8, arg5: &0x2::clock::Clock) {
        0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::assert_version(&arg1.allowed_versions);
        assert!(arg4 <= 18, 20);
        assert_display_name(&arg3);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, AssetEntry>(&arg1.assets, arg2), 0);
        assert!((0x2::table::length<0x1::type_name::TypeName, AssetEntry>(&arg1.assets) as u32) < arg1.max_assets, 5);
        0x2::table::add<0x1::type_name::TypeName, AssetEntry>(&mut arg1.assets, arg2, new_asset_entry(arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5)));
        let v0 = AssetAddedEvent{
            type_name    : arg2,
            display_name : arg3,
        };
        0x2::event::emit<AssetAddedEvent>(v0);
    }

    public fun add_pool(arg0: &MasterWhitelistCap, arg1: &mut WhitelistRegistry, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: &0x2::clock::Clock) {
        0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::assert_version(&arg1.allowed_versions);
        assert_display_name(&arg4);
        assert!(is_protocol_active(arg1, arg3), 8);
        assert!(!0x2::table::contains<0x2::object::ID, PoolEntry>(&arg1.pools, arg2), 14);
        assert!((0x2::table::length<0x2::object::ID, PoolEntry>(&arg1.pools) as u32) < arg1.max_pools, 18);
        0x2::table::add<0x2::object::ID, PoolEntry>(&mut arg1.pools, arg2, new_pool_entry(arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5)));
        let v0 = PoolAddedEvent{
            pool_id      : arg2,
            protocol_id  : arg3,
            display_name : arg4,
        };
        0x2::event::emit<PoolAddedEvent>(v0);
    }

    public fun add_protocol(arg0: &MasterWhitelistCap, arg1: &mut WhitelistRegistry, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: u8, arg5: &0x2::clock::Clock) {
        0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::assert_version(&arg1.allowed_versions);
        assert!(arg4 <= 4, 21);
        assert_display_name(&arg3);
        assert!(!0x2::table::contains<0x2::object::ID, ProtocolEntry>(&arg1.protocols, arg2), 6);
        assert!((0x2::table::length<0x2::object::ID, ProtocolEntry>(&arg1.protocols) as u32) < arg1.max_protocols, 10);
        0x2::table::add<0x2::object::ID, ProtocolEntry>(&mut arg1.protocols, arg2, new_protocol_entry(arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5)));
        let v0 = ProtocolAddedEvent{
            protocol_id  : arg2,
            display_name : arg3,
        };
        0x2::event::emit<ProtocolAddedEvent>(v0);
    }

    public fun allowed_versions(arg0: &WhitelistRegistry) : &0x2::vec_set::VecSet<u64> {
        &arg0.allowed_versions
    }

    public fun assert_asset_active(arg0: &WhitelistRegistry, arg1: 0x1::type_name::TypeName) {
        assert!(is_asset_active(arg0, arg1), 12);
    }

    fun assert_display_name(arg0: &0x1::string::String) {
        assert!(0x1::string::length(arg0) > 0, 24);
        assert!(0x1::string::length(arg0) <= 128, 25);
    }

    public fun assert_pool_active(arg0: &WhitelistRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert!(is_pool_active(arg0, arg1, arg2), 19);
    }

    public fun assert_pool_usable(arg0: &WhitelistRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert!(is_pool_usable(arg0, arg1, arg2), 19);
    }

    public fun assert_protocol_active(arg0: &WhitelistRegistry, arg1: 0x2::object::ID) {
        assert!(is_protocol_active(arg0, arg1), 13);
    }

    public fun asset_exists(arg0: &WhitelistRegistry, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, AssetEntry>(&arg0.assets, arg1)
    }

    public fun default_max_assets() : u32 {
        200
    }

    public fun default_max_pools() : u32 {
        500
    }

    public fun default_max_protocols() : u32 {
        100
    }

    public fun deprecate_asset(arg0: &MasterWhitelistCap, arg1: &mut WhitelistRegistry, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) {
        0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::assert_version(&arg1.allowed_versions);
        assert!(0x2::table::contains<0x1::type_name::TypeName, AssetEntry>(&arg1.assets, arg2), 1);
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, AssetEntry>(&mut arg1.assets, arg2);
        assert!(v0.status == 0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        v0.status = 1;
        v0.deprecated_at = 0x1::option::some<u64>(v1);
        let v2 = AssetDeprecatedEvent{
            type_name            : arg2,
            grace_period_ends_at : v1 + 864000000,
        };
        0x2::event::emit<AssetDeprecatedEvent>(v2);
    }

    public fun deprecate_pool(arg0: &MasterWhitelistCap, arg1: &mut WhitelistRegistry, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::assert_version(&arg1.allowed_versions);
        assert!(0x2::table::contains<0x2::object::ID, PoolEntry>(&arg1.pools, arg2), 15);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, PoolEntry>(&mut arg1.pools, arg2);
        assert!(v0.status == 0, 16);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        v0.status = 1;
        v0.deprecated_at = 0x1::option::some<u64>(v1);
        let v2 = PoolDeprecatedEvent{
            pool_id              : arg2,
            grace_period_ends_at : v1 + 864000000,
        };
        0x2::event::emit<PoolDeprecatedEvent>(v2);
    }

    public fun deprecate_protocol(arg0: &MasterWhitelistCap, arg1: &mut WhitelistRegistry, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::assert_version(&arg1.allowed_versions);
        assert!(0x2::table::contains<0x2::object::ID, ProtocolEntry>(&arg1.protocols, arg2), 7);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, ProtocolEntry>(&mut arg1.protocols, arg2);
        assert!(v0.status == 0, 8);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        v0.status = 1;
        v0.deprecated_at = 0x1::option::some<u64>(v1);
        let v2 = ProtocolDeprecatedEvent{
            protocol_id          : arg2,
            grace_period_ends_at : v1 + 864000000,
        };
        0x2::event::emit<ProtocolDeprecatedEvent>(v2);
    }

    public fun deprecation_grace_period() : u64 {
        864000000
    }

    fun destroy_asset_entry(arg0: AssetEntry) {
        let AssetEntry {
            type_name     : _,
            display_name  : _,
            decimals      : _,
            status        : _,
            added_at      : _,
            deprecated_at : _,
        } = arg0;
    }

    fun destroy_pool_entry(arg0: PoolEntry) {
        let PoolEntry {
            pool_id       : _,
            protocol_id   : _,
            display_name  : _,
            status        : _,
            added_at      : _,
            deprecated_at : _,
            suspended     : _,
        } = arg0;
    }

    fun destroy_protocol_entry(arg0: ProtocolEntry) {
        let ProtocolEntry {
            protocol_id   : _,
            display_name  : _,
            protocol_type : _,
            status        : _,
            added_at      : _,
            deprecated_at : _,
        } = arg0;
    }

    public fun disable_version(arg0: &MasterWhitelistCap, arg1: &mut WhitelistRegistry, arg2: u64) {
        assert!(arg2 != 0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::current_version(), 901);
        assert!(0x2::vec_set::length<u64>(&arg1.allowed_versions) > 1, 27);
        0x2::vec_set::remove<u64>(&mut arg1.allowed_versions, &arg2);
        let v0 = VersionDisabledEvent{
            object_id : 0x2::object::id<WhitelistRegistry>(arg1),
            version   : arg2,
        };
        0x2::event::emit<VersionDisabledEvent>(v0);
    }

    public fun enable_version(arg0: &MasterWhitelistCap, arg1: &mut WhitelistRegistry, arg2: u64) {
        assert!(arg2 <= 0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::current_version() + 1, 26);
        0x2::vec_set::insert<u64>(&mut arg1.allowed_versions, arg2);
        let v0 = VersionEnabledEvent{
            object_id : 0x2::object::id<WhitelistRegistry>(arg1),
            version   : arg2,
        };
        0x2::event::emit<VersionEnabledEvent>(v0);
    }

    public fun get_asset_added_at(arg0: &WhitelistRegistry, arg1: 0x1::type_name::TypeName) : u64 {
        assert!(0x2::table::contains<0x1::type_name::TypeName, AssetEntry>(&arg0.assets, arg1), 1);
        0x2::table::borrow<0x1::type_name::TypeName, AssetEntry>(&arg0.assets, arg1).added_at
    }

    public fun get_asset_count(arg0: &WhitelistRegistry) : u32 {
        (0x2::table::length<0x1::type_name::TypeName, AssetEntry>(&arg0.assets) as u32)
    }

    public fun get_asset_decimals(arg0: &WhitelistRegistry, arg1: 0x1::type_name::TypeName) : u8 {
        assert!(0x2::table::contains<0x1::type_name::TypeName, AssetEntry>(&arg0.assets, arg1), 1);
        0x2::table::borrow<0x1::type_name::TypeName, AssetEntry>(&arg0.assets, arg1).decimals
    }

    public fun get_asset_deprecated_at(arg0: &WhitelistRegistry, arg1: 0x1::type_name::TypeName) : 0x1::option::Option<u64> {
        assert!(0x2::table::contains<0x1::type_name::TypeName, AssetEntry>(&arg0.assets, arg1), 1);
        0x2::table::borrow<0x1::type_name::TypeName, AssetEntry>(&arg0.assets, arg1).deprecated_at
    }

    public fun get_asset_display_name(arg0: &WhitelistRegistry, arg1: 0x1::type_name::TypeName) : 0x1::string::String {
        assert!(0x2::table::contains<0x1::type_name::TypeName, AssetEntry>(&arg0.assets, arg1), 1);
        0x2::table::borrow<0x1::type_name::TypeName, AssetEntry>(&arg0.assets, arg1).display_name
    }

    public fun get_max_assets(arg0: &WhitelistRegistry) : u32 {
        arg0.max_assets
    }

    public fun get_max_pools(arg0: &WhitelistRegistry) : u32 {
        arg0.max_pools
    }

    public fun get_max_protocols(arg0: &WhitelistRegistry) : u32 {
        arg0.max_protocols
    }

    public fun get_pool_added_at(arg0: &WhitelistRegistry, arg1: 0x2::object::ID) : u64 {
        assert!(pool_exists(arg0, arg1), 15);
        0x2::table::borrow<0x2::object::ID, PoolEntry>(&arg0.pools, arg1).added_at
    }

    public fun get_pool_count(arg0: &WhitelistRegistry) : u32 {
        (0x2::table::length<0x2::object::ID, PoolEntry>(&arg0.pools) as u32)
    }

    public fun get_pool_deprecated_at(arg0: &WhitelistRegistry, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        assert!(pool_exists(arg0, arg1), 15);
        0x2::table::borrow<0x2::object::ID, PoolEntry>(&arg0.pools, arg1).deprecated_at
    }

    public fun get_pool_display_name(arg0: &WhitelistRegistry, arg1: 0x2::object::ID) : 0x1::string::String {
        assert!(pool_exists(arg0, arg1), 15);
        0x2::table::borrow<0x2::object::ID, PoolEntry>(&arg0.pools, arg1).display_name
    }

    public fun get_pool_protocol(arg0: &WhitelistRegistry, arg1: 0x2::object::ID) : 0x2::object::ID {
        assert!(pool_exists(arg0, arg1), 15);
        0x2::table::borrow<0x2::object::ID, PoolEntry>(&arg0.pools, arg1).protocol_id
    }

    public fun get_protocol_added_at(arg0: &WhitelistRegistry, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::table::contains<0x2::object::ID, ProtocolEntry>(&arg0.protocols, arg1), 7);
        0x2::table::borrow<0x2::object::ID, ProtocolEntry>(&arg0.protocols, arg1).added_at
    }

    public fun get_protocol_count(arg0: &WhitelistRegistry) : u32 {
        (0x2::table::length<0x2::object::ID, ProtocolEntry>(&arg0.protocols) as u32)
    }

    public fun get_protocol_deprecated_at(arg0: &WhitelistRegistry, arg1: 0x2::object::ID) : 0x1::option::Option<u64> {
        assert!(0x2::table::contains<0x2::object::ID, ProtocolEntry>(&arg0.protocols, arg1), 7);
        0x2::table::borrow<0x2::object::ID, ProtocolEntry>(&arg0.protocols, arg1).deprecated_at
    }

    public fun get_protocol_display_name(arg0: &WhitelistRegistry, arg1: 0x2::object::ID) : 0x1::string::String {
        assert!(0x2::table::contains<0x2::object::ID, ProtocolEntry>(&arg0.protocols, arg1), 7);
        0x2::table::borrow<0x2::object::ID, ProtocolEntry>(&arg0.protocols, arg1).display_name
    }

    public fun get_protocol_type(arg0: &WhitelistRegistry, arg1: 0x2::object::ID) : u8 {
        assert!(0x2::table::contains<0x2::object::ID, ProtocolEntry>(&arg0.protocols, arg1), 7);
        0x2::table::borrow<0x2::object::ID, ProtocolEntry>(&arg0.protocols, arg1).protocol_type
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new_registry(0x2::vec_set::singleton<u64>(0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::current_version()), 200, 100, 500, arg0);
        0x2::transfer::share_object<WhitelistRegistry>(v0);
        let v1 = MasterWhitelistCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MasterWhitelistCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_asset_active(arg0: &WhitelistRegistry, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = &arg0.assets;
        if (!0x2::table::contains<0x1::type_name::TypeName, AssetEntry>(v0, arg1)) {
            return false
        };
        0x2::table::borrow<0x1::type_name::TypeName, AssetEntry>(v0, arg1).status == 0
    }

    public fun is_asset_usable(arg0: &WhitelistRegistry, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = &arg0.assets;
        if (!0x2::table::contains<0x1::type_name::TypeName, AssetEntry>(v0, arg1)) {
            return false
        };
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, AssetEntry>(v0, arg1).status;
        v1 == 0 || v1 == 1
    }

    public fun is_pool_active(arg0: &WhitelistRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : bool {
        let v0 = &arg0.pools;
        if (!0x2::table::contains<0x2::object::ID, PoolEntry>(v0, arg1)) {
            return false
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, PoolEntry>(v0, arg1);
        if (v1.protocol_id != arg2) {
            return false
        };
        if (v1.suspended) {
            return false
        };
        v1.status == 0
    }

    public fun is_pool_suspended(arg0: &WhitelistRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, PoolEntry>(&arg0.pools, arg1) && 0x2::table::borrow<0x2::object::ID, PoolEntry>(&arg0.pools, arg1).suspended
    }

    public fun is_pool_usable(arg0: &WhitelistRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : bool {
        let v0 = &arg0.pools;
        if (!0x2::table::contains<0x2::object::ID, PoolEntry>(v0, arg1)) {
            return false
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, PoolEntry>(v0, arg1);
        if (v1.protocol_id != arg2) {
            return false
        };
        if (v1.suspended) {
            return false
        };
        let v2 = v1.status;
        v2 == 0 || v2 == 1
    }

    public fun is_protocol_active(arg0: &WhitelistRegistry, arg1: 0x2::object::ID) : bool {
        let v0 = &arg0.protocols;
        if (!0x2::table::contains<0x2::object::ID, ProtocolEntry>(v0, arg1)) {
            return false
        };
        0x2::table::borrow<0x2::object::ID, ProtocolEntry>(v0, arg1).status == 0
    }

    public fun is_protocol_usable(arg0: &WhitelistRegistry, arg1: 0x2::object::ID) : bool {
        let v0 = &arg0.protocols;
        if (!0x2::table::contains<0x2::object::ID, ProtocolEntry>(v0, arg1)) {
            return false
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, ProtocolEntry>(v0, arg1).status;
        v1 == 0 || v1 == 1
    }

    public fun max_display_name_bytes() : u64 {
        128
    }

    fun new_asset_entry(arg0: 0x1::type_name::TypeName, arg1: 0x1::string::String, arg2: u8, arg3: u64) : AssetEntry {
        AssetEntry{
            type_name     : arg0,
            display_name  : arg1,
            decimals      : arg2,
            status        : 0,
            added_at      : arg3,
            deprecated_at : 0x1::option::none<u64>(),
        }
    }

    fun new_pool_entry(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: u64) : PoolEntry {
        PoolEntry{
            pool_id       : arg0,
            protocol_id   : arg1,
            display_name  : arg2,
            status        : 0,
            added_at      : arg3,
            deprecated_at : 0x1::option::none<u64>(),
            suspended     : false,
        }
    }

    fun new_protocol_entry(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u8, arg3: u64) : ProtocolEntry {
        ProtocolEntry{
            protocol_id   : arg0,
            display_name  : arg1,
            protocol_type : arg2,
            status        : 0,
            added_at      : arg3,
            deprecated_at : 0x1::option::none<u64>(),
        }
    }

    fun new_registry(arg0: 0x2::vec_set::VecSet<u64>, arg1: u32, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) : WhitelistRegistry {
        WhitelistRegistry{
            id               : 0x2::object::new(arg4),
            allowed_versions : arg0,
            assets           : 0x2::table::new<0x1::type_name::TypeName, AssetEntry>(arg4),
            protocols        : 0x2::table::new<0x2::object::ID, ProtocolEntry>(arg4),
            pools            : 0x2::table::new<0x2::object::ID, PoolEntry>(arg4),
            max_assets       : arg1,
            max_protocols    : arg2,
            max_pools        : arg3,
        }
    }

    public fun pool_exists(arg0: &WhitelistRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, PoolEntry>(&arg0.pools, arg1)
    }

    public fun protocol_exists(arg0: &WhitelistRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, ProtocolEntry>(&arg0.protocols, arg1)
    }

    public fun remove_asset(arg0: &MasterWhitelistCap, arg1: &mut WhitelistRegistry, arg2: 0x1::type_name::TypeName, arg3: &0x2::clock::Clock) {
        0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::assert_version(&arg1.allowed_versions);
        let v0 = &arg1.assets;
        assert!(0x2::table::contains<0x1::type_name::TypeName, AssetEntry>(v0, arg2), 1);
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, AssetEntry>(v0, arg2);
        assert!(v1.status == 1, 3);
        assert!(0x2::clock::timestamp_ms(arg3) >= 0x1::option::destroy_some<u64>(v1.deprecated_at) + 864000000, 4);
        destroy_asset_entry(0x2::table::remove<0x1::type_name::TypeName, AssetEntry>(&mut arg1.assets, arg2));
        let v2 = AssetRemovedEvent{type_name: arg2};
        0x2::event::emit<AssetRemovedEvent>(v2);
    }

    public fun remove_pool(arg0: &MasterWhitelistCap, arg1: &mut WhitelistRegistry, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::assert_version(&arg1.allowed_versions);
        let v0 = &arg1.pools;
        assert!(0x2::table::contains<0x2::object::ID, PoolEntry>(v0, arg2), 15);
        let v1 = 0x2::table::borrow<0x2::object::ID, PoolEntry>(v0, arg2);
        assert!(v1.status == 1, 17);
        assert!(0x2::clock::timestamp_ms(arg3) >= 0x1::option::destroy_some<u64>(v1.deprecated_at) + 864000000, 4);
        destroy_pool_entry(0x2::table::remove<0x2::object::ID, PoolEntry>(&mut arg1.pools, arg2));
        let v2 = PoolRemovedEvent{pool_id: arg2};
        0x2::event::emit<PoolRemovedEvent>(v2);
    }

    public fun remove_protocol(arg0: &MasterWhitelistCap, arg1: &mut WhitelistRegistry, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::assert_version(&arg1.allowed_versions);
        let v0 = &arg1.protocols;
        assert!(0x2::table::contains<0x2::object::ID, ProtocolEntry>(v0, arg2), 7);
        let v1 = 0x2::table::borrow<0x2::object::ID, ProtocolEntry>(v0, arg2);
        assert!(v1.status == 1, 9);
        assert!(0x2::clock::timestamp_ms(arg3) >= 0x1::option::destroy_some<u64>(v1.deprecated_at) + 864000000, 4);
        destroy_protocol_entry(0x2::table::remove<0x2::object::ID, ProtocolEntry>(&mut arg1.protocols, arg2));
        let v2 = ProtocolRemovedEvent{protocol_id: arg2};
        0x2::event::emit<ProtocolRemovedEvent>(v2);
    }

    public fun status_active() : u8 {
        0
    }

    public fun status_deprecated() : u8 {
        1
    }

    public fun suspend_pool(arg0: &MasterWhitelistCap, arg1: &mut WhitelistRegistry, arg2: 0x2::object::ID) {
        0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::assert_version(&arg1.allowed_versions);
        assert!(0x2::table::contains<0x2::object::ID, PoolEntry>(&arg1.pools, arg2), 15);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, PoolEntry>(&mut arg1.pools, arg2);
        assert!(!v0.suspended, 22);
        v0.suspended = true;
        let v1 = PoolSuspendedEvent{pool_id: arg2};
        0x2::event::emit<PoolSuspendedEvent>(v1);
    }

    public fun undeprecate_asset(arg0: &MasterWhitelistCap, arg1: &mut WhitelistRegistry, arg2: 0x1::type_name::TypeName) {
        0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::assert_version(&arg1.allowed_versions);
        assert!(0x2::table::contains<0x1::type_name::TypeName, AssetEntry>(&arg1.assets, arg2), 1);
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, AssetEntry>(&mut arg1.assets, arg2);
        assert!(v0.status == 1, 3);
        v0.status = 0;
        v0.deprecated_at = 0x1::option::none<u64>();
        let v1 = AssetUndeprecatedEvent{type_name: arg2};
        0x2::event::emit<AssetUndeprecatedEvent>(v1);
    }

    public fun undeprecate_pool(arg0: &MasterWhitelistCap, arg1: &mut WhitelistRegistry, arg2: 0x2::object::ID) {
        0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::assert_version(&arg1.allowed_versions);
        assert!(0x2::table::contains<0x2::object::ID, PoolEntry>(&arg1.pools, arg2), 15);
        assert!(0x2::table::borrow<0x2::object::ID, PoolEntry>(&arg1.pools, arg2).status == 1, 17);
        assert!(is_protocol_active(arg1, 0x2::table::borrow<0x2::object::ID, PoolEntry>(&arg1.pools, arg2).protocol_id), 8);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, PoolEntry>(&mut arg1.pools, arg2);
        v0.status = 0;
        v0.deprecated_at = 0x1::option::none<u64>();
        let v1 = PoolUndeprecatedEvent{pool_id: arg2};
        0x2::event::emit<PoolUndeprecatedEvent>(v1);
    }

    public fun undeprecate_protocol(arg0: &MasterWhitelistCap, arg1: &mut WhitelistRegistry, arg2: 0x2::object::ID) {
        0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::assert_version(&arg1.allowed_versions);
        assert!(0x2::table::contains<0x2::object::ID, ProtocolEntry>(&arg1.protocols, arg2), 7);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, ProtocolEntry>(&mut arg1.protocols, arg2);
        assert!(v0.status == 1, 9);
        v0.status = 0;
        v0.deprecated_at = 0x1::option::none<u64>();
        let v1 = ProtocolUndeprecatedEvent{protocol_id: arg2};
        0x2::event::emit<ProtocolUndeprecatedEvent>(v1);
    }

    public fun unsuspend_pool(arg0: &MasterWhitelistCap, arg1: &mut WhitelistRegistry, arg2: 0x2::object::ID) {
        0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::assert_version(&arg1.allowed_versions);
        assert!(0x2::table::contains<0x2::object::ID, PoolEntry>(&arg1.pools, arg2), 15);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, PoolEntry>(&mut arg1.pools, arg2);
        assert!(v0.suspended, 23);
        v0.suspended = false;
        let v1 = PoolUnsuspendedEvent{pool_id: arg2};
        0x2::event::emit<PoolUnsuspendedEvent>(v1);
    }

    public fun update_max_assets(arg0: &MasterWhitelistCap, arg1: &mut WhitelistRegistry, arg2: u32) {
        0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::assert_version(&arg1.allowed_versions);
        assert!(arg2 >= (0x2::table::length<0x1::type_name::TypeName, AssetEntry>(&arg1.assets) as u32), 11);
        arg1.max_assets = arg2;
        let v0 = MaxAssetsUpdatedEvent{
            old_max : arg1.max_assets,
            new_max : arg2,
        };
        0x2::event::emit<MaxAssetsUpdatedEvent>(v0);
    }

    public fun update_max_pools(arg0: &MasterWhitelistCap, arg1: &mut WhitelistRegistry, arg2: u32) {
        0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::assert_version(&arg1.allowed_versions);
        assert!(arg2 >= (0x2::table::length<0x2::object::ID, PoolEntry>(&arg1.pools) as u32), 11);
        arg1.max_pools = arg2;
        let v0 = MaxPoolsUpdatedEvent{
            old_max : arg1.max_pools,
            new_max : arg2,
        };
        0x2::event::emit<MaxPoolsUpdatedEvent>(v0);
    }

    public fun update_max_protocols(arg0: &MasterWhitelistCap, arg1: &mut WhitelistRegistry, arg2: u32) {
        0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version::assert_version(&arg1.allowed_versions);
        assert!(arg2 >= (0x2::table::length<0x2::object::ID, ProtocolEntry>(&arg1.protocols) as u32), 11);
        arg1.max_protocols = arg2;
        let v0 = MaxProtocolsUpdatedEvent{
            old_max : arg1.max_protocols,
            new_max : arg2,
        };
        0x2::event::emit<MaxProtocolsUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

