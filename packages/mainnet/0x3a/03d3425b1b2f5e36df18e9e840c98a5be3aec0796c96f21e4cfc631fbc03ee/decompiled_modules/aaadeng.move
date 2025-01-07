module 0x3a03d3425b1b2f5e36df18e9e840c98a5be3aec0796c96f21e4cfc631fbc03ee::aaadeng {
    struct AAADENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADENG>(arg0, 6, b"AAADENG", b"aaa deng", b"Can't stop won't stop (thinking about Sui Moo Deng)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaa_deng_916e13bbeb.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

