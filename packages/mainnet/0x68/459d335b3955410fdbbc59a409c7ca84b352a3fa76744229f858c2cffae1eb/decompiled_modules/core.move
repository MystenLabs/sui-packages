module 0x68459d335b3955410fdbbc59a409c7ca84b352a3fa76744229f858c2cffae1eb::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<CORE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CORE>>(arg0, arg1);
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORE>(arg0, 9, b"TOKEN", b"Random Token", b"Random Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<CORE>(&mut v2, 600000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORE>>(v2, v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORE>>(v1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CORE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CORE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

