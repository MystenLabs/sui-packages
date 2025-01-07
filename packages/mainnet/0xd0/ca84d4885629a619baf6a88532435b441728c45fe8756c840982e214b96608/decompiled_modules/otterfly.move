module 0xd0ca84d4885629a619baf6a88532435b441728c45fe8756c840982e214b96608::otterfly {
    struct OTTERFLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTERFLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTERFLY>(arg0, 6, b"OTTERFLY", b"OTTERFLY SUI", b"This is $OTF a flying otter from uptober with many adorable facial expressions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731315697621.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTTERFLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTERFLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

