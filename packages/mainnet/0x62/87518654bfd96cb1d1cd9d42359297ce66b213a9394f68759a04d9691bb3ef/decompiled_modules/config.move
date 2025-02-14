module 0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::config {
    struct ProtocolConfig has store, key {
        id: 0x2::object::UID,
        protocol_fee: u64,
        fee_recipient: address,
        version: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun increase_supported_package_version(arg0: &AdminCap, arg1: &mut ProtocolConfig) {
        assert!(arg1.version < 1, 1002);
        arg1.version = arg1.version + 1;
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::events::emit_supported_version_update_event(arg1.version, arg1.version);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::tx_context::sender(arg0);
        0x2::transfer::transfer<AdminCap>(v0, v1);
        let v2 = ProtocolConfig{
            id            : 0x2::object::new(arg0),
            protocol_fee  : 100,
            fee_recipient : v1,
            version       : 1,
        };
        0x2::transfer::share_object<ProtocolConfig>(v2);
    }

    public fun max_allowed_protocol_fee_percentage() : u64 {
        50000
    }

    public fun protocol_fee(arg0: &ProtocolConfig) : u64 {
        arg0.protocol_fee
    }

    public fun protocol_fee_denominator() : u64 {
        1000000
    }

    public fun protocol_fee_recipient(arg0: &ProtocolConfig) : address {
        arg0.fee_recipient
    }

    public fun set_protocol_fee_recipient(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: address) {
        verify_supported_package(arg1);
        assert!(arg2 != @0x0, 1007);
        arg1.fee_recipient = arg2;
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::events::emit_protocol_fee_recipient_update_event(arg1.fee_recipient, arg2);
    }

    public fun transfer_admin_cap(arg0: AdminCap, arg1: &ProtocolConfig, arg2: address) {
        verify_supported_package(arg1);
        0x2::transfer::transfer<AdminCap>(arg0, arg2);
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::events::emit_admin_cap_transfer_event(arg2);
    }

    public fun update_default_protocol_fee_percentage(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: u64) {
        verify_supported_package(arg1);
        assert!(arg2 <= 50000, 1003);
        arg1.protocol_fee = arg2;
        0x6287518654bfd96cb1d1cd9d42359297ce66b213a9394f68759a04d9691bb3ef::events::emit_default_protocol_fee_percentage_update_event(arg1.protocol_fee, arg2);
    }

    public fun verify_supported_package(arg0: &ProtocolConfig) {
        assert!(arg0.version == 1, 1001);
    }

    public fun version(arg0: &ProtocolConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

