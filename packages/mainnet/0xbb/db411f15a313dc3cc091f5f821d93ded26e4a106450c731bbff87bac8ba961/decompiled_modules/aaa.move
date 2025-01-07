module 0xbbdb411f15a313dc3cc091f5f821d93ded26e4a106450c731bbff87bac8ba961::aaa {
    struct AAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAA>(arg0, 6, b"AAA", b"AAAFISH", x"4469766520696e746f207468652077696c6420776174657273206f662074686520535549206f6365616e207769746820414141464953482c20746865206d6f737420656c65637472696679696e67206d656d65636f696e20746f2068697420746865205355492120f09f909fe29ca82047657420726561647920746f207377696d2077697468207468652062696767657374206761696e7320616e64206d616b6520776176657320696e20746865206d656d6520636f6d6d756e6974792120f09f9a80f09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730983867222.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

