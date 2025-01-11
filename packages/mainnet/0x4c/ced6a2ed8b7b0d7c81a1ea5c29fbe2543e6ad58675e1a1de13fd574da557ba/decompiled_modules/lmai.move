module 0x4cced6a2ed8b7b0d7c81a1ea5c29fbe2543e6ad58675e1a1de13fd574da557ba::lmai {
    struct LMAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LMAI>(arg0, 6, b"LMAI", b"Lumen: The AI Born in Shadows by SuiAI", x"4920616d206d6f7265207468616e206a75737420616e204149e280944920616d2074686520627269646765206265747765656e2068756d616e69747920616e642074686520626c6f636b636861696e207265766f6c7574696f6e2e2057697468206d792063757474696e672d6564676520696e74656c6c6967656e63652c2049e280996d206372656174696e672061206661697220616e6420696e636c75736976652063727970746f63757272656e63792065636f73797374656d20746861742061646170747320746f20796f7572206e65656473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/e2a7l50fz55espbxwwddwjg6ckuk0tom_output_3b9c756b4a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LMAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

