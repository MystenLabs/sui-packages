module 0xc4706781119fbb06503586bb154ad755926aca7834cb770e15843469927f086d::svSUI {
    struct SVSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVSUI>(arg0, 6, b"sysvSUI", b"SY svSUI", b"SY scallop svSUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SVSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

