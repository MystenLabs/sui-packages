module 0x9937df51d032f46985e8242b45ee3b961654dff9f55be41327dbe771f32e4573::TrovestainedGaze {
    struct TROVESTAINEDGAZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROVESTAINEDGAZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROVESTAINEDGAZE>(arg0, 0, b"COS", b"Trove-stained Gaze", b"What you see... it is beauty, it is power, it is majestic... No?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Trove-stained_Gaze.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROVESTAINEDGAZE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROVESTAINEDGAZE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

