module 0x463e469633d9fedff1d59107fe6a85ba4f86199e89b9335d7b26ca3fe8fd36a9::sso {
    struct SSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSO>(arg0, 6, b"SSO", b"SuiSoulja", x"53554920534f554c4a412069732064657369676e656420746f206265636f6d652061207265636f676e697a61626c6520696e7465726e65742d6e617469766520636861726163746572206672616e636869736520706f77657265642062792063756c747572652c2073746f727974656c6c696e672c206d656d65732c20616e6420636f6d6d756e6974792070617274696369706174696f6e2e0a0a434f5245205448454d45530ae280a22046616974680ae280a220507572706f73650ae280a22042726f74686572686f6f640ae280a2204469736369706c696e650ae280a2204c65676163790ae280a220436f6d6d756e69747920737472656e677468", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1779855510156.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

