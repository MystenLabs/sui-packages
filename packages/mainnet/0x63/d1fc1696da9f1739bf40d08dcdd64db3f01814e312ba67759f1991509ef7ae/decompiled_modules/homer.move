module 0x63d1fc1696da9f1739bf40d08dcdd64db3f01814e312ba67759f1991509ef7ae::homer {
    struct HOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMER>(arg0, 6, b"HOMER", b"SuiSimpson", b"simpsonssss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i18_Brhzl_400x400_aa62b0661a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

