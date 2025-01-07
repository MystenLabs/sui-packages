module 0x27995574b86d9c356cfc7ba26cd4f88c41db6eccb2489be2a3575ac50914a47e::tsalu {
    struct TSALU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSALU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSALU>(arg0, 9, b"TSALU", b"Tsula", b"Dedicated to the people of Alfindiki ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3e6c30a-a3a2-4a55-99a0-b01d54c88348.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSALU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSALU>>(v1);
    }

    // decompiled from Move bytecode v6
}

