module 0xc20b98956e2af3049874225f01e608f87f655b16c8bb6362a9079e2cb2d9ea9c::ysui {
    struct YSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YSUI>(arg0, 9, b"ySUI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YSUI>>(v1);
        0x2::transfer::public_transfer<0xc20b98956e2af3049874225f01e608f87f655b16c8bb6362a9079e2cb2d9ea9c::vault::AdminCap<YSUI>>(0xc20b98956e2af3049874225f01e608f87f655b16c8bb6362a9079e2cb2d9ea9c::vault::new<0x2::sui::SUI, YSUI>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

