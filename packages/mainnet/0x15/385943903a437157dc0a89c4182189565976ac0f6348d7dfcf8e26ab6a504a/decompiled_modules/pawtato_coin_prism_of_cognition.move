module 0x15385943903a437157dc0a89c4182189565976ac0f6348d7dfcf8e26ab6a504a::pawtato_coin_prism_of_cognition {
    struct PAWTATO_COIN_PRISM_OF_COGNITION has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_PRISM_OF_COGNITION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_PRISM_OF_COGNITION>(arg0, 9, b"PRISM_OF_COGNITION", b"Pawtato Prism of Cognition", b"A masterfully crafted ornament said to increase perception", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_consumables/prism-of-cognition.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_PRISM_OF_COGNITION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_PRISM_OF_COGNITION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

