module 0x1b7b95a2029ae93cdaa9eb81586c8e18c5d22ed3fbfe0364dd6e9cfadd9613ee::suisse {
    struct SUISSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISSE>(arg0, 6, b"Suisse", b"Action Suisse", b"Action Suisse Network. Join TELEGRAM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d9d75867_1daa_4d33_ba04_e90a826b0938_83824b6330.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

