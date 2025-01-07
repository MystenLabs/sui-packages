module 0xdb16b20e66eb1a39a2f72f281b2a0f3155175f80c8ed50428da717cf6af7572c::bbasx {
    struct BBASX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBASX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBASX>(arg0, 6, b"BBASX", b"Baby Asterix", x"404261627941737465726978206f66666572696e672061206e6577206f70706f7274756e69747920666f722074686f73652077686f206d697373656420746865206d6f6f6e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmcc1i4hr_Q2_V76_B2_HJQ_57p5b_MSA_7m2ffdntaxuqgi_Sr_NAC_958a00a621.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBASX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBASX>>(v1);
    }

    // decompiled from Move bytecode v6
}

