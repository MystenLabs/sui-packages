module 0x941a6a05929ebd0530042a06b70ab2dd5fee2a3a9249a85894b17544e25e8279::dontbui {
    struct DONTBUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONTBUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONTBUI>(arg0, 6, b"DONTBUI", b"Annunciament Suiperman", b"In a world where the cryptocurrency market can be as volatile as it is exciting, a financial hero emerges: the Superman of Cryptocurrency Investing. With his X-ray vision, he sees beyond daily fluctuations and identifies investment opportunities that most mortals cannot see. Using his super strength, he protects investors from fraud and deceptive schemes, ensuring that their assets are safe. With a superior intellect, he educates the public about safe practices, portfolio diversification and the importance of staying up to date with market trends. In a digital universe fraught with risk, this Superman not only saves investments, but also empowers people to make smarter, more informed financial decisions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Comfy_UI_Generate_1_image_1_removebg_preview_2a1aca7535.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONTBUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONTBUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

