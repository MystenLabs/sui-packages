module 0xe9b0c2f39c2c71a9e2dff791bb03cd2b5e4b421556759bad292a6dcfb157d5c8::ploofy {
    struct PLOOFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOOFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOOFY>(arg0, 9, b"PLOOFY", b"PLOOFY ", b"Ploofy on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0b4e9440-4c92-4749-8668-97aae788bb03.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOOFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLOOFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

