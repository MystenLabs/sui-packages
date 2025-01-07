module 0x7369e6f0241a603d53868870a7010759a1cab8f3566d898adc2d4a0ef05ea853::hrmb {
    struct HRMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRMB>(arg0, 6, b"Hrmb", b"Harambe", b"Loving gorilla", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20240917_145242_98ac791f44.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HRMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

