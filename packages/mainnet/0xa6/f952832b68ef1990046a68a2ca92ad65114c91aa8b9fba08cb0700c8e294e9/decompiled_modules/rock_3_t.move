module 0xa6f952832b68ef1990046a68a2ca92ad65114c91aa8b9fba08cb0700c8e294e9::rock_3_t {
    struct ROCK_3_T has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCK_3_T, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<ROCK_3_T>(arg0, 1177809363444378319, b"AI Rock3t", b"rock3t", b"Token for fun to the moon, always - check its sister on solana \"9tYZckisExKfQaf1kQmVx7h4T64w2s3RzEwDfV2p2PMV\"", b"https://images.hop.ag/ipfs/QmbuTvVRZcXHBoVGGavxnLLYxaTkRkT4zXfLBRedgDerY4", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

