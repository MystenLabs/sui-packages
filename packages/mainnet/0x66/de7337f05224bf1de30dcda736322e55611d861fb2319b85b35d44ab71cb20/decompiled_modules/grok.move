module 0x66de7337f05224bf1de30dcda736322e55611d861fb2319b85b35d44ab71cb20::grok {
    struct GROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROK>(arg0, 6, b"GROK", b"Grok on Sui", b"Introducing Grok AI on Sui, the meme coin that's taking the blockchain by storm, straight from the imaginative mind of Grok himself! This coin features an exclusive image crafted by Grok, embodying the essence of his AI persona - a blend of JARVIS's sleek, tech-savvy vibe with a dash of the quirky, universe-exploring spirit from Hitchhiker's Guide to the Galaxy. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_03ce9a17b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

