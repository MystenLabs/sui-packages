module 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::authority {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminRegistry has key {
        id: 0x2::object::UID,
        active_cap_id: 0x2::object::ID,
    }

    struct AdminCapIssued has copy, drop {
        cap_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
    }

    struct AdminCapRotated has copy, drop {
        old_cap_id: 0x2::object::ID,
        new_cap_id: 0x2::object::ID,
    }

    struct LaunchIssuerCap has store, key {
        id: 0x2::object::UID,
    }

    struct LaunchIssuerRegistry has key {
        id: 0x2::object::UID,
        active_cap_id: 0x2::object::ID,
        protocol_config_id: 0x2::object::ID,
    }

    struct LaunchTicket<phantom T0> has key {
        id: 0x2::object::UID,
        issuer_cap_id: 0x2::object::ID,
        recipient: address,
        expires_at_ms: u64,
    }

    struct LaunchTicketIssued has copy, drop {
        ticket_id: 0x2::object::ID,
        recipient: address,
        expires_at_ms: u64,
    }

    struct LaunchIssuerCapIssued has copy, drop {
        cap_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
    }

    struct LaunchIssuerCapRotated has copy, drop {
        old_cap_id: 0x2::object::ID,
        new_cap_id: 0x2::object::ID,
    }

    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        protocol_lp_recipient: address,
        version: u64,
    }

    struct ProtocolConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
        protocol_lp_recipient: address,
    }

    struct ProtocolLpRecipientSet has copy, drop {
        old: address,
        new: address,
    }

    struct ProtocolConfigMigrated has copy, drop {
        config_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    public fun active_admin_cap_id(arg0: &AdminRegistry) : 0x2::object::ID {
        arg0.active_cap_id
    }

    public fun active_launch_issuer_cap_id(arg0: &LaunchIssuerRegistry) : 0x2::object::ID {
        arg0.active_cap_id
    }

    public fun assert_active_admin(arg0: &AdminCap, arg1: &AdminRegistry) {
        assert!(arg1.active_cap_id == 0x2::object::id<AdminCap>(arg0), 13858702159484813321);
    }

    public fun canonical_protocol_config_id(arg0: &LaunchIssuerRegistry) : 0x2::object::ID {
        arg0.protocol_config_id
    }

    public(friend) fun consume_launch_ticket<T0>(arg0: LaunchTicket<T0>, arg1: &LaunchIssuerRegistry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.active_cap_id == arg0.issuer_cap_id, 13852791837808394241);
        assert!(0x2::tx_context::sender(arg3) == arg0.recipient, 13853354792057044997);
        assert!(0x2::clock::timestamp_ms(arg2) <= arg0.expires_at_ms, 13853073321375170563);
        let LaunchTicket {
            id            : v0,
            issuer_cap_id : _,
            recipient     : _,
            expires_at_ms : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = 0x2::object::id<AdminCap>(&v1);
        let v3 = AdminRegistry{
            id            : 0x2::object::new(arg0),
            active_cap_id : v2,
        };
        let v4 = AdminCapIssued{
            cap_id      : v2,
            registry_id : 0x2::object::id<AdminRegistry>(&v3),
        };
        0x2::event::emit<AdminCapIssued>(v4);
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        0x2::transfer::share_object<AdminRegistry>(v3);
        let v5 = ProtocolConfig{
            id                    : 0x2::object::new(arg0),
            protocol_lp_recipient : v0,
            version               : 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(),
        };
        let v6 = 0x2::object::id<ProtocolConfig>(&v5);
        let v7 = ProtocolConfigCreated{
            config_id             : v6,
            protocol_lp_recipient : v0,
        };
        0x2::event::emit<ProtocolConfigCreated>(v7);
        0x2::transfer::share_object<ProtocolConfig>(v5);
        let v8 = LaunchIssuerCap{id: 0x2::object::new(arg0)};
        let v9 = 0x2::object::id<LaunchIssuerCap>(&v8);
        let v10 = LaunchIssuerRegistry{
            id                 : 0x2::object::new(arg0),
            active_cap_id      : v9,
            protocol_config_id : v6,
        };
        let v11 = LaunchIssuerCapIssued{
            cap_id      : v9,
            registry_id : 0x2::object::id<LaunchIssuerRegistry>(&v10),
        };
        0x2::event::emit<LaunchIssuerCapIssued>(v11);
        0x2::transfer::public_transfer<LaunchIssuerCap>(v8, v0);
        0x2::transfer::share_object<LaunchIssuerRegistry>(v10);
    }

    public fun issue_launch_ticket<T0>(arg0: &LaunchIssuerCap, arg1: &LaunchIssuerRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.active_cap_id == 0x2::object::id<LaunchIssuerCap>(arg0), 13852791657419767809);
        let v0 = 0x2::clock::timestamp_ms(arg3) + 3600000;
        let v1 = LaunchTicket<T0>{
            id            : 0x2::object::new(arg4),
            issuer_cap_id : 0x2::object::id<LaunchIssuerCap>(arg0),
            recipient     : arg2,
            expires_at_ms : v0,
        };
        let v2 = LaunchTicketIssued{
            ticket_id     : 0x2::object::id<LaunchTicket<T0>>(&v1),
            recipient     : arg2,
            expires_at_ms : v0,
        };
        0x2::event::emit<LaunchTicketIssued>(v2);
        0x2::transfer::transfer<LaunchTicket<T0>>(v1, arg2);
    }

    public fun migrate_protocol_config(arg0: &mut ProtocolConfig) {
        assert!(arg0.version < 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(), 13853636374408069127);
        arg0.version = 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current();
        let v0 = ProtocolConfigMigrated{
            config_id    : 0x2::object::id<ProtocolConfig>(arg0),
            from_version : arg0.version,
            to_version   : 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(),
        };
        0x2::event::emit<ProtocolConfigMigrated>(v0);
    }

    public fun protocol_config_version(arg0: &ProtocolConfig) : u64 {
        arg0.version
    }

    public fun protocol_lp_recipient(arg0: &ProtocolConfig) : address {
        arg0.protocol_lp_recipient
    }

    public fun rotate_admin_cap(arg0: &AdminCap, arg1: &mut AdminRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_active_admin(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<AdminCap>(&v0);
        arg1.active_cap_id = v1;
        let v2 = AdminCapRotated{
            old_cap_id : arg1.active_cap_id,
            new_cap_id : v1,
        };
        0x2::event::emit<AdminCapRotated>(v2);
        0x2::transfer::public_transfer<AdminCap>(v0, arg2);
    }

    public fun rotate_launch_issuer_cap(arg0: &AdminCap, arg1: &AdminRegistry, arg2: &mut LaunchIssuerRegistry, arg3: &mut 0x2::tx_context::TxContext) : LaunchIssuerCap {
        assert_active_admin(arg0, arg1);
        let v0 = LaunchIssuerCap{id: 0x2::object::new(arg3)};
        let v1 = 0x2::object::id<LaunchIssuerCap>(&v0);
        arg2.active_cap_id = v1;
        let v2 = LaunchIssuerCapRotated{
            old_cap_id : arg2.active_cap_id,
            new_cap_id : v1,
        };
        0x2::event::emit<LaunchIssuerCapRotated>(v2);
        v0
    }

    public fun set_protocol_lp_recipient(arg0: &AdminCap, arg1: &AdminRegistry, arg2: &mut ProtocolConfig, arg3: address) {
        assert_active_admin(arg0, arg1);
        assert!(arg2.version == 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(), 13853636331458396167);
        assert!(arg3 != @0x0, 13873058109146660875);
        arg2.protocol_lp_recipient = arg3;
        let v0 = ProtocolLpRecipientSet{
            old : arg2.protocol_lp_recipient,
            new : arg3,
        };
        0x2::event::emit<ProtocolLpRecipientSet>(v0);
    }

    // decompiled from Move bytecode v7
}

