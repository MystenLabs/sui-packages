module 0x1cf0645c821ca63212680120f3e8e939add266953356650bda4995effdba8498::OceanaEyes {
    struct OCEANAEYES has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEANAEYES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCEANAEYES>(arg0, 0, b"COS", b"Oceana Eyes", b"Travel... go far... but stray not from the lamplight...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Oceana_Eyes.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCEANAEYES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCEANAEYES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

