module 0xec6b29bf1dd848f0ab350ae82e46f2308cc8bb7633455325de847937df41e4aa::jojo {
    struct JOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOJO>(arg0, 9, b"JOJO", b"rachael_jo", b"JoJo Coinnnn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/09145624-99fd-4c6c-aab6-ed91adb3cba7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

