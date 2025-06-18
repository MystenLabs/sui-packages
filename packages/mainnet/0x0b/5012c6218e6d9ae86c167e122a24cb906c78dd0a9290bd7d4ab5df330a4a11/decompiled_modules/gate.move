module 0xb5012c6218e6d9ae86c167e122a24cb906c78dd0a9290bd7d4ab5df330a4a11::gate {
    struct GATE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GATE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GATE>>(0x2::coin::mint<GATE>(arg0, arg1 * 1000000000, arg3), arg2);
    }

    fun init(arg0: GATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATE>(arg0, 9, b"GATE", b"nft gate", b"asdf sadfds fdsfasdfsdf asdfds fsdfsdf ds", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://plz.money/coin-icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<GATE>>(0x2::coin::mint<GATE>(&mut v2, 1 * 1000000000 / 100 * 1000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GATE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

