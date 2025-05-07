module 0x352272fae951612f12b1bafa2ad331827de1bcba35ec5e31188ab668fde9918c::owell {
    struct OWELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWELL>(arg0, 6, b"OWELL", b"Owell the Hydronaut", x"4f77656c6c2c2074686520796f756e676573742072656372756974206f6e20407375696e6574776f726b0a200a547261696e656420696e20646565702d76696265206578706c6f726174696f6e2c20706f776572656420627920687970652c20616e64206675656c656420627920687964726174696f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/451sui_1_fa6f44dfb7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWELL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OWELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

