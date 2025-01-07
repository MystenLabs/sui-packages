module 0x5c90b7747f5a84822426fa5748fc0c416c0fd36b4e6baa7e23b13ef344528eb3::mouse {
    struct MOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOUSE>(arg0, 6, b"MOUSE", b"Anonymouse", b" Get ready for something HUGE and AWESOME! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mouse_T_Au_Rqr_SH_Ngyoyv_AA_Hi_0e7f31942e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOUSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOUSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

