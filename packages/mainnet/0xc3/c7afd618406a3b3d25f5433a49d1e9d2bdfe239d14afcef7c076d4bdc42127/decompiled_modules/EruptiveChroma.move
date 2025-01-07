module 0xc3c7afd618406a3b3d25f5433a49d1e9d2bdfe239d14afcef7c076d4bdc42127::EruptiveChroma {
    struct ERUPTIVECHROMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERUPTIVECHROMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERUPTIVECHROMA>(arg0, 0, b"COS", b"Eruptive Chroma", b"Steeped in the lava flow... the melting restoration... Do you remember?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Eruptive_Chroma.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERUPTIVECHROMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERUPTIVECHROMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

