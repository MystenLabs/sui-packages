module 0x29b989de9c673ba60027b64a284d08e457c7227d4ddf75b03045e5a8bdfd4bd5::ywhusdte {
    struct YWHUSDTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YWHUSDTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YWHUSDTE>(arg0, 6, b"yUSDT", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YWHUSDTE>>(v1);
        0x2::transfer::public_transfer<0x29b989de9c673ba60027b64a284d08e457c7227d4ddf75b03045e5a8bdfd4bd5::vault::AdminCap<YWHUSDTE>>(0x29b989de9c673ba60027b64a284d08e457c7227d4ddf75b03045e5a8bdfd4bd5::vault::new<0xc060006111016b8a020ad5b33834984a437aaa7d3c74c18e09a95d48aceab08c::coin::COIN, YWHUSDTE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

