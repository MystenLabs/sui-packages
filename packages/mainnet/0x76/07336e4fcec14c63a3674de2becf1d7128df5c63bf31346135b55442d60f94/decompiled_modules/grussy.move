module 0x7607336e4fcec14c63a3674de2becf1d7128df5c63bf31346135b55442d60f94::grussy {
    struct GRUSSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUSSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUSSY>(arg0, 6, b"GRUSSY", b"GRUSSSY", b"Time of that year again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/the_grussy_why_does_this_exist_v0_vgrup6oiy2hc1_b3393e547b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUSSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRUSSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

