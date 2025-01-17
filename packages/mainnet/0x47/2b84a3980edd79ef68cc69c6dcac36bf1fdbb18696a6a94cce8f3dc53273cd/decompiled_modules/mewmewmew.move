module 0x472b84a3980edd79ef68cc69c6dcac36bf1fdbb18696a6a94cce8f3dc53273cd::mewmewmew {
    struct MEWMEWMEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWMEWMEW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MEWMEWMEW>(arg0, 6, b"MEWMEWMEW", b"MEW by SuiAI", b"mewmewmewmew", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/3373da1ae6e9a429e7fc8dbad72bf5f4726eb13b_c19dbacf16.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEWMEWMEW>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWMEWMEW>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

