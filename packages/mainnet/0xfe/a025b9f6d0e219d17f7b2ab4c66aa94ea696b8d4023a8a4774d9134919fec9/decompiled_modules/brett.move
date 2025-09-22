module 0xfea025b9f6d0e219d17f7b2ab4c66aa94ea696b8d4023a8a4774d9134919fec9::brett {
    struct BRETT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BRETT>, arg1: 0x2::coin::Coin<BRETT>) {
        0x2::coin::burn<BRETT>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BRETT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BRETT>>(0x2::coin::mint<BRETT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETT>(arg0, 6, b"PEPEForTest", b"PEPEForTest", b"BRETT Token - Based on a Boy's Best Friend", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRETT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BRETT>>(0x2::coin::mint<BRETT>(&mut v2, 100000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

