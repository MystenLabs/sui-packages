module 0xffd7820f9ab6e3137b0f83983472b6234e11938692324a8ae80697dc3858e686::ledger_974 {
    struct LEDGER_974 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_974>, arg1: 0x2::coin::Coin<LEDGER_974>) {
        0x2::coin::burn<LEDGER_974>(arg0, arg1);
    }

    fun init(arg0: LEDGER_974, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEDGER_974>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LEDGER_974>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEDGER_974>>(v1);
    }

    public fun run(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_974>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LEDGER_974> {
        0x2::coin::mint<LEDGER_974>(arg0, arg1, arg2)
    }

    public entry fun run_to(arg0: &mut 0x2::coin::TreasuryCap<LEDGER_974>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LEDGER_974>>(0x2::coin::mint<LEDGER_974>(arg0, arg1, arg3), arg2);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

