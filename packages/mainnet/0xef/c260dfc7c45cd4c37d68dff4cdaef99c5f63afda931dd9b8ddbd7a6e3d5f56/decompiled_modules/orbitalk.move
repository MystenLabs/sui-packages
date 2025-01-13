module 0xefc260dfc7c45cd4c37d68dff4cdaef99c5f63afda931dd9b8ddbd7a6e3d5f56::orbitalk {
    struct ORBITALK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORBITALK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ORBITALK>(arg0, 6, b"ORBITALK", b"OrbiTalk by SuiAI", x"457870657269656e63652061206e65772077617920746f206368617420e2809420776865726520636f6e766572736174696f6e732061726520736d61727465722c206661737465722c20616e64206d6f726520706572736f6e616c697a6564207468616e2065766572206265666f72652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2126_ab7071380e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ORBITALK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORBITALK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

