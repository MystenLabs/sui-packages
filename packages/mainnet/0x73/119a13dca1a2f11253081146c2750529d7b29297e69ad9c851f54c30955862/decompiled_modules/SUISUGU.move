module 0x73119a13dca1a2f11253081146c2750529d7b29297e69ad9c851f54c30955862::SUISUGU {
    struct SUISUGU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUISUGU>, arg1: 0x2::coin::Coin<SUISUGU>) {
        0x2::coin::burn<SUISUGU>(arg0, arg1);
    }

    fun init(arg0: SUISUGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUGU>(arg0, 9, b"SUGU", b"SUI SUGU", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISUGU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUGU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISUGU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISUGU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

