module 0x3a3e47c85fe45f13be6da0f7261bae2299bcdfc61bf277ca9e67005f94403229::meerkat {
    struct MEERKAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEERKAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEERKAT>(arg0, 9, b"MEERKAT", b"meerkat", b"The Meerkat, a small but fearless mongoose, is the ultimate symbol of community, vigilance, and resilience. Found in the arid plains of Africa, these charismatic creatures work together to survive in harsh environment", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ce1882d-f77b-4827-a294-05880eead398.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEERKAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEERKAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

