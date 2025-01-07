module 0xbfbd6846ac776a711f68d3dd8ed44b2ddcaf2518198db7637ecf1166e8ed94b4::skbddy {
    struct SKBDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKBDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKBDDY>(arg0, 9, b"SKBDDY", b"SkibiDiddy", b"SKIBIDI DIDDY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/FfhENRtsudrPbWaJhuMnYq2fKchHqU1Erd7vK9Gzpump.png?size=xl&key=e9739a")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SKBDDY>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKBDDY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKBDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

