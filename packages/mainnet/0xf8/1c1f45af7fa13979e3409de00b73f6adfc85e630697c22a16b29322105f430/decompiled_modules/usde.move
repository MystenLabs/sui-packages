module 0xf81c1f45af7fa13979e3409de00b73f6adfc85e630697c22a16b29322105f430::usde {
    struct USDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDE>(arg0, 6, b"USDE", b"USDE", b"USDE for test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

