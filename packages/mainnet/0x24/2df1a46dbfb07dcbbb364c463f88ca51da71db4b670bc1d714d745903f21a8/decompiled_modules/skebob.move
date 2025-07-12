module 0x242df1a46dbfb07dcbbb364c463f88ca51da71db4b670bc1d714d745903f21a8::skebob {
    struct SKEBOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKEBOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKEBOB>(arg0, 6, b"SKEBOB", x"d0a1d09ad095d091d09ed091", b"viral russian bird", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752300087346.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKEBOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKEBOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

