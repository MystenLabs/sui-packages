module 0xa2157b2c62662c0ae2b9c7a828d60e551b00547721557f04002d602e3b9da043::chadpepe {
    struct CHADPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHADPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHADPEPE>(arg0, 6, b"ChadPepe", b"Chad Pepe", x"4368616420506570652028244368616450657065290a5768656e20796f7520636f6d62696e65204368616420616e6420506570652c20796f7520676574202443686164506570652074686520756c74696d617465206d656d6520636861642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111_99117c46ee.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHADPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHADPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

