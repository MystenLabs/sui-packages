module 0x15d33094e98de4d91e69433a400ae2de648446c6e04820371c3d548090275b::wecantwin {
    struct WECANTWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WECANTWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WECANTWIN>(arg0, 6, b"WECANTWIN", b"CantWIn", b"notspam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732613434786.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WECANTWIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WECANTWIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

