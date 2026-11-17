module 0xb1b03755f889cb4334f2017f4bcb9bf15019a4a290aab17c739ba60e81b3532c::junk {
    struct JUNK has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<JUNK>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JUNK> {
        0x2::coin::mint<JUNK>(arg0, arg1, arg2)
    }

    fun init(arg0: JUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUNK>(arg0, 9, b"JUNK", b"PoC JUNK", b"deep-vault-drain devInspect reproduction", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JUNK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUNK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

