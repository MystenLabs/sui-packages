module 0xc819d455707dc30e992af53403e898462bd2d954d151b0669ab64454d255278e::rats {
    struct RATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATS>(arg0, 9, b"RATS", b"RAT", b"RATS MEME TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3643c714-08e3-47d4-845f-fcd96b94274c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

