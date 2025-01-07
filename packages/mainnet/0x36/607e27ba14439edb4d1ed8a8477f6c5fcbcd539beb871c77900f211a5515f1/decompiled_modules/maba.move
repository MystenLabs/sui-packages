module 0x36607e27ba14439edb4d1ed8a8477f6c5fcbcd539beb871c77900f211a5515f1::maba {
    struct MABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MABA>(arg0, 6, b"MABA", b"MABA ON SUI", x"5765276c6c2057494e200a5945532057452057494c4c2120416c736f2077697468204f4720244d414241200a526576657273616c206f662061206c69666574696d6520697320636f6d696e6720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZSJ_Tai_X0_AE_Jvda_e0af86fdda.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

