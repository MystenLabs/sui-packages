module 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::share_helper {
    public(friend) fun calculate_amount_to_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0) {
            0
        } else {
            0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::u64::mul_div(arg0, arg1, arg2)
        }
    }

    public(friend) fun calculate_shares_to_mint(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            arg0
        } else {
            0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::u64::mul_div(arg0, arg2, arg1)
        }
    }

    // decompiled from Move bytecode v6
}

