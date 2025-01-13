module 0x69729405442c0fbc2c16eee0e7d93f4065c6f5ebc0d875af94a79cee54950f2c::symbol {
    struct SYMBOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYMBOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYMBOL>(arg0, 6, b"SYMBOL", b"TOKEN", b"DESC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/f56c06e5-6aed-47c9-84a1-1612f6264316.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYMBOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYMBOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

