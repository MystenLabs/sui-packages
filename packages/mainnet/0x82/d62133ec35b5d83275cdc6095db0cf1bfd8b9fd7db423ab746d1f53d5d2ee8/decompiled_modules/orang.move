module 0x82d62133ec35b5d83275cdc6095db0cf1bfd8b9fd7db423ab746d1f53d5d2ee8::orang {
    struct ORANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORANG>(arg0, 6, b"ORANG", b"Orang Sui", x"4f72616e672c2069732061206d616a6f7220616e7461676f6e697374206f6620746865205375727265616c204d656d6573206d756c7469766572736520616e64206f6e65206f66204d656d65204d616e2773206269676765737420726976616c732e204869732066756c6c206e616d652069732074686f7567687420746f206265204f72616e67204d696e2e20486520697320746865206d6f73742077656c6c2d6b6e6f776e2066726f6f6e742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Orang_Sui_7ee6ba673e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

