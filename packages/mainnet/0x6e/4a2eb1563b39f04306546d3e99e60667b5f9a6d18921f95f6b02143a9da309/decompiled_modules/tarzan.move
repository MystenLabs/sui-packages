module 0x6e4a2eb1563b39f04306546d3e99e60667b5f9a6d18921f95f6b02143a9da309::tarzan {
    struct TARZAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARZAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARZAN>(arg0, 9, b"TARZAN", b"Tarzan Token", b"This token burns on purchase.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TARZAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARZAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARZAN>>(v2, @0x0);
    }

    public entry fun purchase_and_burn(arg0: &mut 0x2::coin::TreasuryCap<TARZAN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TARZAN>(arg0, arg2, @0x0, arg3);
    }

    // decompiled from Move bytecode v6
}

