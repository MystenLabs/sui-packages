module 0x3fef274ab2363f7bb99b937bc303299e59d5330066416cf61fa2e3f7d99fad70::utils {
    public(friend) fun get_lucky_number(arg0: &0x2::random::Random, arg1: u32, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) : u32 {
        let v0 = 0x2::random::new_generator(arg0, arg3);
        0x2::random::generate_u32_in_range(&mut v0, arg1, arg2)
    }

    public(friend) fun get_lucky_number_with_prob(arg0: vector<u32>, arg1: u32) : u32 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(&arg0)) {
            let v2 = *0x1::vector::borrow<u32>(&arg0, v1);
            if (arg1 > v0 && arg1 <= v0 + v2) {
                break
            };
            v0 = v0 + v2;
            v1 = v1 + 1;
        };
        (v1 as u32)
    }

    public(friend) fun get_prob_bps(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u32 {
        ((arg1 * (arg2 - arg3) * 1000 / arg0 * 1440) as u32)
    }

    // decompiled from Move bytecode v6
}

