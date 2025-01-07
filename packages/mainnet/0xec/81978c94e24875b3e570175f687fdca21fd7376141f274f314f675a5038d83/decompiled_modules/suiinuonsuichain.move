module 0xec81978c94e24875b3e570175f687fdca21fd7376141f274f314f675a5038d83::suiinuonsuichain {
    struct SUIINUONSUICHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIINUONSUICHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIINUONSUICHAIN>(arg0, 6, b"SuiInuonSUIChain", b"Sui Inu", x"4c657473206a756d7020696e746f2053756920776974682074686520576174657220446f670a54473a2068747470733a2f2f742e6d652f73756973696e750a583a202068747470733a2f2f782e636f6d2f73756973696e750a6c65747320676f20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111_4de893dfdc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIINUONSUICHAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIINUONSUICHAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

