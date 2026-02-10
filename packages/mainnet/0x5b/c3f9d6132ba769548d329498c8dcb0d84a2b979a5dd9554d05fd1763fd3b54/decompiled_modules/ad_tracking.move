module 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::ad_tracking {
    struct ClickToken has store, key {
        id: 0x2::object::UID,
        ad_id: 0x2::object::ID,
        content_id: vector<u8>,
        token_hash: vector<u8>,
        created_at: u64,
        expires_at: u64,
        is_used: bool,
    }

    struct Conversion has drop, store {
        click_token_hash: vector<u8>,
        conversion_token_hash: vector<u8>,
        ad_id: 0x2::object::ID,
        content_id: vector<u8>,
        verified: bool,
        timestamp: u64,
    }

    struct ClickTokenRegistry has key {
        id: 0x2::object::UID,
        tokens: 0x2::table::Table<vector<u8>, bool>,
        conversions: 0x2::table::Table<vector<u8>, Conversion>,
        total_clicks: u64,
        total_conversions: u64,
        paused: bool,
        last_creation_ts: 0x2::table::Table<address, u64>,
    }

    struct ClickTokenCreated has copy, drop {
        token_id: 0x2::object::ID,
        ad_id: 0x2::object::ID,
        token_hash: vector<u8>,
        expires_at: u64,
    }

    struct TokenVerified has copy, drop {
        token_hash: vector<u8>,
        ad_id: 0x2::object::ID,
        valid: bool,
    }

    struct ConversionRecorded has copy, drop {
        click_token_hash: vector<u8>,
        conversion_token_hash: vector<u8>,
        ad_id: 0x2::object::ID,
    }

    struct ConversionVerified has copy, drop {
        click_token_hash: vector<u8>,
        ad_id: 0x2::object::ID,
        verified: bool,
    }

    struct TrackingPaused has copy, drop {
        timestamp: u64,
    }

    struct ClickTokenUsed has copy, drop {
        click_token_hash: vector<u8>,
        ad_id: 0x2::object::ID,
    }

    public fun create_click_token(arg0: &mut ClickTokenRegistry, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert!(0x1::vector::length<u8>(&arg3) <= 64, 8);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        if (0x2::table::contains<address, u64>(&arg0.last_creation_ts, v0)) {
            assert!(v1 >= *0x2::table::borrow<address, u64>(&arg0.last_creation_ts, v0) + 300000, 7);
            *0x2::table::borrow_mut<address, u64>(&mut arg0.last_creation_ts, v0) = v1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.last_creation_ts, v0, v1);
        };
        let v2 = v1 + 86400000;
        let v3 = 0x2::bcs::to_bytes<0x2::object::ID>(&arg1);
        0x1::vector::append<u8>(&mut v3, arg2);
        0x1::vector::append<u8>(&mut v3, arg3);
        0x1::vector::append<u8>(&mut v3, u64_to_bytes(v1));
        let v4 = 0x2::hash::keccak256(&v3);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.tokens, v4), 3);
        let v5 = 0x2::object::new(arg5);
        let v6 = ClickToken{
            id         : v5,
            ad_id      : arg1,
            content_id : arg2,
            token_hash : v4,
            created_at : v1,
            expires_at : v2,
            is_used    : false,
        };
        0x2::table::add<vector<u8>, bool>(&mut arg0.tokens, v4, true);
        arg0.total_clicks = arg0.total_clicks + 1;
        let v7 = ClickTokenCreated{
            token_id   : 0x2::object::uid_to_inner(&v5),
            ad_id      : arg1,
            token_hash : v4,
            expires_at : v2,
        };
        0x2::event::emit<ClickTokenCreated>(v7);
        0x2::transfer::transfer<ClickToken>(v6, 0x2::tx_context::sender(arg5));
    }

    public fun get_registry_stats(arg0: &ClickTokenRegistry) : (u64, u64) {
        (arg0.total_clicks, arg0.total_conversions)
    }

    public fun get_token_ad_id(arg0: &ClickToken) : 0x2::object::ID {
        arg0.ad_id
    }

    public fun get_token_hash(arg0: &ClickToken) : vector<u8> {
        arg0.token_hash
    }

    public fun has_conversion(arg0: &ClickTokenRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, Conversion>(&arg0.conversions, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ClickTokenRegistry{
            id                : 0x2::object::new(arg0),
            tokens            : 0x2::table::new<vector<u8>, bool>(arg0),
            conversions       : 0x2::table::new<vector<u8>, Conversion>(arg0),
            total_clicks      : 0,
            total_conversions : 0,
            paused            : false,
            last_creation_ts  : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<ClickTokenRegistry>(v0);
    }

    public fun is_conversion_verified(arg0: &ClickTokenRegistry, arg1: vector<u8>) : bool {
        if (!0x2::table::contains<vector<u8>, Conversion>(&arg0.conversions, arg1)) {
            return false
        };
        0x2::table::borrow<vector<u8>, Conversion>(&arg0.conversions, arg1).verified
    }

    public fun is_registry_paused(arg0: &ClickTokenRegistry) : bool {
        arg0.paused
    }

    public fun is_token_expired(arg0: &ClickToken, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.expires_at
    }

    public fun is_token_used(arg0: &ClickToken) : bool {
        arg0.is_used
    }

    public fun pause_registry(arg0: &mut ClickTokenRegistry, arg1: &0x2::clock::Clock, arg2: &0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::ad_payments::AdminCap) {
        arg0.paused = true;
        let v0 = TrackingPaused{timestamp: 0x2::clock::timestamp_ms(arg1)};
        0x2::event::emit<TrackingPaused>(v0);
    }

    public fun record_conversion(arg0: &mut ClickToken, arg1: &mut ClickTokenRegistry, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::ad_payments::AdminCap) {
        assert!(!arg1.paused, 6);
        assert!(0x1::vector::length<u8>(&arg2) <= 64, 8);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 <= arg0.expires_at, 1);
        assert!(!arg0.is_used, 3);
        assert!(!0x2::table::contains<vector<u8>, Conversion>(&arg1.conversions, arg0.token_hash), 5);
        let v1 = arg0.token_hash;
        0x1::vector::append<u8>(&mut v1, arg2);
        0x1::vector::append<u8>(&mut v1, u64_to_bytes(v0));
        let v2 = 0x2::hash::keccak256(&v1);
        let v3 = Conversion{
            click_token_hash      : arg0.token_hash,
            conversion_token_hash : v2,
            ad_id                 : arg0.ad_id,
            content_id            : arg0.content_id,
            verified              : false,
            timestamp             : v0,
        };
        0x2::table::add<vector<u8>, Conversion>(&mut arg1.conversions, arg0.token_hash, v3);
        arg1.total_conversions = arg1.total_conversions + 1;
        arg0.is_used = true;
        let v4 = ClickTokenUsed{
            click_token_hash : arg0.token_hash,
            ad_id            : arg0.ad_id,
        };
        0x2::event::emit<ClickTokenUsed>(v4);
        let v5 = ConversionRecorded{
            click_token_hash      : arg0.token_hash,
            conversion_token_hash : v2,
            ad_id                 : arg0.ad_id,
        };
        0x2::event::emit<ConversionRecorded>(v5);
    }

    fun u64_to_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        v0
    }

    public fun verify_click_token(arg0: &ClickToken, arg1: &ClickTokenRegistry, arg2: &0x2::clock::Clock) : bool {
        if (0x2::clock::timestamp_ms(arg2) > arg0.expires_at) {
            return false
        };
        if (arg0.is_used) {
            return false
        };
        if (!0x2::table::contains<vector<u8>, bool>(&arg1.tokens, arg0.token_hash)) {
            return false
        };
        true
    }

    public fun verify_conversion(arg0: &mut ClickTokenRegistry, arg1: vector<u8>, arg2: &0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::ad_payments::AdminCap) {
        assert!(!arg0.paused, 6);
        assert!(0x2::table::contains<vector<u8>, Conversion>(&arg0.conversions, arg1), 2);
        let v0 = 0x2::table::borrow_mut<vector<u8>, Conversion>(&mut arg0.conversions, arg1);
        v0.verified = true;
        let v1 = ConversionVerified{
            click_token_hash : v0.click_token_hash,
            ad_id            : v0.ad_id,
            verified         : true,
        };
        0x2::event::emit<ConversionVerified>(v1);
    }

    public fun verify_token(arg0: &ClickToken, arg1: &ClickTokenRegistry, arg2: &0x2::clock::Clock) {
        let v0 = TokenVerified{
            token_hash : arg0.token_hash,
            ad_id      : arg0.ad_id,
            valid      : verify_click_token(arg0, arg1, arg2),
        };
        0x2::event::emit<TokenVerified>(v0);
    }

    // decompiled from Move bytecode v6
}

