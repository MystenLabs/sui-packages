module 0x2a63e378ab0138cdcb12651a093f3799f8b8e4f6c927ce6de0e8bc7ded0ec49d::registry {
    struct RegistryAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OracleRegistry has key {
        id: 0x2::object::UID,
        sources: 0x2::table::Table<OracleSourceKey, 0x2::object::ID>,
        bindings: 0x2::table::Table<OracleBindingKey, OracleMetadata>,
        source_bindings: 0x2::table::Table<OracleSourceKey, u32>,
        block_scholes_stores: 0x2::table::Table<u32, BlockScholesStorePair>,
    }

    struct BlockScholesStorePair has copy, drop, store {
        value_store_id: 0x2::object::ID,
        svi_store_id: 0x2::object::ID,
        block_scholes_base_asset: 0x1::string::String,
    }

    struct OracleSourceKey has copy, drop, store {
        oracle_kind: u8,
        source_id: u32,
    }

    struct OracleBindingKey has copy, drop, store {
        propbook_underlying_id: u32,
        oracle_kind: u8,
        value_kind: u8,
    }

    struct OracleMetadata has copy, drop, store {
        propbook_underlying_id: u32,
        oracle_kind: u8,
        source_id: u32,
        propbook_oracle_id: 0x2::object::ID,
        value_kind: u8,
    }

    struct OracleSourceRegistered has copy, drop {
        oracle_kind: u8,
        source_id: u32,
        propbook_oracle_id: 0x2::object::ID,
    }

    struct OracleBound has copy, drop {
        propbook_underlying_id: u32,
        oracle_kind: u8,
        source_id: u32,
        propbook_oracle_id: 0x2::object::ID,
        value_kind: u8,
    }

    struct BlockScholesStoresRegistered has copy, drop {
        propbook_underlying_id: u32,
        value_store_id: 0x2::object::ID,
        svi_store_id: 0x2::object::ID,
        block_scholes_base_asset: 0x1::string::String,
    }

    struct OracleRebound has copy, drop {
        propbook_underlying_id: u32,
        oracle_kind: u8,
        value_kind: u8,
        old_source_id: u32,
        old_propbook_oracle_id: 0x2::object::ID,
        new_source_id: u32,
        new_propbook_oracle_id: 0x2::object::ID,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : OracleRegistry {
        OracleRegistry{
            id                   : 0x2::object::new(arg0),
            sources              : 0x2::table::new<OracleSourceKey, 0x2::object::ID>(arg0),
            bindings             : 0x2::table::new<OracleBindingKey, OracleMetadata>(arg0),
            source_bindings      : 0x2::table::new<OracleSourceKey, u32>(arg0),
            block_scholes_stores : 0x2::table::new<u32, BlockScholesStorePair>(arg0),
        }
    }

    public(friend) fun create_and_share(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<OracleRegistry>(new(arg0));
    }

    public fun id(arg0: &OracleRegistry) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun assert_binding_available(arg0: &OracleRegistry, arg1: OracleBindingKey) {
        assert!(!0x2::table::contains<OracleBindingKey, OracleMetadata>(&arg0.bindings, arg1), 4);
    }

    fun assert_binding_exists(arg0: &OracleRegistry, arg1: OracleBindingKey) {
        assert!(0x2::table::contains<OracleBindingKey, OracleMetadata>(&arg0.bindings, arg1), 5);
    }

    fun assert_registered_source_object(arg0: &OracleRegistry, arg1: OracleSourceKey, arg2: 0x2::object::ID) {
        assert!(0x2::table::contains<OracleSourceKey, 0x2::object::ID>(&arg0.sources, arg1), 1);
        assert!(*0x2::table::borrow<OracleSourceKey, 0x2::object::ID>(&arg0.sources, arg1) == arg2, 2);
    }

    fun assert_source_assignable(arg0: &OracleRegistry, arg1: OracleSourceKey, arg2: u32) {
        if (0x2::table::contains<OracleSourceKey, u32>(&arg0.source_bindings, arg1)) {
            assert!(*0x2::table::borrow<OracleSourceKey, u32>(&arg0.source_bindings, arg1) == arg2, 3);
        };
    }

    fun assert_source_available(arg0: &OracleRegistry, arg1: OracleSourceKey) {
        assert!(!0x2::table::contains<OracleSourceKey, 0x2::object::ID>(&arg0.sources, arg1), 0);
    }

    fun bind_oracle(arg0: &mut OracleRegistry, arg1: &RegistryAdminCap, arg2: OracleSourceKey, arg3: 0x2::object::ID, arg4: OracleBindingKey) {
        let v0 = arg4.propbook_underlying_id;
        assert_registered_source_object(arg0, arg2, arg3);
        assert_binding_available(arg0, arg4);
        assert_source_assignable(arg0, arg2, v0);
        let v1 = OracleMetadata{
            propbook_underlying_id : v0,
            oracle_kind            : arg2.oracle_kind,
            source_id              : arg2.source_id,
            propbook_oracle_id     : arg3,
            value_kind             : arg4.value_kind,
        };
        0x2::table::add<OracleBindingKey, OracleMetadata>(&mut arg0.bindings, arg4, v1);
        record_source_binding_if_missing(arg0, arg2, v0);
        let v2 = OracleBound{
            propbook_underlying_id : v0,
            oracle_kind            : arg2.oracle_kind,
            source_id              : arg2.source_id,
            propbook_oracle_id     : arg3,
            value_kind             : arg4.value_kind,
        };
        0x2::event::emit<OracleBound>(v2);
    }

    public fun bind_pyth_to_underlying(arg0: &mut OracleRegistry, arg1: &RegistryAdminCap, arg2: &mut 0x2a63e378ab0138cdcb12651a093f3799f8b8e4f6c927ce6de0e8bc7ded0ec49d::pyth_feed::PythFeed, arg3: u32) {
        bind_oracle(arg0, arg1, pyth_source_key(0x2a63e378ab0138cdcb12651a093f3799f8b8e4f6c927ce6de0e8bc7ded0ec49d::pyth_feed::pyth_source_id(arg2)), 0x2a63e378ab0138cdcb12651a093f3799f8b8e4f6c927ce6de0e8bc7ded0ec49d::pyth_feed::id(arg2), pyth_binding_key(arg3));
        0x2a63e378ab0138cdcb12651a093f3799f8b8e4f6c927ce6de0e8bc7ded0ec49d::pyth_feed::assign_underlying(arg2, arg3);
    }

    public fun block_scholes_base_asset(arg0: &BlockScholesStorePair) : 0x1::string::String {
        arg0.block_scholes_base_asset
    }

    public fun block_scholes_svi_store_id(arg0: &BlockScholesStorePair) : 0x2::object::ID {
        arg0.svi_store_id
    }

    public fun block_scholes_value_store_id(arg0: &BlockScholesStorePair) : 0x2::object::ID {
        arg0.value_store_id
    }

    fun canonical_metadata(arg0: &OracleRegistry, arg1: OracleBindingKey) : 0x1::option::Option<OracleMetadata> {
        if (0x2::table::contains<OracleBindingKey, OracleMetadata>(&arg0.bindings, arg1)) {
            0x1::option::some<OracleMetadata>(*0x2::table::borrow<OracleBindingKey, OracleMetadata>(&arg0.bindings, arg1))
        } else {
            0x1::option::none<OracleMetadata>()
        }
    }

    fun canonical_oracle_id(arg0: &OracleRegistry, arg1: OracleBindingKey) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<OracleBindingKey, OracleMetadata>(&arg0.bindings, arg1)) {
            0x1::option::some<0x2::object::ID>(0x2::table::borrow<OracleBindingKey, OracleMetadata>(&arg0.bindings, arg1).propbook_oracle_id)
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun contains_pyth_source(arg0: &OracleRegistry, arg1: u32) : bool {
        contains_source(arg0, pyth_source_key(arg1))
    }

    fun contains_source(arg0: &OracleRegistry, arg1: OracleSourceKey) : bool {
        0x2::table::contains<OracleSourceKey, 0x2::object::ID>(&arg0.sources, arg1)
    }

    public fun create_and_share_block_scholes_stores(arg0: &mut OracleRegistry, arg1: &RegistryAdminCap, arg2: u32, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : BlockScholesStorePair {
        assert!(!0x2::table::contains<u32, BlockScholesStorePair>(&arg0.block_scholes_stores, arg2), 6);
        assert!(!0x1::string::is_empty(&arg3), 7);
        assert!(0x1::vector::length<u8>(0x1::string::as_bytes(&arg3)) <= 32, 7);
        let v0 = 0x2a63e378ab0138cdcb12651a093f3799f8b8e4f6c927ce6de0e8bc7ded0ec49d::block_scholes_store::create_and_share_value_store(arg2, arg3, arg4);
        let v1 = 0x2a63e378ab0138cdcb12651a093f3799f8b8e4f6c927ce6de0e8bc7ded0ec49d::block_scholes_store::create_and_share_svi_store(arg2, arg3, arg4);
        let v2 = BlockScholesStorePair{
            value_store_id           : v0,
            svi_store_id             : v1,
            block_scholes_base_asset : arg3,
        };
        0x2::table::add<u32, BlockScholesStorePair>(&mut arg0.block_scholes_stores, arg2, v2);
        let v3 = BlockScholesStoresRegistered{
            propbook_underlying_id   : arg2,
            value_store_id           : v0,
            svi_store_id             : v1,
            block_scholes_base_asset : v2.block_scholes_base_asset,
        };
        0x2::event::emit<BlockScholesStoresRegistered>(v3);
        v2
    }

    public fun create_and_share_pyth_feed(arg0: &mut OracleRegistry, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = pyth_source_key(arg1);
        assert_source_available(arg0, v0);
        let v1 = 0x2a63e378ab0138cdcb12651a093f3799f8b8e4f6c927ce6de0e8bc7ded0ec49d::pyth_feed::create_and_share(arg1, arg2);
        record_source(arg0, v0, v1);
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_and_share(arg0);
        let v0 = RegistryAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<RegistryAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun oracle_kind(arg0: &OracleMetadata) : u8 {
        arg0.oracle_kind
    }

    public fun propbook_block_scholes_store_pair_for_underlying(arg0: &OracleRegistry, arg1: u32) : 0x1::option::Option<BlockScholesStorePair> {
        if (!0x2::table::contains<u32, BlockScholesStorePair>(&arg0.block_scholes_stores, arg1)) {
            0x1::option::none<BlockScholesStorePair>()
        } else {
            0x1::option::some<BlockScholesStorePair>(*0x2::table::borrow<u32, BlockScholesStorePair>(&arg0.block_scholes_stores, arg1))
        }
    }

    public fun propbook_oracle_id(arg0: &OracleMetadata) : 0x2::object::ID {
        arg0.propbook_oracle_id
    }

    public fun propbook_pyth_id_for_source(arg0: &OracleRegistry, arg1: u32) : 0x1::option::Option<0x2::object::ID> {
        source_oracle_id(arg0, pyth_source_key(arg1))
    }

    public fun propbook_pyth_id_for_underlying(arg0: &OracleRegistry, arg1: u32) : 0x1::option::Option<0x2::object::ID> {
        canonical_oracle_id(arg0, pyth_binding_key(arg1))
    }

    public fun propbook_underlying_id(arg0: &OracleMetadata) : u32 {
        arg0.propbook_underlying_id
    }

    fun pyth_binding_key(arg0: u32) : OracleBindingKey {
        OracleBindingKey{
            propbook_underlying_id : arg0,
            oracle_kind            : 0,
            value_kind             : 0,
        }
    }

    public fun pyth_metadata_for_underlying(arg0: &OracleRegistry, arg1: u32) : 0x1::option::Option<OracleMetadata> {
        canonical_metadata(arg0, pyth_binding_key(arg1))
    }

    fun pyth_source_key(arg0: u32) : OracleSourceKey {
        OracleSourceKey{
            oracle_kind : 0,
            source_id   : arg0,
        }
    }

    fun record_source(arg0: &mut OracleRegistry, arg1: OracleSourceKey, arg2: 0x2::object::ID) {
        assert!(!0x2::table::contains<OracleSourceKey, 0x2::object::ID>(&arg0.sources, arg1), 0);
        0x2::table::add<OracleSourceKey, 0x2::object::ID>(&mut arg0.sources, arg1, arg2);
        let v0 = OracleSourceRegistered{
            oracle_kind        : arg1.oracle_kind,
            source_id          : arg1.source_id,
            propbook_oracle_id : arg2,
        };
        0x2::event::emit<OracleSourceRegistered>(v0);
    }

    fun record_source_binding_if_missing(arg0: &mut OracleRegistry, arg1: OracleSourceKey, arg2: u32) {
        if (!0x2::table::contains<OracleSourceKey, u32>(&arg0.source_bindings, arg1)) {
            0x2::table::add<OracleSourceKey, u32>(&mut arg0.source_bindings, arg1, arg2);
        };
    }

    public fun registry_admin_cap_id(arg0: &RegistryAdminCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun replace_oracle(arg0: &mut OracleRegistry, arg1: &RegistryAdminCap, arg2: OracleSourceKey, arg3: 0x2::object::ID, arg4: OracleBindingKey) {
        let v0 = arg4.propbook_underlying_id;
        assert_binding_exists(arg0, arg4);
        assert_registered_source_object(arg0, arg2, arg3);
        assert_source_assignable(arg0, arg2, v0);
        let v1 = *0x2::table::borrow<OracleBindingKey, OracleMetadata>(&arg0.bindings, arg4);
        let v2 = OracleMetadata{
            propbook_underlying_id : v0,
            oracle_kind            : arg2.oracle_kind,
            source_id              : arg2.source_id,
            propbook_oracle_id     : arg3,
            value_kind             : arg4.value_kind,
        };
        *0x2::table::borrow_mut<OracleBindingKey, OracleMetadata>(&mut arg0.bindings, arg4) = v2;
        record_source_binding_if_missing(arg0, arg2, v0);
        let v3 = OracleRebound{
            propbook_underlying_id : v0,
            oracle_kind            : arg2.oracle_kind,
            value_kind             : arg4.value_kind,
            old_source_id          : v1.source_id,
            old_propbook_oracle_id : v1.propbook_oracle_id,
            new_source_id          : arg2.source_id,
            new_propbook_oracle_id : arg3,
        };
        0x2::event::emit<OracleRebound>(v3);
    }

    public fun replace_pyth_binding_for_underlying(arg0: &mut OracleRegistry, arg1: &RegistryAdminCap, arg2: &mut 0x2a63e378ab0138cdcb12651a093f3799f8b8e4f6c927ce6de0e8bc7ded0ec49d::pyth_feed::PythFeed, arg3: u32) {
        replace_oracle(arg0, arg1, pyth_source_key(0x2a63e378ab0138cdcb12651a093f3799f8b8e4f6c927ce6de0e8bc7ded0ec49d::pyth_feed::pyth_source_id(arg2)), 0x2a63e378ab0138cdcb12651a093f3799f8b8e4f6c927ce6de0e8bc7ded0ec49d::pyth_feed::id(arg2), pyth_binding_key(arg3));
        0x2a63e378ab0138cdcb12651a093f3799f8b8e4f6c927ce6de0e8bc7ded0ec49d::pyth_feed::assign_underlying(arg2, arg3);
    }

    public fun source_id(arg0: &OracleMetadata) : u32 {
        arg0.source_id
    }

    fun source_oracle_id(arg0: &OracleRegistry, arg1: OracleSourceKey) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<OracleSourceKey, 0x2::object::ID>(&arg0.sources, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<OracleSourceKey, 0x2::object::ID>(&arg0.sources, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun value_kind(arg0: &OracleMetadata) : u8 {
        arg0.value_kind
    }

    // decompiled from Move bytecode v7
}

