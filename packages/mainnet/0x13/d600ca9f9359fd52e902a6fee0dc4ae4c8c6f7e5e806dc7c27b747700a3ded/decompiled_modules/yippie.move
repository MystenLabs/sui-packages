module 0x13d600ca9f9359fd52e902a6fee0dc4ae4c8c6f7e5e806dc7c27b747700a3ded::yippie {
    struct YIPPIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YIPPIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YIPPIE>(arg0, 6, b"YIPPIE", b"YIPPIE TOKIE", x"24594950504945202c2054686520656e642065766f6c7574696f6e206f662054424820437265617475726520262043757465737420446f6f646c65206f6e2074686520426c6f636b636861696e2e204920616d20616c736f2074686520556e6f6666696369616c204d6173636f7420666f722041757469736d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/t_UTLOX_2u_400x400_df845b848b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YIPPIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YIPPIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

