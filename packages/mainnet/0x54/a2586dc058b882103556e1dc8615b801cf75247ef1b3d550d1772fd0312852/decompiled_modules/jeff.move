module 0x54a2586dc058b882103556e1dc8615b801cf75247ef1b3d550d1772fd0312852::jeff {
    struct JEFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEFF>(arg0, 6, b"JEFF", b"My Name is Jeff", b"only for jeff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5992554778057621806_c_376fb209ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

