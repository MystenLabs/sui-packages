module 0x93bec304d13817ead6b34b89d3c2c788ae1e1e30be96ee11e9754c81bd23a309::adapter {
    struct VerifiedQuote {
        storage_id: 0x2::object::ID,
        feed_info_id: 0x2::object::ID,
        source_id: u64,
        feed_id: u32,
        price_wad: u128,
        twap_wad: u128,
        price_timestamp_ms: u64,
        conf_wad: 0x1::option::Option<u128>,
        conf_timestamp_ms: u64,
        sequence: u64,
        slot: u64,
        session_closed: bool,
        session_present: bool,
        timestamp_window: bool,
    }

    struct SignedQuote {
        storage_id: 0x2::object::ID,
        feed_info_id: 0x2::object::ID,
        source_id: u64,
        feed_id: u32,
        price_wad: u128,
        price_timestamp_ms: u64,
        conf_wad: 0x1::option::Option<u128>,
        sequence: u64,
        storage_timestamp_ms: u64,
        twap_wad: u128,
        session_closed: bool,
        session_present: bool,
    }

    struct SignedUpdate has drop {
        feed_id: u32,
        price_wad: u128,
        conf_wad: 0x1::option::Option<u128>,
        conf_timestamp_ms: u64,
        sequence: u64,
        session_closed: bool,
        session_present: bool,
        session_regular: bool,
    }

    struct PricedUpdate has drop {
        feed_id: u32,
        price_wad: u128,
        price_timestamp_ms: u64,
        conf_wad: 0x1::option::Option<u128>,
        sequence: u64,
        session_closed: bool,
        session_present: bool,
        session_regular: bool,
    }

    public fun feed_id(arg0: &VerifiedQuote) : u32 {
        arg0.feed_id
    }

    fun assemble(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u128, arg4: u128, arg5: u64, arg6: SignedUpdate) : VerifiedQuote {
        let SignedUpdate {
            feed_id           : v0,
            price_wad         : v1,
            conf_wad          : v2,
            conf_timestamp_ms : v3,
            sequence          : v4,
            session_closed    : v5,
            session_present   : v6,
            session_regular   : v7,
        } = arg6;
        assert!(v1 == arg3, 13837593421722681361);
        let v8 = if (v5) {
            v4 / 1000
        } else {
            v3
        };
        let v9 = arg5 != v8;
        if (v9) {
            let v10 = if (v7) {
                if (arg5 > v3) {
                    arg5 <= v4 / 1000
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v10, 13837874974008934419);
        };
        VerifiedQuote{
            storage_id         : arg0,
            feed_info_id       : arg1,
            source_id          : arg2,
            feed_id            : v0,
            price_wad          : arg3,
            twap_wad           : arg4,
            price_timestamp_ms : arg5,
            conf_wad           : v2,
            conf_timestamp_ms  : v3,
            sequence           : v4,
            slot               : arg5,
            session_closed     : v5,
            session_present    : v6,
            timestamp_window   : v9,
        }
    }

    fun assemble_signed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u128, arg4: u64, arg5: PricedUpdate) : SignedQuote {
        let PricedUpdate {
            feed_id            : v0,
            price_wad          : v1,
            price_timestamp_ms : v2,
            conf_wad           : v3,
            sequence           : v4,
            session_closed     : v5,
            session_present    : v6,
            session_regular    : _,
        } = arg5;
        assert!(arg4 >= v2, 13837311719112572943);
        SignedQuote{
            storage_id           : arg0,
            feed_info_id         : arg1,
            source_id            : arg2,
            feed_id              : v0,
            price_wad            : v1,
            price_timestamp_ms   : v2,
            conf_wad             : v3,
            sequence             : v4,
            storage_timestamp_ms : arg4,
            twap_wad             : arg3,
            session_closed       : v5,
            session_present      : v6,
        }
    }

    fun bind(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg1: 0x2::object::ID, arg2: u64, arg3: SignedUpdate) : VerifiedQuote {
        let (v0, v1, v2) = read_storage(arg0, arg1, arg2);
        assemble(0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg0), 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::from(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg0, (arg2 as u16))), arg2, v0, v1, v2, arg3)
    }

    public fun conf_timestamp_ms(arg0: &VerifiedQuote) : u64 {
        arg0.conf_timestamp_ms
    }

    public fun conf_wad(arg0: &VerifiedQuote) : 0x1::option::Option<u128> {
        arg0.conf_wad
    }

    public fun destroy(arg0: VerifiedQuote) {
        let VerifiedQuote {
            storage_id         : _,
            feed_info_id       : _,
            source_id          : _,
            feed_id            : _,
            price_wad          : _,
            twap_wad           : _,
            price_timestamp_ms : _,
            conf_wad           : _,
            conf_timestamp_ms  : _,
            sequence           : _,
            slot               : _,
            session_closed     : _,
            session_present    : _,
            timestamp_window   : _,
        } = arg0;
    }

    public fun destroy_signed(arg0: SignedQuote) {
        let SignedQuote {
            storage_id           : _,
            feed_info_id         : _,
            source_id            : _,
            feed_id              : _,
            price_wad            : _,
            price_timestamp_ms   : _,
            conf_wad             : _,
            sequence             : _,
            storage_timestamp_ms : _,
            twap_wad             : _,
            session_closed       : _,
            session_present      : _,
        } = arg0;
    }

    fun extract(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg1: vector<u8>, arg2: u32, arg3: &0x2::clock::Clock) : SignedUpdate {
        let PricedUpdate {
            feed_id            : v0,
            price_wad          : v1,
            price_timestamp_ms : v2,
            conf_wad           : v3,
            sequence           : v4,
            session_closed     : v5,
            session_present    : v6,
            session_regular    : v7,
        } = extract_priced(arg0, arg1, arg2, arg3);
        SignedUpdate{
            feed_id           : v0,
            price_wad         : v1,
            conf_wad          : v3,
            conf_timestamp_ms : v2,
            sequence          : v4,
            session_closed    : v5,
            session_present   : v6,
            session_regular   : v7,
        }
    }

    fun extract_priced(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg1: vector<u8>, arg2: u32, arg3: &0x2::clock::Clock) : PricedUpdate {
        let (v0, v1, v2) = parse(arg0, arg1, arg2, arg3);
        let v3 = v0;
        let v4 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(&v3);
        assert!(0x1::option::is_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v4) && 0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(0x1::option::borrow<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v4)), 13836748666079674379);
        let v5 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(&v3);
        assert!(0x1::option::is_some<0x1::option::Option<u64>>(&v5) && 0x1::option::is_some<u64>(0x1::option::borrow<0x1::option::Option<u64>>(&v5)), 13837030162531352589);
        let v6 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::market_session(&v3);
        PricedUpdate{
            feed_id            : arg2,
            price_wad          : to_wad(0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(0x1::option::destroy_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(v4)), v1),
            price_timestamp_ms : 0x1::option::destroy_some<u64>(0x1::option::destroy_some<0x1::option::Option<u64>>(v5)) / 1000,
            conf_wad           : signed_conf(&v3, v1),
            sequence           : v2,
            session_closed     : session_is_closed(&v3),
            session_present    : 0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(&v6),
            session_regular    : session_is_regular(&v3),
        }
    }

    public fun feed_info_id(arg0: &VerifiedQuote) : 0x2::object::ID {
        arg0.feed_info_id
    }

    fun parse(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg1: vector<u8>, arg2: u32, arg3: &0x2::clock::Clock) : (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16, u64) {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::pyth_lazer::parse_and_verify_le_ecdsa_update(arg0, arg3, arg1);
        let v1 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::feeds(&v0);
        let v2 = 0;
        let v3 = 0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>();
        while (v2 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v1)) {
            if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v1, v2)) == arg2) {
                0x1::option::fill<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&mut v3, *0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v1, v2));
                break
            };
            v2 = v2 + 1;
        };
        assert!(0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v3), 13835622615848452099);
        let v4 = 0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v3);
        let v5 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(&v4);
        assert!(0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v5), 13835904103710195717);
        (v4, 0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(v5), 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(&v0))
    }

    public fun price_timestamp_ms(arg0: &VerifiedQuote) : u64 {
        arg0.price_timestamp_ms
    }

    public fun price_wad(arg0: &VerifiedQuote) : u128 {
        arg0.price_wad
    }

    public fun quote(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg1: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg2: vector<u8>, arg3: 0x2::object::ID, arg4: u64, arg5: u32, arg6: &0x2::clock::Clock) : VerifiedQuote {
        let v0 = 0x2::object::id<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State>(arg0);
        assert!(0x2::object::id_to_address(&v0) == @0xd0db9c1e9212a98120384bf78d8b8c985d87b9ee6921dffcf9d1394062911573, 13835340238928478209);
        bind(arg1, arg3, arg4, extract(arg0, arg2, arg5, arg6))
    }

    public fun quote_signed(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg1: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg2: vector<u8>, arg3: 0x2::object::ID, arg4: u64, arg5: u32, arg6: &0x2::clock::Clock) : SignedQuote {
        let v0 = 0x2::object::id<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State>(arg0);
        assert!(0x2::object::id_to_address(&v0) == @0xd0db9c1e9212a98120384bf78d8b8c985d87b9ee6921dffcf9d1394062911573, 13835340354892595201);
        let (_, v2, v3) = read_storage(arg1, arg3, arg4);
        assemble_signed(0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg1), 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::from(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg1, (arg4 as u16))), arg4, v2, v3, extract_priced(arg0, arg2, arg5, arg6))
    }

    public fun read_storage(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg1: 0x2::object::ID, arg2: u64) : (u128, u128, u64) {
        assert!(0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg0) == arg1, 13835622087567474691);
        assert!(arg2 <= 65535, 13836466516792967177);
        let v0 = 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg0, (arg2 as u16));
        let (v1, v2) = 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::price_and_timestamp_ms(v0);
        (v1, 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::twap_price(v0), v2)
    }

    public fun sequence(arg0: &VerifiedQuote) : u64 {
        arg0.sequence
    }

    public fun session_closed(arg0: &VerifiedQuote) : bool {
        arg0.session_closed
    }

    fun session_is_closed(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed) : bool {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::market_session(arg0);
        0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(&v0) && 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::is_closed(0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(&v0))
    }

    fun session_is_regular(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed) : bool {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::market_session(arg0);
        0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(&v0) && 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::is_regular(0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::market_session::MarketSession>(&v0))
    }

    public fun session_present(arg0: &VerifiedQuote) : bool {
        arg0.session_present
    }

    fun signed_conf(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16) : 0x1::option::Option<u128> {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(arg0);
        if (0x1::option::is_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v0) && 0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(0x1::option::borrow<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v0))) {
            0x1::option::some<u128>(to_wad(0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(0x1::option::destroy_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(v0)), arg1))
        } else {
            0x1::option::none<u128>()
        }
    }

    public fun signed_conf_wad(arg0: &SignedQuote) : 0x1::option::Option<u128> {
        arg0.conf_wad
    }

    public fun signed_feed_id(arg0: &SignedQuote) : u32 {
        arg0.feed_id
    }

    public fun signed_feed_info_id(arg0: &SignedQuote) : 0x2::object::ID {
        arg0.feed_info_id
    }

    public fun signed_price_timestamp_ms(arg0: &SignedQuote) : u64 {
        arg0.price_timestamp_ms
    }

    public fun signed_price_wad(arg0: &SignedQuote) : u128 {
        arg0.price_wad
    }

    public fun signed_sequence(arg0: &SignedQuote) : u64 {
        arg0.sequence
    }

    public fun signed_session_closed(arg0: &SignedQuote) : bool {
        arg0.session_closed
    }

    public fun signed_session_present(arg0: &SignedQuote) : bool {
        arg0.session_present
    }

    public fun signed_source_id(arg0: &SignedQuote) : u64 {
        arg0.source_id
    }

    public fun signed_storage_id(arg0: &SignedQuote) : 0x2::object::ID {
        arg0.storage_id
    }

    public fun signed_storage_timestamp_ms(arg0: &SignedQuote) : u64 {
        arg0.storage_timestamp_ms
    }

    public fun signed_twap_wad(arg0: &SignedQuote) : u128 {
        arg0.twap_wad
    }

    public fun slot(arg0: &VerifiedQuote) : u64 {
        arg0.slot
    }

    public fun source_id(arg0: &VerifiedQuote) : u64 {
        arg0.source_id
    }

    public fun storage_id(arg0: &VerifiedQuote) : 0x2::object::ID {
        arg0.storage_id
    }

    public fun timestamp_window(arg0: &VerifiedQuote) : bool {
        arg0.timestamp_window
    }

    fun to_wad(arg0: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16) : u128 {
        assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&arg0), 13835904743660322821);
        let v0 = if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&arg1)) {
            0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&arg1)
        } else {
            assert!(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&arg1) == 0, 13836186240112001031);
            0
        };
        assert!(v0 <= 18, 13836186252996902919);
        let v1 = 1;
        let v2 = 0;
        while (v2 < 18 - v0) {
            v1 = v1 * 10;
            v2 = v2 + 1;
        };
        let v3 = (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&arg0) as u256) * v1;
        assert!(v3 <= 340282366920938463463374607431768211455, 13836186287356641287);
        (v3 as u128)
    }

    public fun twap_wad(arg0: &VerifiedQuote) : u128 {
        arg0.twap_wad
    }

    // decompiled from Move bytecode v7
}

