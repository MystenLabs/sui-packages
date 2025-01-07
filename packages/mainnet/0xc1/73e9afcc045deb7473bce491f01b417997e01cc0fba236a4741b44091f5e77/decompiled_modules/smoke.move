module 0xc173e9afcc045deb7473bce491f01b417997e01cc0fba236a4741b44091f5e77::smoke {
    struct SMOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOKE>(arg0, 6, b"SMOKE", b"Smokey The Bear", x"4c69746572616c6c79206a75737420536d6f6b65792074686520626561722e200a50726f746563742074686520666f726573742c206d616b6520736f6d65206d6f6e65792e204e6f205447206e6f20582e2059616c6c2077616e6e61206d616b65206f6e6520676f20666f722069742e20446576206f75742e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2665_0ff05a0034.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

