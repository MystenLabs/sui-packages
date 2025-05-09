module 0x4495b8466130819d3604db0724444ea4422c9d201e45b93bd3b2dd3b9d95b47d::suilight {
    struct SUILIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILIGHT>(arg0, 6, b"SUILIGHT", b"SuiLight", b"Water and light merge and make the suelight even stronger and more energized ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000089303_fe2e0e3dfc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

