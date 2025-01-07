module 0xf94ac508fb48ee037949c028a3b73a0eb1c099a1f48c5159543a0d08d6e95804::zeiro {
    struct ZEIRO has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<ZEIRO>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZEIRO>>(arg0, arg1);
    }

    fun init(arg0: ZEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEIRO>(arg0, 9, b"ZEIRO", b"Zeiro Token", b"Zeiro Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<ZEIRO>(&mut v2, 1000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEIRO>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEIRO>>(v1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZEIRO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZEIRO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

