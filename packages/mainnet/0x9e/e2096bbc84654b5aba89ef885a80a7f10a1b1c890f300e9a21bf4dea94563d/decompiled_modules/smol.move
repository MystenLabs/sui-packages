module 0x9ee2096bbc84654b5aba89ef885a80a7f10a1b1c890f300e9a21bf4dea94563d::smol {
    struct SMOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOL>(arg0, 6, b"Smol", b"SuiSmol", x"54686520626967207468696e67732077696c6c20636f6d6520696e2023534d4f4c206f6e205375690a42757920536d6f6c2c486f6c6420536d6f6c20616e64207761697420666f7220536d6f6c20676f20746f206d6f6f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731033219481.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

