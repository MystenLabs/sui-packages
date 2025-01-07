module 0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::ysui {
    struct YSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YSUI>(arg0, 9, b"ySUI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YSUI>>(v1);
        0x2::transfer::public_transfer<0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::AdminCap<YSUI>>(0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::new<0x2::sui::SUI, YSUI>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

