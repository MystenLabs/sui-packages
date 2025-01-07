module 0x4ad7f15ecd0ac6bee00cbed4e600e602772d4b2c444fcf9c6f036b27a4ee6bf2::pirates {
    struct PIRATES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRATES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRATES>(arg0, 6, b"PIRATES", b"Sui Pirates", b"All Aboard the Sui Seas. Sail the Bluemove waves as we trade and plunder for riches in meme coins for Sui. Join our Pirate Ship as go in search of new booty.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_20_14_33_29_21c72aa7e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRATES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIRATES>>(v1);
    }

    // decompiled from Move bytecode v6
}

