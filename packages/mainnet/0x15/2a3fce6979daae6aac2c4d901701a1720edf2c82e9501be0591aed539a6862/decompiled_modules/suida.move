module 0x152a3fce6979daae6aac2c4d901701a1720edf2c82e9501be0591aed539a6862::suida {
    struct SUIDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDA>(arg0, 6, b"SUIDA", b"SuiDa", x"53756964612c20746865207375692070616e64612c20747279696e6720686973206265737420746f2067657420612073706f74206f6e20746865205375692065636f2d73797374656d2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0378_cc7dbfaee8_396343e6ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

