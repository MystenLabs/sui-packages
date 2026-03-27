module 0x1bb304fb163c6fd001644a464dd6f6f29c3ef22bee5749a434a282217e2e940b::test {
    entry fun test_random(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u64_in_range(&mut v0, 0, 100);
    }

    // decompiled from Move bytecode v6
}

