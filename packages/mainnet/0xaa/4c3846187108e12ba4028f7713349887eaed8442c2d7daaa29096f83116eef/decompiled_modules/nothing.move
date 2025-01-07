module 0xaa4c3846187108e12ba4028f7713349887eaed8442c2d7daaa29096f83116eef::nothing {
    struct NOTHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTHING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTHING>(arg0, 6, b"NOTHING", b"Just Don't Buy", x"5768617420646f20796f7520657870656374206d6520746f206465736372696265203f0a0a0a4e6f20776562736974650a4e6f2054656c656772616d0a4e6f20547769747465720a0a446f6e277420627579", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732421681923.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTHING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTHING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

