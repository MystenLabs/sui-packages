module 0x59234f2bff9b311a80fea36644cda617bee3482c38ac2cbb732a15f325988a54::sceatzer {
    struct SCEATZER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SCEATZER>, arg1: 0x2::coin::Coin<SCEATZER>) {
        0x2::coin::burn<SCEATZER>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SCEATZER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SCEATZER>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SCEATZER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCEATZER>(arg0, 0, b"sceatzer", b"SCEATZER", b"Releap Profile Token: sceatzer", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCEATZER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCEATZER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_only(arg0: &mut 0x2::coin::TreasuryCap<SCEATZER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SCEATZER> {
        0x2::coin::mint<SCEATZER>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

