module 0x9bf33b922544d649036448364030acc80c12d5411162d85e1ced5581926985c5::golden_meme {
    struct GOLDEN_MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDEN_MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDEN_MEME>(arg0, 9, b"DogeGold", b"The Golden Meme", b"The Golden Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775501367196-d2b5ca33bd970f64a6301fa75ae2eb22.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<GOLDEN_MEME>>(0x2::coin::mint<GOLDEN_MEME>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOLDEN_MEME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDEN_MEME>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

