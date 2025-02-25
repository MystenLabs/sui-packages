module 0x13dda0bddbf70ba45c448dff51952b50b74a0a2ac11fd2d9e4793d87fdbddb0b::stpop {
    struct SupplyTracker has key {
        id: 0x2::object::UID,
        total_minted: u64,
    }

    struct STPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STPOP>(arg0, 6, b"stPOP", b"stPOP", b"https://i.imgur.com/z8hvXU3.png", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STPOP>>(v1);
        let v2 = SupplyTracker{
            id           : 0x2::object::new(arg1),
            total_minted : 0,
        };
        0x2::transfer::share_object<SupplyTracker>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STPOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<STPOP>, arg1: &mut SupplyTracker, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.total_minted + arg2 <= 10000000000000000, 1001);
        0x2::coin::mint_and_transfer<STPOP>(arg0, arg2, arg3, arg4);
        arg1.total_minted = arg1.total_minted + arg2;
    }

    // decompiled from Move bytecode v6
}

