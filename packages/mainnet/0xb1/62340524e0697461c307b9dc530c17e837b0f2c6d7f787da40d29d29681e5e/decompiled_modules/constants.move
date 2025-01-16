module 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::constants {
    public fun discount_rule_types() : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0);
        v0
    }

    public fun fixed_price_discount_type() : u8 {
        abort 1337
    }

    public fun percentage_discount_type() : u8 {
        0
    }

    // decompiled from Move bytecode v6
}

