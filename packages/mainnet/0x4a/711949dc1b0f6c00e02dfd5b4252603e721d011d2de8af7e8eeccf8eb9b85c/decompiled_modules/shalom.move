module 0x4a711949dc1b0f6c00e02dfd5b4252603e721d011d2de8af7e8eeccf8eb9b85c::shalom {
    struct SHALOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHALOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHALOM>(arg0, 6, b"Shalom", b"SUI Shalom", b"SUI-Shalom is a meme coin that combines the spirit of peace with the innovation of the SUI blockchain. Its more than just a tokenits a playful symbol that celebrates tradition and technology coming together. With a focus on community and creative utilities, SUI-Shalom aims to bring unique experiences and meaningful connections to the crypto world. Get ready for a new kind of meme coin thats fun, friendly, and full of possibilities", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_10_16_01_51_A_digital_artwork_combining_the_Star_of_David_and_the_SUI_blockchain_logo_The_Star_of_David_is_centrally_featured_with_the_SUI_logo_integrated_seamle_12aeacd7c3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHALOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHALOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

