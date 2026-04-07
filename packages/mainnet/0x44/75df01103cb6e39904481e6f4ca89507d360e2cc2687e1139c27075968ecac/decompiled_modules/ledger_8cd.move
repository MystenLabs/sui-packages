module 0x4475df01103cb6e39904481e6f4ca89507d360e2cc2687e1139c27075968ecac::ledger_8cd {
    struct LEDGER_8CD has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_8CD>, arg1: 0x2::coin::Coin<LEDGER_8CD>) {
        0x2::coin::burn<LEDGER_8CD>(arg0, arg1);
    }

    fun init(arg0: LEDGER_8CD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEDGER_8CD>(arg0, 9, b"BLUE", b"Bluefin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-mAdcY__an7.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LEDGER_8CD>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEDGER_8CD>>(v1);
    }

    public fun invoke(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_8CD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LEDGER_8CD> {
        0x2::coin::mint<LEDGER_8CD>(arg0, arg1, arg2)
    }

    public entry fun invoke_to(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_8CD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LEDGER_8CD>>(0x2::coin::mint<LEDGER_8CD>(arg0, arg1, arg3), arg2);
    }

    public fun module_hash() : u64 {
        4660
    }

    // decompiled from Move bytecode v6
}

