module 0x1dea65454218134e93586905631560bd82845c23f24c8d4b2af81cdd9b8e5ab2::dbz {
    struct DBZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBZ>(arg0, 9, b"DBZ", b"Goku", b"Just take it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a34b9cba-6eb5-4417-bd6f-c63aacf38d06.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DBZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

