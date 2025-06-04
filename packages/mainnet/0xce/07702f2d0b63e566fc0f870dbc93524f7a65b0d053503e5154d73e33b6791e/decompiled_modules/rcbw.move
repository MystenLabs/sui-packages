module 0xce07702f2d0b63e566fc0f870dbc93524f7a65b0d053503e5154d73e33b6791e::rcbw {
    struct RCBW has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCBW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCBW>(arg0, 9, b"RCBw", b"RCB", b"never give up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2268fb683a24b32948f8921abc886bb2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RCBW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCBW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

