module 0xec796f88919b8c696ee0d8d96b9343c77246e3b00b533edf829d3525a286059b::swamp {
    struct SWAMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWAMP>(arg0, 6, b"SWAMP", b"SWAMPION", b"SWAMP is a meme token born from the depths of internet culture, blending humor, chaos, and community into a single digital asset. Inspired by the untamed energy of the swamp  wild, unpredictable, and teeming with life SWAMP doesn't follow the rules of traditional finance. It's a grassroots movement driven by memes, community spirit, and the shared belief that even the muddiest waters can lead to something valuable. Whether you're here for the laughs or the long haul, SWAMP is a place where everyone can wade in and stir things up.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig75iithglu6peur5o4jjhyuhhl7pgl4pdwicayl5sinkkyotbkdq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWAMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SWAMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

