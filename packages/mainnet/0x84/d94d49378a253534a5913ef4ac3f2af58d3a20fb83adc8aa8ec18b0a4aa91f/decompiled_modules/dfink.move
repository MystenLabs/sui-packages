module 0x84d94d49378a253534a5913ef4ac3f2af58d3a20fb83adc8aa8ec18b0a4aa91f::dfink {
    struct DFINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFINK>(arg0, 6, b"DFINK", b"Deep Fink", b"Not just an ordinary fink, deep fink grows from childhood and will become a great memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019758_93dd4f0b51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DFINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

