module 0xad421271913607cab135184481d65d25f10b3ef4464004fe6333930503404e3d::mjsui2 {
    struct MJSUI2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MJSUI2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MJSUI2>(arg0, 9, b"MJSUI2", b"muSUI_2", b"This LST is for MJ ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MJSUI2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MJSUI2>>(v1);
    }

    // decompiled from Move bytecode v6
}

