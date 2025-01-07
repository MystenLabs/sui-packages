module 0x9b71276ace86e6bcedfd6a606b0a6989a1fb6e1b981d0093e02dcae1e2b05f38::pelf {
    struct PELF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELF>(arg0, 6, b"PELF", b"PELFORT", x"537569206d656d65636f696e207061726f6479206261736564206f6e204a6f72646f6e2042656c666f727420617320506570652e200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d_N9j_Vm1_E_400x400_eb51ac8001.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PELF>>(v1);
    }

    // decompiled from Move bytecode v6
}

