module 0x3bd1ef0b28885d88adcdae3e62c87f9a36a09b18b63d987a6606da9193fe7055::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEME>, arg1: vector<0x2::coin::Coin<MEME>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<MEME>>(&mut arg1);
        0x2::pay::join_vec<MEME>(&mut v0, arg1);
        0x2::coin::burn<MEME>(arg0, 0x2::coin::split<MEME>(&mut v0, arg2, arg3));
        if (0x2::coin::value<MEME>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MEME>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<MEME>(v0);
        };
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<MEME>(arg0, 6, b"MEME", b"MEME", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<MEME>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEME>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEME>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<MEME>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEME>>(arg0);
    }

    // decompiled from Move bytecode v6
}

