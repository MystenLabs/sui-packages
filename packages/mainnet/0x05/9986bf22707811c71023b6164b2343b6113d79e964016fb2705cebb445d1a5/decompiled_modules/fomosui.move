module 0x59986bf22707811c71023b6164b2343b6113d79e964016fb2705cebb445d1a5::fomosui {
    struct FOMOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMOSUI>(arg0, 6, b"FOMOSUI", b"FOMO SUI", b"FOMOSUI is a platform designed to make token creation accessible to everyone. Our platform allows you to easily create, customize, and launch your own tokens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fomoaa_cef060e27b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

