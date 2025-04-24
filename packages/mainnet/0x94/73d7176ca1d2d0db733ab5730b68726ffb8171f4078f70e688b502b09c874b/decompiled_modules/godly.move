module 0x9473d7176ca1d2d0db733ab5730b68726ffb8171f4078f70e688b502b09c874b::godly {
    struct GODLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODLY>(arg0, 6, b"GODLY", b"Sui Godly", b"Welcome to the world of $GODLY, a collection of memes as weird as they are awesomewhere every character has one thing in common: a single eye. We are the outcasts, the rebels of the metaverse, seeing the world from a different perspective. Launched on the Base network, $GODLY isn't just a tokenit's a culture. Every meme, every character, represents the chaos, the fun, and the spirit of true crypto degenerates. No rules herejust creativity, community, and one big watching eye. Are you a GODLY? Then join the swarm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061667_06d1bd6e27.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GODLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

