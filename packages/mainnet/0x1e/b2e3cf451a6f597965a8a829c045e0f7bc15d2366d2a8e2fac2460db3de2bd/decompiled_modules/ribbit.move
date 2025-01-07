module 0x1eb2e3cf451a6f597965a8a829c045e0f7bc15d2366d2a8e2fac2460db3de2bd::ribbit {
    struct RIBBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIBBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIBBIT>(arg0, 6, b"Ribbit", b"Frog", b"Ribbit...ribbit...ribitt...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zte_PL_4_W4_A8o0_Mg_2bbb3f1927.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIBBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIBBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

