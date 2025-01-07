module 0x3c19529ff53648846d9d56437b5e09fba41e5e259152ae49d73184e2714cc880::pnutffp {
    struct PNUTFFP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUTFFP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUTFFP>(arg0, 6, b"PNUTFFP", b"Pnuts FF Party", b"THE PNUTS FREEDOM FARM PARTY .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730952988174.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNUTFFP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUTFFP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

