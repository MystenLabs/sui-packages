module 0xa25e6ebb81c474af0afa86eb5077164fdbb15f600873b573f2a87a4dcda2eece::utils {
    public entry fun join<T0>(arg0: &mut 0x2::token::Token<T0>, arg1: 0x2::token::Token<T0>) {
        0x2::token::join<T0>(arg0, arg1);
    }

    public fun split<T0>(arg0: &mut 0x2::token::Token<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<T0> {
        0x2::token::split<T0>(arg0, arg1, arg2)
    }

    public entry fun join_vec<T0>(arg0: &mut 0x2::token::Token<T0>, arg1: vector<0x2::token::Token<T0>>) {
        let v0 = 0x1::vector::length<0x2::token::Token<T0>>(&arg1);
        while (v0 > 0) {
            0x2::token::join<T0>(arg0, 0x1::vector::pop_back<0x2::token::Token<T0>>(&mut arg1));
            v0 = v0 - 1;
        };
        0x1::vector::destroy_empty<0x2::token::Token<T0>>(arg1);
    }

    public entry fun nftDisplay<T0: store + key>(arg0: &0x2::display::Display<T0>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        *0x2::display::fields<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

