module 0xce7c4090e519a0a345404a550ad4587a309a12ef2852b5d02a7ff1644ce56c46::sfwog {
    struct SFWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFWOG>(arg0, 6, b"SFWOG", b"$SUIFWOG", b"Suifwog is a unique meme project built on the Sui blockchain, featuring whimsical, frog-like characters with a playful water theme. These cartoonish characters, inspired by Pepe memes, inhabit an underwater world filled with bubbles, coral reefs, and vibrant aquatic landscapes. Suifwog aims to stand out as the first of its kind on the Sui chain, combining meme culture with a distinctive, environmentally-inspired aesthetic. With its lighthearted approach and focus on community engagement, Suifwog seeks to capture the playful spirit of the crypto world and make a splash in the meme coin space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suifwog_1_778ef58ac5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

