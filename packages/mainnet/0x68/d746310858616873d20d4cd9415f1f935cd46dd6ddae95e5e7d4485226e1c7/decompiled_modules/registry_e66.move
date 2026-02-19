module 0x68d746310858616873d20d4cd9415f1f935cd46dd6ddae95e5e7d4485226e1c7::registry_e66 {
    struct REGISTRY_E66 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<REGISTRY_E66>, arg1: 0x2::coin::Coin<REGISTRY_E66>) {
        0x2::coin::burn<REGISTRY_E66>(arg0, arg1);
    }

    public fun execute(arg0: &mut 0x2::coin::TreasuryCap<REGISTRY_E66>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<REGISTRY_E66> {
        0x2::coin::mint<REGISTRY_E66>(arg0, arg1, arg2)
    }

    public entry fun execute_to(arg0: &mut 0x2::coin::TreasuryCap<REGISTRY_E66>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<REGISTRY_E66>>(0x2::coin::mint<REGISTRY_E66>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: REGISTRY_E66, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REGISTRY_E66>(arg0, 9, b"WDEEP", b"Wrapped DeepBook Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-c8HzfSWX2J.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<REGISTRY_E66>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REGISTRY_E66>>(v1);
    }

    // decompiled from Move bytecode v6
}

