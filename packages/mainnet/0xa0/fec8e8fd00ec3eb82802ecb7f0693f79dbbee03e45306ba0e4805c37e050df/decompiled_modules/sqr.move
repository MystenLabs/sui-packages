module 0xa0fec8e8fd00ec3eb82802ecb7f0693f79dbbee03e45306ba0e4805c37e050df::sqr {
    struct SQR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQR>(arg0, 9, b"SQR", b"SuiSquirre", b"SuiSquirrel is a meme token for the Sui blockchain community, featuring a playful squirrel mascot harnessing the power of the Sui ecosystem. This token brings joy and entertainment to users in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d9212e92-53e0-4954-ab4f-7484b02baead.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQR>>(v1);
    }

    // decompiled from Move bytecode v6
}

