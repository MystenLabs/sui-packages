module 0x8f7af98abaf3c5fff0141188fc4b034be12a92ae51c94381d97410dfaf948f29::iaos {
    struct IAOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IAOS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<IAOS>(arg0, 6, b"IAOS", b"SUI Agents IAOs by SuiAI", x"4272696e6720616e79207265616c206f722066696374696f6e616c2063686172616374657220746f206c696665206f6e20746865202353554920636861696e2077697468206a75737420612066657720636c69636b732120f09f8c8a20202e4a6f696e205355492049414f7320616e6420696e6675736520414920696e746f2074686520776174657220636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/p_Fei_R5_ZV_400x400_8f2fe09b49.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IAOS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IAOS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

