module 0x9fc2413dbaa51e2987f846da0bef94ad3692fe9f5f7ed9339676b94da3e78601::fov {
    struct FOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FOV>(arg0, 6, b"FOV", b"Forever", b"Moon forever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/moon_6ffb893f6d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FOV>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOV>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

