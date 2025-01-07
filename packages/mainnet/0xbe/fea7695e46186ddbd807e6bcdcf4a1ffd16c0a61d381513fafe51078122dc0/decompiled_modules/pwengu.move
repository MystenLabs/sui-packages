module 0xbefea7695e46186ddbd807e6bcdcf4a1ffd16c0a61d381513fafe51078122dc0::pwengu {
    struct PWENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWENGU>(arg0, 6, b"PWENGU", b"Pwengu on sui", x"48692049276d205057454e47550a49276d2074686520666c756666696573742c20616e64206d6f737420706c617966756c2050656e6775696e0a696e2074686520656e74697265204172637469632e2057656c636f6d6520746f206d7920776f726c642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053639_c43ca52bfc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

