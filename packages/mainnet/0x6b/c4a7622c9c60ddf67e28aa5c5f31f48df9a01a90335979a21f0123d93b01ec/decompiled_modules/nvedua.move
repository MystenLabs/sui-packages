module 0x6bc4a7622c9c60ddf67e28aa5c5f31f48df9a01a90335979a21f0123d93b01ec::nvedua {
    struct NVEDUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NVEDUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NVEDUA>(arg0, 6, b"NVEDUA", b"Sui Nvedua", x"476565506565552069732067756420666f72206d696e696e670a0a746568206675747572206f6620636f6d707574696e20697a206e6f7420616275742077757420636f6d70757472732063616e20646f2c20697427732061627574207775742068756d616e732063616e0a646f2077696620636f6d7075747273", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Iv_o_VWWQAAXXEK_e41296d3b3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NVEDUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NVEDUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

