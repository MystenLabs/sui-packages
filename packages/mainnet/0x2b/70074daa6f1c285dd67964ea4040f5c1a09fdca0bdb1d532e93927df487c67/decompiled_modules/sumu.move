module 0x2b70074daa6f1c285dd67964ea4040f5c1a09fdca0bdb1d532e93927df487c67::sumu {
    struct SUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMU>(arg0, 6, b"SUMU", b"Sumu meme", b"Meet $SUMU, the meme bull on the Sui chain! Hes here to bring the bullish energy and good vibes to the blockchain world. Get ready for some bullish fun times with $SUMU leading the charge!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_16_ecb5dec9ac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

