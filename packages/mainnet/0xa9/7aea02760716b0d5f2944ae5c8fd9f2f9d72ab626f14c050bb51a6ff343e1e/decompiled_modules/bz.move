module 0xa97aea02760716b0d5f2944ae5c8fd9f2f9d72ab626f14c050bb51a6ff343e1e::bz {
    struct BZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BZ>(arg0, 6, b"BZ", b"BoiZilla: The Mighty Bull of Memes", b"A gigantic and invincible bull that symbolizes strength, fun, and the hunger to dominate the crypto market. Inspired by the success of tokens like Doge and Pepe, but with the power and charisma of the fields!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_22_21_26_11_A_striking_and_humorous_logo_for_Boi_Zilla_The_Mighty_Bull_of_Meme_The_logo_features_a_gigantic_muscular_bull_with_a_playful_yet_powerful_demeanor_818cc95e86.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

