module 0xd70f76763cf34d44e8df6dc77f3b47c380a9ea9be8bc745c8e58caf898da05e9::random {
    struct RandomU128Event has copy, drop {
        value: u128,
    }

    entry fun new(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = RandomU128Event{value: 0x2::random::generate_u128(&mut v0)};
        0x2::event::emit<RandomU128Event>(v1);
    }

    // decompiled from Move bytecode v6
}

