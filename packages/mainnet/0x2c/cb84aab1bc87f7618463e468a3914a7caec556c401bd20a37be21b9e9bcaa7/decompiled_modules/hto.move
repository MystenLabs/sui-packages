module 0x2ccb84aab1bc87f7618463e468a3914a7caec556c401bd20a37be21b9e9bcaa7::hto {
    struct HTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTO>(arg0, 6, b"HTO", b"HYPE TOAD OVERLOAD", b"HYPE TOAD OVERLOAD ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_27_040040_49e8da7f1a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

