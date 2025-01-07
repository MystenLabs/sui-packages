module 0x8402e9ef4f793aad758f6e27dfed12da1276edfadec03627632ce40ae8f39321::inf {
    struct INF has drop {
        dummy_field: bool,
    }

    fun init(arg0: INF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INF>(arg0, 9, b"INF", b"Foreign token represent Infinity", b"Foreign token represent Infinity", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

