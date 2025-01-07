module 0xf0e5154ad41dafce2c978b18102b5bbbbf390ab8fa02504519918c12022ee61f::vsn {
    struct VSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VSN>(arg0, 6, b"Vsn", b"Vishnu", b"God is consciousness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002649_5047d1bd12.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

