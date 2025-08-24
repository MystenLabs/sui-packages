module 0x19f50b946241e097b2d0f639222eaf3d208f491ea2e86770e65880a2888fce27::kitty_coinflip {
    struct Result has copy, drop {
        guess: u8,
        result: u8,
    }

    entry fun coinflip(arg0: u8, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg1, arg2);
        let v1 = Result{
            guess  : arg0,
            result : 0x2::random::generate_u8_in_range(&mut v0, 0, 1),
        };
        0x2::event::emit<Result>(v1);
    }

    // decompiled from Move bytecode v6
}

