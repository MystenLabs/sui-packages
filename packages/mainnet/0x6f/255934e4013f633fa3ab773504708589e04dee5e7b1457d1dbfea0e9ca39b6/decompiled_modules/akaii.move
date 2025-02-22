module 0x6f255934e4013f633fa3ab773504708589e04dee5e7b1457d1dbfea0e9ca39b6::akaii {
    struct AKAII has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKAII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKAII>(arg0, 6, b"AKAII", b"AKAI", b"AKAI is an AI Agent that helps you explore deep into the global AI technology scene!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/b8c9b5bd-464a-43e9-9aef-d16d3a32e3c3.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AKAII>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKAII>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

