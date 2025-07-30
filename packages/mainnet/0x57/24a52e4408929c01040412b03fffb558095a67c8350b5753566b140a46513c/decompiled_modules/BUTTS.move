module 0x5724a52e4408929c01040412b03fffb558095a67c8350b5753566b140a46513c::BUTTS {
    struct BUTTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTTS>(arg0, 6, b"Sui Dick Butts", b"BUTTS", b"A hilarious and irreverent meme coin for the Sui blockchain, celebrating the absurdity of internet culture with a playful nod to the iconic 'Dick Butts' meme. CDBS is all about fun, community, and embracing the meme magic of crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/pGrobKLfC2XeFUBE4Ti1fE8G1MNyKF08Szr490QsZoYx8eXUB/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTTS>>(v0, @0x82ea3f8d2475bae1d2aba484c46125fdb81e0f192172e398c2ee99d9813cea00);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

