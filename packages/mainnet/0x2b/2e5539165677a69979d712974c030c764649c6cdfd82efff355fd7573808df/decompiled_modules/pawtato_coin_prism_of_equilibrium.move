module 0x2b2e5539165677a69979d712974c030c764649c6cdfd82efff355fd7573808df::pawtato_coin_prism_of_equilibrium {
    struct PAWTATO_COIN_PRISM_OF_EQUILIBRIUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_PRISM_OF_EQUILIBRIUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_PRISM_OF_EQUILIBRIUM>(arg0, 9, b"PRISM_OF_EQUILIBRIUM", b"Pawtato Prism of Equilibrium", b"A masterfully crafted ornament said to bring inner peace", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_consumables/prism-of-equilibrium.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_PRISM_OF_EQUILIBRIUM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_PRISM_OF_EQUILIBRIUM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

