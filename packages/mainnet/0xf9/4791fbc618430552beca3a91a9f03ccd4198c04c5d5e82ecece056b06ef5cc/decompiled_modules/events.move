module 0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::events {
    struct TenantCreated has copy, drop {
        tenant_id: 0x2::object::ID,
        name: vector<u8>,
    }

    struct PolicyRotated has copy, drop {
        tenant_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
        walrus_blob_id: vector<u8>,
    }

    struct DeviceProvisioned has copy, drop {
        tenant_id: 0x2::object::ID,
        device_id: 0x2::object::ID,
        pubkey: vector<u8>,
    }

    struct DeviceHeartbeat has copy, drop {
        tenant_id: 0x2::object::ID,
        device_id: 0x2::object::ID,
        ts_ms: u64,
    }

    struct PolicyDeprecated has copy, drop {
        tenant_id: 0x2::object::ID,
        policy_id: 0x2::object::ID,
        version: u64,
    }

    public(friend) fun emit_device_heartbeat(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = DeviceHeartbeat{
            tenant_id : arg0,
            device_id : arg1,
            ts_ms     : arg2,
        };
        0x2::event::emit<DeviceHeartbeat>(v0);
    }

    public(friend) fun emit_device_provisioned(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<u8>) {
        let v0 = DeviceProvisioned{
            tenant_id : arg0,
            device_id : arg1,
            pubkey    : arg2,
        };
        0x2::event::emit<DeviceProvisioned>(v0);
    }

    public(friend) fun emit_policy_deprecated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = PolicyDeprecated{
            tenant_id : arg0,
            policy_id : arg1,
            version   : arg2,
        };
        0x2::event::emit<PolicyDeprecated>(v0);
    }

    public(friend) fun emit_policy_rotated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: vector<u8>) {
        let v0 = PolicyRotated{
            tenant_id      : arg0,
            policy_id      : arg1,
            old_version    : arg2,
            new_version    : arg3,
            walrus_blob_id : arg4,
        };
        0x2::event::emit<PolicyRotated>(v0);
    }

    public(friend) fun emit_tenant_created(arg0: 0x2::object::ID, arg1: vector<u8>) {
        let v0 = TenantCreated{
            tenant_id : arg0,
            name      : arg1,
        };
        0x2::event::emit<TenantCreated>(v0);
    }

    // decompiled from Move bytecode v7
}

