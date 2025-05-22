module 0x2875ef8a0369443da57c2bef7a6bf0ea61d028cc1dfec4bbf2b03e63a4406418::coinone {
    struct COINONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COINONE>(arg0, 9, b"c1", b"coinone", b"coin one desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com//kappa-dev/coins/903f4b3e-14a5-44bd-8e4d-0dd0428db791.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COINONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COINONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

