module 0x5cd1f834478ce94cadc96740f01db3f32710ddce6dcb10aa0371daa7cae2575::catbowl {
    struct CATBOWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBOWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATBOWL>(arg0, 6, b"CATBOWL", b"CAT BOWL", b"Just Cat on Bowl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/swwswswsw_3cf4640588.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATBOWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATBOWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

