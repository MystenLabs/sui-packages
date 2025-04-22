module 0x2c9e727be8ccf042456a59acecc881b40bec8771c545cd649f3e1752f7ae72ff::fudSui {
    struct FUDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDSUI>(arg0, 9, b"syfudSUI", b"SY fudSUI", b"SY FUD Staked SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUDSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

