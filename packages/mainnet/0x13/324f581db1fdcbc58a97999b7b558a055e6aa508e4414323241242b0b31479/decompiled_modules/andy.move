module 0x13324f581db1fdcbc58a97999b7b558a055e6aa508e4414323241242b0b31479::andy {
    struct ANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDY>(arg0, 6, b"ANDY", b"Andy sui", x"416e647920546f6b656e202824414e445929206973206120636f6d6d756e6974792d64726976656e206d656d6520746f6b656e206f6e207468652053756920436861696e2c206272696e67696e672068756d6f7220616e64207768696d737920746f2074686520626c6f636b636861696e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031015_552d851a1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

