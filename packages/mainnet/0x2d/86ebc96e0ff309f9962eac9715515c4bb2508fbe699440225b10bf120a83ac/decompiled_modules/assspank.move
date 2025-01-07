module 0x2d86ebc96e0ff309f9962eac9715515c4bb2508fbe699440225b10bf120a83ac::assspank {
    struct ASSSPANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSSPANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSSPANK>(arg0, 6, b"ASSSPANK", b"__", b"Lols. This is just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ezgif_1_771e6316dc_e261186245.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSSPANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASSSPANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

