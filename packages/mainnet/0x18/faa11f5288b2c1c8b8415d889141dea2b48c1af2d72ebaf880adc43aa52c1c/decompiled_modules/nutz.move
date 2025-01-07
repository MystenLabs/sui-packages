module 0x18faa11f5288b2c1c8b8415d889141dea2b48c1af2d72ebaf880adc43aa52c1c::nutz {
    struct NUTZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUTZ>(arg0, 6, b"NUTZ", b"Nutz", x"476f206e7574732077697468206761696e7321204120706c617966756c2c20626f6c6420636f696e20666f722074686f73652077686f2077616e7420746f20686176652066756e207768696c6520696e76657374696e672e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nutz_token_c31f98e745.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUTZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUTZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

