module 0x1cba4e285703af2f2a196eaeef545122fce625a1f8a57bf4e402bec830df6396::josh {
    struct JOSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOSH>(arg0, 6, b"JOSH", b"Poke Josh", b"Pokemon card collector, and go player, just starting in the tcg secene!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaddbkilqvu4x7up2rn4fri2fgh4skyud3t7ddw2n6b53vdayizre")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOSH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

