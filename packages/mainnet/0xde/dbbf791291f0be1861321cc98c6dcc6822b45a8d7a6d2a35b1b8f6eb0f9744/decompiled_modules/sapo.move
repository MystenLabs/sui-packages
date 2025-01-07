module 0xdedbbf791291f0be1861321cc98c6dcc6822b45a8d7a6d2a35b1b8f6eb0f9744::sapo {
    struct SAPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPO>(arg0, 6, b"SAPO", b"SAPOsui", b"SAPO ON THE WAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241010_172843_063b2ea91b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

