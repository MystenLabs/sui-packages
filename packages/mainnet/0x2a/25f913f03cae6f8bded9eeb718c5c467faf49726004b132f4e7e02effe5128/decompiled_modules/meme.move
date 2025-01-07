module 0x2a25f913f03cae6f8bded9eeb718c5c467faf49726004b132f4e7e02effe5128::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<MEME>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MEME>>(0x2::coin::split<MEME>(&mut arg0, arg1, arg3), arg2);
        if (0x2::coin::value<MEME>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MEME>>(arg0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<MEME>(arg0);
        };
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 9, b"MEME", b"MEME Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<MEME>>(0x2::coin::mint<MEME>(&mut v2, 8181054663, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

