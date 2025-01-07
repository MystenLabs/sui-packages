module 0x4582ed4dce3b7e838bad728e324e16f54d6f78d0acaa1cd96335aa049596690f::suiwizard {
    struct SUIWIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIZARD>(arg0, 6, b"SUIWIZARD", b"Sui Wizard", b"The enchanting sorcerer of the Sui Network, casting magical spells with water. With a flick of his wand, he transforms liquidity into incredible opportunities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/PP_b5c5055404.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWIZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

