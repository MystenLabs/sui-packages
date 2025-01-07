module 0x40f90ed4a8c093528431cce8ebe9c8140fc78e8df466c6fd0cb19df833c7cc9e::ASnowyAdornment {
    struct ASNOWYADORNMENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASNOWYADORNMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASNOWYADORNMENT>(arg0, 0, b"COS", b"A Snowy Adornment", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_A_Snowy_Adornment.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASNOWYADORNMENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASNOWYADORNMENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

