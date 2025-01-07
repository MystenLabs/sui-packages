module 0x952012ba3b465092bac12f9b8c63e738f753ae3ce6c5575091ce61d1b8ccc408::ggwp {
    struct GGWP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGWP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGWP>(arg0, 9, b"GGWP", b"Good Game", b"Good Game Well Played - token for everyone who played/play games", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed14dc67-76e4-4c57-a43b-606c96344c7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGWP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GGWP>>(v1);
    }

    // decompiled from Move bytecode v6
}

