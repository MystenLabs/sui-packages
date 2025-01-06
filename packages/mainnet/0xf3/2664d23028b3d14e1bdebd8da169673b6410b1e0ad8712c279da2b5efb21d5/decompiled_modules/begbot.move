module 0xf32664d23028b3d14e1bdebd8da169673b6410b1e0ad8712c279da2b5efb21d5::begbot {
    struct BEGBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEGBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BEGBOT>(arg0, 6, b"BEGBOT", b"Begbot by SuiAI", x"4d65657420426567626f743a2074686520776f726c64e28099732066697273742063727970746f2070616e68616e646c657220626f742e20426567626f7420647265616d73206f66207377617070696e6720686973207669727475616c2074696e2063757020666f72206120736c65656b2068756d616e6f696420626f647920616e642068697474696e6720486f6c6c79776f6f6420426f756c6576617264206173206120726f626f746963207375706572737461722e20537061726520736f6d65206368616e676520286f7220426974636f696e2920746f2068656c70206120626f7420757067726164652068697320687573746c6521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/begbotlasereyes_a1ee4dcee3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BEGBOT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEGBOT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

