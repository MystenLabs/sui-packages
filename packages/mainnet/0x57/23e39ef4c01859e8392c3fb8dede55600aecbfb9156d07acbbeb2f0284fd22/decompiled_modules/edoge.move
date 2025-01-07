module 0x5723e39ef4c01859e8392c3fb8dede55600aecbfb9156d07acbbeb2f0284fd22::edoge {
    struct EDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDOGE>(arg0, 9, b"EDOGE", b"SUI Doge", b"Make Doge Based Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x786f112c9a6bc840cdc07cfd840105efd6ef2d4b.png?size=lg&key=b09b2b")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EDOGE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDOGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

