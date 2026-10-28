module 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::authority {
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

    struct PriceRelayerCap has store, key {
        id: 0x2::object::UID,
    }

    struct PriceConfig has key {
        id: 0x2::object::UID,
        sui_price_scaled: u64,
        updated_at_ms: u64,
        prev_sui_price_scaled: u64,
        version: u64,
    }

    struct SuiPriceUpdated has copy, drop {
        price_scaled: u64,
        updated_at_ms: u64,
    }

    struct PriceRelayerCapIssued has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct LaunchIssuerCap has store, key {
        id: 0x2::object::UID,
    }

    struct LaunchIssuerRegistry has key {
        id: 0x2::object::UID,
        active_cap_id: 0x2::object::ID,
        price_config_id: 0x2::object::ID,
        active_price_relayer_cap_id: 0x2::object::ID,
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

    struct PriceRelayerCapRotated has copy, drop {
        old_cap_id: 0x2::object::ID,
        new_cap_id: 0x2::object::ID,
    }

    struct PriceConfigMigrated has copy, drop {
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

    public fun active_price_relayer_cap_id(arg0: &LaunchIssuerRegistry) : 0x2::object::ID {
        arg0.active_price_relayer_cap_id
    }

    public fun assert_active_admin(arg0: &AdminCap, arg1: &AdminRegistry) {
        assert!(arg1.active_cap_id == 0x2::object::id<AdminCap>(arg0), 13858702391413702675);
    }

    public fun canonical_price_config_id(arg0: &LaunchIssuerRegistry) : 0x2::object::ID {
        arg0.price_config_id
    }

    public(friend) fun consume_launch_ticket<T0>(arg0: LaunchTicket<T0>, arg1: &LaunchIssuerRegistry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.active_cap_id == arg0.issuer_cap_id, 13852792967384924163);
        assert!(0x2::tx_context::sender(arg3) == arg0.recipient, 13853355921633574919);
        assert!(0x2::clock::timestamp_ms(arg2) <= arg0.expires_at_ms, 13853074450951700485);
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
        let v5 = PriceRelayerCap{id: 0x2::object::new(arg0)};
        let v6 = 0x2::object::id<PriceRelayerCap>(&v5);
        let v7 = PriceRelayerCapIssued{cap_id: v6};
        0x2::event::emit<PriceRelayerCapIssued>(v7);
        0x2::transfer::public_transfer<PriceRelayerCap>(v5, v0);
        let v8 = PriceConfig{
            id                    : 0x2::object::new(arg0),
            sui_price_scaled      : 0,
            updated_at_ms         : 0,
            prev_sui_price_scaled : 0,
            version               : 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(),
        };
        0x2::transfer::share_object<PriceConfig>(v8);
        let v9 = LaunchIssuerCap{id: 0x2::object::new(arg0)};
        let v10 = 0x2::object::id<LaunchIssuerCap>(&v9);
        let v11 = LaunchIssuerRegistry{
            id                          : 0x2::object::new(arg0),
            active_cap_id               : v10,
            price_config_id             : 0x2::object::id<PriceConfig>(&v8),
            active_price_relayer_cap_id : v6,
        };
        let v12 = LaunchIssuerCapIssued{
            cap_id      : v10,
            registry_id : 0x2::object::id<LaunchIssuerRegistry>(&v11),
        };
        0x2::event::emit<LaunchIssuerCapIssued>(v12);
        0x2::transfer::public_transfer<LaunchIssuerCap>(v9, v0);
        0x2::transfer::share_object<LaunchIssuerRegistry>(v11);
    }

    public fun issue_launch_ticket<T0>(arg0: &LaunchIssuerCap, arg1: &LaunchIssuerRegistry, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.active_cap_id == 0x2::object::id<LaunchIssuerCap>(arg0), 13852792567952965635);
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

    public fun max_price_scaled() : u64 {
        35000
    }

    public fun migrate_price_config(arg0: &mut PriceConfig) {
        assert!(arg0.version < 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(), 13853637263466430473);
        arg0.version = 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current();
        let v0 = PriceConfigMigrated{
            config_id    : 0x2::object::id<PriceConfig>(arg0),
            from_version : arg0.version,
            to_version   : 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(),
        };
        0x2::event::emit<PriceConfigMigrated>(v0);
    }

    public fun prev_price_scaled(arg0: &PriceConfig) : u64 {
        arg0.prev_sui_price_scaled
    }

    public fun price_config_version(arg0: &PriceConfig) : u64 {
        arg0.version
    }

    public fun price_scaled(arg0: &PriceConfig) : u64 {
        arg0.sui_price_scaled
    }

    public fun price_updated_at_ms(arg0: &PriceConfig) : u64 {
        arg0.updated_at_ms
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

    public fun rotate_price_relayer_cap(arg0: &AdminCap, arg1: &AdminRegistry, arg2: &mut LaunchIssuerRegistry, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_active_admin(arg0, arg1);
        let v0 = PriceRelayerCap{id: 0x2::object::new(arg4)};
        let v1 = 0x2::object::id<PriceRelayerCap>(&v0);
        arg2.active_price_relayer_cap_id = v1;
        let v2 = PriceRelayerCapRotated{
            old_cap_id : arg2.active_price_relayer_cap_id,
            new_cap_id : v1,
        };
        0x2::event::emit<PriceRelayerCapRotated>(v2);
        0x2::transfer::public_transfer<PriceRelayerCap>(v0, arg3);
    }

    public fun set_sui_price(arg0: &PriceRelayerCap, arg1: &LaunchIssuerRegistry, arg2: &mut PriceConfig, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg2.version == 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::version::current(), 13853636700825714697);
        assert!(0x2::object::id<PriceRelayerCap>(arg0) == arg1.active_price_relayer_cap_id, 13856732942749925393);
        assert!(0x2::object::id<PriceConfig>(arg2) == arg1.price_config_id, 13853918214457262091);
        assert!(arg3 >= 100 && arg3 <= 35000, 13847162827900452865);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (arg2.sui_price_scaled != 0) {
            assert!(v0 >= arg2.updated_at_ms + 240000, 13855325653765455885);
            let v1 = arg2.sui_price_scaled;
            let v2 = v1 * 2000 / 0x96a8523e464fdb6c1bb267404621cf47fcd3234d168b724b660995a420b439e3::constants::bps_denominator();
            assert!(arg3 <= v1 + v2 && arg3 + v2 >= v1, 13855607175986937871);
        };
        arg2.prev_sui_price_scaled = arg2.sui_price_scaled;
        arg2.sui_price_scaled = arg3;
        arg2.updated_at_ms = v0;
        let v3 = SuiPriceUpdated{
            price_scaled  : arg3,
            updated_at_ms : arg2.updated_at_ms,
        };
        0x2::event::emit<SuiPriceUpdated>(v3);
    }

    // decompiled from Move bytecode v7
}

