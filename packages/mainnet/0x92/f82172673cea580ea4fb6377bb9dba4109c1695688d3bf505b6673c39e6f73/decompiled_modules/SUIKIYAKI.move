module 0x92f82172673cea580ea4fb6377bb9dba4109c1695688d3bf505b6673c39e6f73::SUIKIYAKI {
    struct SUIKIYAKI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIKIYAKI>, arg1: 0x2::coin::Coin<SUIKIYAKI>) {
        0x2::coin::burn<SUIKIYAKI>(arg0, arg1);
    }

    fun init(arg0: SUIKIYAKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKIYAKI>(arg0, 9, b"SUIKIYAKI", b"SUIKIYAKI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKIYAKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKIYAKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIKIYAKI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIKIYAKI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

