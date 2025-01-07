module 0x208ef05d6b4bc53460b1f8731627d15f0a805a4080860cbf722fec813116cd24::pets {
    struct PETS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PETS>, arg1: 0x2::coin::Coin<PETS>) {
        0x2::coin::burn<PETS>(arg0, arg1);
    }

    fun init(arg0: PETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PETS>(arg0, 6, b"PETS", b"PETS SUI TOKEN", b"PETS GAMEFI ON SUI NETWORK", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PETS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PETS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PETS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PETS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

