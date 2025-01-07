module 0x22746d93495ddf9c5f0303294d28f6fb06742547391af999da264a6d6205c6ff::snowy {
    struct SNOWY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOWY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOWY>(arg0, 6, b"SNOWY", b"Snowinimals", b"Cutest Snow Animals", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R_2bf69cff18.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOWY>>(v1);
    }

    // decompiled from Move bytecode v6
}

