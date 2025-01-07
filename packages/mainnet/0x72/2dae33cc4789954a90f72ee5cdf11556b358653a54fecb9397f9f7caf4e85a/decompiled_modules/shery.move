module 0x722dae33cc4789954a90f72ee5cdf11556b358653a54fecb9397f9f7caf4e85a::shery {
    struct SHERY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHERY>, arg1: 0x2::coin::Coin<SHERY>) {
        0x2::coin::burn<SHERY>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHERY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHERY>>(0x2::coin::mint<SHERY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SHERY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHERY>(arg0, 9, b"shery", b"SHERY", b"Test Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHERY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHERY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

