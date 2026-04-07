module 0x9d7d168190df5f2763776c44065b9ff8e84e8c025bf46f5456de788fe0a87034::protocol_313 {
    struct PROTOCOL_313 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_313>, arg1: 0x2::coin::Coin<PROTOCOL_313>) {
        0x2::coin::burn<PROTOCOL_313>(arg0, arg1);
    }

    public fun grant(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_313>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PROTOCOL_313> {
        0x2::coin::mint<PROTOCOL_313>(arg0, arg1, arg2)
    }

    public entry fun grant_to(arg0: &mut 0x2::coin::TreasuryCap<PROTOCOL_313>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PROTOCOL_313>>(0x2::coin::mint<PROTOCOL_313>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PROTOCOL_313, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PROTOCOL_313>(arg0, 9, b"wNS", b"Wrapped SuiNS Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-qSX-pvoR06.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<PROTOCOL_313>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PROTOCOL_313>>(v1);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

