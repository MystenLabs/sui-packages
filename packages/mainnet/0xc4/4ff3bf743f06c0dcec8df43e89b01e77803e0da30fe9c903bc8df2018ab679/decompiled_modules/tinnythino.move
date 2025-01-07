module 0xc44ff3bf743f06c0dcec8df43e89b01e77803e0da30fe9c903bc8df2018ab679::tinnythino {
    struct TINNYTHINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TINNYTHINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TINNYTHINO>(arg0, 6, b"TinnyThino", b"Tinny the Rhino", b"Meet Tinny! The newest Baby Rhino in town.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tin_d428434a0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TINNYTHINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TINNYTHINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

