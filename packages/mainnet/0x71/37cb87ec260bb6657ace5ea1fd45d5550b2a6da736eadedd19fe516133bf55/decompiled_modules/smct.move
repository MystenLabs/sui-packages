module 0x7137cb87ec260bb6657ace5ea1fd45d5550b2a6da736eadedd19fe516133bf55::smct {
    struct SMCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMCT>(arg0, 6, b"SMCT", b"SMOKINCATSUI", b"SMOKIN CAT: A CREATIVE FORCE AT LEAKE STREET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017250_8b0a116c87.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

