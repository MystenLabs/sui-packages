module 0x4c7e7cbd6a2161cb3e74c089520760dc2ed073220219a782467167facb0ac459::hipush {
    struct HIPUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPUSH>(arg0, 6, b"HIPUSH", b"Push da Hippo", b"JUST PUSH DA HIPPO! Together we'll achieve success! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rlogo_b70072c5d6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPUSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPUSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

