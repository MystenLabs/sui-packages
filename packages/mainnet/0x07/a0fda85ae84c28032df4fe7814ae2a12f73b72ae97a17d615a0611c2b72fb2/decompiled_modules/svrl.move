module 0x7a0fda85ae84c28032df4fe7814ae2a12f73b72ae97a17d615a0611c2b72fb2::svrl {
    struct SVRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVRL>(arg0, 6, b"SVRL", b"SuiViral", b"SuiViral is the meme token designed to take the SUI Blockchain to the next level. Our goal is to support the growth of SUI while creating a viral, fun, and community-driven movement. Staying true to the principles of decentralization, SuiViral will not maintain any official social media accounts. Instead, we rely entirely on the power of our community to spread the word and make SUI go viral. Together, well reach the top!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000138501_f083b032f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SVRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

