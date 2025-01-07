module 0xcbe3373399fc04930bf72f19c4d539c28cd06abb35f76b5dd72aac26a481757b::gun {
    struct GUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUN>(arg0, 6, b"GUN", b"gunsui", b"$GUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fo_N_Ycjip_400x400_1695244e79.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

