module 0x4c1e5b7ddbf898bfdafc6b8a7e30837552d7fe25a64a86072fe1b2148c29b1d4::swog {
    struct SWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOG>(arg0, 6, b"SWOG", b"S-WOG ", b"In the ashes a community emerged, a new flog, a more based flog, a SWOG SWOG has no dev. It is the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731195543622.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

