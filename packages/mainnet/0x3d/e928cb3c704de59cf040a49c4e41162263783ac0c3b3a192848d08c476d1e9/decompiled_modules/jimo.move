module 0x3de928cb3c704de59cf040a49c4e41162263783ac0c3b3a192848d08c476d1e9::jimo {
    struct JIMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<JIMO>(arg0, 6, 0x1::string::utf8(b"JIMO"), 0x1::string::utf8(b"Jimothy"), 0x1::string::utf8(x"4a696d6f7468792069732053656174746c65e28099732073686f72742d7370696e6520726163636f6f6e2e205265616c20616e696d616c2e205265616c206c6f61662e20486561642073697473206f6e206869732073686f756c646572732e20486520646f6573206e6f7420636172652061626f757420796f75722063686172742e20486520656174732074726173682c207363616d70657273206c696b652061205461736d616e69616e20646576696c2c20616e642074686520636974792074687265772068696d20612073756d6d65722e2046616972206c61756e63682e204e6f2056432e204e6f207574696c697479"), 0x1::string::utf8(b"https://popularsui.xyz/media/b7f7e85dca29213f6c77e1562fdaf0021e48e173058ebd920c8259b8152da711.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIMO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<JIMO>>(0x2::coin_registry::finalize<JIMO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

