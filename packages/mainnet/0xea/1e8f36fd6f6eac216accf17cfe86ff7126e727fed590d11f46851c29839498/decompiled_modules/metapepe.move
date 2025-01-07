module 0xea1e8f36fd6f6eac216accf17cfe86ff7126e727fed590d11f46851c29839498::metapepe {
    struct METAPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: METAPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<METAPEPE>(arg0, 2, b"METAPEPE", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<METAPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<METAPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<METAPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<METAPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

