module 0xf417ec5528d9da0fccfdbe50400bec5df04bec84115e3f3b6058f489eaf36a6f::first {
    struct FIRST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRST>(arg0, 9, b"FIRST", b"The First", b"I am the first coin on SuiLFG MemeFi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreig3oyltw27aspe2dnet6igrkrt2f5ay76bfwz6cnggpg7pbd72beu")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIRST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

