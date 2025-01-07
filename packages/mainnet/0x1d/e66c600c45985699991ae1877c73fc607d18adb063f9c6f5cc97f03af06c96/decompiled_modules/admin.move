module 0x1de66c600c45985699991ae1877c73fc607d18adb063f9c6f5cc97f03af06c96::admin {
    struct ADMIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADMIN>(arg0, 6, b"ADMIN", b"SUI Admin", b"Power tripping fucking admins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241209_164822_000_febac2236c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADMIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADMIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

