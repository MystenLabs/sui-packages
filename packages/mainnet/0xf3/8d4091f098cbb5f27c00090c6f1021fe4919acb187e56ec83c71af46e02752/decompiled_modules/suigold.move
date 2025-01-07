module 0xf38d4091f098cbb5f27c00090c6f1021fe4919acb187e56ec83c71af46e02752::suigold {
    struct SUIGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOLD>(arg0, 6, b"SUIGOLD", b"Suigold", b"Discover SUIGOLD, the digital gold of the Sui ecosystem. Maximize your investments with tomorrow's precious asset, designed to shine on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049610_15c7e72495.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

