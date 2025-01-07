module 0xe4969adebeff2fd7f7debfaf679966cd054821a223f5b31fba4eb071dce69fdb::RissasRiverwayCirclet {
    struct RISSASRIVERWAYCIRCLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: RISSASRIVERWAYCIRCLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RISSASRIVERWAYCIRCLET>(arg0, 0, b"COS", b"Rissa's Riverway Circlet", b"A word? Or a favor? Please, for I am quite lost...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Rissas_Riverway_Circlet.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RISSASRIVERWAYCIRCLET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RISSASRIVERWAYCIRCLET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

