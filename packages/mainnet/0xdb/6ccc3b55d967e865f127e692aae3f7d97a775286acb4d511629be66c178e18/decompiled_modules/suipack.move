module 0xdb6ccc3b55d967e865f127e692aae3f7d97a775286acb4d511629be66c178e18::suipack {
    struct SUIPACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPACK>(arg0, 6, b"SUIPACK", b"SUPACK", b"Alright, so $SUIPACK just kinda floating around, doing its thing, chillin like a lazy cyan duck on a calm pond.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GP_Kk_B55b_UAA_96_E4_copy_0e38a384e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

