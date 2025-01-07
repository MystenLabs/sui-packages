module 0x894d3f19f699c6aec07f00f53a196ac198c7210367140c4204f73e32c6e8dcbd::lafor {
    struct LAFOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAFOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAFOR>(arg0, 9, b"LAFOR", b"Laforce", b"Don't see any token for crocodile", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/951c9267-a8b9-40c0-bbab-fb728b9ce399.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAFOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAFOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

