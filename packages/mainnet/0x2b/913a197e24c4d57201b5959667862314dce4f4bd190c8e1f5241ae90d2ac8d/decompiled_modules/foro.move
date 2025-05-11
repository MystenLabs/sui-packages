module 0x2b913a197e24c4d57201b5959667862314dce4f4bd190c8e1f5241ae90d2ac8d::foro {
    struct FORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORO>(arg0, 6, b"FORO", b"Foro Sui", x"53686f7274204c6567656e6420666f7220464f524f0a0a496e2061206d7973746963616c206469676974616c206a756e676c652c20464f524f20656d6572676573206173206120677561726469616e206f662066756e20616e6420666f7274756e652e20456d626f6479696e672074686520737069726974206f6620616476656e747572652c20464f524f206c6561647320796f75206f6e20616e206578636974696e67206a6f75726e6579207468726f756768207468652063727970746f20776f726c642c2070726f6d6973696e67206c6175676874657220616e64206761696e7320666f7220616c6c2069747320666f6c6c6f776572732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000068730_2bcf4daf4c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

