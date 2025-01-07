module 0x5877caebd8e3b4a930248ce5619408a8a39455314c48c58f509c33fefa2ba720::memedi {
    struct MEMEDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEDI>(arg0, 9, b"MEMEDI", b"Meme Dino ", b"Meme Dino World ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f6b4154e-57b1-4280-94d4-2a0a0758920d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

