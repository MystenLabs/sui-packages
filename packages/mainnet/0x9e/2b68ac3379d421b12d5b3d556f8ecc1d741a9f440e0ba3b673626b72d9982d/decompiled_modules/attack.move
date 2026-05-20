module 0x9e2b68ac3379d421b12d5b3d556f8ecc1d741a9f440e0ba3b673626b72d9982d::attack {
    public fun test(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::zero<0x2::sui::SUI>(arg0), @0x2340427dfc294af39393c6b9710298823044c1e25e1b0d8d915452042d481203);
    }

    // decompiled from Move bytecode v7
}

