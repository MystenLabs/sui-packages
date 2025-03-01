module 0x71320d99ea72987682ae203211d727b160a485c353af64926967dd3b5b58c9aa::frish {
    struct FRISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRISH>(arg0, 6, b"FRISH", b"FROG FISH", x"5468652048616972792046726f67666973683a2054686520537465616c7468204d6173746572206f662053756920436861696e212048616c662066726f672c2068616c6620666973682c203130302520756e69717565210a0a426c656e647320696e206c696b65206120737465616c7468206d6f64652063727970746f2070726f6a6563742c2077616974696e6720666f7220746865207269676874206d6f6d656e7420746f206578706c6f646521204f6e2053756920436861696e2c20697473207468652068696464656e2067656d20726561647920746f20626520646973636f766572656421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4400_95f983ab66.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

