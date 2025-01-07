module 0xe0176a4d35b9d3e558483be8204bca2e101462a1db401922517b2f91471cc03e::test_fee {
    struct FeeCaptured has copy, drop {
        fee: u8,
    }

    public fun test(arg0: &0xc6311775f6ebad4515fd5d60cd96c40ae2f688eeb0e21d90c26ae7135ca09e9a::state::FeeManagerState) {
        let v0 = FeeCaptured{fee: 0xc6311775f6ebad4515fd5d60cd96c40ae2f688eeb0e21d90c26ae7135ca09e9a::calculate_fee_rate::calculate_fee(arg0, 3, @0x0, 2, @0x0, 0, 0, @0x0, 3)};
        0x2::event::emit<FeeCaptured>(v0);
    }

    // decompiled from Move bytecode v6
}

