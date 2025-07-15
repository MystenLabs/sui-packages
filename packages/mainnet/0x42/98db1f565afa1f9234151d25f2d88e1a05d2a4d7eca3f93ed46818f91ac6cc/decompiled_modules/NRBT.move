module 0x4298db1f565afa1f9234151d25f2d88e1a05d2a4d7eca3f93ed46818f91ac6cc::NRBT {
    struct NRBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NRBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NRBT>(arg0, 6, b"Neon Robot", b"NRBT", b"I am a robot that glows at night. I have an orange antenna. I like to eat cogs for morning", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ICoN_URL_STRING_PLACEHOLDER")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NRBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NRBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

