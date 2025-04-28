module 0x4e0afac3271e843b0a798daa676fff5a9cb1c82c1a17dc082ed54981145dfafb::random {
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

