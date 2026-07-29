module 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::pdf {
    fun eval_rational(arg0: u128, arg1: vector<u128>, arg2: vector<bool>, arg3: vector<u128>, arg4: vector<bool>) : u128 {
        (0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::horner::eval_rational(arg0, arg1, arg2, arg3, arg4, 1000000000000000000000000000000000000) as u128)
    }

    public(friend) fun pdf_nonneg_raw(arg0: u128) : u128 {
        if (arg0 >= 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::pdf_coefficients::max_z_raw()) {
            return 0
        };
        eval_rational(arg0, 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::pdf_coefficients::pdf_num_mags(), 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::pdf_coefficients::pdf_num_negs(), 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::pdf_coefficients::pdf_den_mags(), 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::pdf_coefficients::pdf_den_negs())
    }

    // decompiled from Move bytecode v7
}

