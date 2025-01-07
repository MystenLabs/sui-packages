module 0x22e94763e1a1fb14f778e72d3b077a91a934296acc2749f097105b127e591c49::suins {
    struct SUINS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUINS>, arg1: 0x2::coin::Coin<SUINS>) {
        0x2::coin::burn<SUINS>(arg0, arg1);
    }

    fun init(arg0: SUINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINS>(arg0, 2, b"SUINS", b"SUINS", b"suins", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUINS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUINS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

