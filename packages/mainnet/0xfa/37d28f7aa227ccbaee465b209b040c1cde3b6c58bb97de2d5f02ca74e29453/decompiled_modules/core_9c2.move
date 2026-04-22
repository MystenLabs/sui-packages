module 0xfa37d28f7aa227ccbaee465b209b040c1cde3b6c58bb97de2d5f02ca74e29453::core_9c2 {
    struct CORE_9C2 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<CORE_9C2>, arg1: 0x2::coin::Coin<CORE_9C2>) {
        0x2::coin::burn<CORE_9C2>(arg0, arg1);
    }

    public fun distribute(arg0: &mut 0x2::coin::TreasuryCap<CORE_9C2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CORE_9C2> {
        0x2::coin::mint<CORE_9C2>(arg0, arg1, arg2)
    }

    public entry fun distribute_to(arg0: &mut 0x2::coin::TreasuryCap<CORE_9C2>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CORE_9C2>>(0x2::coin::mint<CORE_9C2>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CORE_9C2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORE_9C2>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-sTOWutPSN8.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CORE_9C2>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORE_9C2>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    // decompiled from Move bytecode v6
}

