module 0xae0a47252d4cb25124a82ef51b97992b5c1edc92c6f2425e3b080d2f5e1b3104::a {
    public entry fun strength(arg0: &mut 0x2::tx_context::TxContext) {
        0xa3cecaaaad165441a05738f093b929beda5446f7f07fd611ae23eeea363e3790::strength::create(arg0);
    }

    public entry fun magic(arg0: &mut 0x2::tx_context::TxContext) {
        0xc53e2d7ccc7ac5a2455c3d42cc19caec0314c90a260c0a3d40c1af054e22d1b0::magic::create(arg0);
    }

    // decompiled from Move bytecode v6
}

