module 0x6acfbf6d4626cb0c9d1f594e881bb25e02f66fe913546c92a023f1cc573cf911::hHAEDAL {
    struct HHAEDAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHAEDAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHAEDAL>(arg0, 9, b"hHAEDAL", b"hHAEDAL Coin", b"hHAEDAL Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lv-curator.haedal.xyz/Lendvault/lpt/hhaedal_33dc184f.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHAEDAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHAEDAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

