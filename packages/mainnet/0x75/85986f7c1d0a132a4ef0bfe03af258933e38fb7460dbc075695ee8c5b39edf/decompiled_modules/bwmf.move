module 0x7585986f7c1d0a132a4ef0bfe03af258933e38fb7460dbc075695ee8c5b39edf::bwmf {
    struct BWMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWMF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWMF>(arg0, 6, b"BWMF", b"Be Water My Friend", x"204272756365204c6565200a0a22456d70747920796f7572206d696e642c20626520666f726d6c6573732c2073686170656c6573732c206c696b652077617465722e2050757420776174657220696e746f2061206375702c206974206265636f6d657320746865206375702e2050757420776174657220696e746f206120746561706f742c206974206265636f6d65732074686520746561706f742e2057617465722063616e20666c6f77206f722069742063616e2063726173682e2042652077617465722c206d7920667269656e642e222020202d204272756365204c6565", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/movepump_c391813876.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWMF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BWMF>>(v1);
    }

    // decompiled from Move bytecode v6
}

