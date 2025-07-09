module 0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::utils_crime {
    public(friend) fun flip_coin(arg0: &0x2::random::Random, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::random::new_generator(arg0, arg2);
        0x2::random::generate_u64_in_range(&mut v0, 0, 100) <= arg1
    }

    // decompiled from Move bytecode v6
}

