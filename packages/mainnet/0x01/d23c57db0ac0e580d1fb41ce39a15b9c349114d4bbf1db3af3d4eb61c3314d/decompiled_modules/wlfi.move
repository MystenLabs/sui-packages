module 0x1d23c57db0ac0e580d1fb41ce39a15b9c349114d4bbf1db3af3d4eb61c3314d::wlfi {
    struct WLFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLFI>(arg0, 6, b"WLFI", b"wlfi", b"Freedom, equality, and peace.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/666_2a8061e07f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WLFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

