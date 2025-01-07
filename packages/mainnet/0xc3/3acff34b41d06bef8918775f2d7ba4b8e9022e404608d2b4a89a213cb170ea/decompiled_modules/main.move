module 0xc33acff34b41d06bef8918775f2d7ba4b8e9022e404608d2b4a89a213cb170ea::main {
    public entry fun batch(arg0: &mut 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::MistHouse, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::AccountHouse, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 20) {
            0xc273c1abd6b5573a8d386d0c824e60d36247e43be2b1f387cbad6c34f36b9cdd::mist::claim_immediately(arg0, arg1, arg2 / 20, arg3, arg4);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

