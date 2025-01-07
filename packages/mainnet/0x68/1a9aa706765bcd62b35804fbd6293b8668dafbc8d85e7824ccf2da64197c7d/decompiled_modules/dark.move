module 0x681a9aa706765bcd62b35804fbd6293b8668dafbc8d85e7824ccf2da64197c7d::dark {
    struct DARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARK>(arg0, 6, b"Dark", b"DarkSideOfTheMoon", b"Best Album ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731773976834.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DARK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

