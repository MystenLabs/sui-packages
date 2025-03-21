module 0xf4391882cb8b79c172a238d75b1af388b47137fdfbf81797d43d5a1eb5c6f93f::titan {
    struct TITAN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TITAN>, arg1: 0x2::coin::Coin<TITAN>) {
        0x2::coin::burn<TITAN>(arg0, arg1);
    }

    fun init(arg0: TITAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITAN>(arg0, 9, b"TITAN", b"Titanium", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TITAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TITAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TITAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

