module 0x87445a799356134969f64e7b67b0a285405e1229550e9e90c8ae8b9d47b5e1b3::haloooweeen {
    struct HALOOOWEEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALOOOWEEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALOOOWEEEN>(arg0, 6, b"HALOOOWEEEN", b"SPOOKY", b"We Only Accept Diamond Hands Sui, no paper hands.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jack_o_Lantern_2003_10_31_aeccebc2b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALOOOWEEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALOOOWEEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

