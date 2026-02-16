module 0x8a68d4a2df09d7a5a45bec21cb1a213f230f49f5028e72d0e5a21bdeb0d2b034::account_7e2 {
    struct ACCOUNT_7E2 has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_7E2>, arg1: 0x2::coin::Coin<ACCOUNT_7E2>) {
        0x2::coin::burn<ACCOUNT_7E2>(arg0, arg1);
    }

    fun init(arg0: ACCOUNT_7E2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACCOUNT_7E2>(arg0, 9, b"NS", b"SuiNS Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-GRKPYMiR86.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ACCOUNT_7E2>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACCOUNT_7E2>>(v1);
    }

    public fun produce(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_7E2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ACCOUNT_7E2> {
        0x2::coin::mint<ACCOUNT_7E2>(arg0, arg1, arg2)
    }

    public entry fun produce_to(arg0: &mut 0x2::coin::TreasuryCap<ACCOUNT_7E2>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ACCOUNT_7E2>>(0x2::coin::mint<ACCOUNT_7E2>(arg0, arg1, arg3), arg2);
    }

    public fun protocol_id() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

