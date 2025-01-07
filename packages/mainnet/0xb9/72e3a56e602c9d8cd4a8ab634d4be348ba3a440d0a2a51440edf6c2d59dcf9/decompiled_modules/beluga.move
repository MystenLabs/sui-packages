module 0xb972e3a56e602c9d8cd4a8ab634d4be348ba3a440d0a2a51440edf6c2d59dcf9::beluga {
    struct BELUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELUGA>(arg0, 6, b"BELUGA", b"BelugaOnSui", b" BELUGA on SUI meme coin is like the cool kid in the crypto block. It's all about fun and memes on the SUI network.  Just imagine a bunch of beluga whales having a blast in the crypto ocean! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007063_aabd67f61b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELUGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELUGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

