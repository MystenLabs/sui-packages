module 0x42ccf264a1662a1ae55e48392467033c720f3e03cca9b59c84c8c939ce4e6eec::xo {
    struct XO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XO>(arg0, 9, b"XO", b"Xociety Token", b"https://xociety.io/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.xociety.io/assets/xo/xo_token.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<XO>>(0x2::coin::mint<XO>(&mut v2, 5000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XO>>(v2);
    }

    // decompiled from Move bytecode v6
}

