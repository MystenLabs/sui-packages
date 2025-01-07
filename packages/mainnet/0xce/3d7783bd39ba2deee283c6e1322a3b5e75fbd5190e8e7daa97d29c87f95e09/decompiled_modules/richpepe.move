module 0xce3d7783bd39ba2deee283c6e1322a3b5e75fbd5190e8e7daa97d29c87f95e09::richpepe {
    struct RICHPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICHPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICHPEPE>(arg0, 6, b"RICHPEPE", b"Richpepe", x"526963682070657065206973206865726520746f2067726f7720616e642073746179206a6f696e20757320616e642074686520636f6d6d756e69747920616e64206c657473206d616b6520746869732067726561742e0a5765207368696c6c20616e64206368696c6c20616e6420676574207269636820746f6765746865722e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730997713896.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICHPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICHPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

