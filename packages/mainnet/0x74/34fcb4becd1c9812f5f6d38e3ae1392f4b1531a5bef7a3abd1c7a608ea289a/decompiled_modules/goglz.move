module 0x7434fcb4becd1c9812f5f6d38e3ae1392f4b1531a5bef7a3abd1c7a608ea289a::goglz {
    struct GOGLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOGLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOGLZ>(arg0, 6, b"GOGLZ", b"SUI GOGGLES", b"GOGGLES ? GOGGLES ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_37801738e0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOGLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOGLZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

