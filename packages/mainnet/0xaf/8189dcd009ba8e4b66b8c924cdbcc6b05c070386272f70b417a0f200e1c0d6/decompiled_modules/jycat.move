module 0xaf8189dcd009ba8e4b66b8c924cdbcc6b05c070386272f70b417a0f200e1c0d6::jycat {
    struct JYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JYCAT>(arg0, 6, b"JYCAT", b"Just a yellow Cat on Sui", x"41204e6577204b696e672048617320526973656e0a4a594341542069732061206c6169642d6261636b20616e64206361726566726565206361742077686f20776f756c64206c6f766520746f20626520667269656e6473207769746820424c55422c204655442c20616e64207468652072657374206f662074686520537569204e6574776f726b2067616e672e2048657320616c7761797320757020666f72206120676f6f642074696d6520616e6420647265616d73206f662068616e67696e67206f75742077697468207468656d2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sp7_d861473cac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

