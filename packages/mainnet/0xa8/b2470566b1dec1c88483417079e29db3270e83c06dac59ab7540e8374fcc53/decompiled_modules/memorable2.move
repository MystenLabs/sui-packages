module 0xa8b2470566b1dec1c88483417079e29db3270e83c06dac59ab7540e8374fcc53::memorable2 {
    struct MEMORABLE2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMORABLE2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMORABLE2>(arg0, 9, b"MEMORABLE2", b"Wave", b"This is a wave wallet token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d3e7934e-1ef2-4597-832d-dcd58f736895.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMORABLE2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMORABLE2>>(v1);
    }

    // decompiled from Move bytecode v6
}

