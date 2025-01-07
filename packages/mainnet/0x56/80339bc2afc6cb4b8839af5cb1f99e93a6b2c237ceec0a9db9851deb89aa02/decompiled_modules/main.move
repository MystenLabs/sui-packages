module 0x5680339bc2afc6cb4b8839af5cb1f99e93a6b2c237ceec0a9db9851deb89aa02::main {
    public entry fun batch(arg0: &mut 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::MistHouse, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::AccountHouse, arg4: &0x2::clock::Clock, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::confirm_to_next_round5(arg0, arg3, arg4, arg5, arg6);
        while (v0 < 20) {
            0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::claim(arg0, arg1, arg2 / 20, arg7);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

