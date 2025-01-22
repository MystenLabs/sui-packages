module 0x838cf1e3d440ce4fbb411feda409a4d7e23c869ae2a5e5a440b4c82fe5fdcfff::devine {
    struct DEVINE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEVINE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEVINE>>(0x2::coin::mint<DEVINE>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: DEVINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEVINE>(arg0, 9, b"DEVI", b"Devine", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEVINE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEVINE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

