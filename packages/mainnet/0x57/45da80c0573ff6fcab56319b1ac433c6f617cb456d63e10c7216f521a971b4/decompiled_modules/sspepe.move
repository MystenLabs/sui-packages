module 0x5745da80c0573ff6fcab56319b1ac433c6f617cb456d63e10c7216f521a971b4::sspepe {
    struct SSPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SSPEPE>, arg1: 0x2::coin::Coin<SSPEPE>) {
        0x2::coin::burn<SSPEPE>(arg0, arg1);
    }

    fun init(arg0: SSPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSPEPE>(arg0, 2, b"PEPEOG", b"PEPEOG", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SSPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SSPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

