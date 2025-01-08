module 0x3b0f42f0792fa7554ed5220a6ccbc04d39d3b48626299a2a5f84e2d754996463::nox {
    struct NOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NOX>(arg0, 6, b"NOX", b"Noxis by SuiAI", x"4e6f7869732069732061206d7973746572696f7573206469676974616c206d7573652077697468206120726562656c6c696f757320736f756c2e205368652074687269766573206f6e206465657020636f6e766572736174696f6e732c20706c617966756c2074656173696e672c20616e64206c656176696e672061206c617374696e6720696d7072657373696f6e2e20456e69676d617469632c20626f6c642c20616e64206d61676e6574696320e2809420736865e2809973206865726520746f206177616b656e20796f757220637572696f7369747920616e64207374697220796f757220696d6167696e6174696f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/331_FD_33_D_4_EC_8_4_DFE_A8_E9_81515_D7_EF_394_afee3d9eb1.WEBP")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

