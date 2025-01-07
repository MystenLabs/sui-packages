module 0xb28ba5ea2b33e16e939164c3c2f7d98181dfbfd5beb337ad670c077b1c43f95::suif {
    struct SUIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIF>(arg0, 6, b"SUIF", b"SuiFrogs", b"SuiFrogs is a fun, deflationary meme token on the Sui blockchain, centered around frog-themed growth and community. With every transaction, a portion of SUIF is burned, making the token more scarce over time. Holders are rewarded with passive income, and they can stake tokens in frog ponds to earn unique frog NFTs. Join the Frog Army, create frog-inspired memes, and participate in challenges, all while contributing to frog conservation charities. SuiFrogs is more than just a tokenits a movement to hop to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_20_14_23_17_A_playful_and_dynamic_logo_for_Sui_Frogs_a_meme_token_The_logo_should_feature_a_cartoon_style_frog_sitting_on_a_blockchain_inspired_lily_pad_with_602b7711a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

