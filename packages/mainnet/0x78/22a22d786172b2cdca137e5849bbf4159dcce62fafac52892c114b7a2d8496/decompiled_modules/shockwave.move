module 0x7822a22d786172b2cdca137e5849bbf4159dcce62fafac52892c114b7a2d8496::shockwave {
    struct SHOCKWAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOCKWAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOCKWAVE>(arg0, 9, b"SHOCKWAVE", b"Shock Wave", b"What happens when 99% of the supply is out of circulation? Let's find out. | Website: https://api.interestlabs.io/files/410e22537adbbefc72eaf8b900c4585d7cd910dcc81ed674.jpg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.interestlabs.io/files/410e22537adbbefc72eaf8b900c4585d7cd910dcc81ed674.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOCKWAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOCKWAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

