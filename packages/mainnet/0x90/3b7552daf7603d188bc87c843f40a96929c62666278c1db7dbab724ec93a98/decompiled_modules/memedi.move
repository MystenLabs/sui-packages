module 0x903b7552daf7603d188bc87c843f40a96929c62666278c1db7dbab724ec93a98::memedi {
    struct MEMEDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEDI>(arg0, 9, b"MEMEDI", b"Meme Dino ", b"Meme Dino World ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d418d45c-a4e0-4bee-a761-fc5efc48d1b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

