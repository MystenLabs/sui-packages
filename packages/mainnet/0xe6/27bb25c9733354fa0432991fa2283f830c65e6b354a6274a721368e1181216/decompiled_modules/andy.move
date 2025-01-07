module 0xe627bb25c9733354fa0432991fa2283f830c65e6b354a6274a721368e1181216::andy {
    struct ANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDY>(arg0, 6, b"Andy", b"Andysui", x"49662074686520696e74726f64756374696f6e20696e666f726d6174696f6e206973206d697373696e67206f722077726f6e672c207573657273206172650a77656c636f6d6520746f206769766520666565646261636b20696e2074686520636f6d6d756e6974790a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_U_U_U_U_U_U_U_U_U_U_U_U_U_U_Chrome_e27754273e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

