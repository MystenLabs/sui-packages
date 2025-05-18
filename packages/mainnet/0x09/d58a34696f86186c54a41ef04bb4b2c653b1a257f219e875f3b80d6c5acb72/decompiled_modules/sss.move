module 0x9d58a34696f86186c54a41ef04bb4b2c653b1a257f219e875f3b80d6c5acb72::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSS>(arg0, 6, b"SSS", b"Sui Super Stars", x"537569205375706572205374617273206973207468652063616c6c20796f7520646f6e742077616e7420746f206d69737321200a0a4120756e6971756520626c656e64206f662067616d696e672c206d656d65732c20616e6420636f6d6d756e6974792d64726976656e20696e6e6f766174696f6e206f6e207468652053554920626c6f636b636861696e2e205768657468657220796f75277265206865726520666f72207468652066756e206f7220746865206675747572652c20245353532068617320736f6d657468696e6720666f7220796f752120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000092274_3a183ff1d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

