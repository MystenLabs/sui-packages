module 0xbcacc10ced30490ddeb3cf74d839ad4e1a965e5a26cf2160aa281e45d63c8105::borg {
    struct BORG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORG>(arg0, 6, b"BORG", b"SUIBORG", b"Suiborg is an innovative meme coin designed to take full advantage of the Sui Networks cutting-edge blockchain technology. As we develop Suiborg, were not just creating another meme coin; we're building a robust and scalable project on the Sui ecosystem. By leveraging Suis speed, efficiency, and developer-friendly tools, Suiborg will seamlessly integrate with the growing ecosystem, offering unique utilities and applications that go beyond memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiborg_118fb80c81.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORG>>(v1);
    }

    // decompiled from Move bytecode v6
}

