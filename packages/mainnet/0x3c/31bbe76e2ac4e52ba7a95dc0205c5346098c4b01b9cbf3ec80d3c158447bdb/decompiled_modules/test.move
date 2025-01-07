module 0x3c31bbe76e2ac4e52ba7a95dc0205c5346098c4b01b9cbf3ec80d3c158447bdb::test {
    struct PriceData has copy, drop {
        pair_index: u32,
        value: u128,
        timestamp: u64,
        decimal: u16,
        round: u64,
    }

    public fun decode(arg0: vector<u8>) {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = &mut v0;
        0x2::bcs::peel_vec_length(v1);
        0x2::bcs::peel_vec_length(v1);
        let v2 = PriceData{
            pair_index : 0x2::bcs::peel_u32(v1),
            value      : 0x2::bcs::peel_u128(v1),
            timestamp  : 0x2::bcs::peel_u64(v1),
            decimal    : 0x2::bcs::peel_u16(v1),
            round      : 0x2::bcs::peel_u64(v1),
        };
        0x2::event::emit<PriceData>(v2);
    }

    // decompiled from Move bytecode v6
}

