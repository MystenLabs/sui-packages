module 0x21e3c45f834fd178edb57ce417855d75d04a455738eeba3b1cb90a3219fc3e3f::bobb {
    struct BOBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBB>(arg0, 6, b"BOBB", b"Bobb Sui", x"5965732c20424f42422069732067726f77696e67200a6e6f7420696e2070726963652c206f6620636f75727365206a7573742073706972697475616c6c792e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250508_014659_d32a39a633.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

