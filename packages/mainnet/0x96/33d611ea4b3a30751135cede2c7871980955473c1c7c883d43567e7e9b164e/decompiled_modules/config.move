module 0xf8870f988ab09be7c5820a856bd5e9da84fc7192e095a7a8829919293b00a36c::config {
    struct ProtocolConfig has store, key {
        id: 0x2::object::UID,
        protocol_fee: u64,
        fee_recipient: address,
        version: u64,
        allowed_sponsors: vector<address>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun increase_supported_package_version(arg0: &AdminCap, arg1: &mut ProtocolConfig) {
        assert!(arg1.version < 1, 0xf8870f988ab09be7c5820a856bd5e9da84fc7192e095a7a8829919293b00a36c::errors::package_already_supported());
        arg1.version = arg1.version + 1;
        0xf8870f988ab09be7c5820a856bd5e9da84fc7192e095a7a8829919293b00a36c::events::emit_supported_version_update_event(arg1.version, arg1.version);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::tx_context::sender(arg0);
        0x2::transfer::transfer<AdminCap>(v0, v1);
        let v2 = ProtocolConfig{
            id               : 0x2::object::new(arg0),
            protocol_fee     : 100,
            fee_recipient    : v1,
            version          : 1,
            allowed_sponsors : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<ProtocolConfig>(v2);
    }

    public fun is_sponsor(arg0: &ProtocolConfig, arg1: address) : bool {
        let (v0, _) = 0x1::vector::index_of<address>(&arg0.allowed_sponsors, &arg1);
        v0
    }

    public fun max_allowed_partner_fee_percentage() : u64 {
        50000
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
        assert!(arg2 != @0x0, 0xf8870f988ab09be7c5820a856bd5e9da84fc7192e095a7a8829919293b00a36c::errors::zero_address());
        arg1.fee_recipient = arg2;
        0xf8870f988ab09be7c5820a856bd5e9da84fc7192e095a7a8829919293b00a36c::events::emit_protocol_fee_recipient_update_event(arg1.fee_recipient, arg2);
    }

    public fun transfer_admin_cap(arg0: AdminCap, arg1: &ProtocolConfig, arg2: address) {
        verify_supported_package(arg1);
        0x2::transfer::transfer<AdminCap>(arg0, arg2);
        0xf8870f988ab09be7c5820a856bd5e9da84fc7192e095a7a8829919293b00a36c::events::emit_admin_cap_transfer_event(arg2);
    }

    public fun update_default_protocol_fee_percentage(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: u64) {
        verify_supported_package(arg1);
        assert!(arg2 <= 50000, 0xf8870f988ab09be7c5820a856bd5e9da84fc7192e095a7a8829919293b00a36c::errors::invalid_protocol_fee_percentage());
        arg1.protocol_fee = arg2;
        0xf8870f988ab09be7c5820a856bd5e9da84fc7192e095a7a8829919293b00a36c::events::emit_default_protocol_fee_percentage_update_event(arg1.protocol_fee, arg2);
    }

    public fun update_protocol_sponsor(arg0: &AdminCap, arg1: &mut ProtocolConfig, arg2: address, arg3: bool) {
        verify_supported_package(arg1);
        if (arg3) {
            let (v0, _) = 0x1::vector::index_of<address>(&arg1.allowed_sponsors, &arg2);
            assert!(!v0, 0xf8870f988ab09be7c5820a856bd5e9da84fc7192e095a7a8829919293b00a36c::errors::sponsor_already_authorized());
            0x1::vector::push_back<address>(&mut arg1.allowed_sponsors, arg2);
            0xf8870f988ab09be7c5820a856bd5e9da84fc7192e095a7a8829919293b00a36c::events::emit_sponsor_updated_event(arg2, true);
        } else {
            let (v2, v3) = 0x1::vector::index_of<address>(&arg1.allowed_sponsors, &arg2);
            assert!(v2, 0xf8870f988ab09be7c5820a856bd5e9da84fc7192e095a7a8829919293b00a36c::errors::sponsor_not_authorized());
            0x1::vector::remove<address>(&mut arg1.allowed_sponsors, v3);
            0xf8870f988ab09be7c5820a856bd5e9da84fc7192e095a7a8829919293b00a36c::events::emit_sponsor_updated_event(arg2, false);
        };
    }

    public fun verify_sponsor(arg0: &ProtocolConfig, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sponsor(arg1);
        assert!(!0x1::option::is_none<address>(&v0), 0xf8870f988ab09be7c5820a856bd5e9da84fc7192e095a7a8829919293b00a36c::errors::no_sponsor());
        let v1 = 0x1::option::extract<address>(&mut v0);
        let (v2, _) = 0x1::vector::index_of<address>(&arg0.allowed_sponsors, &v1);
        assert!(v2, 0xf8870f988ab09be7c5820a856bd5e9da84fc7192e095a7a8829919293b00a36c::errors::invalid_sponsor());
    }

    public fun verify_supported_package(arg0: &ProtocolConfig) {
        assert!(arg0.version == 1, 0xf8870f988ab09be7c5820a856bd5e9da84fc7192e095a7a8829919293b00a36c::errors::unsupported_package());
    }

    public fun version(arg0: &ProtocolConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

