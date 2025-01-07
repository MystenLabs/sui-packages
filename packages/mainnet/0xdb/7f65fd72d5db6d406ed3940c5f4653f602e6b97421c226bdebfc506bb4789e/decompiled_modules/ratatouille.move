module 0xdb7f65fd72d5db6d406ed3940c5f4653f602e6b97421c226bdebfc506bb4789e::ratatouille {
    struct RATATOUILLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATATOUILLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATATOUILLE>(arg0, 6, b"Ratatouille", b"Ratatouille on sui", b"Little mouse, big dreams! Together with SuiRatatouille, we will conquer the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_f84878d879.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATATOUILLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATATOUILLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

