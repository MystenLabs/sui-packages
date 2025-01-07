module 0xc10dbcb46e7ca4b2ec8b4c2dba88d6b56f3eb656506d3c50654e442fa53ddc42::SUITPO {
    struct SUITPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITPO>(arg0, 6, b"SUI Poseidon", b"SUITPO", b"https://pbs.twimg.com/profile_images/1746070003307425793/sZpTwIY5_400x400.jpg", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITPO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITPO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITPO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

