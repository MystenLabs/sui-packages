module 0xce3d037636f249ef7172a0f22cd1df4c820e4c5d84a0d8fdd8350579a7eea00d::tmk {
    struct TMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMK>(arg0, 6, b"TMK", b"TOMOKO", b"Tomoko is a playful memecoin inspired by internet culture, specifically targeting fans of anime and manga. Named after the quirky and relatable character Tomoko, this coin represents a fun, community-driven approach to cryptocurrency. With a lighthearted vibe and meme-oriented focus, Tomoko aims to bring a sense of humor to the crypto world while fostering a supportive community. It's designed to engage fans with a shared interest in anime memes, creating a unique digital space where enthusiasts can share laughs and ideas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tomoko_0af2f04e5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TMK>>(v1);
    }

    // decompiled from Move bytecode v6
}

