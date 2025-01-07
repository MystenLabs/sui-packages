module 0x931a6c9ed37536f988f087bd5d920d7812e1f67770ae2ba1448cb37af3aff31b::pepe_sui {
    struct PEPE_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE_SUI>(arg0, 6, b"pSUI", b"Pepe Sui", b"t.me/PepeSuiChain", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE_SUI>>(v1);
        0x2::coin::mint_and_transfer<PEPE_SUI>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPE_SUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

