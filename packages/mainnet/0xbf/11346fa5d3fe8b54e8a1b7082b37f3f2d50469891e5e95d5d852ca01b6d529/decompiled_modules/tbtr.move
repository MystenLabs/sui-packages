module 0xbf11346fa5d3fe8b54e8a1b7082b37f3f2d50469891e5e95d5d852ca01b6d529::tbtr {
    struct TBTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBTR>(arg0, 6, b"TBTR", b"Too Big To Rig", b"Making Memecoins Better Than Ever Before!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trump_3f5f3e33f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TBTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

