module 0x5766e524020cd91db80ea2724e25d7e69720bfb6a1e9f94ea93107c955bd63a4::swr {
    struct SWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWR>(arg0, 6, b"SWR", b"Swarm", b"Swarm is a community-driven meme token inspired by the collective power of decentralized action. Just like a swarm of bees working together toward a common goal, Swarm represents the strength of unity, rapid momentum, and a buzzworthy presence in the crypto world. Built for those who believe in the chaos of memes and the order of blockchain, Swarm blends humor, hype, and purpose into a single unstoppable force. Whether you're here for the laughs, the gains, or the movement, Swarm is where the hive comes alive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicnbq5isprr6ebueg6seyqz3sgycsl3dfxv47xwtexdlu7ookjnhu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SWR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

