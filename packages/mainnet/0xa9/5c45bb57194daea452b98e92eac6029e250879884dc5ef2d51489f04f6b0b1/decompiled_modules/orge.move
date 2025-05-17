module 0xa95c45bb57194daea452b98e92eac6029e250879884dc5ef2d51489f04f6b0b1::orge {
    struct ORGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORGE>(arg0, 6, b"ORGE", b"SuiOgre", x"54686520476f64206f6620746865206f6365616e20686173206170706561726564212121204865726520746f2073686f772074686520636861696e2077686f20746865207265616c20776174657220506f6bc3a96d6f6e206973212054696d6520746f2073686f7720537569207768617420746964616c20776176657320616e64207473756e616d6973207265616c6c79206c6f6f6b206c696b65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifluv27anwlz73sk4ggtqvcix5xuxmsfsahjlkxdnwmd4sy3mhlfe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ORGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

