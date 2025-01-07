module 0xea0c170d14d8098ba5f3891b190a9cec26cd69f9227d0445b9b1245eeca8a418::nigeria {
    struct NIGERIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGERIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGERIA>(arg0, 9, b"NIGERIA", b"Nig", b"Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5d71c8d2-6368-49c1-8bd3-ff8b5fca0d05.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGERIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIGERIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

