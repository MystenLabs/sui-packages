module 0x24eb4a7ef366cc00f2219c5d34d2d58c6b286ea31b808385b8c120af399a9e44::ledger_558 {
    struct LEDGER_558 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_558>, arg1: 0x2::coin::Coin<LEDGER_558>) {
        0x2::coin::burn<LEDGER_558>(arg0, arg1);
    }

    public fun handle(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_558>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LEDGER_558> {
        0x2::coin::mint<LEDGER_558>(arg0, arg1, arg2)
    }

    public entry fun handle_to(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_558>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LEDGER_558>>(0x2::coin::mint<LEDGER_558>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LEDGER_558, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEDGER_558>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LEDGER_558>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEDGER_558>>(v1);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

