module 0x1b552a0a427b271e89ca80449fe1514720b9ad22cc32cbf451e84b5947ab61a6::reserve_1f6 {
    struct RESERVE_1F6 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_1F6>, arg1: 0x2::coin::Coin<RESERVE_1F6>) {
        0x2::coin::burn<RESERVE_1F6>(arg0, arg1);
    }

    fun init(arg0: RESERVE_1F6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESERVE_1F6>(arg0, 9, b"wNS", b"Wrapped SuiNS Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-qSX-pvoR06.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RESERVE_1F6>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RESERVE_1F6>>(v1);
    }

    public fun process(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_1F6>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RESERVE_1F6> {
        0x2::coin::mint<RESERVE_1F6>(arg0, arg1, arg2)
    }

    public entry fun process_to(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_1F6>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RESERVE_1F6>>(0x2::coin::mint<RESERVE_1F6>(arg0, arg1, arg3), arg2);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

