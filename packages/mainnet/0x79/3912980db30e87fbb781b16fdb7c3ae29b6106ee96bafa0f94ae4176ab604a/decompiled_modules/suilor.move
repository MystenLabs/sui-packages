module 0x793912980db30e87fbb781b16fdb7c3ae29b6106ee96bafa0f94ae4176ab604a::suilor {
    struct SUILOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILOR>(arg0, 6, b"SUILOR", b"SuilorMoon", x"57656c636f6d6520746f205375696c6f72204d6f6f6e2c20776865726520746865206d61676963206f662063727970746f63757272656e6379206d656574732074686520737069726974206f6620616476656e74757265210a4a6f696e20757320696e20612076696272616e7420636f6d6d756e69747920666f6375736564206f6e207472616e73706172656e63792c20696e636c757369766974792c20616e64207375737461696e61626c652067726f7774682e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suilor_Moon_0e052367bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

