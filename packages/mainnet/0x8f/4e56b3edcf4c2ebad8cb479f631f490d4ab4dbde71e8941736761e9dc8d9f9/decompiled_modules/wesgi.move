module 0x8f4e56b3edcf4c2ebad8cb479f631f490d4ab4dbde71e8941736761e9dc8d9f9::wesgi {
    struct WESGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WESGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WESGI>(arg0, 9, b"WESGI", b"weski", b"only meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b1fad7c5-51dd-44e0-b2ea-2e1af09d9f2d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WESGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WESGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

