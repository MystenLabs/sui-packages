module 0xb730616822720e319ba3ea35c6776c3c6e1278836e167755068e3c16cf17931c::tood1 {
    struct TOOD1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOOD1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOOD1>(arg0, 6, b"TOOD1", b"tood", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WX_20221106_194015_2x_dbb696983e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOOD1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOOD1>>(v1);
    }

    // decompiled from Move bytecode v6
}

