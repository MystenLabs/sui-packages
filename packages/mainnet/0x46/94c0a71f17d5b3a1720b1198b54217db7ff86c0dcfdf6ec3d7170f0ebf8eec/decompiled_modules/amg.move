module 0x4694c0a71f17d5b3a1720b1198b54217db7ff86c0dcfdf6ec3d7170f0ebf8eec::amg {
    struct AMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMG>(arg0, 6, b"AMG", b"Amigos ", x"4974e28099732074686520796561722032303630e280a62049e280996d206f6e206d792038746820636f7563682c207374696c6c2077616974696e6720666f7220535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953239472.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

