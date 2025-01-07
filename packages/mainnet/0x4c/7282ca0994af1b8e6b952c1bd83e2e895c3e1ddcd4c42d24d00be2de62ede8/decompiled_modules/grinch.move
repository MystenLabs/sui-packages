module 0x4c7282ca0994af1b8e6b952c1bd83e2e895c3e1ddcd4c42d24d00be2de62ede8::grinch {
    struct GRINCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRINCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRINCH>(arg0, 6, b"GRINCH", b"Grinch On Sui", b"GrinchOnSui is the mischievous crypto thats here to disrupt the digital world with a twist of fun. Built on meme culture, its the perfect blend of playful chaos and crypto excitement. Join the GrinchOnSui community and lets make some noise in the crypto space  no rules, just fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Banner512x512video_ezgif_com_video_to_gif_converter_5_e9c81eb845.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRINCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRINCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

