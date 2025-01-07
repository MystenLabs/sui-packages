module 0x2135065112f63a000da07f93a8bb86aaa10a01085c86624e0de31c3e1d38b912::raku {
    struct RAKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAKU>(arg0, 9, b"RAKU", b"Racoon", b"Raku the racoon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/817f170b-a431-4dbf-9349-2ebf1d1de9b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

