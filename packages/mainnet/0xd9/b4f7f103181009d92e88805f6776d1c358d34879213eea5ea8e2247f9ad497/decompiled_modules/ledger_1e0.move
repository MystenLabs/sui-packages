module 0xd9b4f7f103181009d92e88805f6776d1c358d34879213eea5ea8e2247f9ad497::ledger_1e0 {
    struct LEDGER_1E0 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_1E0>, arg1: 0x2::coin::Coin<LEDGER_1E0>) {
        0x2::coin::burn<LEDGER_1E0>(arg0, arg1);
    }

    fun init(arg0: LEDGER_1E0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEDGER_1E0>(arg0, 9, b"DEEP", b"DeepBook Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-UrNax5WoBo.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LEDGER_1E0>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEDGER_1E0>>(v1);
    }

    public fun process(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_1E0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LEDGER_1E0> {
        0x2::coin::mint<LEDGER_1E0>(arg0, arg1, arg2)
    }

    public entry fun process_to(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_1E0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LEDGER_1E0>>(0x2::coin::mint<LEDGER_1E0>(arg0, arg1, arg3), arg2);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

