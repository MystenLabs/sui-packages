module 0xd334d8f9546e874b5740d802ae3faa21e0ad9a607af1884d1e1cecf53df4cb5d::lime {
    struct LIME has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LIME>, arg1: 0x2::coin::Coin<LIME>) {
        0x2::coin::burn<LIME>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LIME>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LIME>>(0x2::coin::mint<LIME>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIME>(arg0, 9, b"LIME", b"LIME", b"LIME NETWORK", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

