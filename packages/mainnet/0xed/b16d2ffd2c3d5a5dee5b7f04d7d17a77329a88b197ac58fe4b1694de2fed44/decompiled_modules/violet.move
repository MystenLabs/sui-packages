module 0xedb16d2ffd2c3d5a5dee5b7f04d7d17a77329a88b197ac58fe4b1694de2fed44::violet {
    struct VIOLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIOLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIOLET>(arg0, 6, b"VIOLET", b"violet", b"revolutionizing crypto analysis, token discovery, and on-chain data intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2224_d8855122bf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIOLET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIOLET>>(v1);
    }

    // decompiled from Move bytecode v6
}

