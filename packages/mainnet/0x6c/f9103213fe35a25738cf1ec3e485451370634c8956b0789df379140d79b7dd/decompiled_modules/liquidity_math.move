module 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::liquidity_math {
    public fun add_delta(arg0: u128, arg1: 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i128::I128) : u128 {
        let v0 = 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i128::abs_u128(arg1);
        if (0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::i128::is_neg(arg1)) {
            assert!(arg0 >= v0, 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::errors::insufficient_liquidity());
            arg0 - v0
        } else {
            assert!(v0 < 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::constants::max_u128() - arg0, 0x6cf9103213fe35a25738cf1ec3e485451370634c8956b0789df379140d79b7dd::errors::insufficient_liquidity());
            arg0 + v0
        }
    }

    // decompiled from Move bytecode v6
}

