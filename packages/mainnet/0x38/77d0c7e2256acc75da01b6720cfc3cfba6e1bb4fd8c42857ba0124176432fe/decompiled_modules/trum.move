module 0x3877d0c7e2256acc75da01b6720cfc3cfba6e1bb4fd8c42857ba0124176432fe::trum {
    struct TRUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUM>(arg0, 6, b"TRUM", b"TRUMPY", b"TRUMPY IN DA HAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_Ie9_T5v4_400x400_3843b6f3fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

