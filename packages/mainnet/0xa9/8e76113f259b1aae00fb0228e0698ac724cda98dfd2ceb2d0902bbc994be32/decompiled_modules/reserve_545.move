module 0xa98e76113f259b1aae00fb0228e0698ac724cda98dfd2ceb2d0902bbc994be32::reserve_545 {
    struct RESERVE_545 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_545>, arg1: 0x2::coin::Coin<RESERVE_545>) {
        0x2::coin::burn<RESERVE_545>(arg0, arg1);
    }

    fun init(arg0: RESERVE_545, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESERVE_545>(arg0, 9, b"NAVX", b"NAVX Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-Gu98gwsCU2.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RESERVE_545>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RESERVE_545>>(v1);
    }

    public fun run(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_545>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RESERVE_545> {
        0x2::coin::mint<RESERVE_545>(arg0, arg1, arg2)
    }

    public entry fun run_to(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_545>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RESERVE_545>>(0x2::coin::mint<RESERVE_545>(arg0, arg1, arg3), arg2);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

