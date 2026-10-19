module 0x4b49ecc34f16c410eddb89e7c3507af9a0a99f649cb104541dc3f1e277c734d3::adapter {
    struct VerifiedQuote {
        storage_id: 0x2::object::ID,
        feed_info_id: 0x2::object::ID,
        source_id: u64,
        feed_id: u32,
        price_wad: u128,
        twap_wad: u128,
        price_timestamp_ms: u64,
        conf_wad: u128,
        conf_timestamp_ms: u64,
        signed_bid_wad: u128,
        signed_ask_wad: u128,
        sequence: u64,
        slot: u64,
    }

    struct SignedConfidence has drop {
        feed_id: u32,
        conf_wad: u128,
        conf_timestamp_ms: u64,
        signed_bid_wad: u128,
        signed_ask_wad: u128,
        sequence: u64,
    }

    fun assemble(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u128, arg4: u128, arg5: u64, arg6: SignedConfidence) : VerifiedQuote {
        let SignedConfidence {
            feed_id           : v0,
            conf_wad          : v1,
            conf_timestamp_ms : v2,
            signed_bid_wad    : v3,
            signed_ask_wad    : v4,
            sequence          : v5,
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
            signed_bid_wad     : v3,
            signed_ask_wad     : v4,
            sequence           : v5,
            slot               : arg5,
        }
    }

    fun bind(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg1: 0x2::object::ID, arg2: u64, arg3: SignedConfidence) : VerifiedQuote {
        let (v0, v1, v2) = read_storage(arg0, arg1, arg2);
        assemble(0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg0), 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::from(0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg0, (arg2 as u16))), arg2, v0, v1, v2, arg3)
    }

    public fun conf_timestamp_ms(arg0: &VerifiedQuote) : u64 {
        arg0.conf_timestamp_ms
    }

    public fun conf_wad(arg0: &VerifiedQuote) : u128 {
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
            signed_bid_wad     : _,
            signed_ask_wad     : _,
            sequence           : _,
            slot               : _,
        } = arg0;
    }

    fun extract(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg1: vector<u8>, arg2: u32, arg3: &0x2::clock::Clock) : SignedConfidence {
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
        assert!(0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v3), 13835621945833553923);
        let v4 = 0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(v3);
        let v5 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(&v4);
        assert!(0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v5), 13835903433695297541);
        let v6 = 0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(v5);
        let v7 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(&v4);
        let v8 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::best_bid_price(&v4);
        let v9 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::best_ask_price(&v4);
        let v10 = if (0x1::option::is_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v7)) {
            if (0x1::option::is_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v8)) {
                0x1::option::is_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&v9)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v10, 13835903455170134021);
        let v11 = 0x1::option::destroy_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(v7);
        let v12 = 0x1::option::destroy_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(v8);
        let v13 = 0x1::option::destroy_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(v9);
        let v14 = if (0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v11)) {
            if (0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v12)) {
                0x1::option::is_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v13)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v14, 13835903472350003205);
        SignedConfidence{
            feed_id           : arg2,
            conf_wad          : to_wad(0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(v11), v6),
            conf_timestamp_ms : feed_timestamp(&v4, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(&v0)) / 1000,
            signed_bid_wad    : to_wad(0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(v12), v6),
            signed_ask_wad    : to_wad(0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(v13), v6),
            sequence          : 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update::timestamp(&v0),
        }
    }

    public fun feed_id(arg0: &VerifiedQuote) : u32 {
        arg0.feed_id
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
        assert!(0x2::object::id_to_address(&v0) == @0xd0db9c1e9212a98120384bf78d8b8c985d87b9ee6921dffcf9d1394062911573, 13835339933985800193);
        bind(arg1, arg3, arg4, extract(arg0, arg2, arg5, arg6))
    }

    public fun read_storage(arg0: &0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage, arg1: 0x2::object::ID, arg2: u64) : (u128, u128, u64) {
        assert!(0x2::object::id<0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::PriceFeedStorage>(arg0) == arg1, 13835621447617347587);
        assert!(arg2 <= 65535, 13836465876842840073);
        let v0 = 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed_storage::price_feed(arg0, (arg2 as u16));
        let (v1, v2) = 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::price_and_timestamp_ms(v0);
        (v1, 0x9237337d846fc90b0a7acbdee4ab91809298691873d28e1d64d91e6303ff6ba4::price_feed::twap_price(v0), v2)
    }

    public fun sequence(arg0: &VerifiedQuote) : u64 {
        arg0.sequence
    }

    public fun signed_ask_wad(arg0: &VerifiedQuote) : u128 {
        arg0.signed_ask_wad
    }

    public fun signed_bid_wad(arg0: &VerifiedQuote) : u128 {
        arg0.signed_bid_wad
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
        assert!(!0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&arg0), 13835903704278237189);
        let v0 = if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&arg1)) {
            0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&arg1)
        } else {
            assert!(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&arg1) == 0, 13836185200729915399);
            0
        };
        assert!(v0 <= 18, 13836185213614817287);
        let v1 = 1;
        let v2 = 0;
        while (v2 < 18 - v0) {
            v1 = v1 * 10;
            v2 = v2 + 1;
        };
        let v3 = (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&arg0) as u256) * v1;
        assert!(v3 <= 340282366920938463463374607431768211455, 13836185247974555655);
        (v3 as u128)
    }

    public fun twap_wad(arg0: &VerifiedQuote) : u128 {
        arg0.twap_wad
    }

    // decompiled from Move bytecode v7
}

