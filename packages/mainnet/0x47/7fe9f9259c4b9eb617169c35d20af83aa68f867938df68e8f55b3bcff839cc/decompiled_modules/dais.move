module 0x477fe9f9259c4b9eb617169c35d20af83aa68f867938df68e8f55b3bcff839cc::dais {
    struct DAIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DAIS>(arg0, 6, b"DAIS", b"DropAi on sui by SuiAI", b"Have you ever dreamed of owning a work of art created by AI? With DropAI,.it's possible! With just one click you can create beautiful, unique paintings..Let's explore the colorful world of AI art with DropAI!'.DropAI is a unique meme coin, built on the Sui Network platform, allowing.users to create unique works of digital art using artificial intelligence. With.DropAI, anyone can become an AI artist, creating paintings, images, and.even short videos with just a few clicks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/unexpected_af01d3b07d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DAIS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAIS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

