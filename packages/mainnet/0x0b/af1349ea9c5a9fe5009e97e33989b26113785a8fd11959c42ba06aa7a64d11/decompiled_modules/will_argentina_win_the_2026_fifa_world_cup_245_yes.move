module 0xbaf1349ea9c5a9fe5009e97e33989b26113785a8fd11959c42ba06aa7a64d11::will_argentina_win_the_2026_fifa_world_cup_245_yes {
    struct WILL_ARGENTINA_WIN_THE_2026_FIFA_WORLD_CUP_245_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILL_ARGENTINA_WIN_THE_2026_FIFA_WORLD_CUP_245_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILL_ARGENTINA_WIN_THE_2026_FIFA_WORLD_CUP_245_YES>(arg0, 0, b"WILL_ARGENTINA_WIN_THE_2026_FIFA_WORLD_CUP_245_YES", b"WILL_ARGENTINA_WIN_THE_2026_FIFA_WORLD_CUP_245 YES", b"WILL_ARGENTINA_WIN_THE_2026_FIFA_WORLD_CUP_245 YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILL_ARGENTINA_WIN_THE_2026_FIFA_WORLD_CUP_245_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILL_ARGENTINA_WIN_THE_2026_FIFA_WORLD_CUP_245_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

