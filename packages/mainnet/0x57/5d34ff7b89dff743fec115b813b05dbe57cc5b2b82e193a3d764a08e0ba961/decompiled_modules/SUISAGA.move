module 0x575d34ff7b89dff743fec115b813b05dbe57cc5b2b82e193a3d764a08e0ba961::SUISAGA {
    struct SUISAGA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUISAGA>, arg1: 0x2::coin::Coin<SUISAGA>) {
        0x2::coin::burn<SUISAGA>(arg0, arg1);
    }

    fun init(arg0: SUISAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAGA>(arg0, 9, b"SAGA", b"SUI SAGA", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISAGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISAGA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISAGA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

