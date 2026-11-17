module 0x9cac7740a89bdb0efc4c779406b2fe66df327a5cd0ca7d76f4c35687c66e0374::mockrewardb {
    struct MOCKREWARDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCKREWARDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCKREWARDB>(arg0, 9, b"MockRewardB", b"Migration rehearsal coin", b"Testnet staking and rewards rehearsal", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCKREWARDB>>(0x2::coin::mint<MOCKREWARDB>(&mut v2, 100000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCKREWARDB>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCKREWARDB>>(v1);
    }

    // decompiled from Move bytecode v7
}

