module 0xb735874e00b81b9e5dddaa74d8707867658a75563d358a08b0c2aefc46482ac4::prnt {
    struct PRNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRNT>(arg0, 9, b"PRNT", b"BLUEPRINT", b"blueprint your way with this token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4bd18df6-cac1-49c9-898e-a19ccd8f7ce4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

