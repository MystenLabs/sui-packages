module 0x977fd57190d3f047d82fad9063330ac9e97229bbacdfafc1376990bbf015f81::ccc {
    struct CCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCC>(arg0, 6, b"CCC", b"ccc", b"This is CCC.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_101a18be79.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

