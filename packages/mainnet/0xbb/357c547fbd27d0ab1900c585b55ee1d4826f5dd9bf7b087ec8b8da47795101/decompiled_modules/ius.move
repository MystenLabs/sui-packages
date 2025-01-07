module 0xbb357c547fbd27d0ab1900c585b55ee1d4826f5dd9bf7b087ec8b8da47795101::ius {
    struct IUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUS>(arg0, 6, b"IUS", b"ius", b"you own", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956584501.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

