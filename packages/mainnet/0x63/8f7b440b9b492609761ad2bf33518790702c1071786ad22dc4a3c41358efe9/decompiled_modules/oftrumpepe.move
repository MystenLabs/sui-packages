module 0x638f7b440b9b492609761ad2bf33518790702c1071786ad22dc4a3c41358efe9::oftrumpepe {
    struct OFTRUMPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OFTRUMPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OFTRUMPEPE>(arg0, 6, b"OfTrumPepe", b"OfficialTrumPepe", x"776520617265206120636f6d6d756e697479207468617420737570706f727473207472756d7020616761696e737420626964656e20666f722074686520667574757265206f662063727970746f2e20666f722074686520676f6f64206f66207468652077686f6c6520776f726c642e2077652077616e7420646f6e616c64207472756d7020746f20626520676f6f6420707265736964656e7420696620796f752077616e7420746f20737570706f7274207472756d70206c696b6520757320627579206e6f77210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737314779315.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OFTRUMPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OFTRUMPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

