module 0xe286eb02766339926db4c41ee11b90f3ce3af8a60bb144cd8c3d8c8435106757::huge {
    struct HUGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUGE>(arg0, 6, b"HUGE", b"P*nis", b"NEW Paradigm of Money!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mu_coin_1_logo_7720686294.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

