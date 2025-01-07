module 0xb5cb8d641f03625a1bdea65bfed906c70f7c70afe62b845e27c485e2d3950a1d::pugg1000 {
    struct PUGG1000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGG1000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGG1000>(arg0, 6, b"PUGG1000", b"Pugg1000", b"Pug dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000096_26a04c0b38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGG1000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGG1000>>(v1);
    }

    // decompiled from Move bytecode v6
}

