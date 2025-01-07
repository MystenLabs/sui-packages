module 0xd66262004a8fa634bca2f7f973eb6d613a69ce70c2998be65f647c0c7b542fdf::otterfly {
    struct OTTERFLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTERFLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTERFLY>(arg0, 6, b"OTTERFLY", b"SUI OTTERFLY ", b"This is $OTTERFLY a flying otter from TURBOS with many adorable facial expressions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731341579136.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTTERFLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTERFLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

