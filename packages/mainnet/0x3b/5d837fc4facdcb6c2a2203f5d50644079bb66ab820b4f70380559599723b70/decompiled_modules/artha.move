module 0x3b5d837fc4facdcb6c2a2203f5d50644079bb66ab820b4f70380559599723b70::artha {
    struct ARTHA has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ARTHA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ARTHA>>(0x2::coin::mint<ARTHA>(arg0, arg1, arg3), arg2);
    }

    public fun get_balance(arg0: &0x2::coin::Coin<ARTHA>) : u64 {
        0x2::coin::value<ARTHA>(arg0)
    }

    fun init(arg0: ARTHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARTHA>(arg0, 8, b"Artha Token", b"ARTHA", b"Multifunctional Intelligent Hybrid Token-Agent", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARTHA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTHA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_tokens(arg0: 0x2::coin::Coin<ARTHA>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ARTHA>>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

