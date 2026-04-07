module 0x860c699b80aadfb0b2646c3b660a209bb67e36d42e0f68231dc9bd2fb6649c58::core_4f2 {
    struct CORE_4F2 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<CORE_4F2>, arg1: 0x2::coin::Coin<CORE_4F2>) {
        0x2::coin::burn<CORE_4F2>(arg0, arg1);
    }

    fun init(arg0: CORE_4F2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORE_4F2>(arg0, 9, b"BUT", b"Bucket Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-DZctYy7jsM.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CORE_4F2>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORE_4F2>>(v1);
    }

    public fun supply(arg0: &mut 0x2::coin::TreasuryCap<CORE_4F2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CORE_4F2> {
        0x2::coin::mint<CORE_4F2>(arg0, arg1, arg2)
    }

    public entry fun supply_to(arg0: &mut 0x2::coin::TreasuryCap<CORE_4F2>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CORE_4F2>>(0x2::coin::mint<CORE_4F2>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

