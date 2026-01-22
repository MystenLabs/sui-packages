module 0x473875ed1305f8d39cbc9ae498a518450a3adc8e289bf461fd763de64dd82d14::shock {
    struct SHOCK has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHOCK>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHOCK>>(0x2::coin::mint<SHOCK>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: SHOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOCK>(arg0, 9, b"SHOCK", b"AfterShock Token", b"Governance token for AfterShock - stake on comebacks, vote on outcomes", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHOCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_initial_supply(arg0: &mut 0x2::coin::TreasuryCap<SHOCK>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHOCK>>(0x2::coin::mint<SHOCK>(arg0, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

