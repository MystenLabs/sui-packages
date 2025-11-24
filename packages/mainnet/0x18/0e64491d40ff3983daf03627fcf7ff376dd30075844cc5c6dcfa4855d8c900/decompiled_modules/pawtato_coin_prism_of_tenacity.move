module 0x180e64491d40ff3983daf03627fcf7ff376dd30075844cc5c6dcfa4855d8c900::pawtato_coin_prism_of_tenacity {
    struct PAWTATO_COIN_PRISM_OF_TENACITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_PRISM_OF_TENACITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_PRISM_OF_TENACITY>(arg0, 9, b"PRISM_OF_TENACITY", b"Pawtato Prism of Tenacity", b"A masterfully crafted ornament said to increase persistence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_consumables/prism-of-tenacity.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_PRISM_OF_TENACITY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_PRISM_OF_TENACITY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

