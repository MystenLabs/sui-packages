module 0x1e4f3e6b7ffe609e56865856685d6278299f8a54671100faf03015166b4376f2::fusd {
    struct FUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUSD>(arg0, 6, b"FUSD", b"Fake USD", b"Fake USD token for testing", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FUSD>>(0x2::coin::mint<FUSD>(&mut v2, 100000000000000, arg1), @0x1d92520c51971dcdb52fed9d191a8d30a29c5138d3995a50dc54ba3f38a821d2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUSD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUSD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

