module 0x826010998190523e7fce54d54c4cd32d7d79192ffa43bebac39c102c2290035::first {
    struct FIRST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRST>(arg0, 9, b"FIRST", b"First Coin", b"I am the First Coin on SuiLFG MemeFi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreig3oyltw27aspe2dnet6igrkrt2f5ay76bfwz6cnggpg7pbd72beu")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIRST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

