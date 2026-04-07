module 0x929be0139ecb238c3c09280325d63eb5a77479ec21943aa6a3e03c674d70e6a7::ledger_6e5 {
    struct LEDGER_6E5 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_6E5>, arg1: 0x2::coin::Coin<LEDGER_6E5>) {
        0x2::coin::burn<LEDGER_6E5>(arg0, arg1);
    }

    fun init(arg0: LEDGER_6E5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEDGER_6E5>(arg0, 9, b"BUT", b"Bucket Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-DZctYy7jsM.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LEDGER_6E5>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEDGER_6E5>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    public fun provision(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_6E5>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LEDGER_6E5> {
        0x2::coin::mint<LEDGER_6E5>(arg0, arg1, arg2)
    }

    public entry fun provision_to(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_6E5>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LEDGER_6E5>>(0x2::coin::mint<LEDGER_6E5>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

