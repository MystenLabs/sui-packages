module 0x6dde8b2dbb619e85220c0412d44370d4a32d7f8918047ef5f3bf6b1608d02276::emojicoin {
    struct EMOJICOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<EMOJICOIN>, arg1: vector<0x2::coin::Coin<EMOJICOIN>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<EMOJICOIN>>(&mut arg1);
        0x2::pay::join_vec<EMOJICOIN>(&mut v0, arg1);
        0x2::coin::burn<EMOJICOIN>(arg0, 0x2::coin::split<EMOJICOIN>(&mut v0, arg2, arg3));
        if (0x2::coin::value<EMOJICOIN>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<EMOJICOIN>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<EMOJICOIN>(v0);
        };
    }

    fun init(arg0: EMOJICOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmUDQ2Xou7tHFYzptzxcVAq1DzCo1oqrwSoZ685AUssyAs"));
        let (v2, v3) = 0x2::coin::create_currency<EMOJICOIN>(arg0, 8, b"EMO", b"emojicoin", b"EMOCOIN(EMO) IS LITERALLY A MEME COIN.NO UTILITY. NO ROADMAP. NO PROMISES.NO EXPECTATION OF FINANCIAL RETURN.JUST 100% MEMES.", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMOJICOIN>>(v3);
        0x2::coin::mint_and_transfer<EMOJICOIN>(&mut v4, 10000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMOJICOIN>>(v4, v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EMOJICOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EMOJICOIN>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<EMOJICOIN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<EMOJICOIN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

