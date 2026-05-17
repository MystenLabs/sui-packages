module 0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::policy {
    struct Policy has key {
        id: 0x2::object::UID,
        tenant_id: 0x2::object::ID,
        version: u64,
        walrus_blob_id: vector<u8>,
        refhe_key_ref: 0x1::option::Option<vector<u8>>,
        created_at_ms: u64,
        deprecated: bool,
    }

    public fun created_at_ms(arg0: &Policy) : u64 {
        arg0.created_at_ms
    }

    public fun deprecate(arg0: &0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::Tenant, arg1: &0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::AdminCap, arg2: &mut Policy) {
        0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::assert_active(arg0, arg1);
        assert!(0x2::object::id<0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::Tenant>(arg0) == 0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::tenant_id(arg1), 101);
        assert!(arg2.tenant_id == 0x2::object::id<0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::Tenant>(arg0), 101);
        assert!(!arg2.deprecated, 102);
        arg2.deprecated = true;
        0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::events::emit_policy_deprecated(arg2.tenant_id, 0x2::object::id<Policy>(arg2), arg2.version);
    }

    public fun is_deprecated(arg0: &Policy) : bool {
        arg0.deprecated
    }

    public fun mint(arg0: &0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::Tenant, arg1: &0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::AdminCap, arg2: vector<u8>, arg3: 0x1::option::Option<vector<u8>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Policy {
        0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::assert_active(arg0, arg1);
        assert!(0x2::object::id<0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::Tenant>(arg0) == 0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::tenant_id(arg1), 101);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 103);
        let v0 = Policy{
            id             : 0x2::object::new(arg6),
            tenant_id      : 0x2::object::id<0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::Tenant>(arg0),
            version        : arg4,
            walrus_blob_id : arg2,
            refhe_key_ref  : arg3,
            created_at_ms  : 0x2::clock::timestamp_ms(arg5),
            deprecated     : false,
        };
        0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::events::emit_policy_rotated(0x2::object::id<0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::Tenant>(arg0), 0x2::object::id<Policy>(&v0), 0, arg4, v0.walrus_blob_id);
        v0
    }

    public fun refhe_key_ref(arg0: &Policy) : &0x1::option::Option<vector<u8>> {
        &arg0.refhe_key_ref
    }

    public fun rotate(arg0: &0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::Tenant, arg1: &0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::AdminCap, arg2: &mut Policy, arg3: vector<u8>, arg4: u64, arg5: 0x1::option::Option<vector<u8>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Policy {
        0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::assert_active(arg0, arg1);
        assert!(0x2::object::id<0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::Tenant>(arg0) == 0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::tenant_id(arg1), 101);
        assert!(!arg2.deprecated, 102);
        assert!(arg4 > arg2.version, 100);
        assert!(!0x1::vector::is_empty<u8>(&arg3), 103);
        arg2.deprecated = true;
        let v0 = Policy{
            id             : 0x2::object::new(arg7),
            tenant_id      : arg2.tenant_id,
            version        : arg4,
            walrus_blob_id : arg3,
            refhe_key_ref  : arg5,
            created_at_ms  : 0x2::clock::timestamp_ms(arg6),
            deprecated     : false,
        };
        0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::events::emit_policy_rotated(arg2.tenant_id, 0x2::object::id<Policy>(&v0), arg2.version, arg4, v0.walrus_blob_id);
        0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::events::emit_policy_deprecated(arg2.tenant_id, 0x2::object::id<Policy>(arg2), arg2.version);
        v0
    }

    public fun share(arg0: Policy) {
        0x2::transfer::share_object<Policy>(arg0);
    }

    public fun tenant_id(arg0: &Policy) : 0x2::object::ID {
        arg0.tenant_id
    }

    public fun version(arg0: &Policy) : u64 {
        arg0.version
    }

    public fun walrus_blob_id(arg0: &Policy) : vector<u8> {
        arg0.walrus_blob_id
    }

    // decompiled from Move bytecode v7
}

