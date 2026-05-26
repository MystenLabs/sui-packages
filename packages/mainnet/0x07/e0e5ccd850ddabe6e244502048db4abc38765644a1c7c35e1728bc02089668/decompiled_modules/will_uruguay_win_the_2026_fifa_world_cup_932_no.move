module 0x7e0e5ccd850ddabe6e244502048db4abc38765644a1c7c35e1728bc02089668::will_uruguay_win_the_2026_fifa_world_cup_932_no {
    struct WILL_URUGUAY_WIN_THE_2026_FIFA_WORLD_CUP_932_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILL_URUGUAY_WIN_THE_2026_FIFA_WORLD_CUP_932_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILL_URUGUAY_WIN_THE_2026_FIFA_WORLD_CUP_932_NO>(arg0, 0, b"WILL_URUGUAY_WIN_THE_2026_FIFA_WORLD_CUP_932_NO", b"WILL_URUGUAY_WIN_THE_2026_FIFA_WORLD_CUP_932 NO", b"WILL_URUGUAY_WIN_THE_2026_FIFA_WORLD_CUP_932 NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILL_URUGUAY_WIN_THE_2026_FIFA_WORLD_CUP_932_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILL_URUGUAY_WIN_THE_2026_FIFA_WORLD_CUP_932_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

