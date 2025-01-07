module 0xbef210171529b951ce716445fbc2dd861024b938a0067a9d0e5e755e9f929fbe::irie {
    struct IRIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRIE>(arg0, 6, b"IRIE", b"Irie Dog", b"One Love, One Coin...$IRIE takes you to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_30_13_52_27_A_vibrant_and_creative_logo_design_for_a_cryptocurrency_meme_coin_named_IRIE_DOG_The_logo_features_a_cheerful_and_playful_rottweiler_styled_as_a_Ra_b317a7c567.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IRIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

