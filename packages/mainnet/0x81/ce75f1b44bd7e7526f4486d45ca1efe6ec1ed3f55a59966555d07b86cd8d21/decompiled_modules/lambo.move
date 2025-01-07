module 0x81ce75f1b44bd7e7526f4486d45ca1efe6ec1ed3f55a59966555d07b86cd8d21::lambo {
    struct LAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMBO>(arg0, 6, b"LAMBO", b"LAMBOGUY", x"4c616d626f477579204f6666696369616c200a54686520756c74696d617465206d656d6520636f696e206675656c656420627920636173682c20737761672c20616e64204c616d626f732120204a6f696e2074686520726964652077697468204c616d626f2047757920616e64206c65747320666c6578206f75722077617920746f20746865206d6f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_29_03_52_02_b3bdfeb5d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

