module 0x29feb6f46f87f1ab3009c6f86afd36ab01b569a27b94c11280924bd3dd050c2e::chop {
    struct CHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOP>(arg0, 6, b"CHOP", b"Chop on Sui", b"Chop Suey Coin: A Flavorful Dive into the Sui Ecosystem Introducing Chop Suey Coin, a unique memecoin on the Sui blockchain. Inspired by the iconic Chinese dish, Chop Suey Coin aims to bring a taste of fun, community, and innovation to the Sui ecosystem. Our mission is to foster a vibrant and supportive community, while offering exciting opportunities for our token holders Socials soon Website under construction", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048773_e3335c278b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

