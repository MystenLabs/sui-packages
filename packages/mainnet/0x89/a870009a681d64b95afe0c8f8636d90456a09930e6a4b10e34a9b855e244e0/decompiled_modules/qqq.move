module 0x89a870009a681d64b95afe0c8f8636d90456a09930e6a4b10e34a9b855e244e0::qqq {
    struct QQQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQQ>(arg0, 9, b"QQQ", b"Invesco QQQ Trust", b"ZO Virtual Coin for Invesco QQQ Trust", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QQQ>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<QQQ>>(v0);
    }

    // decompiled from Move bytecode v6
}

