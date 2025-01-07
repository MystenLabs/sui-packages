module 0xa087e2ce0338cb9098a5e6d0d48df1b0286bcf731dc245e18cf25b68c75ca3f9::popdeng {
    struct POPDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDENG>(arg0, 6, b"POPDENG", b"POPDENG ON SUI", x"0a0a0a0a24504f5044454e47204272696e67696e6720696e2074686520636f6d62696e6174696f6e206f662074776f20736f6c616e61206e6172726174697665206f662024504f5043415420616e6420244d4f4f44454e4720696e746f20235355492065636f73797374656d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241015_045312_978_664a586caf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

