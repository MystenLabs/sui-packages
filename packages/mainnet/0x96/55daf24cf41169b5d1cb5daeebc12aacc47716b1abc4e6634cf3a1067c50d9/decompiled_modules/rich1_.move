module 0x9655daf24cf41169b5d1cb5daeebc12aacc47716b1abc4e6634cf3a1067c50d9::rich1_ {
    struct RICH1_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICH1_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICH1_>(arg0, 9, b"RICH1_", b"happylucky", b"dsfdsgsdgsgsfgsgsg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ad2f33b-69bf-42f5-93ec-3fb1aea1edb3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICH1_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICH1_>>(v1);
    }

    // decompiled from Move bytecode v6
}

