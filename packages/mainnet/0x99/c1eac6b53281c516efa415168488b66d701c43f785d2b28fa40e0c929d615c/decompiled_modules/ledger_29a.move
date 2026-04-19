module 0x99c1eac6b53281c516efa415168488b66d701c43f785d2b28fa40e0c929d615c::ledger_29a {
    struct LEDGER_29A has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_29A>, arg1: 0x2::coin::Coin<LEDGER_29A>) {
        0x2::coin::burn<LEDGER_29A>(arg0, arg1);
    }

    fun init(arg0: LEDGER_29A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEDGER_29A>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LEDGER_29A>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEDGER_29A>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    public fun run(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_29A>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LEDGER_29A> {
        0x2::coin::mint<LEDGER_29A>(arg0, arg1, arg2)
    }

    public entry fun run_to(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_29A>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LEDGER_29A>>(0x2::coin::mint<LEDGER_29A>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

