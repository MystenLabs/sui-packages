module 0x36ab475333c171f5a2a83ba8b93e157603257e2467c4932cc3d4bd5bd90a886::shim {
    struct SHIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIM>(arg0, 9, b"SHIM", b"Shima Enaga", b"SHIM Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIM>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHIM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHIM>(arg0, arg1, arg2, arg3);
    }

    public entry fun total_supply() : u64 {
        20000000000
    }

    // decompiled from Move bytecode v6
}

