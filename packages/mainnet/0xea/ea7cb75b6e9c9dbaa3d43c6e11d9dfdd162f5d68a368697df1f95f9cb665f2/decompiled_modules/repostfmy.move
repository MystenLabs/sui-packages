module 0xeaea7cb75b6e9c9dbaa3d43c6e11d9dfdd162f5d68a368697df1f95f9cb665f2::repostfmy {
    struct REPOSTFMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: REPOSTFMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REPOSTFMY>(arg0, 6, b"Repostfmy", b"sui Repost Cat", b"lets Repost ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_29_15_08_53_2_b4cdeba3c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REPOSTFMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REPOSTFMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

