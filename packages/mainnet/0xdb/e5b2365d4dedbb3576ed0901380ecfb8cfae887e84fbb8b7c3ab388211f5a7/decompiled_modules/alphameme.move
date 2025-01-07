module 0xdbe5b2365d4dedbb3576ed0901380ecfb8cfae887e84fbb8b7c3ab388211f5a7::alphameme {
    struct ALPHAMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHAMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHAMEME>(arg0, 6, b"ALPHAMEME", b"v0.03 alpha. Not fumny. Do not laugh.", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://c8.alamy.com/comp/PHRYN0/alpha-version-green-grunge-stamp-PHRYN0.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALPHAMEME>(&mut v2, 555555555000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHAMEME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALPHAMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

