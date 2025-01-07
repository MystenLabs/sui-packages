module 0xdac916b60ff0d3102019506e2762e80e73b1d627b3efcbad638c3ee2492c5461::monai {
    struct MONAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONAI>(arg0, 6, b"MONAI", b"MOON AI", x"4d656574204041534b494f4e5f41495f424f54200a596f757220636f6e766572736174696f6e20706172746e65722077697468206e6f206c696d69747321204d656e74696f6e204041534b494f4e5f41495f424f5420746f20737461727420612064697265637420636861742077697468207468697320616476616e636564206172746966696369616c20696e74656c6c6967656e63652e0a0a2057686174206d616b6573206974207370656369616c3f0a0a556e63656e736f7265642c2064697265637420616e642061757468656e7469632e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735933133026.41")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

