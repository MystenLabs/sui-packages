module 0xdde7920d5b6886444e0d9ebeaea85bbe1d35e15507faf9e942c701fcd927983f::mvis {
    struct MVIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MVIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MVIS>(arg0, 6, b"MVIS", b"MuskVision", b"MuskVision (MVIS) is a new meme coin. MuskVision aims to capture the excitement and speculative energy around Musk's ventures, blending humor with high hopes for financial gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731531801905.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MVIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MVIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

