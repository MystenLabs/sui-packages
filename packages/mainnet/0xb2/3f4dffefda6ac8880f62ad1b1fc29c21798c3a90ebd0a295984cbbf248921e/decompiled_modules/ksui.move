module 0xb23f4dffefda6ac8880f62ad1b1fc29c21798c3a90ebd0a295984cbbf248921e::ksui {
    struct KSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSUI>(arg0, 6, b"Ksui", b"Calsuim", b"Pain Pain without Caisuim", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_c414f28445.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

