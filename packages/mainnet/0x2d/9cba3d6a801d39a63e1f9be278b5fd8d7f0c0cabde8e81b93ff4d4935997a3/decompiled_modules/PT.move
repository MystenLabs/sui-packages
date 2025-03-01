module 0x2d9cba3d6a801d39a63e1f9be278b5fd8d7f0c0cabde8e81b93ff4d4935997a3::PT {
    struct PT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PT>(arg0, 9, b"PT", b"PT for HaSui", b"Principal Token for HaSui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

