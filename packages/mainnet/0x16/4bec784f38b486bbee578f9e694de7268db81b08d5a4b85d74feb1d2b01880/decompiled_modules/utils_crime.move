module 0x164bec784f38b486bbee578f9e694de7268db81b08d5a4b85d74feb1d2b01880::utils_crime {
    public(friend) fun flip_coin(arg0: &0x2::random::Random, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::random::new_generator(arg0, arg2);
        0x2::random::generate_u64_in_range(&mut v0, 0, 100) <= arg1
    }

    // decompiled from Move bytecode v6
}

