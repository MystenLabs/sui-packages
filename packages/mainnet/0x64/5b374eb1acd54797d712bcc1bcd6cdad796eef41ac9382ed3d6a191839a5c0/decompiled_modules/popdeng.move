module 0x645b374eb1acd54797d712bcc1bcd6cdad796eef41ac9382ed3d6a191839a5c0::popdeng {
    struct POPDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDENG>(arg0, 6, b"POPDENG", b"Popdeng on Sui", x"0a0a0a0a24504f5044454e47206272696e67696e6720696e2074686520636f6d62696e6174696f6e206f662074776f20736f6c616e61206e6172726174697665206f662024504f5043415420616e6420244d4f4f44454e4720696e746f20235355492065636f73797374656d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241015_025318_359_d189a650cd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

