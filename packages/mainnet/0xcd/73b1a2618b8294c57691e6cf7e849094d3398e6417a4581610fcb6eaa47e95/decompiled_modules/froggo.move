module 0xcd73b1a2618b8294c57691e6cf7e849094d3398e6417a4581610fcb6eaa47e95::froggo {
    struct FROGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGO>(arg0, 6, b"FROGGO", b"BasedFroggi", x"486520697320736f2062617365642c20796f752063616e74206576656e2068616e646c652068696d20726e2066722066720a4a6f696e2074686520636f6d6d756e69747920616e6420666c7920776974682066726f676f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/449205918_987495322880559_3125009896536326102_n_41fe559833.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

