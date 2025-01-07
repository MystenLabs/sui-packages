module 0x70ed7f391a74193d38b40875e467e051f83cf7adf7899eddc386b3c138ed24eb::pepe_sui {
    struct PEPE_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE_SUI>(arg0, 6, b"pSUI", b"Pepe Sui", b"telegram: PepeSuiChain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/0JwYpS5.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE_SUI>>(v1);
        0x2::coin::mint_and_transfer<PEPE_SUI>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPE_SUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

