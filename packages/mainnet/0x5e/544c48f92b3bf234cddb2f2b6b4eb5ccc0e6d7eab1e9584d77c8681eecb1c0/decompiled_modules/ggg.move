module 0x5e544c48f92b3bf234cddb2f2b6b4eb5ccc0e6d7eab1e9584d77c8681eecb1c0::ggg {
    struct GGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGG>(arg0, 6, b"GGG", b"GG", b"GGGGGG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ellipse_279_f028ba71a7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

