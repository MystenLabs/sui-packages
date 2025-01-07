module 0xb74a4f379dfbc2e3f14aab4f93e519ded2288351be4b538c273aa0a75e5dbe6c::shell {
    struct SHELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHELL>(arg0, 6, b"SHELL", b"Blue Shell", b"Blue Shell is a meme token on the Sui Network, inspired by the iconic blue shell from Mario Kart. Just like the blue shell shakes up the race, our token aims to disrupt the crypto space with fast, game-changing moves. Whether youre at the front or catching up, Blue Shell is here to level the playing field with a sense of fun and chaos. Embrace the thrill of becoming a crypto billionaire with $SHELL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5787419546498484130_51eee4d477.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHELL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

