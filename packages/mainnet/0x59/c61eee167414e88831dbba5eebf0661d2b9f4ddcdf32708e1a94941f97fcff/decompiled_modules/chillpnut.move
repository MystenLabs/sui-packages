module 0x59c61eee167414e88831dbba5eebf0661d2b9f4ddcdf32708e1a94941f97fcff::chillpnut {
    struct CHILLPNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLPNUT>(arg0, 6, b"CHILLPNUT", b"LOWKEY CHILLPNUT", b"I'm just a lowkey chill pnut who enjoys with Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/untitled_500_x_500_px_1_m2_Wp2_V4w_J8uor4j_Z_1ac2e7eabf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLPNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLPNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

