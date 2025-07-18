module 0xe107bfa0fc1041b5fc63fcb99685d4c8f87d439307ee112d0cd1df5220caca43::random {
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

