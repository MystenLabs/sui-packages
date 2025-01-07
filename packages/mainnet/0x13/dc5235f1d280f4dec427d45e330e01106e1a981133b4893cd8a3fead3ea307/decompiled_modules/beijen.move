module 0x13dc5235f1d280f4dec427d45e330e01106e1a981133b4893cd8a3fead3ea307::beijen {
    struct BEIJEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEIJEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEIJEN>(arg0, 9, b"BEIJEN", b"bs sn", b"bsjwkn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ad4f1289-66b9-44a6-96ec-80a24adcf88e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEIJEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEIJEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

