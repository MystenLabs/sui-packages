module 0x4dcc660ef1a00fd5712ee16c1e794855025e78e26acc134201e6eeed1edd1985::uwu {
    struct UWU has drop {
        dummy_field: bool,
    }

    fun init(arg0: UWU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UWU>(arg0, 9, b"UWU", b"Unicorn", b"HOLD PLS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/UwU8RVXB69Y6Dcju6cN2Qef6fykkq6UUNpB15rZku6Z.png?size=xl&key=9809ed")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UWU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UWU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UWU>>(v1);
    }

    // decompiled from Move bytecode v6
}

