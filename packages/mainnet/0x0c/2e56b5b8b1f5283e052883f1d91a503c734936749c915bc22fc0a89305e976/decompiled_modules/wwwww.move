module 0xc2e56b5b8b1f5283e052883f1d91a503c734936749c915bc22fc0a89305e976::wwwww {
    struct WWWWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWWWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWWWW>(arg0, 6, b"WWWWW", b"ddd", b"sdadafggfh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid6fgieqs2tnfbi2wmm5hcoevw5fbffpyxoxt2kh7r7z57s47t2u4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWWWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WWWWW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

