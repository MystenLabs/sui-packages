module 0x8d18b60908baa2aabd2db3e516c6eb32b058cf71bd7e31a4c27967bd52dd9474::capo_sui {
    struct CAPO_SUI has drop {
        dummy_field: bool,
    }

    struct TotalSupply has store, key {
        id: 0x2::object::UID,
        supply: u64,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CAPO_SUI>, arg1: u64, arg2: address, arg3: &mut TotalSupply, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.supply + arg1 <= 1000000000000000000, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<CAPO_SUI>>(0x2::coin::mint<CAPO_SUI>(arg0, arg1, arg4), arg2);
        arg3.supply = arg3.supply + arg1;
    }

    fun init(arg0: CAPO_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPO_SUI>(arg0, 9, b"CAPO", b"CapoSui", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = TotalSupply{
            id     : 0x2::object::new(arg1),
            supply : 0,
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPO_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPO_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<TotalSupply>(v2);
    }

    // decompiled from Move bytecode v6
}

