module 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::accumulator {
    fun parse_accumulator_merkle_root_from_vaa_payload(arg0: vector<u8>) : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20 {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(arg0);
        assert!(0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_u32(&mut v0) == 1096111958, 454);
        assert!(0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_u8(&mut v0) == 0, 454);
        0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_u64(&mut v0);
        0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_u32(&mut v0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v0);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::new(0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_vector(&mut v0, 20))
    }

    public(friend) fun parse_and_verify_accumulator_message(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::Cursor<u8>, arg1: vector<u8>, arg2: &0x2::clock::Clock) : vector<0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price_info::PriceInfo> {
        if ((0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_u32(arg0) as u64) != 1347305813) {
            abort 657
        };
        assert!(0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_u8(arg0) == 1, 554);
        assert!(0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_u8(arg0) >= 0, 554);
        0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_vector(arg0, (0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_u8(arg0) as u64));
        assert!(0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_u8(arg0) == 0, 554);
        0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_vector(arg0, (0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_u16(arg0) as u64));
        parse_and_verify_accumulator_updates(arg0, parse_accumulator_merkle_root_from_vaa_payload(arg1), arg2)
    }

    fun parse_and_verify_accumulator_updates(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::Cursor<u8>, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes20::Bytes20, arg2: &0x2::clock::Clock) : vector<0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price_info::PriceInfo> {
        let v0 = 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_u8(arg0);
        let v1 = 0x1::vector::empty<0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price_info::PriceInfo>();
        while (v0 > 0) {
            let v2 = 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_vector(arg0, (0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_u16(arg0) as u64));
            let v3 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::new<u8>(v2);
            let v4 = &mut v3;
            0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::take_rest<u8>(v3);
            0x1::vector::push_back<0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price_info::PriceInfo>(&mut v1, parse_price_feed_message(v4, arg2));
            assert!(0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::merkle_tree::is_proof_valid(arg0, arg1, v2), 345);
            v0 = v0 - 1;
        };
        v1
    }

    fun parse_price_feed_message(arg0: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::cursor::Cursor<u8>, arg1: &0x2::clock::Clock) : 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price_info::PriceInfo {
        assert!(0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_u8(arg0) == 0, 245);
        let v0 = 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_i32(arg0);
        let v1 = 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_u64(arg0);
        0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_i64(arg0);
        0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price_info::new_price_info(0x2::clock::timestamp_ms(arg1) / 1000, 0x2::clock::timestamp_ms(arg1) / 1000, 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price_feed::new(0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price_identifier::from_byte_vec(0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_vector(arg0, 32)), 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price::new(0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_i64(arg0), 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_u64(arg0), v0, v1), 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::price::new(0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_i64(arg0), 0x3fbdad435cdb4210427bc3993b80459b8b0e3c0ec0f9caa9302b4e719391314::deserialize::deserialize_u64(arg0), v0, v1)))
    }

    // decompiled from Move bytecode v6
}

