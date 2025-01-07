module 0xc22a333fd9b39f3eb2594d5df4403557f9b77889a2535eefb9ad2c6056e9f10c::soki {
    struct SOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOKI>(arg0, 6, b"SOKI", b"Soki", b"Token for a new Game on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/socki_7c9063ee3c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

