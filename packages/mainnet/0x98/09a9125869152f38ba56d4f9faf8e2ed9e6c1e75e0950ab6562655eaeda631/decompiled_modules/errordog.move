module 0x9809a9125869152f38ba56d4f9faf8e2ed9e6c1e75e0950ab6562655eaeda631::errordog {
    struct ERRORDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERRORDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERRORDOG>(arg0, 6, b"ERRORDOG", b"ERROR DOG 404", b"SYSTEM GIVEN AN ERROR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dubo_fwog_gm_2ba54e41b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERRORDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERRORDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

