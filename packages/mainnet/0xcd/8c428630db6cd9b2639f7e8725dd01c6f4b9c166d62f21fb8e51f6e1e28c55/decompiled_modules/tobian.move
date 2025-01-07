module 0xcd8c428630db6cd9b2639f7e8725dd01c6f4b9c166d62f21fb8e51f6e1e28c55::tobian {
    struct TOBIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOBIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOBIAN>(arg0, 6, b"Tobian", b"Tobiano", b"Tobiano Meme Coin is a playful, community-driven cryptocurrency inspired by the bold and distinctive patterns of the Tobiano horse. Combining the fun spirit of meme culture with a sustainable tokenomics model, Tobiano rewards loyal holders through staking, NFT collectibles, and a deflationary burn mechanism. With a focus on viral engagement and community governance, Tobiano aims to build a lasting digital ecosystem that goes beyond just jokesit's a meme coin with style, utility, and staying power. Join the herd and ride the wave of fun with Tobiano!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_01_23_21_05_49_5a976a0162.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOBIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOBIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

