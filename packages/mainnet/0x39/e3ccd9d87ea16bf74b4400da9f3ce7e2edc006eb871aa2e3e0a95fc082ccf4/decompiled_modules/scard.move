module 0x39e3ccd9d87ea16bf74b4400da9f3ce7e2edc006eb871aa2e3e0a95fc082ccf4::scard {
    struct SCARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCARD>(arg0, 6, b"SCARD", b"SUICARD", b"Suicard the first SUICARD on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suicardss_454a5d0695.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

