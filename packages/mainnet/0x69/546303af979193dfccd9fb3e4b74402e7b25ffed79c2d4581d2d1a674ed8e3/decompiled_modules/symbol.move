module 0x69546303af979193dfccd9fb3e4b74402e7b25ffed79c2d4581d2d1a674ed8e3::symbol {
    struct SYMBOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYMBOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYMBOL>(arg0, 6, b"SYMBOL", b"TOKEN NAME", b"DESC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/c749251c-28a7-4f94-b90e-d65fe946abfe.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYMBOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYMBOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

