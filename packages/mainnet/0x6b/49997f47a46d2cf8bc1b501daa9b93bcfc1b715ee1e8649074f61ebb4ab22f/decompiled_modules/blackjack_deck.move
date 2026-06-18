module 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::blackjack_deck {
    public fun draw(arg0: &mut vector<u8>) : u8 {
        assert!(0x1::vector::length<u8>(arg0) > 0, 100);
        0x1::vector::pop_back<u8>(arg0)
    }

    public fun draw_fresh(arg0: &mut 0x2::random::RandomGenerator, arg1: &vector<u8>) : u8 {
        let v0;
        loop {
            v0 = 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::randomness::u8_in_range(arg0, 0, 51);
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
        0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::randomness::shuffle_u8(arg0, arg1);
    }

    public fun shuffled(arg0: &mut 0x2::random::RandomGenerator) : vector<u8> {
        let v0 = 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::blackjack_cards::new_deck();
        let v1 = &mut v0;
        shuffle(arg0, v1);
        v0
    }

    // decompiled from Move bytecode v7
}

