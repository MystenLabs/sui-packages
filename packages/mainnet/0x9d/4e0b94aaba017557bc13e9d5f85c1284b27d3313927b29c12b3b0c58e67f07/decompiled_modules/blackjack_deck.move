module 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::blackjack_deck {
    public fun draw(arg0: &mut vector<u8>) : u8 {
        assert!(0x1::vector::length<u8>(arg0) > 0, 100);
        0x1::vector::pop_back<u8>(arg0)
    }

    public fun draw_fresh(arg0: &mut 0x2::random::RandomGenerator, arg1: &vector<u8>) : u8 {
        let v0;
        loop {
            v0 = 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::randomness::u8_in_range(arg0, 0, 51);
            if (!0x1::vector::contains<u8>(arg1, &v0)) {
                break
            };
        };
        v0
    }

    public fun remaining(arg0: &vector<u8>) : u64 {
        0x1::vector::length<u8>(arg0)
    }

    public fun shuffle(arg0: &mut 0x2::random::RandomGenerator, arg1: &mut vector<u8>) {
        assert!(0x1::vector::length<u8>(arg1) == 52, 100);
        0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::randomness::shuffle_u8(arg0, arg1);
    }

    public fun shuffled(arg0: &mut 0x2::random::RandomGenerator) : vector<u8> {
        let v0 = 0x9d4e0b94aaba017557bc13e9d5f85c1284b27d3313927b29c12b3b0c58e67f07::blackjack_cards::new_deck();
        let v1 = &mut v0;
        shuffle(arg0, v1);
        v0
    }

    // decompiled from Move bytecode v7
}

