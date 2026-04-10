module 0x948d04894adeb59ae7d34e960f55605cb74b83903711de864e3768663e7a8f40::controller_0a1 {
    struct CONTROLLER_0A1 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER_0A1>, arg1: 0x2::coin::Coin<CONTROLLER_0A1>) {
        0x2::coin::burn<CONTROLLER_0A1>(arg0, arg1);
    }

    public fun execute(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER_0A1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CONTROLLER_0A1> {
        0x2::coin::mint<CONTROLLER_0A1>(arg0, arg1, arg2)
    }

    public entry fun execute_to(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER_0A1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CONTROLLER_0A1>>(0x2::coin::mint<CONTROLLER_0A1>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CONTROLLER_0A1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONTROLLER_0A1>(arg0, 9, b"wSCA", b"Wrapped Scallop", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://imgurlzx.com/token-image/token-jafPKiKKMb.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CONTROLLER_0A1>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONTROLLER_0A1>>(v1);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

