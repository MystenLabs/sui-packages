module 0x57d1815913dca955f4e2f814f139edf06617aac46c5ce4701e0d2de201b67c90::ceuli {
    struct CEULI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEULI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEULI>(arg0, 9, b"CEULI", b"Ceuli", b"Ceuli oray", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c85b8682-141e-44f2-812e-7f74eff45d82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEULI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CEULI>>(v1);
    }

    // decompiled from Move bytecode v6
}

