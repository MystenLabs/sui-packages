module 0x4830a1a1b2e2aaf31e5c1be7e40cc8e49e15f33a91319dd26a5374670f457599::naka {
    struct NAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAKA>(arg0, 6, b"Naka", b"Satoshi Nakamoto", b"Introducing Nakamoto (Naka)  the memecoin that carries the legendary name, but with a twist! Built on the SUI chain, this token brings you more than just decentralized finance; it brings you the ultimate crypto meme experience. No whitepapers, no roadmaps, just pure vibes and inevitable mooning . Whether you're here for the tech or the memes, Nakamoto is your ticket to ride the DeFi hype train, stacking sats in the most fun way possible. Because, lets face it  Satoshi walked, so Naka could run. Join the Naka-nation, where were all about stacking, hodling, and good times!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/satushi_aac13bc124.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

