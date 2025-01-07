module 0x8fb00ade8f78f607ac473c8326052e7f939a6388f8e37a335215c0ea9ffba000::suioil {
    struct SUIOIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIOIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIOIL>(arg0, 6, b"SUIOIL", b"SUI OIL", x"2246726f6d204c61756e636820746f204c6567656e6422207265666c65637473205375694f696c206a6f75726e65792066726f6d206469676974616c206c61756e636820746f20746865206372656174696f6e206f662061206d656d6520636f696e202e20466f722074686f73652077686f2077616e7420746f206561726e206d6f6e657920616e64206e6f74206f7665726c6f6f6b20616e6f746865722067656d210af09f9a8020436f6d6d756e69747920546f6b656e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730967163686.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIOIL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIOIL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

