module 0xfb88bbece93919169c682426818681b8fb9e6320089d44873a29ca6b5ba4f663::cfish {
    struct CFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFISH>(arg0, 6, b"CFISH", b"Cowfish Sui", b"Popular meme Cowfish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5d3be926e1f8f4ff5e356e3d0ec737f9_a949d6af05.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

