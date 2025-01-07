module 0x805f3e095a393665772affab8b823fc14c5e330343fac22c2c7e99fa922a0c29::quangngai {
    struct QUANGNGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANGNGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANGNGAI>(arg0, 9, b"QUANGNGAI", b"QuangNgai", b"Quang Ngai 76", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0698c3cc-05a5-4ac6-878c-937523747a30.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANGNGAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUANGNGAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

