module 0x443968a1f417e327fbdbd770785703295b8e1bafd70df059d6934449be56b0cb::tickermeme {
    struct TICKERMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKERMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKERMEME>(arg0, 9, b"TICKERMEME", b"memefo", b"asw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/50b06eb3-9b95-4990-97e3-1df8d3c798c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKERMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TICKERMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

