module 0xf7dd48d5484af42b243c02ca9d64b5e82cba2aafa6e6570daa9ba8ab87e16d4::catdog {
    struct CATDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATDOG>(arg0, 6, b"CATDOG", b"SUI CAT DOG", b"just a cat in a dog suit!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/openart_image_D_Mgn_M5bb_1711393170176_raw_6588f342d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

