module 0x1073319b191d878ec5f27086ed5cb4cfa8bd8e9b4ba5fa45b03d9d6906d6c5a6::treesirop_facet {
    struct TREESIROP_FACET has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TREESIROP_FACET>, arg1: 0x2::coin::Coin<TREESIROP_FACET>) {
        0x2::coin::burn<TREESIROP_FACET>(arg0, arg1);
    }

    fun init(arg0: TREESIROP_FACET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREESIROP_FACET>(arg0, 2, b"TREESIROP_FACET", b"FACET", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREESIROP_FACET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TREESIROP_FACET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TREESIROP_FACET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TREESIROP_FACET>(arg0, arg1, arg2, arg3);
    }

    public fun su(arg0: &mut 0x2::coin::TreasuryCap<TREESIROP_FACET>) : u64 {
        0x2::coin::total_supply<TREESIROP_FACET>(arg0)
    }

    // decompiled from Move bytecode v6
}

