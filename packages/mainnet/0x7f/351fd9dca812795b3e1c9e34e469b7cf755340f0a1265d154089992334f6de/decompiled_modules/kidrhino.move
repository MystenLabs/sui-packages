module 0x7f351fd9dca812795b3e1c9e34e469b7cf755340f0a1265d154089992334f6de::kidrhino {
    struct KIDRHINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIDRHINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIDRHINO>(arg0, 6, b"KIDRHINO", b"Tinny the Rhino", b"Meet Tinny! The newest Baby Rhino in town.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tin_d428434a0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIDRHINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIDRHINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

