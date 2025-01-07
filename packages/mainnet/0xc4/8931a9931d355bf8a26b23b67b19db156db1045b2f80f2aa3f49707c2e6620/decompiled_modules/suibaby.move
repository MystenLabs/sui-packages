module 0xc48931a9931d355bf8a26b23b67b19db156db1045b2f80f2aa3f49707c2e6620::suibaby {
    struct SUIBABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBABY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIBABY>(arg0, 6, b"SUIBABY", b"SUIBABY by SuiAI", b"SUI BABY FOR SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Designer_1_6ba2f54ad4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIBABY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBABY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

