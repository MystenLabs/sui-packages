module 0xf459cfce7c7fa82e7cbfd35c1af0820025d2c99cf9c3fd2d99df899e5a512b1b::ledger_225 {
    struct LEDGER_225 has drop {
        dummy_field: bool,
    }

    public fun create(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_225>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LEDGER_225> {
        0x2::coin::mint<LEDGER_225>(arg0, arg1, arg2)
    }

    public entry fun create_to(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_225>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LEDGER_225>>(0x2::coin::mint<LEDGER_225>(arg0, arg1, arg3), arg2);
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_225>, arg1: 0x2::coin::Coin<LEDGER_225>) {
        0x2::coin::burn<LEDGER_225>(arg0, arg1);
    }

    fun init(arg0: LEDGER_225, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEDGER_225>(arg0, 9, b"CETUS", b"Cetus", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-2XQlgGQUe4.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LEDGER_225>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEDGER_225>>(v1);
    }

    public fun is_active() : bool {
        true
    }

    // decompiled from Move bytecode v6
}

