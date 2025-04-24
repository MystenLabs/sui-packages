module 0xd24e15dfe61422686ceb6b3d675021b8be2cf400159bb6b6d15d0248f44c08e6::chifo {
    struct CHIFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIFO>(arg0, 6, b"CHIFO", b"Sui Chifo", b"(CHIFO)  Its not just a UFO its CHIFO. Straight out of a forgotten galaxy (or maybe just the weirdest corner of the metaverse), $CHIFO has landed on the Sui network with one mission: to spread memes, madness, and crypto chaos. Hes green, a little crazy, and has zero clue about economics but somehow hes leading the most unhinged memecoin invasion the blockchain has ever seen. Fueled by memes, powered by degens, and obsessed with green candles. In the crypto universe, everyone's looking for the next rocket. But we already ARE the spaceship.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061887_b0f4d7d90d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

