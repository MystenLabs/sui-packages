module 0x9599b6bc52ce52b701311ad964c68a1e4243bd3101655de0ccdf595086b539e1::jaws {
    struct JAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAWS>(arg0, 6, b"JAWS", b"Jaws - The Famous Shark on SUI", x"427261636520796f757273656c662c20746865206b696e67206f66207468652064656570206973204241434b210a0a52656d656d6265722074686520736861726b2074686174206d61646520796f75206a756d703f2057656c6c2c20244a41575320686173207375726661636564206f6e20245355492c20616e642069747320726561647920746f206665617374210a0a4a6f696e2074686520637265772c206469766520696e20776974682074686520244a41575320636f6d6d756e6974792c20616e6420666c6f6f6420746865206f6365616e207769746820796f75722077696c64657374206d656d657321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_21_52_36_1b17aaedfb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

