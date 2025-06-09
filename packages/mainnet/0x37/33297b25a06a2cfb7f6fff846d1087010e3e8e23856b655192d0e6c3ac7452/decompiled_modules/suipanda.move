module 0x3733297b25a06a2cfb7f6fff846d1087010e3e8e23856b655192d0e6c3ac7452::suipanda {
    struct SUIPANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPANDA>(arg0, 6, b"SuiPanda", b"Sui Panda", x"53756950616e6461202d20746865206368696c6c657374206d656d65636f696e206f6e2074686520736c69636b65737420636861696e2e20204865e28099732062656e64696e6720746865207665727920666162726963206f6620626c6f636b636861696e207265616c6974792c206f6e65206d656d6520617420612074696d65206f6e205375692e20486520697320676c6964696e67207468726f756768207468652077617465726c696b6520617263686974656374757265206f6620537569e2809464726f7070696e672064616e6b206d656d65732c20616e6420646f696e67206b756e672d6675206f6e20746865204655442e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749513238169.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPANDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPANDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

