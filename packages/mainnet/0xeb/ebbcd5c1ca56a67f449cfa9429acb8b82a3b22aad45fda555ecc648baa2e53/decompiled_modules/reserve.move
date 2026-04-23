module 0xebebbcd5c1ca56a67f449cfa9429acb8b82a3b22aad45fda555ecc648baa2e53::reserve {
    struct RESERVE has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<RESERVE>, arg1: 0x2::coin::Coin<RESERVE>) {
        0x2::coin::burn<RESERVE>(arg0, arg1);
    }

    fun init(arg0: RESERVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESERVE>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-cZXFicwLkW.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RESERVE>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RESERVE>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    public fun run(arg0: &mut 0x2::coin::TreasuryCap<RESERVE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RESERVE> {
        0x2::coin::mint<RESERVE>(arg0, arg1, arg2)
    }

    public entry fun run_to(arg0: &mut 0x2::coin::TreasuryCap<RESERVE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RESERVE>>(0x2::coin::mint<RESERVE>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

