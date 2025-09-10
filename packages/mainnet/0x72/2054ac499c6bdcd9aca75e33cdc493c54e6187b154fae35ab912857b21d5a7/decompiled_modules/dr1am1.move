module 0x722054ac499c6bdcd9aca75e33cdc493c54e6187b154fae35ab912857b21d5a7::dr1am1 {
    struct DR1AM1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DR1AM1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DR1AM1>(arg0, 8, b"DR1AM1", b"DR1AM1", b"this is dr1am1coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DR1AM1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DR1AM1>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<DR1AM1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DR1AM1>>(0x2::coin::mint<DR1AM1>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

