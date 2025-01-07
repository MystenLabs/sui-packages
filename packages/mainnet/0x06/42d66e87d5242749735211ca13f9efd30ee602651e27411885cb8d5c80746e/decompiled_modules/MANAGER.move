module 0x642d66e87d5242749735211ca13f9efd30ee602651e27411885cb8d5c80746e::MANAGER {
    struct MANAGER has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MANAGER>, arg1: 0x2::coin::Coin<MANAGER>) {
        0x2::coin::burn<MANAGER>(arg0, arg1);
    }

    fun init(arg0: MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANAGER>(arg0, 2, b"KG Offset", b"KG", b"Offset coins issued by Fils. Each coin represents 1 kg of carbon offset", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAGER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANAGER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MANAGER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MANAGER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

