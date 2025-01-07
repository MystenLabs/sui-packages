module 0x2bf90dd68e8c23b103f0a41c21e27e9c6a876d987fecf43b83fa5f3a3db2a25f::spanda {
    struct SPANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPANDA>(arg0, 6, b"SPANDA", b"SUIPANDA", x"4f6e6c792074686f73652077686f2062656c6965766520696e20746865206d697373696f6e206172652077656c636f6d65210a427579207768617420796f752063616e20686f6c642020736d616c6c206f72206269672c20697420646f65736e74206d6174746572206173206c6f6e6720617320796f7560726520696e20666f722074686520726964652e0a546865206561726c7920686f6c646572732077696c6c20726561702074686520626967676573742072657761726473210a204c657473206d616b6520686973746f727920746f67657468657220616e642073686f772074686520706f776572206f66206f757220636f6d6d756e697479212042757920726573706f6e7369626c792c20616e64206c657473204d4f4f4e20746869732070726f6a6563742120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_12_02_19_08_03_A_Pixar_style_realistic_animated_logo_for_a_meme_token_named_Sui_Panda_The_logo_features_an_adorable_cartoon_panda_with_a_glossy_and_smooth_texture_9f94a93e55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

