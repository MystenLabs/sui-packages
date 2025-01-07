module 0x34c1fbf2f0fef8b0aea0f8c8c2bc101116168102fb796fea3dfe96d035246c3f::fuddy {
    struct FUDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDDY>(arg0, 6, b"Fuddy", b"Fuddies", b"FUD around and find out", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ft_Ctav_N_Wc_AAY_5_B7_2d579dc2cc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

