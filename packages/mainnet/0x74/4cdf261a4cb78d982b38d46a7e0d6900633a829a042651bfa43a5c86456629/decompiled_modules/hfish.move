module 0x744cdf261a4cb78d982b38d46a7e0d6900633a829a042651bfa43a5c86456629::hfish {
    struct HFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFISH>(arg0, 6, b"HFISH", b"HOP FISH", b"They say fish don't jump, I'm an exception #sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmWJJR8B1qXzo6FpAq4YGtPKYBNZWFA4AqZdrSPVZSBUJs")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HFISH>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HFISH>(12230970880764657288, v0, v1, 0x1::string::utf8(b"https://x.com/HopFish_"), 0x1::string::utf8(b"https://hopfish.xyz/"), 0x1::string::utf8(b"https://t.me/HopFish"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

