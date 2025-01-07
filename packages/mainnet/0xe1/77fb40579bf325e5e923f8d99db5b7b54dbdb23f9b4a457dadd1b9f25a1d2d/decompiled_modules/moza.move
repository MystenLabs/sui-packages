module 0xe177fb40579bf325e5e923f8d99db5b7b54dbdb23f9b4a457dadd1b9f25a1d2d::moza {
    struct MOZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOZA>(arg0, 9, b"MOZA", b"moza token", b"kucing moza token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c4b87b7-65d3-48d7-a7b3-21017c36a553.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

