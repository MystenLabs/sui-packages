module 0x5fa1a02eaad027e51bb4185f54ea32f883ebbdbfa60ea0c36ecc5efbe69e5843::suibonk {
    struct SUIBONK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIBONK>, arg1: 0x2::coin::Coin<SUIBONK>) {
        0x2::coin::burn<SUIBONK>(arg0, arg1);
    }

    fun init(arg0: SUIBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBONK>(arg0, 9, b"SUBONK", b"SuiBonk", b"Welcome to SuiBonk, telegram trading bot for the SUI Network", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBONK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBONK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIBONK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIBONK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

