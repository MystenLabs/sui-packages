module 0xe05fcb7c62c85ed3ba4ec445296eadabaab0db5c4f824498c2ff75e3a04e2733::rsatoshi {
    struct RSATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RSATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RSATOSHI>(arg0, 9, b"RSATOSHI", b"Review Sat", x"417320484f4220646f63756d656e746174696f6e2061626f7574205361746f73686920616e6420426974636f696e20697320636f6d696e67207570206c65742773206d616b65206d6f6e657920f09fa49120616e6420617761697420746f207365652077686f205361746f73686920697320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2553de5f-768d-440a-9baa-43ba6fdd25d0-1000085698.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RSATOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RSATOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

