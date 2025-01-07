module 0xb7243ce03833e2e499d95ec4cbf0b4504d6e8a496e62b5c09743337ea117e675::catt {
    struct CATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATT>(arg0, 6, b"CATT", b"cat sui", b"CAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241003195850_c03cdf061f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

