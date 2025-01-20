module 0x5082e92ccdcbeb3e8d5331ac835fcd328e5d0b5c188dea3c5d0f830f23a7fe44::dtd {
    struct DTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTD>(arg0, 6, b"DTD", b"Trump dance", b"Fan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1049_93e0fce430.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

