module 0x5b1652ee101fbcaaf26f5efb91a4583f01ac9eff5a837575132a748ec6e2ffad::stinky {
    struct STINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STINKY>(arg0, 9, b"STINKY", b"STINKY", x"4f646f7220736f207374726f6e672c206974e2809973206c6567656e6461727920f09fa7a6f09fa4a2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/BwfSJ8Hi4VP9oNFKK5LhqCPAXaZPWb8AHwVE3k9Epump.png?size=lg&key=071d08")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STINKY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STINKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

