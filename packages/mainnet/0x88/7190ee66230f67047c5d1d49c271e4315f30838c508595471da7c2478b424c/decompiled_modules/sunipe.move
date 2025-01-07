module 0x887190ee66230f67047c5d1d49c271e4315f30838c508595471da7c2478b424c::sunipe {
    struct SUNIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNIPE>(arg0, 6, b"Sunipe", b"Snipe AI", b"Analyzing Trading and Social Engagement Through AI to Provide Users with Information.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/istockphoto_914826904_612x612_7a7c0138dc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNIPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNIPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

