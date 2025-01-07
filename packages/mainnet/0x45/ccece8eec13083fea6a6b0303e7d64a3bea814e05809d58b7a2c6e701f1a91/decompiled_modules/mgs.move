module 0x45ccece8eec13083fea6a6b0303e7d64a3bea814e05809d58b7a2c6e701f1a91::mgs {
    struct MGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGS>(arg0, 9, b"MGS", b"MANGOSTEEN", x"47726f757020747261646520c491e1bb896e68206e68e1baa5742063c3a1692074656c65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0dd52cf-abf5-4227-a67d-5dc7ef1a775e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

