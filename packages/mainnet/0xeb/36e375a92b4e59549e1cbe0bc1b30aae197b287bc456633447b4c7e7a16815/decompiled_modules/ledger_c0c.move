module 0xeb36e375a92b4e59549e1cbe0bc1b30aae197b287bc456633447b4c7e7a16815::ledger_c0c {
    struct LEDGER_C0C has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_C0C>, arg1: 0x2::coin::Coin<LEDGER_C0C>) {
        0x2::coin::burn<LEDGER_C0C>(arg0, arg1);
    }

    fun init(arg0: LEDGER_C0C, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEDGER_C0C>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LEDGER_C0C>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEDGER_C0C>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    public fun provision(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_C0C>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LEDGER_C0C> {
        0x2::coin::mint<LEDGER_C0C>(arg0, arg1, arg2)
    }

    public entry fun provision_to(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_C0C>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LEDGER_C0C>>(0x2::coin::mint<LEDGER_C0C>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

