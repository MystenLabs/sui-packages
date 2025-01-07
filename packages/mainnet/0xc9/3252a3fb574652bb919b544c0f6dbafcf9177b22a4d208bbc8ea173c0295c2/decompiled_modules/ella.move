module 0xc93252a3fb574652bb919b544c0f6dbafcf9177b22a4d208bbc8ea173c0295c2::ella {
    struct ELLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELLA>(arg0, 6, b"ELLA", b"ELLA SUI", b"Watch ELLA grow with SUI, community driven ELLA dives straight in to thrive on the SUI ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6484_c8e0aa5169.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

