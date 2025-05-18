module 0x48ac510f697d604d887550e8b9391c09c2efd3252a73f48008750013644e0bb9::btc21_deployer {
    public entry fun deploy(arg0: &mut 0x2::coin::TreasuryCap<0x48ac510f697d604d887550e8b9391c09c2efd3252a73f48008750013644e0bb9::btc21_token::BTC21>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 21000000000;
        let v1 = 3150000000;
        let v2 = 3150000000;
        let v3 = 0x2::coin::mint<0x48ac510f697d604d887550e8b9391c09c2efd3252a73f48008750013644e0bb9::btc21_token::BTC21>(arg0, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x48ac510f697d604d887550e8b9391c09c2efd3252a73f48008750013644e0bb9::btc21_token::BTC21>>(0x2::coin::split<0x48ac510f697d604d887550e8b9391c09c2efd3252a73f48008750013644e0bb9::btc21_token::BTC21>(&mut v3, v0 - v1 - v2 - 6300000000, arg1), @0x42216264b95739e181feb2fac36e72a02971271e846b9a56dbada2fdf0addc9b);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x48ac510f697d604d887550e8b9391c09c2efd3252a73f48008750013644e0bb9::btc21_token::BTC21>>(0x2::coin::split<0x48ac510f697d604d887550e8b9391c09c2efd3252a73f48008750013644e0bb9::btc21_token::BTC21>(&mut v3, v1, arg1), @0xe3b920a033d2bc2ea8c52391e9096c1e8d755e3ad2fa74ecfd6402df606118cd);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x48ac510f697d604d887550e8b9391c09c2efd3252a73f48008750013644e0bb9::btc21_token::BTC21>>(0x2::coin::split<0x48ac510f697d604d887550e8b9391c09c2efd3252a73f48008750013644e0bb9::btc21_token::BTC21>(&mut v3, v2, arg1), @0x54593d347979399ee5ceda84e806c75abd08fb1872b8ecc86f6d77d1683b5931);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x48ac510f697d604d887550e8b9391c09c2efd3252a73f48008750013644e0bb9::btc21_token::BTC21>>(v3, @0xbcfa3fa91f6d5dca36f84dceb00ac524363280b0a49c1a200ac44dc719eb036a);
    }

    // decompiled from Move bytecode v6
}

