module 0x4ad118bb24812d2306b435a0c949d48c303dd2b4ca6daf8e6235561820e73962::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct ProtocolConfig has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = ProtocolConfig{
            id      : 0x2::object::new(arg0),
            version : 1,
            admin   : v1,
        };
        0x2::transfer::share_object<ProtocolConfig>(v2);
        0x2::transfer::transfer<AdminCap>(v0, v1);
    }

    public entry fun transer_admin_cap(arg0: &ProtocolConfig, arg1: AdminCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        0x2::transfer::transfer<AdminCap>(arg1, arg2);
        0x4ad118bb24812d2306b435a0c949d48c303dd2b4ca6daf8e6235561820e73962::events::emit_admin_cap_transfer_event(0x2::tx_context::sender(arg3), arg2);
    }

    public entry fun update_supported_version(arg0: &AdminCap, arg1: &mut ProtocolConfig) {
        let v0 = arg1.version + 1;
        arg1.version = v0;
        0x4ad118bb24812d2306b435a0c949d48c303dd2b4ca6daf8e6235561820e73962::events::emit_supported_version_update_event(arg1.version, v0);
    }

    public fun verify_version(arg0: &ProtocolConfig) {
        assert!(arg0.version == 1, 0x4ad118bb24812d2306b435a0c949d48c303dd2b4ca6daf8e6235561820e73962::errors::version_mismatch());
    }

    // decompiled from Move bytecode v6
}

