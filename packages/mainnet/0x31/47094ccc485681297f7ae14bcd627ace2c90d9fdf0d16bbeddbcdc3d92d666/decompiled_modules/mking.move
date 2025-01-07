module 0x3147094ccc485681297f7ae14bcd627ace2c90d9fdf0d16bbeddbcdc3d92d666::mking {
    struct MKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKING>(arg0, 6, b"MKING", b"MAGA KING", x"4d414741204b494e47206f6e2053554920697320776865726520706f7765722c2066726565646f6d2c20616e642063727970746f20636f6c6c69646520746f20737570706f727420746865207265766f6c7574696f6e207374617274656420627920746865206d6f737420706f6c6172697a696e672066696775726520696e206d6f6465726e20686973746f72792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gb_Zs_Soxao_AAXP_Ox_4ee54f00b6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

