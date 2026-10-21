module 0x8c93822a4b93178568a3e3edbe45a63984c3b8d39f4984a85d9add3cb45c9be7::adapter {
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
    }

    struct SignedUpdate has drop {
        feed_id: u32,
        conf_wad: 0x1::option::Option<u128>,
        conf_timestamp_ms: u64,
        sequence: u64,
    }

    public fun feed_id(arg0: &VerifiedQuote) : u32 {
        arg0.feed_id
    }

    fun assemble(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u128, arg4: u128, arg5: u64, arg6: SignedUpdate) : VerifiedQuote {
        let SignedUpdate {
            feed_id           : v0,
            conf_wad          : v1,
            conf_timestamp_ms : v2,
            sequence          : v3,
        } = arg6;
        VerifiedQuote{
            storage_id         : arg0,
            feed_info_id       : arg1,
            source_id          : arg2,
            feed_id            : v0,
            price_wad          : arg3,
            twap_wad           : arg4,
            price_timestamp_ms : arg5,
            conf_wad           : v1,
            conf_timestamp_ms  : v2,
            sequence           : v3,
            slot               : arg5,
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
        } = arg0;
    }

    fun extract(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg1: vector<u8>, arg2: u32, arg3: &0x2::clock::Clock) : SignedUpdate {
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
        assert!(0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v3), 13835621924358717443);
        let v4 = 0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v3);
        let v5 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(&v4);
        assert!(0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v5), 13835903412220461061);
        let v6 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(&v4);
        let v7 = if (0x1::option::is_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v6) && 0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(0x1::option::borrow<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v6))) {
            0x1::option::some<u128>(to_wad(0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(0x1::option::destroy_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(v6)), 0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(v5)))
        } else {
            0x1::option::none<u128>()
        };
        SignedUpdate{
            feed_id           : arg2,
            conf_wad          : v7,
            conf_timestamp_ms : feed_timestamp(&v4, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(&v0)) / 1000,
            sequence          : 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(&v0),
        }
    }

    public fun feed_info_id(arg0: &VerifiedQuote) : 0x2::object::ID {
        arg0.feed_info_id
    }

    fun feed_timestamp(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed, arg1: u64) : u64 {
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(arg0);
        if (0x1::option::is_none<0x1::option::Option<u64>>(&v0)) {
            return arg1
        };
        let v1 = 0x1::option::destroy_some<0x1::option::Option<u64>>(v0);
        if (0x1::option::is_none<u64>(&v1)) {
            arg1
        } else {
            0x1::option::destroy_some<u64>(v1)
        }
    }

    public fun price_timestamp_ms(arg0: &VerifiedQuote) : u64 {
        arg0.price_timestamp_ms
    }

    public fun price_wad(arg0: &VerifiedQuote) : u128 {
        arg0.price_wad
    }

    public fun quote(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg1: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg2: vector<u8>, arg3: 0x2::object::ID, arg4: u64, arg5: u32, arg6: &0x2::clock::Clock) : VerifiedQuote {
        let v0 = 0x2::object::id<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State>(arg0);
        assert!(0x2::object::id_to_address(&v0) == @0xd0db9c1e9212a98120384bf78d8b8c985d87b9ee6921dffcf9d1394062911573, 13835339938280767489);
        bind(arg1, arg3, arg4, extract(arg0, arg2, arg5, arg6))
    }

    public fun read_storage(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg1: 0x2::object::ID, arg2: u64) : (u128, u128, u64) {
        assert!(0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg0) == arg1, 13835621451912314883);
        assert!(arg2 <= 65535, 13836465881137807369);
        let v0 = 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg0, (arg2 as u16));
        let (v1, v2) = 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::price_and_timestamp_ms(v0);
        (v1, 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::twap_price(v0), v2)
    }

    public fun sequence(arg0: &VerifiedQuote) : u64 {
        arg0.sequence
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

    fun to_wad(arg0: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16) : u128 {
        assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&arg0), 13835903665623531525);
        let v0 = if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&arg1)) {
            0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&arg1)
        } else {
            assert!(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&arg1) == 0, 13836185162075209735);
            0
        };
        assert!(v0 <= 18, 13836185174960111623);
        let v1 = 1;
        let v2 = 0;
        while (v2 < 18 - v0) {
            v1 = v1 * 10;
            v2 = v2 + 1;
        };
        let v3 = (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&arg0) as u256) * v1;
        assert!(v3 <= 340282366920938463463374607431768211455, 13836185209319849991);
        (v3 as u128)
    }

    public fun twap_wad(arg0: &VerifiedQuote) : u128 {
        arg0.twap_wad
    }

    // decompiled from Move bytecode v7
}

