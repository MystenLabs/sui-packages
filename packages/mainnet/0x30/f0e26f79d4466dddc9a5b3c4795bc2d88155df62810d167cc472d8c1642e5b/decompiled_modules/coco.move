module 0x30f0e26f79d4466dddc9a5b3c4795bc2d88155df62810d167cc472d8c1642e5b::coco {
    struct COCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCO>(arg0, 6, b"COCO", b"Cococoin", x"24434f434f2c207468652063727970746f63757272656e6379206e616d6564206166746572206865722c20736b79726f636b65747320313030307820696e2076616c75652c206272696e67696e672070726f7370657269747920746f20616c6c2069747320686f6c646572732e2044726976656e206279207468697320647265616d2c20436f636f20656d6261726b73206f6e206120646172696e67206a6f75726e657920746f206d616b65207468697320766973696f6e2061207265616c6974792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040932_4887ce83c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

