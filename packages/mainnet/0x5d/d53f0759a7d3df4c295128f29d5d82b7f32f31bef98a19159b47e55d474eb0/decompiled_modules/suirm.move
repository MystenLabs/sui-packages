module 0x5dd53f0759a7d3df4c295128f29d5d82b7f32f31bef98a19159b47e55d474eb0::suirm {
    struct SUIRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRM>(arg0, 6, b"SUIRM", b"SCREAM", x"446f6e277420416e737765722054686520446f6f722c20446f6e2774204c656176652054686520486f7573652c20446f6e27742053637265616d210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/db1a1bf3_e91a_4d15_85c4_dd05094a7cd3_fe2923fd52.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

