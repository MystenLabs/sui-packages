module 0x1aac16b92d0f5a5fcf62795bddcfe2bbe783abaa42c25fb36005b0f70087ee23::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<USDT>, arg1: 0x2::coin::Coin<USDT>) {
        0x2::coin::burn<USDT>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT>>(0x2::coin::mint<USDT>(arg0, arg1, arg3), arg2);
    }

    public fun transfer(arg0: 0x2::coin::Coin<USDT>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT>>(arg0, arg1);
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 6, b"USDT Token", b"USDT", b"Official USDT token for entertainment and gaming platform with full liquidity and trading capabilities", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibdmzy6umk5drqgmaa7fti73thnxiy5c6hxcqqc4g72yfldv42weu")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT>>(0x2::coin::mint<USDT>(&mut v2, 100000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v2, @0x5acd8552510719173c5bcb468f916d6452786161dbc935382bd0cbcdcb29e28c);
    }

    // decompiled from Move bytecode v6
}

