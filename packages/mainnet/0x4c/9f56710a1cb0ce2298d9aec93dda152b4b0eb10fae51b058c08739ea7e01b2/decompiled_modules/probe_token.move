module 0x4c9f56710a1cb0ce2298d9aec93dda152b4b0eb10fae51b058c08739ea7e01b2::probe_token {
    struct PROBE_TOKEN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PROBE_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PROBE_TOKEN>>(0x2::coin::mint<PROBE_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PROBE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROBE_TOKEN>(arg0, 9, b"SUI", b"Sui", b"CEX deposit probe token. No value.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROBE_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PROBE_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

