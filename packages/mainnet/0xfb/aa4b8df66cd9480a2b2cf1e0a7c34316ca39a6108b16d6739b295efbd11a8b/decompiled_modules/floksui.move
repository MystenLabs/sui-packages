module 0xfbaa4b8df66cd9480a2b2cf1e0a7c34316ca39a6108b16d6739b295efbd11a8b::floksui {
    struct FLOKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKSUI>(arg0, 6, b"Floksui", b"FLOKSUI", b"Floki, the peoples cryptocurrency inspired by Viking legend, is now expanding its realm to the Sui Network! With a strong community and a vision to revolutionize DeFi, Floki is bringing its utility and meme power to Sui, a high-performance, decentralized layer-1 blockchain. Prepare for lightning-fast transactions, enhanced scalability, and new opportunities in the Sui ecosystem. This is more than a token its a movement!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/floooo_ae6e3bfc52.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

