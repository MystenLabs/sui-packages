module 0xa9028e25a46b0f2d088ab68ca21a3cf0e96cbab18b702c2bbfd2ece18c38e6b4::aleeous1 {
    struct ALEEOUS1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALEEOUS1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALEEOUS1>(arg0, 9, b"ALEEOUS1", b"Aleeous", b"A layer 2 with interoperability.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/36765050-564a-47a4-aa4a-868b92fda53d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALEEOUS1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALEEOUS1>>(v1);
    }

    // decompiled from Move bytecode v6
}

