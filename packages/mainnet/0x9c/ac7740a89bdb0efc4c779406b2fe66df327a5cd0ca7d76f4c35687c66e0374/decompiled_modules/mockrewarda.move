module 0x9cac7740a89bdb0efc4c779406b2fe66df327a5cd0ca7d76f4c35687c66e0374::mockrewarda {
    struct MOCKREWARDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCKREWARDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCKREWARDA>(arg0, 9, b"MockRewardA", b"Migration rehearsal coin", b"Testnet staking and rewards rehearsal", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCKREWARDA>>(0x2::coin::mint<MOCKREWARDA>(&mut v2, 100000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCKREWARDA>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCKREWARDA>>(v1);
    }

    // decompiled from Move bytecode v7
}

