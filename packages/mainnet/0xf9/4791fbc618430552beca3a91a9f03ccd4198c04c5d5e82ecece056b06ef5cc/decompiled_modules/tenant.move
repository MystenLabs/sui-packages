module 0xf94791fbc618430552beca3a91a9f03ccd4198c04c5d5e82ecece056b06ef5cc::tenant {
    struct Tenant has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        licensed_devices: u32,
        active_devices: u32,
        billing_anchor: address,
        revoked_caps: vector<0x2::object::ID>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        tenant_id: 0x2::object::ID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
        tenant_id: 0x2::object::ID,
        scope: vector<0x2::object::ID>,
    }

    public fun assert_active(arg0: &Tenant, arg1: &AdminCap) {
        let v0 = 0x2::object::id<AdminCap>(arg1);
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg0.revoked_caps, &v0), 0);
    }

    public fun create(arg0: 0x1::string::String, arg1: u32, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (Tenant, AdminCap) {
        let v0 = Tenant{
            id               : 0x2::object::new(arg3),
            name             : arg0,
            licensed_devices : arg1,
            active_devices   : 0,
            billing_anchor   : arg2,
            revoked_caps     : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v1 = AdminCap{
            id        : 0x2::object::new(arg3),
            tenant_id : 0x2::object::id<Tenant>(&v0),
        };
        (v0, v1)
    }

    public fun operator_scope_includes(arg0: &OperatorCap, arg1: &0x2::object::ID) : bool {
        0x1::vector::is_empty<0x2::object::ID>(&arg0.scope) || 0x1::vector::contains<0x2::object::ID>(&arg0.scope, arg1)
    }

    public fun operator_tenant_id(arg0: &OperatorCap) : 0x2::object::ID {
        arg0.tenant_id
    }

    public fun reserve_device_slot(arg0: &mut Tenant) {
        assert!(arg0.active_devices < arg0.licensed_devices, 1);
        arg0.active_devices = arg0.active_devices + 1;
    }

    public fun share(arg0: Tenant) {
        0x2::transfer::share_object<Tenant>(arg0);
    }

    public fun tenant_id(arg0: &AdminCap) : 0x2::object::ID {
        arg0.tenant_id
    }

    // decompiled from Move bytecode v7
}

