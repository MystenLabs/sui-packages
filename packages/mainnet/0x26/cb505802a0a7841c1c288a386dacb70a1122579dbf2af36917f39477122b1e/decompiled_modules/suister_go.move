module 0x26cb505802a0a7841c1c288a386dacb70a1122579dbf2af36917f39477122b1e::suister_go {
    struct SUISTER_GO has drop {
        dummy_field: bool,
    }

    struct MaxSupply has store, key {
        id: 0x2::object::UID,
        supply: u64,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISTER_GO>, arg1: u64, arg2: address, arg3: &mut MaxSupply, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.supply + arg1 <= 10000000000000000000, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISTER_GO>>(0x2::coin::mint<SUISTER_GO>(arg0, arg1, arg4), arg2);
        arg3.supply = arg3.supply + arg1;
    }

    fun init(arg0: SUISTER_GO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTER_GO>(arg0, 9, b"STG", b"Suister Go", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = MaxSupply{
            id     : 0x2::object::new(arg1),
            supply : 0,
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISTER_GO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTER_GO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<MaxSupply>(v2);
    }

    // decompiled from Move bytecode v6
}

