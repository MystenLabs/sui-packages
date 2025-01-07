module 0xaa12897f575581114cd315000b8ef5508e7aea3b5d9bd63f44d1ae99b6ba17d3::sksk {
    struct SKSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKSK>(arg0, 6, b"Sksk", b"sksksk", b"sksksksksksksksksksksk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sksksksks_7f936c3626.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

