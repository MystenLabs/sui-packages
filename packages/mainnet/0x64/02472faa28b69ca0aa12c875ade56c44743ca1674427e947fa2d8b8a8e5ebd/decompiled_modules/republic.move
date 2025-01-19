module 0x6402472faa28b69ca0aa12c875ade56c44743ca1674427e947fa2d8b8a8e5ebd::republic {
    struct REPUBLIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: REPUBLIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<REPUBLIC>(arg0, 6, b"REPUBLIC", b"REPUBLICAN MEME  by SuiAI", b"Republican Meme Coin , The Meme with a Mission..Visual Concept: Imagine a digital coin with Donald Trump's face on it, styled like a classic coin but with a modern, meme-like twist. His hair is flamboyantly animated, with each strand converting into a tiny American flag. The coin would be adorned with 'MAGA' (Make America Great Again) in bold letters, perhaps with the abbreviation 'RMC' beside it. In the background, there's a collage of iconic Trump memes: Pepe the Frog giving a thumbs-up, the 'Covfefe' coffee cup, and a silhouette of Trump's signature 'deal' handshake. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/RPBLICAN_c7fe81411a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REPUBLIC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REPUBLIC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

