module 0x5bb0f7d18c148d3c1a4be8e40b7e5e272ad1550b3cf28b96982e3c63e7bdd384::suisui {
    struct SUISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUI>(arg0, 6, b"SUISUI", b"suisui", b"2*SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_b44530b93f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

