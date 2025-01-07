module 0x720970043b5a049b43a7e937acc4a6bf8471f8e2b0b481147935a5c271901cb1::coldguy {
    struct COLDGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLDGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COLDGUY>(arg0, 6, b"COLDGUY", b"Cold Guy", x"496d20667265657a696e67207269676874206e6f772e20496d206120434f4c444755592e2049206e65656420746f207761726d2075702e20496d207265616c6c79207265616c6c79207265616c6c7920636f6c642e20496d207374696c6c206368696c6c2062757420496d206665656c696e67206368696c6c792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmaxz_DUQ_Dfb_Zj_Xx_Xurgx_XMB_Le_A_Rmyb_X_Ts8_Dv_Y43qw_U7qac_b4dc5315cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLDGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COLDGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

