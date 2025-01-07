module 0x31de54cbb7752e2c796e75ed2ef02a4cf22613ac8f2657c1b8b52548499654af::tgirl {
    struct TGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGIRL>(arg0, 9, b"TGIRL", b"TattoGirl", b"Meme of AI TATTO GIRL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b36a72d1-a0b9-4855-a74a-8bc2bf0aafab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGIRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGIRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

