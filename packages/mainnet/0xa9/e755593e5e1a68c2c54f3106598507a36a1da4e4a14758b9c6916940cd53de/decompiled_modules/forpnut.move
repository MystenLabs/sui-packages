module 0xa9e755593e5e1a68c2c54f3106598507a36a1da4e4a14758b9c6916940cd53de::forpnut {
    struct FORPNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORPNUT>(arg0, 6, b"ForPNut", b"For PNut", x"566f746520616e642057696e210a466f7220504e7574210a466f72204c696265727479210a466f722046726565646f6d21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730701601064.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FORPNUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORPNUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

