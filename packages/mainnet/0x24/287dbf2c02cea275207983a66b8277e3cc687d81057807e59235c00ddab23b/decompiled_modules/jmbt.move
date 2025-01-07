module 0x24287dbf2c02cea275207983a66b8277e3cc687d81057807e59235c00ddab23b::jmbt {
    struct JMBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JMBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JMBT>(arg0, 9, b"JMBT", b"Jembooot", b"Halah mboooottt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c191c37-495f-47ba-aae2-00679d2d7c25.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JMBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JMBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

