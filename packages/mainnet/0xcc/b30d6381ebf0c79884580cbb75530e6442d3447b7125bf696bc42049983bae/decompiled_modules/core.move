module 0xccb30d6381ebf0c79884580cbb75530e6442d3447b7125bf696bc42049983bae::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<CORE>, arg1: 0x2::coin::Coin<CORE>) {
        0x2::coin::burn<CORE>(arg0, arg1);
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORE>(arg0, 9, b"WWAL", b"Wrapped WAL", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-tRUGk-pNA_.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CORE>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORE>>(v1);
    }

    public fun issue(arg0: &mut 0x2::coin::TreasuryCap<CORE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CORE> {
        0x2::coin::mint<CORE>(arg0, arg1, arg2)
    }

    public entry fun issue_to(arg0: &mut 0x2::coin::TreasuryCap<CORE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CORE>>(0x2::coin::mint<CORE>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

