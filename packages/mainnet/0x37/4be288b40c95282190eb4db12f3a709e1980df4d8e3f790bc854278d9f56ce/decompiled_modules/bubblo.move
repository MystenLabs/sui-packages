module 0x374be288b40c95282190eb4db12f3a709e1980df4d8e3f790bc854278d9f56ce::bubblo {
    struct BUBBLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLO>(arg0, 9, b"Bubblo", b"BUBBLO", x"4472696674696e672064726f706c65742077697468207a65726f2073656e7365206f6620646972656374696f6e2024427562626c6ff09f92a7f09f92a7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/2siNVXDL6Zh585SPhvUa6Va8GTbhbToqXzUbnpEppump.png?size=xl&key=c06265")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUBBLO>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

