module 0xc95d8f24516295dd7fc60d72cee3dc3978d9493c31cd2d03565821abb06c5191::dall {
    struct DALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DALL>(arg0, 6, b"DALL", b"DALLINO", x"f09f9a802050617373696f6e6174652061626f757420616c6c207468696e677320f09f8c90207c20f09fa791e2808df09f92bb2044616c6c20636f6d6d756e69747920f09f9a80207c204578706c6f72696e6720746865204d454d4520756e697665727365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732826063585.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DALL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DALL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

