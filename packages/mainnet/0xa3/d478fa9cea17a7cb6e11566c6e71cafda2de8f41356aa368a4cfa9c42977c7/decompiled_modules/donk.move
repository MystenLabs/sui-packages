module 0xa3d478fa9cea17a7cb6e11566c6e71cafda2de8f41356aa368a4cfa9c42977c7::donk {
    struct DONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONK>(arg0, 6, b"Donk", b"Donkephant Party", x"496e20737570706f7274206f6620456c6f6ee2809973206e65772070617274792c20636f6d62696e696e67207468652062657374206f66207468652044656d6f6372617420506172747920616e64207468652052657075626c6963616e2050617274792e20205468652068616c6620646f6e6b6579202844656d6f637261742920616e642068616c6620656c657068616e74202852657075626c6963616e292073796d626f6c697a65732074686520636f6d696e6720746f676574686572206f662074686520416d65726963616e2070656f706c6520616e6420737570706f72747320456c6f6ee280997320766973696f6e2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1751800065916.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

