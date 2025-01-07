module 0xc9b779760b7d6fe662f388acfe5ce3295b7c5ae15df3ef3c77e4d0ec6115ccd3::starfish {
    struct STARFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARFISH>(arg0, 6, b"STARFISH", b"Starfish the Star", x"5354415246495348206973206865726520746f207368696e65206272696768746572207468616e207468652072657374206f6e2074686520537569206e6574776f726b2e20426520612070617274206f66205354415246495348277320676c6f77206173206974206d616b657320697473206d61726b20696e2074686520537569206f6365616e210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_59_287f677075.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

