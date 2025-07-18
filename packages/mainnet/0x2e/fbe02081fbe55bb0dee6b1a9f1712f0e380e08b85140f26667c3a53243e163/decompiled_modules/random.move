module 0x2efbe02081fbe55bb0dee6b1a9f1712f0e380e08b85140f26667c3a53243e163::random {
    struct RandomNumber has copy, drop {
        value: u16,
    }

    public entry fun generate_random_number(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = RandomNumber{value: 0x2::random::generate_u16_in_range(&mut v0, 1, 10000)};
        0x2::event::emit<RandomNumber>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

