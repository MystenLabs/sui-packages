module 0x7fd0ac796ee1591656b25db47a24d23f7ed428abe7d6b7fad667a7df1b3e4fd3::ctorug {
    struct CTORUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTORUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTORUG>(arg0, 6, b"CTORUG", b"Community Take Over Rugs", x"2443544f5255472028436f6d6d756e6974792054616b65204f7665722052756773290a41206d656d6520746f6b656e20626f726e2066726f6d2074686520777265636b616765206f662053756920727567732e204e6f20646576206d696e742e204a75737420612074727573746c65737320626f6e64696e6720637572766520616e64207075726520636f6d6d756e69747920656e657267792e20506f77657265642062792054726f6c6c6661636520612073796d626f6c206f6620726576656e67652c206368616f732c20616e6420756e73746f707061626c6520646567656e732e204f6e652070726f6a65637420746f20756e69746520616c6c20746865207275676765642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiegqv4pde2d3pkeo225abpxnvnakdc5cojcvqtnzpzhwzilskkq6y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTORUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CTORUG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

