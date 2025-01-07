module 0x28e6d27c52678a5d9e41e1f45f15f8fee2594b1e5a9339098d5e37bb9cd3fdd9::scats {
    struct SCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCATS>(arg0, 9, b"SCATS", b"San Cat ", b"San Cat (SCATS) is an innovative cryptocurrency token created to serve as a utility and community-based token within the crypto and DeFi ecosystems.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/795654f7-98b6-4a04-8632-e1011b77513c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

