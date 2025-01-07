module 0x53a50c510863c1e193451549e28e26ecfbf5f28240d3d35d1d93eb2c98779d66::fenn {
    struct FENN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENN>(arg0, 6, b"FENN", b"Fenn", b"Party hard. Trade harder. Get rich.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_7b511b4d1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FENN>>(v1);
    }

    // decompiled from Move bytecode v6
}

