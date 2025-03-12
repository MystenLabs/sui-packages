module 0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::leader_board {
    struct LEADER_BOARD has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LEADER_BOARD>, arg1: 0x2::coin::Coin<LEADER_BOARD>) {
        0x2::coin::burn<LEADER_BOARD>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LEADER_BOARD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LEADER_BOARD>>(0x2::coin::mint<LEADER_BOARD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LEADER_BOARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEADER_BOARD>(arg0, 9, b"BLT", b"Blavechain Leaderboard Token", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEADER_BOARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEADER_BOARD>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<LEADER_BOARD>>(0x2::coin::mint<LEADER_BOARD>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

