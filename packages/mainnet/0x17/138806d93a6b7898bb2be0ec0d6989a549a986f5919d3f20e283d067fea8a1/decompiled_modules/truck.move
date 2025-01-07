module 0x17138806d93a6b7898bb2be0ec0d6989a549a986f5919d3f20e283d067fea8a1::truck {
    struct TRUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUCK>(arg0, 6, b"TRUCK", b"Check ca aussi gros fils de pute de bstn", b"truck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/61_ATWCRQ_8c_L_AC_UY_1000_db32c0c08a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

