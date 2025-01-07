module 0x740297949c64504f5fe260dab3aa31a8e6eb46c70e546366766d3dc655a7139e::yum {
    struct YUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUM>(arg0, 6, b"YUM", b"TurbosYummy", x"59756d6d792079756d2079756d0a59756d6d792079756d6d792079756d20f09f8eb6200a59756d6d792079756d2079756d0a59756d6d792079756d6d792079756d20f09f8eb5200a59756d6d792079756d2079756d2079756d6d792079756d6d790a59756d2079756d20f09f8eb5200a59756d6d792079756d6d792079756d2079756d0a59756d6d792079756d6d792079756d20f09f8eb6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730993865377.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

