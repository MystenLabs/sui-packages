module 0x82586cb2d84dedb96892c54c6c1f23b36b2bfef98dd70866215f182db0ad1a28::cmcl {
    struct CMCL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMCL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMCL>(arg0, 9, b"CMCL", b"CEMICAL", b"CEMICAL COIN IS HERE TO MAKES YOU HIGH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/12b77620-cda7-463e-9bac-77c727614442.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMCL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CMCL>>(v1);
    }

    // decompiled from Move bytecode v6
}

