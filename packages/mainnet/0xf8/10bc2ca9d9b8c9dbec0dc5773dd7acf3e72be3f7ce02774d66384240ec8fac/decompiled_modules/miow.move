module 0xf810bc2ca9d9b8c9dbec0dc5773dd7acf3e72be3f7ce02774d66384240ec8fac::miow {
    struct MIOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIOW>(arg0, 6, b"MIOW", b"MIOW THE PEPES CAT", b"MIOW THE PEPE'S CAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7851_bb9c2072af.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

