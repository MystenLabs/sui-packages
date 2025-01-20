module 0xcc9f329623ba1f8c12a733f89e222e1a67cc7c4f650ed99961a61703a9ead613::trmwf {
    struct TRMWF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRMWF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRMWF>(arg0, 6, b"TRMWF", b"TREMP WIF HAT", b"TREMP WIF HAT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a2af_Mkdt_400x400_a4606b8ad0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRMWF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRMWF>>(v1);
    }

    // decompiled from Move bytecode v6
}

