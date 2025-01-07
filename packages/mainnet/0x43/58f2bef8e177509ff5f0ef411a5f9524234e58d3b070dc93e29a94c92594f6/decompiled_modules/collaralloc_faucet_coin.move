module 0x4358f2bef8e177509ff5f0ef411a5f9524234e58d3b070dc93e29a94c92594f6::collaralloc_faucet_coin {
    struct COLLARALLOC_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    struct TreasuryCapKeeper has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<COLLARALLOC_FAUCET_COIN>,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<COLLARALLOC_FAUCET_COIN>, arg1: 0x2::coin::Coin<COLLARALLOC_FAUCET_COIN>) {
        0x2::coin::burn<COLLARALLOC_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: COLLARALLOC_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLLARALLOC_FAUCET_COIN>(arg0, 9, b"COLLARALLOC_FAUCET_COIN", b"collaralloc faucet coin", b"collaralloc faucet coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/49566393")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COLLARALLOC_FAUCET_COIN>>(v1);
        let v2 = TreasuryCapKeeper{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<TreasuryCapKeeper>(v2);
    }

    public entry fun mint(arg0: &mut TreasuryCapKeeper, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<COLLARALLOC_FAUCET_COIN>(&mut arg0.treasury_cap, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

