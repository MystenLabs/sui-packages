module 0x5f0beaf4b64a9e3aa4fab330bbe44e73a7a0fc927da68e3e1edd8eeb651bd433::gnrl {
    struct GNRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GNRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GNRL>(arg0, 9, b"GNRL", b"GENERAL", b"GENERAL MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/140821ae-4d79-4c0d-b1ae-39394d67a6bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GNRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GNRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

