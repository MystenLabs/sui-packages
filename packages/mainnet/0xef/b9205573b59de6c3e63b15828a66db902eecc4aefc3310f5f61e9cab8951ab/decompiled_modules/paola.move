module 0xefb9205573b59de6c3e63b15828a66db902eecc4aefc3310f5f61e9cab8951ab::paola {
    struct PAOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAOLA>(arg0, 6, b"PAOLA", b"Paola on SUI", x"50616f6c6120697320612066756e2c20636f6d6d756e74792d64726976656e202c206d656d65636f696e206372656174656420746f206272696e676a6f792c2068756d6f722c20616e64206974206120626974206f6620616476656e7475726520746f207468652063727970746f20776f726c642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cvot_AF_By_400x400_8a542b00ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

