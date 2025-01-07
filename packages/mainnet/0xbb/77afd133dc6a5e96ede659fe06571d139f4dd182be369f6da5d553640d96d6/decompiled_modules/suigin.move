module 0xbb77afd133dc6a5e96ede659fe06571d139f4dd182be369f6da5d553640d96d6::suigin {
    struct SUIGIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGIN>(arg0, 6, b"SUIGIN", b"SUI'GIN", b"Suntory Sui Japanese Gin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/1000120084_8f7910307e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

