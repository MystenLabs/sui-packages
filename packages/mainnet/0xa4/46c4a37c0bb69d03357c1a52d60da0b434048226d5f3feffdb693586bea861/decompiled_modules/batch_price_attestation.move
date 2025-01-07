module 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::batch_price_attestation {
    struct BatchPriceAttestation {
        header: Header,
        attestation_size: u64,
        attestation_count: u64,
        price_infos: vector<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfo>,
    }

    struct Header {
        magic: u64,
        version_major: u64,
        version_minor: u64,
        header_size: u64,
        payload_id: u8,
    }

    public fun deserialize(arg0: vector<u8>, arg1: &0x2::clock::Clock) : BatchPriceAttestation {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        let v1 = &mut v0;
        let v2 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u16(&mut v0);
        let v3 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u16(&mut v0);
        let v4 = 0x1::vector::empty<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfo>();
        let v5 = 0;
        while (v5 < v2) {
            let v6 = &mut v0;
            0x1::vector::push_back<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfo>(&mut v4, deserialize_price_info(v6, arg1));
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(&mut v0, ((v3 - 149) as u64));
            v5 = v5 + 1;
        };
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::destroy_empty<u8>(v0);
        BatchPriceAttestation{
            header            : deserialize_header(v1),
            attestation_size  : (v3 as u64),
            attestation_count : (v2 as u64),
            price_infos       : v4,
        }
    }

    fun deserialize_header(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::Cursor<u8>) : Header {
        let v0 = (0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u32(arg0) as u64);
        assert!(v0 == 1345476424, 0);
        let v1 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u16(arg0);
        assert!(v1 >= 1, 1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::take_bytes(arg0, ((v1 - 1) as u64));
        Header{
            magic         : v0,
            version_major : (0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u16(arg0) as u64),
            version_minor : (0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u16(arg0) as u64),
            header_size   : (v1 as u64),
            payload_id    : 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u8(arg0),
        }
    }

    fun deserialize_price_info(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::Cursor<u8>, arg1: &0x2::clock::Clock) : 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfo {
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_vector(arg0, 32);
        let v0 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_i32(arg0);
        let v1 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_status::from_u64((0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u8(arg0) as u64));
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u32(arg0);
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u32(arg0);
        let v2 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u64(arg0);
        let v3 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u64(arg0);
        let v4 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::new(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_i64(arg0), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u64(arg0), v0, v2);
        if (v1 != 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_status::new_trading()) {
            v4 = 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::new(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_i64(arg0), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u64(arg0), v0, v3);
        };
        let v5 = v2;
        if (v1 != 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_status::new_trading()) {
            v5 = v3;
        };
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::new_price_info(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u64(arg0), 0x2::clock::timestamp_ms(arg1) / 1000, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_feed::new(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_identifier::from_byte_vec(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_vector(arg0, 32)), v4, 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price::new(0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_i64(arg0), 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::deserialize::deserialize_u64(arg0), v0, v5)))
    }

    public fun destroy(arg0: BatchPriceAttestation) : vector<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfo> {
        let BatchPriceAttestation {
            header            : v0,
            attestation_size  : _,
            attestation_count : _,
            price_infos       : v3,
        } = arg0;
        let Header {
            magic         : _,
            version_major : _,
            version_minor : _,
            header_size   : _,
            payload_id    : _,
        } = v0;
        v3
    }

    public fun get_attestation_count(arg0: &BatchPriceAttestation) : u64 {
        arg0.attestation_count
    }

    public fun get_price_info(arg0: &BatchPriceAttestation, arg1: u64) : &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfo {
        0x1::vector::borrow<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfo>(&arg0.price_infos, arg1)
    }

    // decompiled from Move bytecode v6
}

