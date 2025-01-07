module 0x23d0fa94d4d4fbd3fa0a637a9347b47414312d8d0b121fcf175ce5cb7e693bd3::tank {
    struct TANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TANK>(arg0, 6, b"TANK", b"Sui Tank", x"4c6f636b20616e64206c6f61642077697468202454414e4b212054686973206265617374206f66206120636f696e206973206275696c7420746f20646f6d696e617465207468652053756920626174746c656669656c642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tank_2ac8c68cc1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

