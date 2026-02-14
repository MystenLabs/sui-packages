module 0xd007a31ab375e7c935fc46bf72e9cb8d2a7976ed72837b2c1061760d47455978::ledger {
    struct LEDGER has drop {
        dummy_field: bool,
    }

    public fun allocate(arg0: &mut 0x2::coin::TreasuryCap<LEDGER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LEDGER> {
        0x2::coin::mint<LEDGER>(arg0, arg1, arg2)
    }

    public entry fun allocate_to(arg0: &mut 0x2::coin::TreasuryCap<LEDGER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LEDGER>>(0x2::coin::mint<LEDGER>(arg0, arg1, arg3), arg2);
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<LEDGER>, arg1: 0x2::coin::Coin<LEDGER>) {
        0x2::coin::burn<LEDGER>(arg0, arg1);
    }

    fun init(arg0: LEDGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEDGER>(arg0, 9, b"WDEEP", b"DeepBook Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-6ncg2P-RyS.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LEDGER>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEDGER>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

