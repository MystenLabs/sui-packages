module 0x433197fb5e6c5820db659b83168237229ec080c0031cc49bf8ac1366006017f6::ab_token {
    struct AB_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun a(arg0: &mut 0x2::coin::TreasuryCap<AB_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AB_TOKEN>(arg0, arg1, arg2, arg3);
    }

    public entry fun b(arg0: &mut 0x2::coin::TreasuryCap<AB_TOKEN>, arg1: 0x2::coin::Coin<AB_TOKEN>) {
        0x2::coin::burn<AB_TOKEN>(arg0, arg1);
    }

    fun init(arg0: AB_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AB_TOKEN>(arg0, 9, b"ABTK", b"AB Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AB_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AB_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_token(arg0: 0x2::coin::Coin<AB_TOKEN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AB_TOKEN>>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

