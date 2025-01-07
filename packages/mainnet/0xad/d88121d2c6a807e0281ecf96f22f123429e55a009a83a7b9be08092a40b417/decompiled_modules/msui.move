module 0xadd88121d2c6a807e0281ecf96f22f123429e55a009a83a7b9be08092a40b417::msui {
    struct MSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSUI>(arg0, 6, b"MSUI", b"MoonSui", b"The \"MoonSui\" captures a playful, futuristic theme inspired by both the blockchain and space exploration. At its center is a cartoon-style blue moon character, embodying a cheerful personality with a fun twistsunglasses that reflect the Sui blockchain logo in each lens. This not only adds a layer of visual interest but also emphasizes the coin's connection to the Sui ecosystem. The bold, stylized \"MoonSui\" text sits below, set against a starry sky with a glowing crescent moon in the background, creating an energetic and adventurous atmosphere. The color palette of blue, silver, and white underscores a high-tech, space-inspired aesthetic, making the logo both memorable and visually appealing for the meme coin's brand.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Moon_Sui_a19a1b0382.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

