module 0xbe0e02f5d4fc1ed63cd6fcb2d09d201ef839b0e185d493b8f33113fed4e4942::trevinSui {
    struct TREVINSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREVINSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREVINSUI>(arg0, 9, b"sytrevinSUI", b"SY trevinSUI", b"SY Trevin Staked SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TREVINSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREVINSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

