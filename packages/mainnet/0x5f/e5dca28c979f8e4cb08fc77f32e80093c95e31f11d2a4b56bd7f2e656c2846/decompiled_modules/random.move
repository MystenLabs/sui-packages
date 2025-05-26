module 0x5fe5dca28c979f8e4cb08fc77f32e80093c95e31f11d2a4b56bd7f2e656c2846::random {
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

