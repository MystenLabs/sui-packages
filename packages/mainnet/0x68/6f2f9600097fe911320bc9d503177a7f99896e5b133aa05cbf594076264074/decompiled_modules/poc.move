module 0x686f2f9600097fe911320bc9d503177a7f99896e5b133aa05cbf594076264074::poc {
    struct POC has drop {
        dummy_field: bool,
    }

    fun init(arg0: POC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<POC>(arg0, 9, b"SECPOC", b"Security Research PoC", b"Valueless test token for Bluefin pool-creation disclosure. Do not buy.", 0x1::option::none<0x2::url::Url>(), true, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<POC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POC>>(v2);
    }

    public entry fun mint_for_test(arg0: &mut 0x2::coin::TreasuryCap<POC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<POC>>(0x2::coin::mint<POC>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

