module 0x8fbcd9e207213ccbdd40d7f98f56ffbfe889dbb9b8ef68ca82c1794e7690aa37::shuib {
    struct SHUIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUIB>(arg0, 6, b"SHUIB", b"SHUIBA", x"5765277265205368696261204f6e205375692c20576527726520245348554942210a57656273697465206f6e2074686520676f2c20686f7020696e2054472e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_17_20_32_11_32e9db399d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

