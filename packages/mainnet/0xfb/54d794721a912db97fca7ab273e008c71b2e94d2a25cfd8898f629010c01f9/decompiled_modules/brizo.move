module 0xfb54d794721a912db97fca7ab273e008c71b2e94d2a25cfd8898f629010c01f9::brizo {
    struct BRIZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRIZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRIZO>(arg0, 6, b"BRIZO", b"Baby Rizo", b"BabyRizo is a meme coin, likely designed to capture the attention of cryptocurrency enthusiasts with its playful and often humorous branding. BabyRizo could also be tied to a broader narrative or theme that resonates with crypto enthusiasts, although its exact use case or technical foundation may be minimal compared to more serious cryptocurrencies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048525_8aab3135d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRIZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRIZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

