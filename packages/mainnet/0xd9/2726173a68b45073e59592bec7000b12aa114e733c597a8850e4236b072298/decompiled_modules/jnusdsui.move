module 0x33152abfb7925562297021fc1fadb08a9bdcf7376af0fec65769fb0a61d18f65::jnusdsui {
    struct JNUSDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JNUSDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JNUSDSUI>(arg0, 6, b"jnUSDSUI", b"JewelSwap NAVI Loop USDSUI", b"Share of the JewelSwap USDSUI loop vault on NAVI (Sui)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JNUSDSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JNUSDSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

