module 0x23d729f564c60706f52d61f80ada7d74220abfd7aa0c19e89b50654a439965b::SUIPUG {
    struct SUIPUG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIPUG>, arg1: 0x2::coin::Coin<SUIPUG>) {
        0x2::coin::burn<SUIPUG>(arg0, arg1);
    }

    fun init(arg0: SUIPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUG>(arg0, 2, b"SUIPUG", b"PUG", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPUG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIPUG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

