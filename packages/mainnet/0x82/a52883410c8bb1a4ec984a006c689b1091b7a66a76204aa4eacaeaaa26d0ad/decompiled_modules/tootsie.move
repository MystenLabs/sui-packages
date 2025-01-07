module 0x82a52883410c8bb1a4ec984a006c689b1091b7a66a76204aa4eacaeaaa26d0ad::tootsie {
    struct TOOTSIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOOTSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOOTSIE>(arg0, 9, b"TOOTSIE", b"Tootsie The Elephant", b"The first ever token launched on Mastodon, Tootsie the Elephant (the official Mastodon mascot). Peter Todd AKA Satoshi is an admin of Mastodon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/Qme9CJw5oSvfeRxseCHbDPGQxQBgcfCSwb6Y39e3k8cD29?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOOTSIE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOOTSIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOOTSIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

