module 0x2bc582b2eb724470ddd26f37ff2a577edd5d8569847274366012819be4ab2e58::winsome {
    struct WinnersSelected has copy, drop {
        winners: vector<address>,
    }

    public fun select_winners(arg0: &mut vector<address>, arg1: u64, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) : vector<address> {
        let v0 = 0x1::vector::length<address>(arg0);
        assert!(v0 > 0, 1);
        assert!(arg1 <= v0, 0);
        let v1 = 0x2::random::new_generator(arg2, arg3);
        let v2 = 0x1::vector::empty<address>();
        let v3 = 0;
        while (v3 < arg1) {
            if (v0 == 0) {
                break
            };
            0x1::vector::push_back<address>(&mut v2, 0x1::vector::swap_remove<address>(arg0, 0x2::random::generate_u64_in_range(&mut v1, 0, v0 - 1)));
            v0 = v0 - 1;
            v3 = v3 + 1;
        };
        let v4 = WinnersSelected{winners: v2};
        0x2::event::emit<WinnersSelected>(v4);
        v2
    }

    // decompiled from Move bytecode v6
}

