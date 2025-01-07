module 0x4bd9e5b32a97e8c30f96670444027b53949914d18d7d322e6842f727e597146f::acv {
    struct ACV has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACV>(arg0, 9, b"ACV", b"ASF", b"TRJH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b58a240d-5917-4b06-a313-c2e4e13e10be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACV>>(v1);
    }

    // decompiled from Move bytecode v6
}

