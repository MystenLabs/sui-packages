module 0xfb0ab4cc7370b848cdf60d02790fd35b40dba6ea165735d128586fb1369ba79e::geng {
    struct GENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENG>(arg0, 6, b"Geng", b"GengarSui", b"Gengar Sui (GENG), a hauntingly charming meme token issued on the Sui blockchain! Inspired by the cunning and mysterious Ghost type Pokemon Gengar from Pokemon, GENG combines humor, and community driven spirit, aiming to become a ghostly presence in the meme coin world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia5afhsmzwh2srb7gimjkryoofu357fgir2cjjmmtdaznc3k722um")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GENG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

