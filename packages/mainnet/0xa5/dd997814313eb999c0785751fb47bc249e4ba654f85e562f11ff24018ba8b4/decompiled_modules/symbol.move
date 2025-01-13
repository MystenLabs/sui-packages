module 0xa5dd997814313eb999c0785751fb47bc249e4ba654f85e562f11ff24018ba8b4::symbol {
    struct SYMBOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYMBOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYMBOL>(arg0, 6, b"SYMBOL", b"TOKEN", b"DESC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/fece3b8f-a33a-40d3-a0ff-4ead6c959e2c.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYMBOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYMBOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

