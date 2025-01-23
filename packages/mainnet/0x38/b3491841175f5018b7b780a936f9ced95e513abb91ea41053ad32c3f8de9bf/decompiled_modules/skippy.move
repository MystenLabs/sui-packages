module 0x38b3491841175f5018b7b780a936f9ced95e513abb91ea41053ad32c3f8de9bf::skippy {
    struct SKIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIPPY>(arg0, 6, b"SKIPPY", b"SKIPPY AI", b" Passionate creator", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SKIPPY_315af5f29c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

