module 0x28c232ea858b5bbc8414c13ac560613fe9c24ee8ee04cfaf76ea8aa4e8cdc081::bbfud {
    struct BBFUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBFUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBFUD>(arg0, 6, b"BBFUD", b"BB FUD", b"HELLO IM BABY FUD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x76cb819b01abed502bee8a702b4c2d547532c12f25001c9dea795a5e631c26f1_fud_fud_1_b851bd09da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBFUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBFUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

