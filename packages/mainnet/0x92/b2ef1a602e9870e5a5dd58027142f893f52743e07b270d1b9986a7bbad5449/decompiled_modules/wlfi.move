module 0x92b2ef1a602e9870e5a5dd58027142f893f52743e07b270d1b9986a7bbad5449::wlfi {
    struct WLFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLFI>(arg0, 6, b"WLFI", b"WORLD LIBERTYFI", x"5472756d7020746f206c61756e636820576f726c64204c6962657274792046696e616e6369616c200a5468652070726f6a6563742c20776869636820697320657870656374656420746f206c61756e6368204d6f6e6461792c205365702e2031362c2077696c6c20626520616e6f7468657220766963746f727920666f7220506f6c796d61726b6574207061727469636970616e74732c2077686f2068617665207072656469637465642074686174205472756d702077696c6c206c61756e6368206120636f696e206265666f726520746865204e6f76656d62657220656c656374696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Lgx_R_Oh_LW_400x400_43d847891d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WLFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

