module 0x62afacc61de0b30ede3ced349cec30a3dea47b33cf173edbee32ae77301f5814::suilions {
    struct SUILIONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILIONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILIONS>(arg0, 6, b"SUILIONS", b"SUILION", x"636f6c6f6e79206f66207375696c696f6e732074616b696e67206f766572207375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HWA_Au_XA_2_400x400_cd6f1c6b76.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILIONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILIONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

