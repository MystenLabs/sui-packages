module 0x6669b0f9a37514ce85b3e08c68758ac31cf65a9b0741b03eb287c43319eebf35::test {
    struct Result has copy, drop, store {
        value: u64,
    }

    entry fun test_random(arg0: &0x2::random::Random, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::random::new_generator(arg0, arg3);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, arg1, arg2);
        let v2 = Result{value: v1};
        0x2::event::emit<Result>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

