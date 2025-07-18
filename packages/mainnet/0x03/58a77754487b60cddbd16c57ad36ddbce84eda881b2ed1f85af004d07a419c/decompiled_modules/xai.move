module 0x358a77754487b60cddbd16c57ad36ddbce84eda881b2ed1f85af004d07a419c::xai {
    struct XAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XAI>(arg0, 9, b"XAI", b"XAI Coin", b"XAI the best AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1d451d09e8cd93439488fd57e797b1c1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

