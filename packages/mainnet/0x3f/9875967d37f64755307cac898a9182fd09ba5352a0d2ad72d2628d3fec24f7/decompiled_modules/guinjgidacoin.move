module 0x3f9875967d37f64755307cac898a9182fd09ba5352a0d2ad72d2628d3fec24f7::guinjgidacoin {
    struct GUINJGIDACOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GUINJGIDACOIN>, arg1: 0x2::coin::Coin<GUINJGIDACOIN>) {
        0x2::coin::burn<GUINJGIDACOIN>(arg0, arg1);
    }

    fun init(arg0: GUINJGIDACOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUINJGIDACOIN>(arg0, 6, b"COIN", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUINJGIDACOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUINJGIDACOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GUINJGIDACOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GUINJGIDACOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

