module 0x17b16b713ce9c33f8a27d62a637fc117d3b46e0be7c78a312b154aaceb3eb93a::stoshi {
    struct STOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STOSHI>(arg0, 6, b"STOSHI", b"SUITOSHI", b"Len Sassaman is satoshi nakamoto the founder of #Bitcoin , now  undercover as SUITOSHI come join to a moon trip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5904_32f73b25f4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

