module 0xc1f3ab94f047af6f2e89f2977c62a085d38378ce018827e638e50a1769ce8889::mega {
    struct MEGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGA>(arg0, 6, b"MEGA", b"Make Europe Great Again", b"The \"MEGA: Make Europe Great Again\" meme is a satirical play on Donald Trump's \"MAGA\" slogan. It emerged following Elon Musk's recent tweets where he expressed support for right-leaning political leaders in Europe and criticized left-leaning governments.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7789_24a32f17fe.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

