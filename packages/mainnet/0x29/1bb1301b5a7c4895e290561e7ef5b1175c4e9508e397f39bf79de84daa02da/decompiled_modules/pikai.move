module 0x291bb1301b5a7c4895e290561e7ef5b1175c4e9508e397f39bf79de84daa02da::pikai {
    struct PIKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PIKAI>(arg0, 6, b"PIKAI", b"PIKAI AGENT by SuiAI", x"50494b41493a2054686520556c74696d6174652045766f6c7574696f6e2e50494b414920697320616e204149204167656e7420746861742067726f7773207769746820697473206d61726b6574206361702e20456d657267696e672066726f6d2069747320506f6b6562616c6c2c20746865206d6f72652069742065766f6c7665732c20746865206869676865722069747320706f77657220736f6172732c20756e74696c206974207368616b6573207468652053554920626c6f636b636861696e2e2054727920746f20636174636820697420696620796f752063616ee280a620616e64206a6f696e20746865202050494b4149206c6567656e642021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/f1080e90_7cba_4d35_ac49_85c3327cfa4c_1_24d927fb66.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIKAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

