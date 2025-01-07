module 0x4bfc8bde4eada98a5e344606b002cd94cc496a4627027c9a3d4bc0fe0cd204d3::suiwomen {
    struct SUIWOMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWOMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWOMEN>(arg0, 6, b"SUIWOMEN", b"Sui Women", x"53756920576f6d656e2069732061206d656d65746f6b656e206f6e2053556920626c6f636b636861696e20666f7220616c6c200a0a576f6d656e2066697273740a0a576f6d656e2061747472616374206d656e200a0a576f6d656e206c6f7665732062757920537569776f6d656e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiwomen_high_resolution_logo_0f90133bdd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWOMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWOMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

