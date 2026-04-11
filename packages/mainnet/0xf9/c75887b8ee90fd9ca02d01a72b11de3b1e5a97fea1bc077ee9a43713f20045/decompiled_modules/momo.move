module 0xf9c75887b8ee90fd9ca02d01a72b11de3b1e5a97fea1bc077ee9a43713f20045::momo {
    struct MOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMO>(arg0, 6, b"MOMO", b"Momo Coin", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOMO>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOMO>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOMO>>(v2);
    }

    // decompiled from Move bytecode v6
}

