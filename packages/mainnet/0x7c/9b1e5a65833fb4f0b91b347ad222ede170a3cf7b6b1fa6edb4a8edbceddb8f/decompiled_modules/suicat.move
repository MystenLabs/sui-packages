module 0x7c9b1e5a65833fb4f0b91b347ad222ede170a3cf7b6b1fa6edb4a8edbceddb8f::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 6, b"SUICAT", b"SUICAT - the real cat from sui", x"496e74726f647563696e67205355494341542020796f757220676f2d746f206d656d65636f696e206f6e2074686520537569206e6574776f726b2120576974682069747320636861726d696e67206d6173636f7420746861747320736176767920696e2063727970746f207472656e647320616e64206472657373656420746f20696d707265737320696e20626c6f636b636861696e207374796c652c205355494341542070726f6d6973657320707572722d66656374207472616e73616374696f6e7320616e64206d656f772d6e69666963656e74206761696e732e200a4a6f696e207468652066656c696e652066696e616e6365207265766f6c7574696f6e20746f6461792120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_09_12_32_59_807fb76130.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

