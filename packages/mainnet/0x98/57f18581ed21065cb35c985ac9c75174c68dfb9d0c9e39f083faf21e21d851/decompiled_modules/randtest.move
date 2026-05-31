module 0x9857f18581ed21065cb35c985ac9c75174c68dfb9d0c9e39f083faf21e21d851::randtest {
    struct RollResult has copy, drop {
        value: u64,
    }

    entry fun roll(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = RollResult{value: 0x2::random::generate_u64_in_range(&mut v0, 1, 100)};
        0x2::event::emit<RollResult>(v1);
    }

    // decompiled from Move bytecode v7
}

