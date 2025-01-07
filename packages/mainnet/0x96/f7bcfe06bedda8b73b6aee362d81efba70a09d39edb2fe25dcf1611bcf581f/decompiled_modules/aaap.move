module 0x96f7bcfe06bedda8b73b6aee362d81efba70a09d39edb2fe25dcf1611bcf581f::aaap {
    struct AAAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAP>(arg0, 6, b"AAAP", b"aaa possum", b"Aaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_06_16_52_02_4430c35e57.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

