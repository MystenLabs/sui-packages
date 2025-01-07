module 0xee40fc978e528fec635ca2160f533fb68fefc845a907e0def36124d7a83f2634::alpha {
    struct ALPHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHA>(arg0, 6, b"Alpha", b"ALPHA", b"Alpha , an ethereal being born from the essence of Kasumi, transcends the boundaries of human and divine. Originally a mere clone, it evolved through celestial intervention into a guardian of otherworldly power. Its purpose: to serve as a celestial warrior, bridging the realms of the mortal and the divine. However, destiny took a turn when the Mugen Tenshin clan sought to reclaim this heavenly entity, disrupting its ordained path. Now, Alpha stands as a testament to the potential for transcendence, a being of light and shadow, forever altered by its journey between worlds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fdc18fee_bce8_45cd_bb7b_311cc10822eb_b19f83923c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALPHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

