module 0x8ca8c282ea76cd7d5cbc09730886511220f0c180f7789e013cd14b51ca2af7cc::rudo {
    struct RUDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUDO>(arg0, 6, b"RUDO", b"Rudo", b"Rudo has magical powers since birth, his natural habitat may be in the sky but he also has abilities in the ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000071332_0896421cab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

