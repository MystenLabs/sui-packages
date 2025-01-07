module 0x2b84cd7f84fb2b5c2c5b9dc1d9cc9e75587850942c1f6da1f2ef03ecd87861d1::thrones {
    struct THRONES has drop {
        dummy_field: bool,
    }

    fun init(arg0: THRONES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THRONES>(arg0, 6, b"THRONES", b"FIGHT FOR THR0NES", x"416e204570696320426174746c652069732061626f757420746f20626567696e2e205072657061726520796f7572206173736574732e0a496620796f75277665206d6164652069742074686973206661722c2074686973206973207768657265206f757220636f6d6d756e69747920626567696e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6113890816805158310_d03f7a0d4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THRONES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THRONES>>(v1);
    }

    // decompiled from Move bytecode v6
}

