module 0xd46c8a2b205c3680beedd2f5d1caaf44d0eb4ff46204bb3a0c08b7c1ea2757e3::will_spain_win_the_2026_fifa_world_cup_963_no {
    struct WILL_SPAIN_WIN_THE_2026_FIFA_WORLD_CUP_963_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILL_SPAIN_WIN_THE_2026_FIFA_WORLD_CUP_963_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILL_SPAIN_WIN_THE_2026_FIFA_WORLD_CUP_963_NO>(arg0, 0, b"WILL_SPAIN_WIN_THE_2026_FIFA_WORLD_CUP_963_NO", b"WILL_SPAIN_WIN_THE_2026_FIFA_WORLD_CUP_963 NO", b"WILL_SPAIN_WIN_THE_2026_FIFA_WORLD_CUP_963 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILL_SPAIN_WIN_THE_2026_FIFA_WORLD_CUP_963_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILL_SPAIN_WIN_THE_2026_FIFA_WORLD_CUP_963_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

