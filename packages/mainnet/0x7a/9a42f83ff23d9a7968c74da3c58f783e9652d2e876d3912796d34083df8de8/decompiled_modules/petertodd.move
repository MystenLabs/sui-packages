module 0x7a9a42f83ff23d9a7968c74da3c58f783e9652d2e876d3912796d34083df8de8::petertodd {
    struct PETERTODD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PETERTODD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETERTODD>(arg0, 6, b"PETERTODD", b"SATOSHI NAKAMOTO", b"THE BITCOIN CREATOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_07_00_55_5badc8678d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETERTODD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PETERTODD>>(v1);
    }

    // decompiled from Move bytecode v6
}

