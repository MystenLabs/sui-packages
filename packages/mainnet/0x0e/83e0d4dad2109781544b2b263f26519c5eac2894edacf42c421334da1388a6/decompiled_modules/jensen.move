module 0xe83e0d4dad2109781544b2b263f26519c5eac2894edacf42c421334da1388a6::jensen {
    struct JENSEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JENSEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JENSEN>(arg0, 6, b"JENSEN", b"JENSEN ON SUI", b"Jensen started NVIDIA with $200 in a Dennys, and built it up to be the most valuable company in the world. Before it all comes together, you must endure great pain & suffering. \"Success is a work in progress. It's not about achieving a goal; it's about constantly improving and pushing boundaries.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SL_4i_A_Whi_400x400_c19b1bb4e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JENSEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JENSEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

