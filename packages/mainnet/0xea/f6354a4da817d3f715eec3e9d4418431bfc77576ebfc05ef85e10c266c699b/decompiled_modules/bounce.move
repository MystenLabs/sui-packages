module 0xeaf6354a4da817d3f715eec3e9d4418431bfc77576ebfc05ef85e10c266c699b::bounce {
    struct BOUNCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOUNCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOUNCE>(arg0, 6, b"Bounce", b"Bounce will Bounce", x"426f756e636520697320746865206d6f737420626f756e6379206d656d65206163726f73732074686520636861696e7320616e6420697320646f696e67206772656174206f6e2054696b746f6b2068747470733a2f2f7777772e74696b746f6b2e636f6d2f40626f756e63656d656d65636c75620a66696e6420746865207265616c20426f756e636520736b696c6c732e0a544720616e64205820616e642054696b746f6b200a436f6d6d756e6974792069732041637469766520616e64205465616d20697320536b696c6c65640a4c6574732024426f756e636520746f67657468657220746f20746865206d6f6f6e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734317486903.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOUNCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOUNCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

