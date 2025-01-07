module 0xf3c42f20803c99ffd7fe7588eea04437b182f048e62ecb0afdc3c8c71d715ca4::test {
    struct PriceData has copy, drop {
        pair_index: u32,
        value: u128,
        timestamp: u64,
        decimal: u16,
        round: u64,
    }

    struct TestEvent has copy, drop {
        price_data_vec: vector<PriceData>,
    }

    public fun decode(arg0: vector<u8>) {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = &mut v0;
        let v2 = 0x2::bcs::peel_vec_length(v1);
        let v3 = 0x1::vector::empty<PriceData>();
        while (v2 > 0) {
            let v4 = 0x2::bcs::peel_vec_length(v1);
            while (v4 > 0) {
                let v5 = PriceData{
                    pair_index : 0x2::bcs::peel_u32(v1),
                    value      : 0x2::bcs::peel_u128(v1),
                    timestamp  : 0x2::bcs::peel_u64(v1),
                    decimal    : 0x2::bcs::peel_u16(v1),
                    round      : 0x2::bcs::peel_u64(v1),
                };
                0x1::vector::push_back<PriceData>(&mut v3, v5);
                v4 = v4 - 1;
            };
            0x2::bcs::peel_vec_vec_u8(v1);
            let v6 = 0x2::bcs::peel_vec_length(v1);
            while (v6 > 0) {
                0x2::bcs::peel_bool(v1);
                v6 = v6 - 1;
            };
            0x2::bcs::peel_u64(v1);
            0x2::bcs::peel_vec_u8(v1);
            0x2::bcs::peel_vec_u8(v1);
            v2 = v2 - 1;
        };
        let v7 = TestEvent{price_data_vec: v3};
        0x2::event::emit<TestEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

