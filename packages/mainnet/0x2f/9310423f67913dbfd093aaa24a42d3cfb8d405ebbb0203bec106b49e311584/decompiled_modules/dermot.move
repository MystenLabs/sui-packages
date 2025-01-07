module 0x2f9310423f67913dbfd093aaa24a42d3cfb8d405ebbb0203bec106b49e311584::dermot {
    struct DERMOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERMOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERMOT>(arg0, 6, b"DERMOT", b"SUI DERMOT", b"YEEEEEEEEEEtttt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DERMOT_2b3c76d10a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERMOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DERMOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

