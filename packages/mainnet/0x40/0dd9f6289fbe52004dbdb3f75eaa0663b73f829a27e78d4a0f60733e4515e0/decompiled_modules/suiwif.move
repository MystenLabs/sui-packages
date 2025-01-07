module 0x400dd9f6289fbe52004dbdb3f75eaa0663b73f829a27e78d4a0f60733e4515e0::suiwif {
    struct SUIWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIF>(arg0, 6, b"Suiwif", b"DOGWIF", b"Dogs cute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731158887287.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIWIF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

