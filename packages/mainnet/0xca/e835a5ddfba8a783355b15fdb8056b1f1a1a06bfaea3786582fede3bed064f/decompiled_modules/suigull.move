module 0xcae835a5ddfba8a783355b15fdb8056b1f1a1a06bfaea3786582fede3bed064f::suigull {
    struct SUIGULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGULL>(arg0, 6, b"SUIGULL", b"Suigull sui", b"Dive into the world of SUIGULL, THE NEWEST TREASURE ON SUI's BLOCKCHAIN. In the vast blue of the SUI chain , Brett and his friend Suigull are exploring, creating bonds and laughter. This unique token symbolizes more than just fun... it's about connection, freedom, and making the digital space vibrant. With SUIGULL, we're not just launching another meme coin: we're inviting you to join a journey of friendship, discovery, and growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039935_53da37d3c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

