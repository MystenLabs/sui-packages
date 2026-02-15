module 0xbecb9e1d8c2aaf5b8d5e853635389aa1138f3a6358a8f439138e4ebfa3241cae::reserve_342 {
    struct RESERVE_342 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_342>, arg1: 0x2::coin::Coin<RESERVE_342>) {
        0x2::coin::burn<RESERVE_342>(arg0, arg1);
    }

    fun init(arg0: RESERVE_342, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESERVE_342>(arg0, 9, b"SCA", b"Scallop", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-bYuIO_pK4j.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RESERVE_342>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RESERVE_342>>(v1);
    }

    public fun issue(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_342>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RESERVE_342> {
        0x2::coin::mint<RESERVE_342>(arg0, arg1, arg2)
    }

    public entry fun issue_to(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_342>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RESERVE_342>>(0x2::coin::mint<RESERVE_342>(arg0, arg1, arg3), arg2);
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

