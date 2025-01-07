module 0xa5bdc81437529ca558b0ef2801f06bf0e6294dabda7698a570c07205b482b6f6::standwich {
    struct STANDWICH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STANDWICH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STANDWICH>(arg0, 6, b"STANDWICH", b"Standwich", b"Standing sandwich ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_10_14_043910323_bbf85fed96.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STANDWICH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STANDWICH>>(v1);
    }

    // decompiled from Move bytecode v6
}

