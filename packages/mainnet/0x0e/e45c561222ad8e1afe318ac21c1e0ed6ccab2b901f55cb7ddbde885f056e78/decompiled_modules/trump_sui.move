module 0xee45c561222ad8e1afe318ac21c1e0ed6ccab2b901f55cb7ddbde885f056e78::trump_sui {
    struct TRUMP_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP_SUI>(arg0, 9, b"TRUMP_SUI", b"TRUS", b"This is the first Trump coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e2b82e89-4415-4520-aaca-c03e68d2e428.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

