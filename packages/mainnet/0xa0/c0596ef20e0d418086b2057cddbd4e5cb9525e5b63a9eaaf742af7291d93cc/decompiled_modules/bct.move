module 0xa0c0596ef20e0d418086b2057cddbd4e5cb9525e5b63a9eaaf742af7291d93cc::bct {
    struct BCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCT>(arg0, 6, b"BCT", b"Blue Cyber Turtle", b"Silent, quiet, brave... this power cannot be stopped. This is our new warrior.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_27_11_30_51_6dee03d84f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

