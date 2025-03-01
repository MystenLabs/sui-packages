module 0x7ac010bbb0c7e5269c7b779361b2d39d31f043e8002623a0cc22d2d9377531b1::kim {
    struct KIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIM>(arg0, 6, b"KIM", b"Kim Jong Eth", x"492073746f6c6520616c6c20796f75722045544820616e64206e6f77206974e28099732074696d6520746f2067657420796f75722053554920485545485545485545485545", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1740861024027.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

