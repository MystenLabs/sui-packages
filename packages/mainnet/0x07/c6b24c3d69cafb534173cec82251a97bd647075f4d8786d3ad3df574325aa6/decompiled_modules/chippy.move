module 0x7c6b24c3d69cafb534173cec82251a97bd647075f4d8786d3ad3df574325aa6::chippy {
    struct CHIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIPPY>(arg0, 6, b"CHIPPY", b"ChippyonSUI", b"Hey, I'm Chippy, the wildest chipmunk you'll ever meet..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_KZTS_582_400x400_9e0fe04dbc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

