module 0x5e042783521878ce6d89c39689efd7aceea95c85c345d7c43e8f3210eca3e405::trump_sui {
    struct TRUMP_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP_SUI>(arg0, 9, b"TRUMP_SUI", b"TRUS", b"This is the first Trump coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94646084-a6f6-4405-9bf3-4c0c9759a48f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

