module 0xc5280902b79577eddaddc5bfb7d9cb9e976576d7b271768e22131c5b4ebd93f7::hopcat {
    struct HOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCAT>(arg0, 6, b"HopCat", b"HopCatSui", x"486f704361740a68747470733a2f2f782e636f6d2f686f706361747375690a68747470733a2f2f742e6d652f486f7043436865636b5f626f74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zm_P_Sh_XWQAEV_2oc_8dcf9569fc.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

