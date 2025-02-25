module 0x76b39f4fcea01766d9bcb4818c925ea7ee8fb34361ec11458af384df218c19c2::stpop {
    struct SupplyTracker has key {
        id: 0x2::object::UID,
        total_minted: u64,
    }

    struct STPOP has drop {
        dummy_field: bool,
    }

    public fun get_total_supply(arg0: &SupplyTracker) : u64 {
        arg0.total_minted
    }

    fun init(arg0: STPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://i.imgur.com/z8hvXU3.png";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<STPOP>(arg0, 6, b"stPOP", b"stPOP", b"stPOP Utility Token", v1, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STPOP>>(v3);
        let v4 = SupplyTracker{
            id           : 0x2::object::new(arg1),
            total_minted : 0,
        };
        0x2::transfer::share_object<SupplyTracker>(v4);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STPOP>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<STPOP>, arg1: &mut SupplyTracker, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.total_minted + arg2 <= 10000000000000000, 1001);
        0x2::coin::mint_and_transfer<STPOP>(arg0, arg2, arg3, arg4);
        arg1.total_minted = arg1.total_minted + arg2;
    }

    // decompiled from Move bytecode v6
}

