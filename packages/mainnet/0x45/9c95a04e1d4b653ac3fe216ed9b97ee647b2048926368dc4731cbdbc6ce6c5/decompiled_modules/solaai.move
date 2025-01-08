module 0x459c95a04e1d4b653ac3fe216ed9b97ee647b2048926368dc4731cbdbc6ce6c5::solaai {
    struct SOLAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLAAI>(arg0, 6, b"SolaAI", b"the first voice assistant", x"4275696c64696e672074686520666972737420706572736f6e616c697a656420766f69636520617373697374616e74206f6e2040736f6c616e612068747470733a2f2f782e636f6d2f546865536f6c615f41492068747470733a2f2f736f6c6161692e636c69636b0a626f6e64696e672063757276652070726f67726573733a20313030250a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043169_f45d27ad4c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLAAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLAAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

