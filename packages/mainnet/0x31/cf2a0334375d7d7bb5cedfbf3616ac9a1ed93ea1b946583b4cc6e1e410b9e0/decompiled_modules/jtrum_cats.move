module 0x31cf2a0334375d7d7bb5cedfbf3616ac9a1ed93ea1b946583b4cc6e1e410b9e0::jtrum_cats {
    struct JTRUM_CATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JTRUM_CATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JTRUM_CATS>(arg0, 9, b"JTRUM_CATS", b"JTrump Cat", b"Jtrum Token New Meme Era Token3745 Lunch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dab1f2ef-9ff6-4aae-add3-1a3a948cb80c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JTRUM_CATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JTRUM_CATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

