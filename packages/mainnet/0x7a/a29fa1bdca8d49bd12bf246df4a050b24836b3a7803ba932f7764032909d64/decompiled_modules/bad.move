module 0x7aa29fa1bdca8d49bd12bf246df4a050b24836b3a7803ba932f7764032909d64::bad {
    struct BAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAD>(arg0, 6, b"BAD", b"BADMOUTH", b"$BAD: The most daring and cheeky token on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733359190562.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

