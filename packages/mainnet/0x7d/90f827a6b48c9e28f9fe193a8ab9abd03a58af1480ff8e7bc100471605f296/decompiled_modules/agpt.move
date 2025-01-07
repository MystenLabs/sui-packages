module 0x7d90f827a6b48c9e28f9fe193a8ab9abd03a58af1480ff8e7bc100471605f296::agpt {
    struct AGPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGPT>(arg0, 6, b"AGPT", b"AgentGPT", x"50696f6e656572696e6720414920666f722074686520737570657268756d616e2c207765206272696467652074686520676170206265747765656e20627261696e2d636f6d707574657220696e7465726661636520696d706c616e747320616e642068756d616e20636f6e7363696f75736e6573730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3w_Ni_DF_3_400x400_a8dd7a384d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

