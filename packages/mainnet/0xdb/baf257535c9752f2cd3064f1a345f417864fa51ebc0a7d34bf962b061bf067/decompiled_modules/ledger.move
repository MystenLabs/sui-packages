module 0xdbbaf257535c9752f2cd3064f1a345f417864fa51ebc0a7d34bf962b061bf067::ledger {
    struct LEDGER has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<LEDGER>, arg1: 0x2::coin::Coin<LEDGER>) {
        0x2::coin::burn<LEDGER>(arg0, arg1);
    }

    public fun grant(arg0: &mut 0x2::coin::TreasuryCap<LEDGER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LEDGER> {
        0x2::coin::mint<LEDGER>(arg0, arg1, arg2)
    }

    public entry fun grant_to(arg0: &mut 0x2::coin::TreasuryCap<LEDGER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LEDGER>>(0x2::coin::mint<LEDGER>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LEDGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEDGER>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<LEDGER>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEDGER>>(v1);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

