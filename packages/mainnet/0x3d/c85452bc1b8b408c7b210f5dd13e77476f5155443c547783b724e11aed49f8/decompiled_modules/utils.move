module 0x3dc85452bc1b8b408c7b210f5dd13e77476f5155443c547783b724e11aed49f8::utils {
    public(friend) fun join_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0, 0);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        while (0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0) {
            0x2::coin::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        v0
    }

    public(friend) fun join_tokens<T0>(arg0: vector<0x2::token::Token<T0>>) : 0x2::token::Token<T0> {
        assert!(0x1::vector::length<0x2::token::Token<T0>>(&arg0) > 0, 0);
        let v0 = 0x1::vector::pop_back<0x2::token::Token<T0>>(&mut arg0);
        while (0x1::vector::length<0x2::token::Token<T0>>(&arg0) > 0) {
            0x2::token::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::token::Token<T0>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x2::token::Token<T0>>(arg0);
        v0
    }

    // decompiled from Move bytecode v7
}

