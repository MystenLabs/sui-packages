module 0xab443a8184c3e1aa93b686ea7f14f1f73c9e69cfb47ff4edba74f60161b414da::sms {
    struct SMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMS>(arg0, 6, b"SMS", b"Sui Me Sui", b"Sui Me Sui is the ultimate meme token riding the waves of the Sui blockchain fast, fun, and full of vibes. Powered by the community, for the culture. No roadmap, just pure meme magic. Sui me baby.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidhctnbkgn2uggo3thbuuvc4uqqlhmtxle7omjjbyedqgf6xo5wvy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

