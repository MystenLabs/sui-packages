module 0xbb7e62a8c5b5d2991b9c6e45cdc0e30255ea40f83e1d12c703c14171a8de863d::zapp {
    struct ZAPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAPP>(arg0, 9, b"ZAPP", b"Zazi", b"Family govern token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9916efcf-d5db-4244-b9ea-5386f21c3602.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

