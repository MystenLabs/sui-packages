module 0xa2990a91efa2e2fd1320a55c101e903fad4f60d69859c846d6fce9463283ac26::sdoge {
    struct SDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOGE>(arg0, 6, b"SDOGE", b"SuiDoge", b"SuiDoge (SDOGE) is an innovative memecoin built on the Sui network, inspired by the fun and community-driven spirit of meme cryptocurrencies like Dogecoin. With a focus on accessibility, engagement, and a vibrant community, SuiDoge offers a lighthearted and playful approach to the crypto world while leveraging the advanced technology of the Sui network for fast and efficient transactions. Whether you're a token collector or simply looking for fun in the crypto space, SuiDoge is here to bring value through humor and innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_15_19_45_14_A_playful_and_colorful_image_representing_the_Sui_Doge_memecoin_The_scene_features_a_fun_cartoon_style_Shiba_Inu_dog_like_Dogecoin_with_a_futurist_b0313991b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

