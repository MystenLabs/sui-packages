module 0xe6ac44efdb29b2e60353698f35e18fb9218fdf1a3cfc8c722b3fff001e4d49c4::suro {
    struct SURO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURO>(arg0, 6, b"SURO", b"ROCET", b"Blast off to the Moon with SUI the symbol of rapid growth and limitless potential in the crypto world. Invest in a future that's already taking flight!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_11_00_03_33_A_humorous_meme_related_to_cryptocurrency_for_an_audience_interested_in_blockchain_and_De_Fi_The_image_features_a_cartoon_character_holding_a_rocket_l_dfac9f3e85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURO>>(v1);
    }

    // decompiled from Move bytecode v6
}

