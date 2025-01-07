module 0xf4b0296398c7fbbaebe7c9e3362e8825a5d3674b5b85a8ed0a93b7fda2341aed::witness {
    public fun check_owner(arg0: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = vector[@0x199a693b39f1763afe018d4a195b8c999ebfb27cdff7908b9cf2429e3ac2a513, @0xaec38ac6d61e41883d03e100e2d22700c58a9049d02e42da2077a0d80da5fdcf, @0x26cf364a0b2d11b1ca0314ce50c532e852bb64e407cddfebcb5cf82a23675922];
        let v1 = 0x2::tx_context::sender(arg0);
        0x1::vector::contains<address>(&v0, &v1)
    }

    public fun get_contract_onwer() : vector<address> {
        vector[@0x199a693b39f1763afe018d4a195b8c999ebfb27cdff7908b9cf2429e3ac2a513, @0xaec38ac6d61e41883d03e100e2d22700c58a9049d02e42da2077a0d80da5fdcf, @0x26cf364a0b2d11b1ca0314ce50c532e852bb64e407cddfebcb5cf82a23675922]
    }

    // decompiled from Move bytecode v6
}

