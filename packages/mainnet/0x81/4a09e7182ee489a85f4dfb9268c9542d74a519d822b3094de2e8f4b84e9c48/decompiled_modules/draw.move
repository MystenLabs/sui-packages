module 0x814a09e7182ee489a85f4dfb9268c9542d74a519d822b3094de2e8f4b84e9c48::draw {
    struct DrawResult has copy, drop {
        min: u64,
        max: u64,
        result: u64,
    }

    entry fun draw(arg0: &0x2::random::Random, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg3);
        let v1 = DrawResult{
            min    : arg1,
            max    : arg2,
            result : 0x2::random::generate_u64_in_range(&mut v0, arg1, arg2),
        };
        0x2::event::emit<DrawResult>(v1);
    }

    // decompiled from Move bytecode v6
}

