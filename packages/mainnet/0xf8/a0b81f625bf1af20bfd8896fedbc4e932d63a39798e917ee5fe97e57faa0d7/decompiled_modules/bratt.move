module 0xf8a0b81f625bf1af20bfd8896fedbc4e932d63a39798e917ee5fe97e57faa0d7::bratt {
    struct BRATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRATT>(arg0, 6, b"BRATT", b"Bratt on Sui", x"5265766f6c7574696f6e697a696e6720746865206d656d65636f696e206c616e647363617065207769746820696e6e6f766174697665207574696c697469657320616e6420636f6d6d756e6974792d64726976656e2066656174757265732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_6_bd96193bb7_d394647726.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

