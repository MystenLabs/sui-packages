module 0xa7b06a991bb84990269ffa815e1d91e0b3ca413d21cccfaef45981ee35c6ffd7::sipe {
    struct SIPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SIPE>, arg1: 0x2::coin::Coin<SIPE>) {
        0x2::coin::burn<SIPE>(arg0, arg1);
    }

    fun init(arg0: SIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIPE>(arg0, 2, b"SIPE", b"SIPE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SIPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

