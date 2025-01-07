module 0xd14b65c81e310b3d4b769179145f7155bfc7d718564e8a69370d94ef41ad61f7::dogemas {
    struct DOGEMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEMAS>(arg0, 9, b"DOGEMAS", b"Dogemas", b"Merry Dogemas Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/59UBR8NebtKoRwWDa4MeRWd2fpq5PQCABQKXKkn9pump.png?size=xl&key=05880b")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGEMAS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGEMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEMAS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

