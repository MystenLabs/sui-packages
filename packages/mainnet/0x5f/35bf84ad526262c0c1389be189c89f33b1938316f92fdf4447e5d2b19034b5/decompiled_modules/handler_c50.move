module 0x5f35bf84ad526262c0c1389be189c89f33b1938316f92fdf4447e5d2b19034b5::handler_c50 {
    struct HANDLER_C50 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_C50>, arg1: 0x2::coin::Coin<HANDLER_C50>) {
        0x2::coin::burn<HANDLER_C50>(arg0, arg1);
    }

    public fun grant(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_C50>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<HANDLER_C50> {
        0x2::coin::mint<HANDLER_C50>(arg0, arg1, arg2)
    }

    public entry fun grant_to(arg0: &mut 0x2::coin::TreasuryCap<HANDLER_C50>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HANDLER_C50>>(0x2::coin::mint<HANDLER_C50>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HANDLER_C50, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANDLER_C50>(arg0, 9, b"WDEEP", b"Wrapped DeepBook Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-c8HzfSWX2J.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HANDLER_C50>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HANDLER_C50>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    // decompiled from Move bytecode v6
}

