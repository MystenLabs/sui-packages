module 0xdd5fe6bdbd01bc2359f306838d58c8199c44d81bee5867246da2dfaab00191ff::cult {
    struct CULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CULT>(arg0, 6, b"CULT", b"Science Cult Mascot by SuiAI", b" the first immortalized human cell line and one of the most important cell lines in medical research.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/hh_363a7219d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CULT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CULT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

