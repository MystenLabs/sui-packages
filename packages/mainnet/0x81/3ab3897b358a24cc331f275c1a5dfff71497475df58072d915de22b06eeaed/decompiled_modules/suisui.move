module 0x813ab3897b358a24cc331f275c1a5dfff71497475df58072d915de22b06eeaed::suisui {
    struct SUISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUI>(arg0, 6, b"SuiSui", b"SuiSui the guitar", x"53554953554920746865204755495441520a5468652062657374206d656d65206f6e20537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003878_b72759cc31.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

