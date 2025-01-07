module 0xcad3d190c2b1c0ee4d39a34af20a5148251beb4347bc4721dfcf874a5028bd51::odsc {
    struct ODSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODSC>(arg0, 6, b"OdsC", b"Oopsui DOopsui Suiowwy Cat", b"Suiwwy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3856_0bad5df2b6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ODSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

