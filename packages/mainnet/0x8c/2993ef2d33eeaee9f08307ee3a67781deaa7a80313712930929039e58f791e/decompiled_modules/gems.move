module 0x8c2993ef2d33eeaee9f08307ee3a67781deaa7a80313712930929039e58f791e::gems {
    struct GEMS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GEMS>, arg1: 0x2::coin::Coin<GEMS>) {
        0x2::coin::burn<GEMS>(arg0, arg1);
    }

    fun init(arg0: GEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEMS>(arg0, 6, b"Gems Coin", b"GEMS", b"the new treasure just arrived", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEMS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GEMS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GEMS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

