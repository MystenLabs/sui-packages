module 0x5904d41e5e7d78dae94dc577d00c00276012f9acfb52272203fe02e8d2ae2752::uuuuu {
    struct UUUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: UUUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UUUUU>(arg0, 6, b"UUUUU", b"dssss", b"ddd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fsml_J_Yo_K_400x400_69b532e592.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UUUUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UUUUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

