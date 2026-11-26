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

    struct LaunchIssuerV2CapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LaunchPathV2Opened has copy, drop {
        registry_id: 0x2::object::ID,
        v2_cap_id: 0x2::object::ID,
    }

    struct LaunchPathV1Closed has copy, drop {
        registry_id: 0x2::object::ID,
        was: 0x2::object::ID,
    }

    struct QuotePriceRelayerCap has store, key {
        id: 0x2::object::UID,
    }

    struct QuotePrice has copy, drop, store {
        sui_price_scaled: u64,
        quote_price_e9: u64,
        updated_at_ms: u64,
        prev_sui_price_scaled: u64,
        prev_quote_price_e9: u64,
    }

    struct QuotePriceConfig has key {
        id: 0x2::object::UID,
        prices: 0x2::vec_map::VecMap<0x1::type_name::TypeName, QuotePrice>,
        active_relayer_cap_id: 0x2::object::ID,
        version: u64,
    }

    struct QuotePriceConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct QuotePriceConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
        relayer_cap_id: 0x2::object::ID,
        relayer: address,
    }

    struct QuotePriceUpdated has copy, drop {
        quote: 0x1::type_name::TypeName,
        sui_price_scaled: u64,
        quote_price_e9: u64,
        updated_at_ms: u64,
    }

    struct QuotePriceRelayerCapRotated has copy, drop {
        old_cap_id: 0x2::object::ID,
        new_cap_id: 0x2::object::ID,
    }

    struct QuotePriceConfigMigrated has copy, drop {
        config_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    public fun active_admin_cap_id(arg0: &AdminRegistry) : 0x2::object::ID {
        arg0.active_cap_id
    }

    public fun active_launch_issuer_cap_id(arg0: &LaunchIssuerRegistry) : 0x2::object::ID {
        let v0 = LaunchIssuerV2CapKey{dummy_field: false};
        if (0x2::dynamic_field::exists<LaunchIssuerV2CapKey>(&arg0.id, v0)) {
            let v2 = LaunchIssuerV2CapKey{dummy_field: false};
            *0x2::dynamic_field::borrow<LaunchIssuerV2CapKey, 0x2::object::ID>(&arg0.id, v2)
        } else {
            arg0.active_cap_id
        }
    }

    public fun active_quote_price_relayer_cap_id(arg0: &QuotePriceConfig) : 0x2::object::ID {
        arg0.active_relayer_cap_id
    }

    public fun assert_active_admin(arg0: &AdminCap, arg1: &AdminRegistry) {
        assert!(arg1.active_cap_id == 0x2::object::id<AdminCap>(arg0), 13858702249679126537);
    }

    public fun canonical_protocol_config_id(arg0: &LaunchIssuerRegistry) : 0x2::object::ID {
        arg0.protocol_config_id
    }

    public fun close_v1_launch_path(arg0: &mut LaunchIssuerRegistry) {
        let v0 = LaunchIssuerV2CapKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<LaunchIssuerV2CapKey>(&arg0.id, v0), 13884317554892603417);
        let v1 = 0x2::object::id<LaunchIssuerRegistry>(arg0);
        if (arg0.active_cap_id != v1) {
            arg0.active_cap_id = v1;
            let v2 = LaunchPathV1Closed{
                registry_id : v1,
                was         : arg0.active_cap_id,
            };
            0x2::event::emit<LaunchPathV1Closed>(v2);
        };
    }

    public(friend) fun consume_launch_ticket<T0>(arg0: LaunchTicket<T0>, arg1: &LaunchIssuerRegistry, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = LaunchIssuerV2CapKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<LaunchIssuerV2CapKey>(&arg1.id, v0), 13884317207000252441);
        let v1 = LaunchIssuerV2CapKey{dummy_field: false};
        assert!(*0x2::dynamic_field::borrow<LaunchIssuerV2CapKey, 0x2::object::ID>(&arg1.id, v1) == arg0.issuer_cap_id, 13852792022491987969);
        assert!(0x2::tx_context::sender(arg3) == arg0.recipient, 13853354981035606021);
        assert!(0x2::clock::timestamp_ms(arg2) <= arg0.expires_at_ms, 13853073510353731587);
        let LaunchTicket {
            id            : v2,
            issuer_cap_id : _,
            recipient     : _,
            expires_at_ms : _,
        } = arg0;
        0x2::object::delete(v2);
    }

    public fun create_quote_price_config(arg0: &AdminCap, arg1: &AdminRegistry, arg2: &mut LaunchIssuerRegistry, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_active_admin(arg0, arg1);
        let v0 = QuotePriceConfigKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<QuotePriceConfigKey>(&arg2.id, v0), 13883755047320551445);
        let v1 = QuotePriceRelayerCap{id: 0x2::object::new(arg4)};
        let v2 = 0x2::object::id<QuotePriceRelayerCap>(&v1);
        let v3 = QuotePriceConfig{
            id                    : 0x2::object::new(arg4),
            prices                : 0x2::vec_map::empty<0x1::type_name::TypeName, QuotePrice>(),
            active_relayer_cap_id : v2,
            version               : 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(),
        };
        let v4 = 0x2::object::id<QuotePriceConfig>(&v3);
        let v5 = QuotePriceConfigKey{dummy_field: false};
        0x2::dynamic_field::add<QuotePriceConfigKey, 0x2::object::ID>(&mut arg2.id, v5, v4);
        let v6 = QuotePriceConfigCreated{
            config_id      : v4,
            relayer_cap_id : v2,
            relayer        : arg3,
        };
        0x2::event::emit<QuotePriceConfigCreated>(v6);
        0x2::transfer::share_object<QuotePriceConfig>(v3);
        0x2::transfer::public_transfer<QuotePriceRelayerCap>(v1, arg3);
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
        let v0 = LaunchIssuerV2CapKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<LaunchIssuerV2CapKey>(&arg1.id, v0), 13884316953597181977);
        let v1 = LaunchIssuerV2CapKey{dummy_field: false};
        assert!(*0x2::dynamic_field::borrow<LaunchIssuerV2CapKey, 0x2::object::ID>(&arg1.id, v1) == 0x2::object::id<LaunchIssuerCap>(arg0), 13852791760498982913);
        let v2 = 0x2::clock::timestamp_ms(arg3) + 3600000;
        let v3 = LaunchTicket<T0>{
            id            : 0x2::object::new(arg4),
            issuer_cap_id : 0x2::object::id<LaunchIssuerCap>(arg0),
            recipient     : arg2,
            expires_at_ms : v2,
        };
        let v4 = LaunchTicketIssued{
            ticket_id     : 0x2::object::id<LaunchTicket<T0>>(&v3),
            recipient     : arg2,
            expires_at_ms : v2,
        };
        0x2::event::emit<LaunchTicketIssued>(v4);
        0x2::transfer::transfer<LaunchTicket<T0>>(v3, arg2);
    }

    public fun launch_path_v2_open(arg0: &LaunchIssuerRegistry) : bool {
        let v0 = LaunchIssuerV2CapKey{dummy_field: false};
        0x2::dynamic_field::exists<LaunchIssuerV2CapKey>(&arg0.id, v0)
    }

    public fun migrate_protocol_config(arg0: &mut ProtocolConfig) {
        assert!(arg0.version < 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(), 13853636563386630151);
        arg0.version = 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current();
        let v0 = ProtocolConfigMigrated{
            config_id    : 0x2::object::id<ProtocolConfig>(arg0),
            from_version : arg0.version,
            to_version   : 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(),
        };
        0x2::event::emit<ProtocolConfigMigrated>(v0);
    }

    public fun migrate_quote_price_config(arg0: &mut QuotePriceConfig) {
        assert!(arg0.version < 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(), 13853637710142898183);
        arg0.version = 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current();
        let v0 = QuotePriceConfigMigrated{
            config_id    : 0x2::object::id<QuotePriceConfig>(arg0),
            from_version : arg0.version,
            to_version   : 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(),
        };
        0x2::event::emit<QuotePriceConfigMigrated>(v0);
    }

    public fun open_v2_launch_path(arg0: &AdminCap, arg1: &AdminRegistry, arg2: &mut LaunchIssuerRegistry) {
        assert_active_admin(arg0, arg1);
        let v0 = LaunchIssuerV2CapKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists<LaunchIssuerV2CapKey>(&arg2.id, v0), 13884598974034870299);
        let v1 = arg2.active_cap_id;
        let v2 = 0x2::object::id<LaunchIssuerRegistry>(arg2);
        let v3 = LaunchIssuerV2CapKey{dummy_field: false};
        0x2::dynamic_field::add<LaunchIssuerV2CapKey, 0x2::object::ID>(&mut arg2.id, v3, v1);
        arg2.active_cap_id = v2;
        let v4 = LaunchPathV2Opened{
            registry_id : v2,
            v2_cap_id   : v1,
        };
        0x2::event::emit<LaunchPathV2Opened>(v4);
    }

    fun price_band_of_name(arg0: &vector<u8>) : (bool, u64, u64) {
        if (*arg0 == b"aaffd090b57fcdcf293f7e7ec59c119acc910eeb5fc4aadfb4185fa56b6a2cb5::suipump::SUIPUMP") {
            (true, 10000, 100000000)
        } else if (*arg0 == b"d30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc::BTC") {
            (true, 10000000000000, 500000000000000)
        } else {
            (false, 0, 0)
        }
    }

    public fun protocol_config_version(arg0: &ProtocolConfig) : u64 {
        arg0.version
    }

    public fun protocol_lp_recipient(arg0: &ProtocolConfig) : address {
        arg0.protocol_lp_recipient
    }

    public fun quote_price<T0>(arg0: &QuotePriceConfig) : (bool, u64, u64, u64, u64, u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, QuotePrice>(&arg0.prices, &v0)) {
            return (false, 0, 0, 0, 0, 0)
        };
        let v1 = 0x2::vec_map::get<0x1::type_name::TypeName, QuotePrice>(&arg0.prices, &v0);
        (true, v1.sui_price_scaled, v1.quote_price_e9, v1.updated_at_ms, v1.prev_sui_price_scaled, v1.prev_quote_price_e9)
    }

    public fun quote_price_band<T0>() : (bool, u64, u64) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        price_band_of_name(0x1::ascii::as_bytes(0x1::type_name::as_string(&v0)))
    }

    public fun quote_price_config_id(arg0: &LaunchIssuerRegistry) : 0x1::option::Option<0x2::object::ID> {
        let v0 = QuotePriceConfigKey{dummy_field: false};
        if (0x2::dynamic_field::exists<QuotePriceConfigKey>(&arg0.id, v0)) {
            let v2 = QuotePriceConfigKey{dummy_field: false};
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<QuotePriceConfigKey, 0x2::object::ID>(&arg0.id, v2))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun quote_price_config_version(arg0: &QuotePriceConfig) : u64 {
        arg0.version
    }

    public fun quote_price_update_rules() : (u64, u64) {
        (240000, 2000)
    }

    public fun quote_sui_price_band() : (u64, u64) {
        (100, 35000)
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
        let v2 = LaunchIssuerV2CapKey{dummy_field: false};
        let v3 = if (0x2::dynamic_field::exists<LaunchIssuerV2CapKey>(&arg2.id, v2)) {
            let v4 = LaunchIssuerV2CapKey{dummy_field: false};
            let v5 = 0x2::dynamic_field::borrow_mut<LaunchIssuerV2CapKey, 0x2::object::ID>(&mut arg2.id, v4);
            *v5 = v1;
            *v5
        } else {
            arg2.active_cap_id = v1;
            arg2.active_cap_id
        };
        let v6 = LaunchIssuerCapRotated{
            old_cap_id : v3,
            new_cap_id : v1,
        };
        0x2::event::emit<LaunchIssuerCapRotated>(v6);
        v0
    }

    public fun rotate_quote_price_relayer_cap(arg0: &AdminCap, arg1: &AdminRegistry, arg2: &mut QuotePriceConfig, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_active_admin(arg0, arg1);
        assert!(arg2.version == 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(), 13853637658603290631);
        let v0 = QuotePriceRelayerCap{id: 0x2::object::new(arg4)};
        let v1 = 0x2::object::id<QuotePriceRelayerCap>(&v0);
        arg2.active_relayer_cap_id = v1;
        let v2 = QuotePriceRelayerCapRotated{
            old_cap_id : arg2.active_relayer_cap_id,
            new_cap_id : v1,
        };
        0x2::event::emit<QuotePriceRelayerCapRotated>(v2);
        0x2::transfer::public_transfer<QuotePriceRelayerCap>(v0, arg3);
    }

    public fun set_protocol_lp_recipient(arg0: &AdminCap, arg1: &AdminRegistry, arg2: &mut ProtocolConfig, arg3: address) {
        assert_active_admin(arg0, arg1);
        assert!(arg2.version == 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(), 13853636520436957191);
        assert!(arg3 != @0x0, 13873058298125221899);
        arg2.protocol_lp_recipient = arg3;
        let v0 = ProtocolLpRecipientSet{
            old : arg2.protocol_lp_recipient,
            new : arg3,
        };
        0x2::event::emit<ProtocolLpRecipientSet>(v0);
    }

    public fun set_quote_price<T0>(arg0: &QuotePriceRelayerCap, arg1: &mut QuotePriceConfig, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(arg1.version == 0x12cef1403b5eaf1d03b8c34e8902dc0abe4b5496ed7727e0f05b3e244e056fc3::version::current(), 13853637448149893127);
        assert!(0x2::object::id<QuotePriceRelayerCap>(arg0) == arg1.active_relayer_cap_id, 13856733677189464083);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let (v1, v2, v3) = price_band_of_name(0x1::ascii::as_bytes(0x1::type_name::as_string(&v0)));
        assert!(v1, 13884036762815561751);
        assert!(arg2 >= 100 && arg2 <= 35000, 13847163545160777741);
        assert!(arg3 >= v2 && arg3 <= v3, 13847163549455745037);
        let v4 = 0x2::clock::timestamp_ms(arg4);
        let v5 = 0x2::vec_map::contains<0x1::type_name::TypeName, QuotePrice>(&arg1.prices, &v0);
        if (v5) {
            let v6 = 0x2::vec_map::get<0x1::type_name::TypeName, QuotePrice>(&arg1.prices, &v0);
            assert!(v4 >= v6.updated_at_ms + 240000, 13855326345255321615);
            assert!(within_step(arg2, v6.sui_price_scaled), 13855607824527130641);
            assert!(within_step(arg3, v6.quote_price_e9), 13855607828822097937);
        };
        if (v5) {
            let v7 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, QuotePrice>(&mut arg1.prices, &v0);
            v7.prev_sui_price_scaled = v7.sui_price_scaled;
            v7.prev_quote_price_e9 = v7.quote_price_e9;
            v7.sui_price_scaled = arg2;
            v7.quote_price_e9 = arg3;
            v7.updated_at_ms = v4;
        } else {
            let v8 = QuotePrice{
                sui_price_scaled      : arg2,
                quote_price_e9        : arg3,
                updated_at_ms         : v4,
                prev_sui_price_scaled : 0,
                prev_quote_price_e9   : 0,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, QuotePrice>(&mut arg1.prices, v0, v8);
        };
        let v9 = QuotePriceUpdated{
            quote            : v0,
            sui_price_scaled : arg2,
            quote_price_e9   : arg3,
            updated_at_ms    : v4,
        };
        0x2::event::emit<QuotePriceUpdated>(v9);
    }

    public fun v1_launch_path_closed(arg0: &LaunchIssuerRegistry) : bool {
        arg0.active_cap_id == 0x2::object::id<LaunchIssuerRegistry>(arg0)
    }

    fun within_step(arg0: u64, arg1: u64) : bool {
        let v0 = (arg1 as u128) * (2000 as u128) / 10000;
        (arg0 as u128) <= (arg1 as u128) + v0 && (arg0 as u128) + v0 >= (arg1 as u128)
    }

    // decompiled from Move bytecode v7
}

