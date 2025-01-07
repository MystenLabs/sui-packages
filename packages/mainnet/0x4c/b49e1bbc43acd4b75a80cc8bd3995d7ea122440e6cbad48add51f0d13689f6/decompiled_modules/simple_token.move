module 0x4cb49e1bbc43acd4b75a80cc8bd3995d7ea122440e6cbad48add51f0d13689f6::simple_token {
    struct SIMPLE_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMPLE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMPLE_TOKEN>(arg0, 9, b"MANAGED", b"MANAGED", b"Managed coin", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIMPLE_TOKEN>(&mut v2, 1000000000000, @0x1d88d908f1fc79368c4add5a8c3a3c37e981eef92c27e70796fbc3376451f02d, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPLE_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIMPLE_TOKEN>>(v1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIMPLE_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SIMPLE_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

