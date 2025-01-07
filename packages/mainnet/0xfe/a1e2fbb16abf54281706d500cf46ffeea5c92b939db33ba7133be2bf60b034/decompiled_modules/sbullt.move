module 0xfea1e2fbb16abf54281706d500cf46ffeea5c92b939db33ba7133be2bf60b034::sbullt {
    struct SBULLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBULLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBULLT>(arg0, 9, b"SBULLT", b"Sui Bull Technology", b"The Sui Bull Token (SBULLT) powers the fully developed Sui Bull Trading bot, offering up to 60% lower trading fees. By holding SBULLT in your wallet, reduced fees are automatically applied to your trades. For more information, check out the Sui Bull Whitepaper on our website!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cache.tonapi.io/imgproxy/ywHfNpeSW-6wmKLsucJzV3grHwoO6gPMozwhFAIjcRw/rs:fill:200:200:1/g:no/aHR0cHM6Ly9kMTIxdnR5NzU5bnBhaS5jbG91ZGZyb250Lm5ldC9pbWFnZXMvMGI5MGYyYmU2ZjkxNDZiZGIxNzUwOWMwMmI5ZTdiNzkucG5n.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SBULLT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBULLT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBULLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

