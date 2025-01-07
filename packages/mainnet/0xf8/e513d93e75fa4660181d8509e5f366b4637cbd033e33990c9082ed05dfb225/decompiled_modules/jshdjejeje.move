module 0xf8e513d93e75fa4660181d8509e5f366b4637cbd033e33990c9082ed05dfb225::jshdjejeje {
    struct JSHDJEJEJE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JSHDJEJEJE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JSHDJEJEJE>(arg0, 9, b"JSHDJEJEJE", b"Uus", x"53c6b06a6575657565", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ded9ad1-73c2-400d-8e96-fa8943e7de2a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JSHDJEJEJE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JSHDJEJEJE>>(v1);
    }

    // decompiled from Move bytecode v6
}

