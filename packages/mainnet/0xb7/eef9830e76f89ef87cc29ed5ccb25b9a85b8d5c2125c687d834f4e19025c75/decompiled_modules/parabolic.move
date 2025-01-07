module 0xb7eef9830e76f89ef87cc29ed5ccb25b9a85b8d5c2125c687d834f4e19025c75::parabolic {
    struct PARABOLIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARABOLIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARABOLIC>(arg0, 9, b"PARABOLIC", b"Parabolic", b"2025. Parabolic year ahead.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/AdnFCiHpJgxQJVZqgUSGLToRbgpkbozT6Ynpic9ipump.png?size=xl&key=ce213e")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PARABOLIC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARABOLIC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARABOLIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

