module 0xefa0c1e02494e0faf809eb55d050b74d091465e98b2eb1d8b6faf41e90dc43e7::kipi {
    struct KIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIPI>(arg0, 6, b"KIPI", b"KIKI PusPin", x"4b696b692050757350696e2069732061206368617269736d6174696320616e642063756c747572616c6c792072696368206d6173636f7420666f722061206d656d65636f696e206f6e207468652053554920626c6f636b636861696e2e2041732061206469676974616c20656d626f64696d656e74206f662046696c6970696e6f2070726964652c204b696b69205075735069206973206d6f7265207468616e206a75737420612073796d626f6ce2809469742773206120636f6e6e656374696f6e206265747765656e20747261646974696f6e2c2068756d6f722c20616e6420696e6e6f766174696f6e20696e2074686520666173742d70616365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735812410067.32")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIPI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIPI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

