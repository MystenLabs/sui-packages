module 0xa16d005567716ba6feede5224fd411888174959c94d53ecf38f3dd15b00d09a2::DROPPER {
    struct DROPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROPPER>(arg0, 6, b"DROPP", b"DROPPER COIN", b"DROPPER KING", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DROPPER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPPER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

