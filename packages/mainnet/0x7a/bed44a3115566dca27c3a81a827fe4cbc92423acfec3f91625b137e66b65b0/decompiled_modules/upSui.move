module 0x7abed44a3115566dca27c3a81a827fe4cbc92423acfec3f91625b137e66b65b0::upSui {
    struct UPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPSUI>(arg0, 9, b"syupSUI", b"SY upSUI", b"SY Double Up Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UPSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

