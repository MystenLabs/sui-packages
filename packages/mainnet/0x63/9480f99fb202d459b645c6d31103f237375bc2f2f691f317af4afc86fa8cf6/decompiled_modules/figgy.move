module 0x639480f99fb202d459b645c6d31103f237375bc2f2f691f317af4afc86fa8cf6::figgy {
    struct FIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIGGY>(arg0, 6, b"FIGGY", b"BLUE FIGGY", b"Fish and piggy is best combination on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3886_bdddf2a8b2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

