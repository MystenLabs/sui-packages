module 0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::device {
    struct Device has key {
        id: 0x2::object::UID,
        tenant_id: 0x2::object::ID,
        device_pubkey: vector<u8>,
        current_policy_id: 0x2::object::ID,
        last_heartbeat_ms: u64,
        hw_fingerprint: vector<u8>,
        status: u8,
    }

    public fun current_policy_id(arg0: &Device) : 0x2::object::ID {
        arg0.current_policy_id
    }

    public fun heartbeat(arg0: &mut Device, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.last_heartbeat_ms = v0;
        0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::events::emit_device_heartbeat(arg0.tenant_id, 0x2::object::id<Device>(arg0), v0);
    }

    public fun last_heartbeat_ms(arg0: &Device) : u64 {
        arg0.last_heartbeat_ms
    }

    public fun provision(arg0: &mut 0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::Tenant, arg1: &0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::OperatorCap, arg2: &0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::policy::Policy, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : Device {
        assert!(0x2::object::id<0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::Tenant>(arg0) == 0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::operator_tenant_id(arg1), 200);
        assert!(0x2::object::id<0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::Tenant>(arg0) == 0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::policy::tenant_id(arg2), 200);
        assert!(!0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::policy::is_deprecated(arg2), 203);
        assert!(!0x1::vector::is_empty<u8>(&arg3), 202);
        0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::reserve_device_slot(arg0);
        let v0 = Device{
            id                : 0x2::object::new(arg5),
            tenant_id         : 0x2::object::id<0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::Tenant>(arg0),
            device_pubkey     : arg3,
            current_policy_id : 0x2::object::id<0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::policy::Policy>(arg2),
            last_heartbeat_ms : 0,
            hw_fingerprint    : arg4,
            status            : 0,
        };
        0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::events::emit_device_provisioned(0x2::object::id<0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::Tenant>(arg0), 0x2::object::id<Device>(&v0), v0.device_pubkey);
        v0
    }

    public fun set_policy(arg0: &0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::OperatorCap, arg1: &mut Device, arg2: &0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::policy::Policy) {
        assert!(arg1.tenant_id == 0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::operator_tenant_id(arg0), 200);
        assert!(arg1.tenant_id == 0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::policy::tenant_id(arg2), 200);
        assert!(!0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::policy::is_deprecated(arg2), 203);
        let v0 = 0x2::object::id<Device>(arg1);
        assert!(0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant::operator_scope_includes(arg0, &v0), 201);
        arg1.current_policy_id = 0x2::object::id<0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::policy::Policy>(arg2);
        if (arg1.status == 0) {
            arg1.status = 1;
        };
    }

    public fun share(arg0: Device) {
        0x2::transfer::share_object<Device>(arg0);
    }

    public fun status(arg0: &Device) : u8 {
        arg0.status
    }

    // decompiled from Move bytecode v7
}

