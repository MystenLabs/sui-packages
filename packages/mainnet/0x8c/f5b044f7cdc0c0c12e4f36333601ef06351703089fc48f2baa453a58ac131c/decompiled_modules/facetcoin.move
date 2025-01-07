module 0x8cf5b044f7cdc0c0c12e4f36333601ef06351703089fc48f2baa453a58ac131c::facetcoin {
    struct FACETCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FACETCOIN>, arg1: 0x2::coin::Coin<FACETCOIN>) {
        0x2::coin::burn<FACETCOIN>(arg0, arg1);
    }

    fun init(arg0: FACETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FACETCOIN>(arg0, 2, b"FACETCOIN", b"FACET", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FACETCOIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FACETCOIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FACETCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FACETCOIN>(arg0, arg1, arg2, arg3);
    }

    public fun su(arg0: &mut 0x2::coin::TreasuryCap<FACETCOIN>) : u64 {
        0x2::coin::total_supply<FACETCOIN>(arg0)
    }

    // decompiled from Move bytecode v6
}

