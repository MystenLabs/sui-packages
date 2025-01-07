module 0x3b2309601c34f60c737f98419ce7e6f564a4a6aaaf0b2156d54ce7d3d5be187d::ths {
    struct THS has drop {
        dummy_field: bool,
    }

    fun init(arg0: THS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THS>(arg0, 6, b"THS", b"The Hamsa", b"Introducing Hamsa Coin: the meme crypto that's all about good luck and protection! With its iconic hand symbol, HamsaCoin is your shield against market chaos. Dive into a community that celebrates fun, positivity, and a sprinkle of fortune. Hamsa Coin where memes meet money!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_AI_256x256_fabf47406e.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THS>>(v1);
    }

    // decompiled from Move bytecode v6
}

