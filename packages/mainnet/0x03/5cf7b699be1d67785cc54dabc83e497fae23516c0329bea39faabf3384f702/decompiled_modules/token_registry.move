module 0x35cf7b699be1d67785cc54dabc83e497fae23516c0329bea39faabf3384f702::token_registry {
    struct TokenRegistry has key {
        id: 0x2::object::UID,
        crowd_walrus_id: 0x2::object::ID,
    }

    struct CoinKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct TokenMetadata has store {
        symbol: 0x1::string::String,
        name: 0x1::string::String,
        decimals: u8,
        pyth_feed_id: vector<u8>,
        enabled: bool,
        max_age_ms: u64,
    }

    struct TokenAdded has copy, drop {
        coin_type: 0x1::string::String,
        symbol: 0x1::string::String,
        name: 0x1::string::String,
        decimals: u8,
        pyth_feed_id: vector<u8>,
        max_age_ms: u64,
        enabled: bool,
        timestamp_ms: u64,
    }

    struct TokenUpdated has copy, drop {
        coin_type: 0x1::string::String,
        symbol: 0x1::string::String,
        name: 0x1::string::String,
        decimals: u8,
        pyth_feed_id: vector<u8>,
        max_age_ms: u64,
        timestamp_ms: u64,
    }

    struct TokenEnabled has copy, drop {
        coin_type: 0x1::string::String,
        symbol: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct TokenDisabled has copy, drop {
        coin_type: 0x1::string::String,
        symbol: 0x1::string::String,
        timestamp_ms: u64,
    }

    public(friend) fun add_coin<T0>(arg0: &mut TokenRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: vector<u8>, arg5: u64, arg6: &0x2::clock::Clock) {
        assert!(!contains<T0>(arg0), 1);
        assert_feed_id(&arg4);
        assert_decimals(arg3);
        let v0 = TokenMetadata{
            symbol       : arg1,
            name         : arg2,
            decimals     : arg3,
            pyth_feed_id : arg4,
            enabled      : false,
            max_age_ms   : arg5,
        };
        0x2::dynamic_field::add<CoinKey<T0>, TokenMetadata>(&mut arg0.id, coin_key<T0>(), v0);
        emit_added_event<T0>(arg0, arg6);
    }

    fun assert_decimals(arg0: u8) {
        assert!(arg0 <= 38, 4);
    }

    fun assert_feed_id(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 3);
    }

    fun borrow_metadata<T0>(arg0: &TokenRegistry) : &TokenMetadata {
        ensure_exists<T0>(arg0);
        0x2::dynamic_field::borrow<CoinKey<T0>, TokenMetadata>(&arg0.id, coin_key<T0>())
    }

    fun borrow_metadata_mut<T0>(arg0: &mut TokenRegistry) : &mut TokenMetadata {
        ensure_exists<T0>(arg0);
        0x2::dynamic_field::borrow_mut<CoinKey<T0>, TokenMetadata>(&mut arg0.id, coin_key<T0>())
    }

    fun clone_bytes(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun coin_key<T0>() : CoinKey<T0> {
        CoinKey<T0>{dummy_field: false}
    }

    public fun coin_type_canonical<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()))
    }

    public fun contains<T0>(arg0: &TokenRegistry) : bool {
        0x2::dynamic_field::exists_<CoinKey<T0>>(&arg0.id, coin_key<T0>())
    }

    public(friend) fun create_registry(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : TokenRegistry {
        TokenRegistry{
            id              : 0x2::object::new(arg1),
            crowd_walrus_id : arg0,
        }
    }

    public fun decimals<T0>(arg0: &TokenRegistry) : u8 {
        borrow_metadata<T0>(arg0).decimals
    }

    fun emit_added_event<T0>(arg0: &TokenRegistry, arg1: &0x2::clock::Clock) {
        let v0 = borrow_metadata<T0>(arg0);
        let v1 = TokenAdded{
            coin_type    : coin_type_canonical<T0>(),
            symbol       : v0.symbol,
            name         : v0.name,
            decimals     : v0.decimals,
            pyth_feed_id : clone_bytes(&v0.pyth_feed_id),
            max_age_ms   : v0.max_age_ms,
            enabled      : v0.enabled,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<TokenAdded>(v1);
    }

    fun emit_disabled_event<T0>(arg0: &TokenMetadata, arg1: &0x2::clock::Clock) {
        let v0 = TokenDisabled{
            coin_type    : coin_type_canonical<T0>(),
            symbol       : arg0.symbol,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<TokenDisabled>(v0);
    }

    fun emit_enabled_event<T0>(arg0: &TokenMetadata, arg1: &0x2::clock::Clock) {
        let v0 = TokenEnabled{
            coin_type    : coin_type_canonical<T0>(),
            symbol       : arg0.symbol,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<TokenEnabled>(v0);
    }

    fun emit_updated_event<T0>(arg0: &TokenMetadata, arg1: &0x2::clock::Clock) {
        let v0 = TokenUpdated{
            coin_type    : coin_type_canonical<T0>(),
            symbol       : arg0.symbol,
            name         : arg0.name,
            decimals     : arg0.decimals,
            pyth_feed_id : clone_bytes(&arg0.pyth_feed_id),
            max_age_ms   : arg0.max_age_ms,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<TokenUpdated>(v0);
    }

    fun ensure_exists<T0>(arg0: &TokenRegistry) {
        assert!(contains<T0>(arg0), 2);
    }

    public fun is_enabled<T0>(arg0: &TokenRegistry) : bool {
        borrow_metadata<T0>(arg0).enabled
    }

    public fun max_age_ms<T0>(arg0: &TokenRegistry) : u64 {
        borrow_metadata<T0>(arg0).max_age_ms
    }

    public fun name<T0>(arg0: &TokenRegistry) : 0x1::string::String {
        borrow_metadata<T0>(arg0).name
    }

    public fun pyth_feed_id<T0>(arg0: &TokenRegistry) : vector<u8> {
        clone_bytes(&borrow_metadata<T0>(arg0).pyth_feed_id)
    }

    public fun registry_owner_id(arg0: &TokenRegistry) : 0x2::object::ID {
        arg0.crowd_walrus_id
    }

    public(friend) fun require_enabled<T0>(arg0: &TokenRegistry) {
        ensure_exists<T0>(arg0);
        assert!(is_enabled<T0>(arg0), 2);
    }

    public(friend) fun set_enabled<T0>(arg0: &mut TokenRegistry, arg1: bool, arg2: &0x2::clock::Clock) {
        ensure_exists<T0>(arg0);
        let v0 = borrow_metadata_mut<T0>(arg0);
        v0.enabled = arg1;
        if (arg1) {
            emit_enabled_event<T0>(v0, arg2);
        } else {
            emit_disabled_event<T0>(v0, arg2);
        };
    }

    public(friend) fun set_max_age_ms<T0>(arg0: &mut TokenRegistry, arg1: u64, arg2: &0x2::clock::Clock) {
        ensure_exists<T0>(arg0);
        let v0 = borrow_metadata_mut<T0>(arg0);
        v0.max_age_ms = arg1;
        emit_updated_event<T0>(v0, arg2);
    }

    public(friend) fun share_registry(arg0: TokenRegistry) {
        0x2::transfer::share_object<TokenRegistry>(arg0);
    }

    public fun symbol<T0>(arg0: &TokenRegistry) : 0x1::string::String {
        borrow_metadata<T0>(arg0).symbol
    }

    public fun token_added_coin_type(arg0: &TokenAdded) : 0x1::string::String {
        arg0.coin_type
    }

    public fun token_added_decimals(arg0: &TokenAdded) : u8 {
        arg0.decimals
    }

    public fun token_added_enabled(arg0: &TokenAdded) : bool {
        arg0.enabled
    }

    public fun token_added_max_age_ms(arg0: &TokenAdded) : u64 {
        arg0.max_age_ms
    }

    public fun token_added_name(arg0: &TokenAdded) : 0x1::string::String {
        arg0.name
    }

    public fun token_added_pyth_feed_id(arg0: &TokenAdded) : vector<u8> {
        clone_bytes(&arg0.pyth_feed_id)
    }

    public fun token_added_symbol(arg0: &TokenAdded) : 0x1::string::String {
        arg0.symbol
    }

    public fun token_added_timestamp_ms(arg0: &TokenAdded) : u64 {
        arg0.timestamp_ms
    }

    public fun token_disabled_coin_type(arg0: &TokenDisabled) : 0x1::string::String {
        arg0.coin_type
    }

    public fun token_disabled_symbol(arg0: &TokenDisabled) : 0x1::string::String {
        arg0.symbol
    }

    public fun token_disabled_timestamp_ms(arg0: &TokenDisabled) : u64 {
        arg0.timestamp_ms
    }

    public fun token_enabled_coin_type(arg0: &TokenEnabled) : 0x1::string::String {
        arg0.coin_type
    }

    public fun token_enabled_symbol(arg0: &TokenEnabled) : 0x1::string::String {
        arg0.symbol
    }

    public fun token_enabled_timestamp_ms(arg0: &TokenEnabled) : u64 {
        arg0.timestamp_ms
    }

    public fun token_updated_coin_type(arg0: &TokenUpdated) : 0x1::string::String {
        arg0.coin_type
    }

    public fun token_updated_decimals(arg0: &TokenUpdated) : u8 {
        arg0.decimals
    }

    public fun token_updated_max_age_ms(arg0: &TokenUpdated) : u64 {
        arg0.max_age_ms
    }

    public fun token_updated_name(arg0: &TokenUpdated) : 0x1::string::String {
        arg0.name
    }

    public fun token_updated_pyth_feed_id(arg0: &TokenUpdated) : vector<u8> {
        clone_bytes(&arg0.pyth_feed_id)
    }

    public fun token_updated_symbol(arg0: &TokenUpdated) : 0x1::string::String {
        arg0.symbol
    }

    public fun token_updated_timestamp_ms(arg0: &TokenUpdated) : u64 {
        arg0.timestamp_ms
    }

    public(friend) fun update_metadata<T0>(arg0: &mut TokenRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        assert_feed_id(&arg4);
        assert_decimals(arg3);
        ensure_exists<T0>(arg0);
        let v0 = borrow_metadata_mut<T0>(arg0);
        v0.symbol = arg1;
        v0.name = arg2;
        v0.decimals = arg3;
        v0.pyth_feed_id = arg4;
        emit_updated_event<T0>(v0, arg5);
    }

    // decompiled from Move bytecode v6
}

