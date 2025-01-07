module 0xb72688e4685bee43f0dc24c5408646b0a9ef14ed655f8d4b25b0599dc75d2640::mario {
    struct MARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIO>(arg0, 6, b"MARIO", b"First Mario on Sui", b"THE LEGENDARY HERO OF THE GALAXY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mario_img_2_ec68b7cad8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

