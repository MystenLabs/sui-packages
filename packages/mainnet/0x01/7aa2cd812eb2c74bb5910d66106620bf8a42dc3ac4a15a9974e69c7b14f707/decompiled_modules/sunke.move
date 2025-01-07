module 0x17aa2cd812eb2c74bb5910d66106620bf8a42dc3ac4a15a9974e69c7b14f707::sunke {
    struct SUNKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNKE>(arg0, 6, b"SUNKE", b"SUNKE ON SUI", b"SUNKE was a monkey who always felt life was boring. While his friends played and climbed, he sat on a rock, puffing on a cigar he found somewhere.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731049318498.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUNKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

