module 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::protocol {
    struct PROTOCOL has drop {
        dummy_field: bool,
    }

    struct Protocol has store, key {
        id: 0x2::object::UID,
        inner: 0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::VersionedObject,
    }

    struct ProtocolInner has store, key {
        id: 0x2::object::UID,
        num_queries: u64,
        fee_factor_bps: u64,
        default_liveness_ms: u64,
        resolver_fees: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        topic_schemas: 0x2::table::Table<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::SchemaRef, SchemaEntry>,
        supported_coin_types: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        last_schema_versions: 0x2::table::Table<vector<u8>, u64>,
    }

    struct SchemaEntry has copy, drop, store {
        active: bool,
        schema: 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::Schema,
    }

    struct ProtocolCap has key {
        id: 0x2::object::UID,
    }

    struct DefaultLivenessChanged has copy, drop {
        old_ms: u64,
        new_ms: u64,
    }

    struct FeeFactorChanged has copy, drop {
        old_bps: u64,
        new_bps: u64,
    }

    struct ResolverFeeSet has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        fee: u64,
    }

    struct ResolverFeeRemoved has copy, drop {
        coin_type: 0x1::type_name::TypeName,
    }

    struct CoinTypeAdded has copy, drop {
        coin_type: 0x1::type_name::TypeName,
    }

    struct CoinTypeRemoved has copy, drop {
        coin_type: 0x1::type_name::TypeName,
    }

    struct TopicSchemaSet has copy, drop {
        version: u64,
        topic: vector<u8>,
    }

    struct TopicSchemaDeactivated has copy, drop {
        version: u64,
        topic: vector<u8>,
    }

    public fun add_supported_coin_type<T0>(arg0: &mut Protocol, arg1: &ProtocolCap) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::table::add<0x1::type_name::TypeName, bool>(&mut load_inner_mut(arg0).supported_coin_types, v0, true);
        let v1 = CoinTypeAdded{coin_type: v0};
        0x2::event::emit<CoinTypeAdded>(v1);
    }

    public fun deactivate_topic_schema(arg0: &mut Protocol, arg1: &ProtocolCap, arg2: vector<u8>, arg3: u64) {
        let v0 = load_inner_mut(arg0);
        let v1 = 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::new_schema_ref(arg2, arg3);
        assert!(0x2::table::contains<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::SchemaRef, SchemaEntry>(&v0.topic_schemas, v1), 7);
        0x2::table::borrow_mut<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::SchemaRef, SchemaEntry>(&mut v0.topic_schemas, v1).active = false;
        let v2 = TopicSchemaDeactivated{
            version : arg3,
            topic   : arg2,
        };
        0x2::event::emit<TopicSchemaDeactivated>(v2);
    }

    public fun default_liveness_ms(arg0: &mut Protocol) : u64 {
        load_inner(arg0).default_liveness_ms
    }

    public(friend) fun extend(arg0: &mut Protocol) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun fee_factor_bps(arg0: &mut Protocol) : u64 {
        load_inner(arg0).fee_factor_bps
    }

    public fun has_topic_schema(arg0: &mut Protocol, arg1: vector<u8>, arg2: u64) : bool {
        0x2::table::contains<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::SchemaRef, SchemaEntry>(&load_inner(arg0).topic_schemas, 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::new_schema_ref(arg1, arg2))
    }

    public(friend) fun increment_num_queries(arg0: &mut Protocol) {
        let v0 = load_inner_mut(arg0);
        v0.num_queries = v0.num_queries + 1;
    }

    fun init(arg0: PROTOCOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<PROTOCOL>(arg0, arg1);
    }

    public fun initialize(arg0: 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : (Protocol, ProtocolCap) {
        assert!(0x2::package::from_module<PROTOCOL>(&arg0), 1);
        let v0 = 0x2::object::new(arg1);
        let v1 = ProtocolInner{
            id                   : 0x2::derived_object::claim<u64>(&mut v0, 1),
            num_queries          : 0,
            fee_factor_bps       : 5000,
            default_liveness_ms  : 300000,
            resolver_fees        : 0x2::table::new<0x1::type_name::TypeName, u64>(arg1),
            topic_schemas        : 0x2::table::new<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::SchemaRef, SchemaEntry>(arg1),
            supported_coin_types : 0x2::table::new<0x1::type_name::TypeName, bool>(arg1),
            last_schema_versions : 0x2::table::new<vector<u8>, u64>(arg1),
        };
        let v2 = ProtocolCap{id: 0x2::derived_object::claim<vector<u8>>(&mut v0, b"PROTOCOL_CAP")};
        let v3 = Protocol{
            id    : v0,
            inner : 0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::create<ProtocolInner>(1, v1, arg1),
        };
        0x2::package::burn_publisher(arg0);
        (v3, v2)
    }

    public fun is_coin_type_supported<T0>(arg0: &mut Protocol) : bool {
        0x2::table::contains<0x1::type_name::TypeName, bool>(&load_inner(arg0).supported_coin_types, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun is_topic_schema_active(arg0: &mut Protocol, arg1: vector<u8>, arg2: u64) : bool {
        0x2::table::borrow<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::SchemaRef, SchemaEntry>(&load_inner(arg0).topic_schemas, 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::new_schema_ref(arg1, arg2)).active
    }

    fun load_inner(arg0: &mut Protocol) : &ProtocolInner {
        assert!(0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::version(&arg0.inner) == 1, 6);
        0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::load_value<ProtocolInner>(&arg0.inner)
    }

    fun load_inner_mut(arg0: &mut Protocol) : &mut ProtocolInner {
        assert!(0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::version(&arg0.inner) == 1, 6);
        0x8256e107385261b483aad47fdbcf99b22706396d9f49b53a756ee4af0d11f977::versioned_object::load_value_mut<ProtocolInner>(&mut arg0.inner)
    }

    public fun minimum_bond_amount<T0>(arg0: &mut Protocol) : u64 {
        let v0 = load_inner(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&v0.resolver_fees, v1), 3);
        (((*0x2::table::borrow<0x1::type_name::TypeName, u64>(&v0.resolver_fees, v1) as u128) * 10000 / (v0.fee_factor_bps as u128)) as u64)
    }

    public fun num_queries(arg0: &mut Protocol) : u64 {
        load_inner(arg0).num_queries
    }

    public fun remove_resolver_fee<T0>(arg0: &mut Protocol, arg1: &ProtocolCap) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = load_inner_mut(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&v1.resolver_fees, v0), 3);
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut v1.resolver_fees, v0);
        let v2 = ResolverFeeRemoved{coin_type: v0};
        0x2::event::emit<ResolverFeeRemoved>(v2);
    }

    public fun remove_supported_coin_type<T0>(arg0: &mut Protocol, arg1: &ProtocolCap) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::table::remove<0x1::type_name::TypeName, bool>(&mut load_inner_mut(arg0).supported_coin_types, v0);
        let v1 = CoinTypeRemoved{coin_type: v0};
        0x2::event::emit<CoinTypeRemoved>(v1);
    }

    public fun resolver_fee<T0>(arg0: &mut Protocol) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = load_inner(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&v1.resolver_fees, v0), 3);
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&v1.resolver_fees, v0)
    }

    public fun set_default_liveness_ms(arg0: &mut Protocol, arg1: &ProtocolCap, arg2: u64) {
        assert!(arg2 >= 300000, 0);
        let v0 = load_inner_mut(arg0);
        v0.default_liveness_ms = arg2;
        let v1 = DefaultLivenessChanged{
            old_ms : v0.default_liveness_ms,
            new_ms : arg2,
        };
        0x2::event::emit<DefaultLivenessChanged>(v1);
    }

    public fun set_fee_factor_bps(arg0: &mut Protocol, arg1: &ProtocolCap, arg2: u64) {
        assert!(arg2 > 0 && arg2 <= 10000, 2);
        let v0 = load_inner_mut(arg0);
        v0.fee_factor_bps = arg2;
        let v1 = FeeFactorChanged{
            old_bps : v0.fee_factor_bps,
            new_bps : arg2,
        };
        0x2::event::emit<FeeFactorChanged>(v1);
    }

    public fun set_resolver_fee<T0>(arg0: &mut Protocol, arg1: &ProtocolCap, arg2: u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = load_inner_mut(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&v1.supported_coin_types, v0), 3);
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&v1.resolver_fees, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut v1.resolver_fees, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut v1.resolver_fees, v0, arg2);
        let v2 = ResolverFeeSet{
            coin_type : v0,
            fee       : arg2,
        };
        0x2::event::emit<ResolverFeeSet>(v2);
    }

    public fun set_topic_schema(arg0: &mut Protocol, arg1: &ProtocolCap, arg2: vector<u8>, arg3: 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::Schema) {
        assert!(!0x1::vector::is_empty<u8>(&arg2), 4);
        assert!(0x1::vector::length<u8>(&arg2) <= 256, 5);
        let v0 = load_inner_mut(arg0);
        let v1 = if (0x2::table::contains<vector<u8>, u64>(&v0.last_schema_versions, arg2)) {
            *0x2::table::borrow<vector<u8>, u64>(&v0.last_schema_versions, arg2)
        } else {
            0
        };
        let v2 = v1 + 1;
        if (v2 > 1) {
            let v3 = 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::new_schema_ref(arg2, v1);
            if (0x2::table::contains<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::SchemaRef, SchemaEntry>(&v0.topic_schemas, v3)) {
                0x2::table::borrow_mut<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::SchemaRef, SchemaEntry>(&mut v0.topic_schemas, v3).active = false;
            };
        };
        let v4 = SchemaEntry{
            active : true,
            schema : arg3,
        };
        0x2::table::add<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::SchemaRef, SchemaEntry>(&mut v0.topic_schemas, 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::new_schema_ref(arg2, v2), v4);
        if (0x2::table::contains<vector<u8>, u64>(&v0.last_schema_versions, arg2)) {
            0x2::table::remove<vector<u8>, u64>(&mut v0.last_schema_versions, arg2);
        };
        0x2::table::add<vector<u8>, u64>(&mut v0.last_schema_versions, arg2, v2);
        let v5 = TopicSchemaSet{
            version : v2,
            topic   : arg2,
        };
        0x2::event::emit<TopicSchemaSet>(v5);
    }

    public fun topic_schema(arg0: &mut Protocol, arg1: vector<u8>, arg2: u64) : &0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::Schema {
        let v0 = load_inner(arg0);
        let v1 = 0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::new_schema_ref(arg1, arg2);
        assert!(0x2::table::contains<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::SchemaRef, SchemaEntry>(&v0.topic_schemas, v1), 7);
        &0x2::table::borrow<0xd382c7d5cb16fe6b42ea3d9a1354819028b41c6c87b62a81a0846c5e65bed411::schema::SchemaRef, SchemaEntry>(&v0.topic_schemas, v1).schema
    }

    public fun transfer_cap(arg0: ProtocolCap, arg1: address) {
        0x2::transfer::transfer<ProtocolCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

