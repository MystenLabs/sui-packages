module 0x1ee39046562b1f2ad26aff2b6219490058e3e44675619cfeac0852df21bc9c53::symbol {
    struct SYMBOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYMBOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYMBOL>(arg0, 6, b"SYMBOL", b"TOKEN", b"DESC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/6db5b796-f821-4363-ab07-f01353462b26.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYMBOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYMBOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

