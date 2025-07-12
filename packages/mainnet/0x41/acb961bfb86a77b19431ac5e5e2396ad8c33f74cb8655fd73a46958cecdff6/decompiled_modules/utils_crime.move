module 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::utils_crime {
    public(friend) fun flip_coin(arg0: &0x2::random::Random, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::random::new_generator(arg0, arg2);
        0x2::random::generate_u64_in_range(&mut v0, 0, 100000) <= arg1
    }

    // decompiled from Move bytecode v6
}

