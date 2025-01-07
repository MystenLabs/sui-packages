module 0x93aed7b3f81d21187f2eb6aa6879cb9780b99d3fb3c0644fc14f93c07ba943eb::suitofifty {
    struct SUITOFIFTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOFIFTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOFIFTY>(arg0, 6, b"SUITOFIFTY", b"Sui To $50", x"35302520535550504c592053454e5420544f2044524950505920414e442035302520544f204144454e4959490a0a574542534954450a580a47524f55500a4d41524b4554494e470a494e434f4d494e470a0a444f20495420464f522046554e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_coin_3d_icon_download_in_png_blend_fbx_gltf_file_formats_crypto_cryptocurrency_pack_science_technology_icons_7479564_1_373467f075.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOFIFTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOFIFTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

