module 0x73a5d8ef9e6138067ca106045399cdcc5c7e326d84b01b7034a37d25e231bdea::pgt {
    struct PGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PGT>(arg0, 6, b"PGT", b"PEGUEOT", b"The best car on the world !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_50406913_13d3770b17.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

