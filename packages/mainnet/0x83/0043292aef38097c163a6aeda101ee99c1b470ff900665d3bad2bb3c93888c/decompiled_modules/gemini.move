module 0x830043292aef38097c163a6aeda101ee99c1b470ff900665d3bad2bb3c93888c::gemini {
    struct GEMINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEMINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEMINI>(arg0, 9, b"GEMINI", b"Sui Gemini", b"Sui Gemini is a meme token on the Sui blockchain, inspired by Gemini meme culture. It promotes community engagement through fun initiatives, offering fast transactions and low fees.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843330182335393792/pP3in2qK.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GEMINI>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEMINI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEMINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

