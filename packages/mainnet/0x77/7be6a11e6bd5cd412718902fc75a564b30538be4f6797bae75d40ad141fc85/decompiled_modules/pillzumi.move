module 0x777be6a11e6bd5cd412718902fc75a564b30538be4f6797bae75d40ad141fc85::pillzumi {
    struct PILLZUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PILLZUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PILLZUMI>(arg0, 6, b"PILLZUMI", b"Pillzumi", b"Pillzumi merges AI and artistic expression, creating intelligent agents with unique personalities and evolving narratives. Unlike typical AI tools, our characters bring depth and creativity to an immersive experience. We ensure scalability and innovation at the intersection of technology and art.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/token_img_site_logo_3f831941f0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PILLZUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PILLZUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

