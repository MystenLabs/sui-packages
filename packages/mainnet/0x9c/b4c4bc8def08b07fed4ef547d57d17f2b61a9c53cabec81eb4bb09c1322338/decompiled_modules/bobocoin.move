module 0x9cb4c4bc8def08b07fed4ef547d57d17f2b61a9c53cabec81eb4bb09c1322338::bobocoin {
    struct BOBOCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBOCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBOCOIN>(arg0, 9, b"BOBOCOIN", b"BOBO", b"Bobocoin top meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/485a64ac-04f5-4200-851d-0492903c9fe2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBOCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBOCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

