module 0x31f4ac1bf3e54f5991d1142c99a83aaa2a4fb8fb128ee5942907184d5377ce51::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<USDT>, arg1: 0x2::coin::Coin<USDT>) {
        0x2::coin::burn<USDT>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT>>(0x2::coin::mint<USDT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 9, b"USDD", b"Tether USDD", b"yulezhuanyong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZTdTrRfQhYMZhywkKBZiKWe3XXgKXoupH7eN5vEjw1Mf")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDT>>(v1);
        let v3 = &mut v2;
        mint(v3, 1320000000000000, @0x3b00383fd3d4ba0ff00cdbaa8f99bbc6adcf156fcf134a8c46f778e39f8401f, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v2, @0x3b00383fd3d4ba0ff00cdbaa8f99bbc6adcf156fcf134a8c46f778e39f8401f);
    }

    // decompiled from Move bytecode v6
}

