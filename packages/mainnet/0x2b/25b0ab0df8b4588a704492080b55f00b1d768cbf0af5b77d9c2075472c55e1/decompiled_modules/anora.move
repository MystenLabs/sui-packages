module 0x2b25b0ab0df8b4588a704492080b55f00b1d768cbf0af5b77d9c2075472c55e1::anora {
    struct ANORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANORA>(arg0, 9, b"ANORA", b"Anora", b"Anora, a young sex worker from Brooklyn, gets her chance at a Cinderella story when she meets and impulsively marries the son of an oligarch. Once the news reaches Russia, her fairytale is threatened as the parents set out for New York to get the marriage annulled.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/ANORA.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANORA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANORA>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

