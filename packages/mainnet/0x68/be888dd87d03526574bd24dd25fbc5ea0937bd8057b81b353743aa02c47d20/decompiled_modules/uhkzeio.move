module 0x68be888dd87d03526574bd24dd25fbc5ea0937bd8057b81b353743aa02c47d20::uhkzeio {
    struct UHKZEIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UHKZEIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UHKZEIO>(arg0, 0, b"UHKZEIO", b"Sui Blue Gift User HKZEIO", b"Sui Blue Gift mainnet user-flow smoke token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UHKZEIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<UHKZEIO>>(0x2::coin::mint<UHKZEIO>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UHKZEIO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

