module 0x5f9a74acc24caa2c8bccac2d3715bde64bb820c59d30b9126e0684f42c196a79::bhwh {
    struct BHWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHWH>(arg0, 6, b"BHWH", b"Baby Hippo Wif Hat", x"4261627920486970706f2057696620486174200a5768657265206973206d79204441444459204d4f4f2044454e4720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BWH_123a99d811.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BHWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

