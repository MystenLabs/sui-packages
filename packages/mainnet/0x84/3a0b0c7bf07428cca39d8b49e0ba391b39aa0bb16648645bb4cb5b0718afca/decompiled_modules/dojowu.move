module 0x843a0b0c7bf07428cca39d8b49e0ba391b39aa0bb16648645bb4cb5b0718afca::dojowu {
    struct DOJOWU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOJOWU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOJOWU>(arg0, 6, b"DOJOWU", b"$DOJO WUKONG", x"24444f4a4f5755206973207468652077696c646573742057554b4f4e47206d656d6520746f6b656e206f6e2074686520535549206e6574776f726b2c20204a6f696e2074686520747269626520616e64206c6574277320676f2062616e616e617320746f676574686572210a0a57656e204c616d626f3f204e61682c2066616d2e2057656e206a756e676c653f0a0a68747470733a2f2f782e636f6d2f646f6a6f777562617365640a68747470733a2f2f742e6d652f646f6a6f7775", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731070530695.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOJOWU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOJOWU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

