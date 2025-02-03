module 0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::ywhusdte {
    struct YWHUSDTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YWHUSDTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YWHUSDTE>(arg0, 6, b"yUSDT", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YWHUSDTE>>(v1);
        0x2::transfer::public_transfer<0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::AdminCap<YWHUSDTE>>(0xf226eea7b5c1d879305cabf779c97337c8b8d37baaa04cbe75b90e85d22eb323::vault::new<0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN, YWHUSDTE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

