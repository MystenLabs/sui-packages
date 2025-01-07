module 0x64117a45f777c00ec7799cf1fe0c1b8d882a1d426a8dff106caaf280babcec6c::wifmog {
    struct WIFMOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFMOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFMOG>(arg0, 6, b"WIFMOG", b"Dogwifmog", x"54686973206d756c746920636861696e2070726f6a656374207265616479206f6e20736f6c616e6120262053756920626c6f636b636861696e2074616c65202074686520646f6720776966206861742c20616e64204d6f672c2074686520756e64656e6961626c6520666f726365206f66206368616f7320616e642066756e2e20245749464d4f472077696c6c2074616b65206f766572207468652053756920626c6f636b636861696e2c206272696e67696e672061206d6978206f66206d656d65732c206d697363686965662c20616e64206120746f6b656e2074686174e280997320616e797468696e6720627574206f7264696e6172792e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732159234374.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIFMOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFMOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

