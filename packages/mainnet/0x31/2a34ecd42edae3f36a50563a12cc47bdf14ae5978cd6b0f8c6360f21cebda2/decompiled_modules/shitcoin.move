module 0x312a34ecd42edae3f36a50563a12cc47bdf14ae5978cd6b0f8c6360f21cebda2::shitcoin {
    struct SHITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITCOIN>(arg0, 6, b"SHITCOIN", b"Shitcoin", x"53686974636f696e2044617920697320616c6c2061626f75742066756e2c20636f6d6d756e6974792c20616e64206120626974206f662073656c662d69726f6e797768657265206761696e73206172652074686520676f616c20616e64206c61756768732067756172616e74656564210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vc_Xhn3ld_400x400_ad34caccad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHITCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

