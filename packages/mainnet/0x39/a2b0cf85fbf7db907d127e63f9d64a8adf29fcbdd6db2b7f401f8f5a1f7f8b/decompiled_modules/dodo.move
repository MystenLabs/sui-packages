module 0x39a2b0cf85fbf7db907d127e63f9d64a8adf29fcbdd6db2b7f401f8f5a1f7f8b::dodo {
    struct DODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DODO>(arg0, 6, b"DODO", b"suidodo", b"DODO is a playful, meme-inspired token created to bring fun and creativity to the SUI blockchain. With its iconic dodo bird mascot, the token represents a lighthearted approach to the crypto world, offering users a chance to be part of something unique and entertaining. Despite the dodo bird being extinct in the real world, DODO on the blockchain is alive, bold, and ready to fly to new heights.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_15_16_17_55_A_playful_meme_token_image_for_a_cryptocurrency_called_DODO_The_image_should_feature_a_cute_slightly_chubby_cartoon_dodo_bird_with_a_mischievous_s_2546c09509.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DODO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

