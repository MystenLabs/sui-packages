module 0x2d359df81f2cdf90534e85c1a5967bb4286e04f71d6a56818b0b48ec7c1b22ad::wcum {
    struct WCUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCUM>(arg0, 6, b"WCUM", b"Whalecum", b"Whalecum To Whalecum.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4824_a41a8a96cd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WCUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

