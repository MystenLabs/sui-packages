module 0x88ef5fc407268adf34758357403c61ff27a41daa8f3bea35b03071a2f8ad4fa::suck {
    struct SUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCK>(arg0, 6, b"SUCK", b"SUICK", b"\"You must be sick if you think Sui will make it this cycle\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731003987697.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

