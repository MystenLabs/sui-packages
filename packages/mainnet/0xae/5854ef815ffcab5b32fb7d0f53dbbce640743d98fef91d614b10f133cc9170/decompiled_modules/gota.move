module 0xae5854ef815ffcab5b32fb7d0f53dbbce640743d98fef91d614b10f133cc9170::gota {
    struct GOTA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GOTA>, arg1: 0x2::coin::Coin<GOTA>) {
        0x2::coin::burn<GOTA>(arg0, arg1);
    }

    fun init(arg0: GOTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOTA>(arg0, 18, b"GT", b"GOTA", b"Gota de agua", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOTA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOTA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GOTA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GOTA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

