module 0x373f336ff48769466d68fedda53ccff5fc7d66190e36fc928babe1766afc3dc7::suck {
    struct SUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCK>(arg0, 6, b"SUCK", b"Suck the Duck", b"Hello, I'm $SUCK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958125303.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

