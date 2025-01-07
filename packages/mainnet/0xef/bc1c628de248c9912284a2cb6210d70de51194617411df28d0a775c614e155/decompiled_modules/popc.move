module 0xefbc1c628de248c9912284a2cb6210d70de51194617411df28d0a775c614e155::popc {
    struct POPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPC>(arg0, 9, b"POPC", b"POPCAT", b"A poppy cat meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42a06615-2b28-4ec5-ab2d-add1e70cbd70.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

