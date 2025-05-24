module 0xf29bb70c7337963859f94fdfd7fed91e2533a037ff310008fb7113af24696a87::micro {
    struct MICRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICRO>(arg0, 6, b"MICRO", b"Micro Toad", x"4a75737420612074696e792c20676f6f667920616e64204d6963726f2066726f672e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/micro_toad_logo_a1011c9f75.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MICRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

