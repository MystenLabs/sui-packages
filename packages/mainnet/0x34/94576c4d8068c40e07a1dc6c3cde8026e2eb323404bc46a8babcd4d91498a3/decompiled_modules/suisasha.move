module 0x3494576c4d8068c40e07a1dc6c3cde8026e2eb323404bc46a8babcd4d91498a3::suisasha {
    struct SUISASHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISASHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISASHA>(arg0, 6, b"SuiSASHA", b"SASHA", b"A new HBO documentary titled Money Electric: The Bitcoin Mystery is set to reveal the real identity of the anonymous creator of Bitcoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/25_e94f379ea5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISASHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISASHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

