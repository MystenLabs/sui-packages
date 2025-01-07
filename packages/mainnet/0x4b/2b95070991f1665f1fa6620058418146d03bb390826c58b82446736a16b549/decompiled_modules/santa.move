module 0x4b2b95070991f1665f1fa6620058418146d03bb390826c58b82446736a16b549::santa {
    struct SANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SANTA>(arg0, 6, b"SANTA", b"SANTA ON SUIAI", b"We wish u a Merry Chrismast and a happy new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/LOGO_SANTA_bb44af94f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SANTA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

