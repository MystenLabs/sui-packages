module 0x1201a78729a907fdde167415e1b73164ea0c2369bfb57580b36807804a94ca28::kiki {
    struct KIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIKI>(arg0, 6, b"KiKi", b"Space Cat on Sui (Sui KiKi)", b"Sui Kiki, the cosmic cat powered by Sui blockchain, is a fully transparent, community-driven meme token. With no centralized ownership and a fair launch, all details are verifiable on Sui Explorer. Trust begins with transparency, and Kiki is here to unite the galaxy through memes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/04df2913_33cd_4d3c_81ac_2384e2c99059_ebc53b8dc6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

