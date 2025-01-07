module 0xe3530252e90c847fbc37882bd0f230bf0e5aeff6abd184a3cf3d717e72e0a5c::suits {
    struct SUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITS>(arg0, 6, b"SUITS", b"SUI_SUITS", b"LFG suit up  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1d_C2f_KWF_400x400_ebdf5e896e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

