module 0xdd3ba042c03854131831a0d301960be2d7aba1d9528344610b9fa9bd960cdb2f::ad_tracking {
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
    }

    struct VerifierCap has store, key {
        id: 0x2::object::UID,
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

    public fun create_click_token(arg0: &mut ClickTokenRegistry, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = v0 + 86400000;
        let v2 = 0x2::object::id_to_bytes(&arg1);
        0x1::vector::append<u8>(&mut v2, arg2);
        0x1::vector::append<u8>(&mut v2, arg3);
        0x1::vector::append<u8>(&mut v2, u64_to_bytes(v0));
        let v3 = 0x2::hash::keccak256(&v2);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.tokens, v3), 3);
        let v4 = 0x2::object::new(arg5);
        let v5 = ClickToken{
            id         : v4,
            ad_id      : arg1,
            content_id : arg2,
            token_hash : v3,
            created_at : v0,
            expires_at : v1,
            is_used    : false,
        };
        0x2::table::add<vector<u8>, bool>(&mut arg0.tokens, v3, true);
        arg0.total_clicks = arg0.total_clicks + 1;
        let v6 = ClickTokenCreated{
            token_id   : 0x2::object::uid_to_inner(&v4),
            ad_id      : arg1,
            token_hash : v3,
            expires_at : v1,
        };
        0x2::event::emit<ClickTokenCreated>(v6);
        0x2::transfer::transfer<ClickToken>(v5, 0x2::tx_context::sender(arg5));
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
        let v0 = VerifierCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VerifierCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ClickTokenRegistry{
            id                : 0x2::object::new(arg0),
            tokens            : 0x2::table::new<vector<u8>, bool>(arg0),
            conversions       : 0x2::table::new<vector<u8>, Conversion>(arg0),
            total_clicks      : 0,
            total_conversions : 0,
        };
        0x2::transfer::share_object<ClickTokenRegistry>(v1);
    }

    public fun is_conversion_verified(arg0: &ClickTokenRegistry, arg1: vector<u8>) : bool {
        if (!0x2::table::contains<vector<u8>, Conversion>(&arg0.conversions, arg1)) {
            return false
        };
        0x2::table::borrow<vector<u8>, Conversion>(&arg0.conversions, arg1).verified
    }

    public fun is_token_expired(arg0: &ClickToken, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.expires_at
    }

    public fun is_token_used(arg0: &ClickToken) : bool {
        arg0.is_used
    }

    public fun record_conversion(arg0: &mut ClickToken, arg1: &mut ClickTokenRegistry, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &VerifierCap) {
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
        let v4 = ConversionRecorded{
            click_token_hash      : arg0.token_hash,
            conversion_token_hash : v2,
            ad_id                 : arg0.ad_id,
        };
        0x2::event::emit<ConversionRecorded>(v4);
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

    public fun verify_conversion(arg0: &mut ClickTokenRegistry, arg1: vector<u8>, arg2: &VerifierCap) {
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

